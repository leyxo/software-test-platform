using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
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

            // 根据权限初始化界面控件
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_case_add.aspx"))
            {
                Button_Add_Case.Visible = false;
            }
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_report.aspx"))
            {
                Button_Generate_Report.Visible = false;
            }
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_case_edit.aspx"))
            {
                GridView1.Columns[12].Visible = false;
                GridView2.Columns[12].Visible = false;
                GridView1.Columns[11].Visible = false;
                GridView2.Columns[11].Visible = false;
            }
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_case_describe.aspx"))
            {
                GridView1.Columns[13].Visible = false;
                GridView2.Columns[13].Visible = false;
            }


            alert.Visible = false;
            
            if (Session["current_test_id"] != null && Session["current_test_id"].ToString() == "")
            {
                // 第一次加载时，初始化Session["current_test_id"]和Session["current_test_version"]
                // 获取第一个项目id
                string sql = new StringBuilder("select id from test where")
                    .Append(" creation_department_id = @creation_department_id").ToString();
                SqlParameter[] parameters = {
                    new SqlParameter("@creation_department_id", Session["current_user_department_id"]),
                };
                DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Session["current_test_id"] = ds.Tables[0].Rows[0]["id"].ToString();

                    // 获取第一个版本id
                    string sql2 = new StringBuilder("select id from test_version where")
                        .Append(" test_id = @test_id").ToString();
                    SqlParameter[] parameters2 = {
                    new SqlParameter("@test_id", Session["current_test_id"]),
                    };
                    DataSet ds2 = sqlHelper.ExecuteSqlDataSet(sql2, parameters2);
                    if (ds2.Tables[0].Rows.Count > 0)
                    {
                        Session["current_test_version"] = ds2.Tables[0].Rows[0]["id"].ToString();
                    }
                    else
                    {
                        Session["current_test_version"] = "0";
                    }
                }
                else
                {
                    Session["current_test_id"] = "0";
                }  
            }

            // 测试系统还在，但是当前版本被删除时，初始化为第一个存在的版本
            if (Session["current_test_version"] != null && (Session["current_test_version"].ToString() == "" || Session["current_test_version"].ToString() == "0") && Session["current_test_id"] != null && Session["current_test_id"].ToString() != "" && Session["current_test_id"].ToString() != "0")
            {
                // 获取第一个版本id
                string sql2 = new StringBuilder("select id from test_version where")
                    .Append(" test_id = @test_id").ToString();
                SqlParameter[] parameters2 = {
                    new SqlParameter("@test_id", Session["current_test_id"]),
                    };
                DataSet ds2 = sqlHelper.ExecuteSqlDataSet(sql2, parameters2);
                if (ds2.Tables[0].Rows.Count > 0)
                {
                    Session["current_test_version"] = ds2.Tables[0].Rows[0]["id"].ToString();
                }
                else
                {
                    Session["current_test_version"] = "0";
                }
            }
        }

        /// <summary>
        /// 在测试系统DropDownList数据绑定以后，选中指定默认项   ***注意此坑***
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void DropDownList_test_DataBound(object sender, EventArgs e)
        {
            if (Session["current_test_id"].ToString() != "" && Session["current_test_id"].ToString() != "0")
            {
                DropDownList_test.Items.FindByValue(Session["current_test_id"].ToString()).Selected = true;
                setVersionInfo();
            }
        }

        /// <summary>
        /// 在版本DropDownList数据绑定以后，选中指定默认项
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void DropDownList_test_version_DataBound(object sender, EventArgs e)
        {
            if (Session["current_test_version"].ToString() != "" && Session["current_test_version"].ToString() != "0")
            {
                DropDownList_test_version.Items.FindByValue(Session["current_test_version"].ToString()).Selected = true;
                setVersionInfo();
            }
        }
        
        /// <summary>
        /// 在测试系统DropDownList改变选择时
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void DropDownList_test_SelectedIndexChanged(object sender, EventArgs e)
        {
            // 初始化 Session["current_test_version"]
            Session["current_test_id"] = DropDownList_test.SelectedValue;
            // 获取第一个版本id
            string sql = new StringBuilder("select id from test_version where")
                .Append(" test_id = @test_id").ToString();
            SqlParameter[] parameters = {
                    new SqlParameter("@test_id", Session["current_test_id"]),
                    };
            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Session["current_test_version"] = ds.Tables[0].Rows[0]["id"].ToString();
            }
            else
            {
                Session["current_test_version"] = "0";
            }
            setVersionInfo();
        }

        /// <summary>
        /// 在版本DropDownList改变选择时
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void DropDownList_test_version_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["current_test_version"] = DropDownList_test_version.SelectedValue;
            setVersionInfo();
        }

        protected void Button_Add_Case_Click(object sender, EventArgs e)
        {
            if (DropDownList_test.Items.Count == 0)
            {
                alert_text.InnerHtml = "没有测试系统";
                alert.Visible = true;
            }
            else if (DropDownList_test_version.Items.Count == 0)
            {
                alert_text.InnerHtml = "没有版本";
                alert.Visible = true;
            }
            else
            {
                string sql = "select * from test_version where id = " + Session["current_test_version"];
                DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, null);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    // 判断项目进行情况
                    DateTime start = Convert.ToDateTime(ds.Tables[0].Rows[0]["start_time"].ToString());
                    DateTime end = Convert.ToDateTime(ds.Tables[0].Rows[0]["end_time"].ToString());
                    if (DateTime.Now > start && DateTime.Now < end)
                    {
                        Response.Redirect("/platform/test_case_add.aspx");
                    }
                    else if (DateTime.Now < start)
                    {
                        alert_text.InnerHtml = "项目未开始";
                        alert.Visible = true;
                    }
                    else
                    {
                        alert_text.InnerHtml = "项目已过期";
                        alert.Visible = true;
                    }

                }
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
            string sql = "delete from test_case where id = '" + GridView1.DataKeys[e.RowIndex]["ID"].ToString() + "'";
            SqlDataSource_test_case.DeleteCommand = sql;
        }

        /// <summary>
        /// 根据起止日期设置当前版本测试状态
        /// </summary>
        protected void setVersionInfo()
        {
            string sql = "select * from test_version where id = " + Session["current_test_version"];
            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, null);
            if (ds.Tables[0].Rows.Count > 0)
            {
                creation_date.Text = ds.Tables[0].Rows[0]["creation_date"].ToString();
                start_time.Text = ds.Tables[0].Rows[0]["start_time"].ToString().Split(' ')[0]; ;
                end_time.Text = ds.Tables[0].Rows[0]["end_time"].ToString().Split(' ')[0];
                user.Text = Session["current_user_name"].ToString();
                // 判断项目进行情况
                DateTime start = Convert.ToDateTime(ds.Tables[0].Rows[0]["start_time"].ToString());
                DateTime end = Convert.ToDateTime(ds.Tables[0].Rows[0]["end_time"].ToString());
                if (DateTime.Now > start && DateTime.Now < end)
                {
                    status.ForeColor = System.Drawing.Color.Black;
                    status.Text = "测试中";
                }
                else if (DateTime.Now < start)
                {
                    status.ForeColor = System.Drawing.Color.Goldenrod;
                    status.Text = "未开始";
                }
                else
                {
                    status.ForeColor = System.Drawing.Color.Crimson;
                    status.Text = "已过期";
                }
                
            }
            else
            {
                creation_date.Text = "";
                start_time.Text = "";
                end_time.Text = "";
                user.Text = "";
                status.Text = "";
            }
        }

        /// <summary>
        /// 生成测试报告
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_Generate_Report_Click(object sender, EventArgs e)
        {
            if (DropDownList_test.Items.Count == 0)
            {
                alert_text.InnerHtml = "没有测试系统";
                alert.Visible = true;
            }
            else if (DropDownList_test_version.Items.Count == 0)
            {
                alert_text.InnerHtml = "没有版本";
                alert.Visible = true;
            }
            else
            {
                Response.Write("<script     language='javascript'>window.open('/platform/test_report.aspx');</script>");
            }
        }
    }

}