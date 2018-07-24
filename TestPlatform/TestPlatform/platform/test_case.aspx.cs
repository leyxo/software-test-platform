﻿using System;
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

            if (!IsPostBack)
            {
                setVersionInfo();
                initWidght();
                alert.Visible = false;
            }

            if (Session["current_test_id"] != null && Session["current_test_id"].ToString() == "")
            {
                // 第一次加载时，初始化Session["current_test_id"]和Session["current_test_version"]
                // 获取第一个项目id
                string sql = new StringBuilder("select test.id from test INNER JOIN test_users ON test.id = test_users.test_id where")
                    .Append(" test_users.user_id = @user_id").ToString();
                SqlParameter[] parameters = {
                    new SqlParameter("@user_id", Session["current_user_id"]),
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


        protected void initWidght()
        {
            // 根据权限初始化界面控件
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


        ///// <summary>
        ///// 在测试系统DropDownList数据绑定以后，选中指定默认项   ***注意此坑***
        ///// </summary>
        ///// <param name="sender"></param>
        ///// <param name="e"></param>
        //protected void DropDownList_test_DataBound(object sender, EventArgs e)
        //{
        //    if (Session["current_test_id"].ToString() != "" && Session["current_test_id"].ToString() != "0")
        //    {
        //        DropDownList_test.Items.FindByValue(Session["current_test_id"].ToString()).Selected = true;
        //        setVersionInfo();
        //        initWidght();
        //    }
        //}

        ///// <summary>
        ///// 在版本DropDownList数据绑定以后，选中指定默认项
        ///// </summary>
        ///// <param name="sender"></param>
        ///// <param name="e"></param>
        //protected void DropDownList_test_version_DataBound(object sender, EventArgs e)
        //{
        //    if (Session["current_test_version"].ToString() != "" && Session["current_test_version"].ToString() != "0")
        //    {
        //        DropDownList_test_version.Items.FindByValue(Session["current_test_version"].ToString()).Selected = true;
        //        setVersionInfo();
        //        initWidght();
        //    }
        //}
        
        ///// <summary>
        ///// 在测试系统DropDownList改变选择时
        ///// </summary>
        ///// <param name="sender"></param>
        ///// <param name="e"></param>
        //protected void DropDownList_test_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    // 初始化 Session["current_test_version"]
        //    Session["current_test_id"] = DropDownList_test.SelectedValue;
        //    // 获取第一个版本id
        //    string sql = new StringBuilder("select id from test_version where")
        //        .Append(" test_id = @test_id").ToString();
        //    SqlParameter[] parameters = {
        //            new SqlParameter("@test_id", Session["current_test_id"]),
        //            };
        //    DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
        //    if (ds.Tables[0].Rows.Count > 0)
        //    {
        //        Session["current_test_version"] = ds.Tables[0].Rows[0]["id"].ToString();
        //    }
        //    else
        //    {
        //        Session["current_test_version"] = "0";
        //    }
        //    setVersionInfo();
        //    initWidght();
        //}

        ///// <summary>
        ///// 在版本DropDownList改变选择时
        ///// </summary>
        ///// <param name="sender"></param>
        ///// <param name="e"></param>
        //protected void DropDownList_test_version_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    Session["current_test_version"] = DropDownList_test_version.SelectedValue;
        //    setVersionInfo();
        //    initWidght();
        //}


        protected void Button_Add_Case_Click(object sender, EventArgs e)
        {
            //if (DropDownList_test.Items.Count == 0)
            //{
            //    alert_text.InnerHtml = "没有测试系统";
            //    alert.Visible = true;
            //}
            //else if (DropDownList_test_version.Items.Count == 0)
            //{
            //    alert_text.InnerHtml = "没有版本";
            //    alert.Visible = true;
            //}
            //else
            //{
                string sql = "select * from test_version where id = " + Session["current_test_version"];
                DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, null);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    // 判断项目进行情况
                    string is_finish = ds.Tables[0].Rows[0]["is_finish"].ToString();
                    if ("0" == is_finish)
                    {
                        Response.Redirect("/platform/test_case_add.aspx");
                    }
                    else
                    {
                        alert_text.InnerHtml = "版本已提交";
                        alert.Visible = true;
                    }
                }
            //}
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
            if (Session["current_test_version"] != null && Session["current_test_version"].ToString() != "")
            {
                string sql = "select test.name, test_version.name, test_version.creation_date, start_time, end_time, summary, is_finish  from test_version INNER JOIN test ON test.id = test_version.test_id where test_version.id = " + Session["current_test_version"];
                DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, null);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    label_test.Text = ds.Tables[0].Rows[0][0].ToString();
                    label_test_version.Text = ds.Tables[0].Rows[0][1].ToString();

                    creation_date.Text = ds.Tables[0].Rows[0][2].ToString().Split(' ')[0];
                    start_time.Text = ds.Tables[0].Rows[0][3].ToString().Split(' ')[0];
                    end_time.Text = ds.Tables[0].Rows[0][4].ToString().Split(' ')[0];
                    textfield_summary.Value = ds.Tables[0].Rows[0][5].ToString();
                    user.Text = Session["current_user_name"].ToString();
                    // 判断项目进行情况
                    string is_finish = ds.Tables[0].Rows[0][6].ToString();
                    if ("0" == is_finish)
                    {
                        // 可以写测试，可以[提交]，不可写总结，不可[完成]，不可写回馈，不可看报告
                        status.ForeColor = System.Drawing.Color.Green;
                        status.Text = "测试中";
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
                        // 不可写测试，不可[提交]，可以写总结，可以[完成]，不可写回馈，不可看报告
                        status.ForeColor = System.Drawing.Color.DarkOrange;
                        status.Text = "已提交";
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
                        // 不可写测试，不可[提交]，不可写总结，不可[完成]，可以写回馈，可以看报告
                        status.ForeColor = System.Drawing.Color.Black;
                        status.Text = "已完成";
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
                    creation_date.Text = "";
                    start_time.Text = "无";
                    end_time.Text = "无";
                    user.Text = "";
                    status.Text = "";

                    // 啥也没有时，让按钮全部再见
                    Button_Save.Visible = false;
                    Button_Submit.Visible = false;
                    Button_Generate_Report.Visible = false;
                    Button_Add_Case.Visible = false;
                    Button_Finish.Visible = false;
                    textfield_summary.Value = "";
                }
            }
            else
            {
                creation_date.Text = "";
                start_time.Text = "";
                end_time.Text = "";
                user.Text = "";
                status.Text = "";

                Button_Save.Visible = false;
                Button_Submit.Visible = false;
                Button_Generate_Report.Visible = false;
                Button_Add_Case.Visible = false;
                Button_Finish.Visible = false;
                textfield_summary.Value = "";
            }
        }

        /// <summary>
        /// 生成测试报告
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_Generate_Report_Click(object sender, EventArgs e)
        {
            //if (DropDownList_test.Items.Count == 0)
            //{
            //    alert_text.InnerHtml = "没有测试系统";
            //    alert.Visible = true;
            //}
            //else if (DropDownList_test_version.Items.Count == 0)
            //{
            //    alert_text.InnerHtml = "没有版本";
            //    alert.Visible = true;
            //}
            //else
            //{
                Response.Write("<script     language='javascript'>window.open('/platform/test_report.aspx');</script>");
            //}
        }

        /// <summary>
        /// 提交当前版本 (is_finish状态置1)
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_Submit_Click(object sender, EventArgs e)
        {
            //if (DropDownList_test.Items.Count == 0)
            //{
            //    alert_text.InnerHtml = "没有测试系统";
            //    alert.Visible = true;
            //}
            //else if (DropDownList_test_version.Items.Count == 0)
            //{
            //    alert_text.InnerHtml = "没有版本";
            //    alert.Visible = true;
            //}
            //else
            //{
                string sql = new StringBuilder("update test_version set")
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
            //}
        }

        /// <summary>
        /// 完成测试 (is_finish状态置2)
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_Finish_Click(object sender, EventArgs e)
        {
            //if (DropDownList_test.Items.Count == 0)
            //{
            //    alert_text.InnerHtml = "没有测试系统";
            //    alert.Visible = true;
            //}
            //else if (DropDownList_test_version.Items.Count == 0)
            //{
            //    alert_text.InnerHtml = "没有版本";
            //    alert.Visible = true;
            //}
            //else
            //{
                string sql = new StringBuilder("update test_version set")
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
            //}
        }

        /// <summary>
        /// 保存测试总结
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_Save_Click(object sender, EventArgs e)
        {
            string textfield_summary = this.textfield_summary.Value;

            //if (DropDownList_test.Items.Count == 0)
            //{
            //    alert_text.InnerHtml = "没有测试系统";
            //    alert.Visible = true;
            //}
            //else if (DropDownList_test_version.Items.Count == 0)
            //{
            //    alert_text.InnerHtml = "没有版本";
            //    alert.Visible = true;
            //}
            //else
            //{
                string sql = new StringBuilder("update test_version set")
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
            //}
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

        
    }

}