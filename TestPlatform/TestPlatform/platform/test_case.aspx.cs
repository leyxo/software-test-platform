using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;

namespace TestPlatform.platform
{
    public partial class test_case : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 未登录跳转回登录界面
            if (Session["current_user_id"] == null)
            {
                Response.Redirect("/login.aspx");
            }

            // 没有权限跳转回用户主页
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), Request.Path))
            {
                Response.Redirect("/platform/platform_home.aspx");
            }

            if (!IsPostBack)
            {
                setVersionInfo();
                initWidght();
                alert.Visible = false;
            }
        }


        /// <summary>
        /// 根据权限初始化界面控件
        /// </summary>
        protected void initWidght()
        {
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_case_add.aspx"))
            {
                Button_Add_Case.Visible = false;
            }
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_report.aspx"))
            {
                Button_Generate_Report.Visible = false;
            }
            // 编辑删除
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_case_edit.aspx"))
            {
                GridView1.Columns[12].Visible = false;
                GridView2.Columns[12].Visible = false;
                GridView1.Columns[11].Visible = false;
            }
            // 撰写开发回馈
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_case_describe.aspx"))
            {
                GridView1.Columns[13].Visible = false;
            }

            // 写总结和提交/结束测试版本
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_version_submit"))
            {
                textfield_summary.Attributes.Add("readonly", "radonly");
                Button_Save.Visible = false;
                Button_Submit.Visible = false;
                Button_Finish.Visible = false;
            }
        }
        
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // 编辑选择项目
            if (e.CommandName == "edit")
            {
                Session["editing_test_case_id"] = e.CommandArgument.ToString();
                Response.Redirect("/platform/test_case_edit.aspx");
            }

            // 撰写开发描述
            if (e.CommandName == "describe")
            {
                Session["editing_test_case_id"] = e.CommandArgument.ToString();
                Response.Redirect("/platform/test_case_describe.aspx");
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Session["editing_test_case_id"] = "";

            string sql = "delete from sys_test_record where id = '" + GridView1.DataKeys[e.RowIndex]["ID"].ToString() + "'";
            SqlDataSource_test_case.DeleteCommand = sql;
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // 编辑选择项目
            if (e.CommandName == "edit")
            {
                Session["editing_test_case_id"] = e.CommandArgument.ToString();
                Response.Redirect("/platform/test_case_edit.aspx");
            }
        }

        /// <summary>
        /// 设置当前版本测试状态
        /// </summary>
        protected void setVersionInfo()
        {
            if (null != Session["current_test_version"] && "" != Session["current_test_version"].ToString())
            {
                string sql = "select sys_test_name.name, sys_test_name_version.name, sys_test_name_version.creation_date, start_time, end_time, summary, is_finish  from sys_test_name_version INNER JOIN sys_test_name ON sys_test_name.id = sys_test_name_version.test_id where sys_test_name_version.id = " + Session["current_test_version"];
                DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, null);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    label_test.Text = ds.Tables[0].Rows[0][0].ToString();
                    label_test_version.Text = ds.Tables[0].Rows[0][1].ToString();

                    creation_date.Text = ds.Tables[0].Rows[0][2].ToString().Split(' ')[0];
                    start_time.Text = ds.Tables[0].Rows[0][3].ToString().Split(' ')[0];
                    end_time.Text = ds.Tables[0].Rows[0][4].ToString().Split(' ')[0];
                    textfield_summary.Value = ds.Tables[0].Rows[0][5].ToString();
                    // 判断项目进行情况
                    string is_finish = ds.Tables[0].Rows[0][6].ToString();
                    if ("0" == is_finish)
                    {
                        // 可以写测试，可以[提交]，不可写总结，不可[完成]，不可写回馈，不可查看报告
                        test_case_status.InnerHtml = "<span style=\"color: darkgreen\"><strong>测试中</strong></span> -- <span style=\"color: lightgray\">已提交</span> -- <span style=\"color: lightgray\">已结束</span>";
                        Button_Save.Visible = false;
                        Button_Submit.Visible = true;
                        Button_Generate_Report.Visible = false;
                        Button_Add_Case.Visible = true;
                        Button_Finish.Visible = false;

                        GridView1.Columns[13].Visible = false;
                        GridView1.Columns[12].Visible = true;
                        GridView1.Columns[11].Visible = true;
                    }
                    else if ("1" == is_finish)
                    {
                        // 不可写测试，不可[提交]，可以写总结，可以[完成]，不可写回馈，不可查看报告
                        test_case_status.InnerHtml = "<span style=\"color: lightgray\">测试中</span> -- <span style=\"color: darkorange\"><strong>已提交</strong></span> -- <span style=\"color: lightgray\">已结束</span>";
                        Button_Save.Visible = true;
                        Button_Submit.Visible = false;
                        Button_Generate_Report.Visible = false;
                        Button_Add_Case.Visible = false;
                        Button_Finish.Visible = true;

                        GridView1.Columns[13].Visible = false;
                        GridView1.Columns[12].Visible = false;
                        GridView1.Columns[11].Visible = false;
                    }
                    else if ("2" == is_finish)
                    {
                        // 不可写测试，不可[提交]，不可写总结，不可[完成]，可以写回馈，可以查看报告
                        test_case_status.InnerHtml = "<span style=\"color: lightgray\">测试中</span> -- <span style=\"color: lightgray\">已提交</span> -- <span style=\"color: black\"><strong>已结束</strong></span>";
                        Button_Save.Visible = false;
                        Button_Submit.Visible = false;
                        Button_Generate_Report.Visible = true;
                        Button_Add_Case.Visible = false;
                        Button_Finish.Visible = false;

                        GridView1.Columns[13].Visible = true;
                        GridView1.Columns[12].Visible = false;
                        GridView1.Columns[11].Visible = false;
                    }
                }
                else
                {
                    Response.Redirect("/platform/basedata_manage_test_version.aspx");
                }
            }
            else
            {
                Response.Redirect("/platform/basedata_manage_test_version.aspx");
            }
        }

        /// <summary>
        /// 新建测试项目
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_Add_Case_Click(object sender, EventArgs e)
        {
            string sql = "select * from sys_test_name_version where id = " + Session["current_test_version"];
            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, null);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Response.Redirect("/platform/test_case_add.aspx");
            }
        }

        /// <summary>
        /// 生成测试报告
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_Generate_Report_Click(object sender, EventArgs e)
        {
            Response.Write("<script>window.open('/platform/test_report.aspx');</script>");
        }

        /// <summary>
        /// 提交当前版本 (is_finish状态置1)
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_Submit_Click(object sender, EventArgs e)
        {
            string sql = new StringBuilder("update sys_test_name_version set")
            .Append(" is_finish = 1")
            .Append(" where id = @id").ToString();

            SqlParameter[] parameters = {
                new SqlParameter("@id", Session["current_test_version"]),
            };
            
            if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
            {
                // 操作成功
                alert_text.InnerText = "版本已提交";
                alert.Attributes["class"] = "alert alert-success";
                Response.Redirect("/platform/test_case.aspx");
            }
            else
            {
                alert_text.InnerText = "操作失败";
            }
            alert.Visible = true;
        }

        /// <summary>
        /// 完成测试 (is_finish状态置2)
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_Finish_Click(object sender, EventArgs e)
        {
            string sql = new StringBuilder("update sys_test_name_version set")
            .Append(" is_finish = 2")
            .Append(" where id = @id").ToString();

            SqlParameter[] parameters = {
                new SqlParameter("@id", Session["current_test_version"]),
            };

            if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
            {
                // 操作成功
                alert_text.InnerText = "当前版本测试已结束";
                alert.Attributes["class"] = "alert alert-success";
                Response.Redirect("/platform/test_case.aspx");
            }
            else
            {
                alert_text.InnerText = "操作失败";
            }
            alert.Visible = true;
        }

        /// <summary>
        /// 保存测试总结
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_Save_Click(object sender, EventArgs e)
        {
            string textfield_summary = this.textfield_summary.Value;

            string sql = new StringBuilder("update sys_test_name_version set")
            .Append(" summary = @summary")
            .Append(" where id = @id").ToString();

            SqlParameter[] parameters = {
                new SqlParameter("@summary", textfield_summary),
                new SqlParameter("@id", Session["current_test_version"]) };

            if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
            {
                // 操作成功
                Response.Redirect("/platform/test_case.aspx");
                alert_text.InnerText = "保存成功";
                alert.Attributes["class"] = "alert alert-success";
            }
            else
            {
                alert_text.InnerText = "操作失败";
            }
            alert.Visible = true;
        }

        /// <summary>
        /// 返回版本列表
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_Back_Click(object sender, EventArgs e)
        {
            Session["current_test_id"] = "";
            Session["current_test_version"] = "";
            Response.Redirect("/platform/basedata_manage_test_version.aspx");
        }

        /// <summary>
        /// 搜索以前版本
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_Search_Previous_Click(object sender, EventArgs e)
        {
            string res = "SELECT sys_test_name_version.name AS 版本, sys_test_record.id AS ID, sys_test_record.name AS 项目, sys_test_record.precondition AS 前置条件, sys_test_record.process AS 测试过程及结果, base_issuetype.name AS 类型, sys_test_record.times AS 次数, sys_test_record.suggestion AS 改进建议, sys_test_record.describe AS 开发描述, base_status_pass.name AS 结论, users.name AS 记录者, sys_test_record.creation_date AS 创建时间 FROM sys_test_record INNER JOIN base_status_pass ON base_status_pass.id = sys_test_record.pass INNER JOIN users ON users.id = sys_test_record.creation_user_id INNER JOIN base_issuetype ON sys_test_record.type = base_issuetype.id INNER JOIN sys_test_name_version ON sys_test_name_version.id = sys_test_record.version_id WHERE sys_test_name_version.test_ID = @test_id and sys_test_record.version_id < @version_id and (sys_test_record.pass = 2 or sys_test_record.type = 2) and (sys_test_record.process like '%" + search_previous.Value.ToString() + "%' or sys_test_record.suggestion like '%" + search_previous.Value.ToString() + "%')";
            SqlDataSource_test_case_previous.SelectCommand = res;
            GridView2.DataSourceID = "SqlDataSource_test_case_previous";
            GridView2.DataBind();
        }
    }
}