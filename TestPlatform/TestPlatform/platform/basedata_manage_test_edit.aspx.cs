﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace TestPlatform.platform
{
    public partial class basedata_manage_test_edit : System.Web.UI.Page
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
                Response.Redirect("/platform/basedata_manage_test.aspx");
            }

            alert.Attributes["class"] = "alert alert-danger";
            alert.Visible = false;

            if (null != Session["editing_test_id"] && "" != Session["editing_test_id"].ToString())
            {
                if (!IsPostBack)
                {
                    // 加载测试项目信息
                    string sql = new StringBuilder("select * from sys_test_name where")
                    .Append(" id = @id").ToString();

                    SqlParameter[] parameters = {
                    new SqlParameter("@id", Session["editing_test_id"]),
                };

                    DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        test_name.Value = ds.Tables[0].Rows[0]["name"].ToString();
                        test_describe.Value = ds.Tables[0].Rows[0]["describe"].ToString();
                        string available = ds.Tables[0].Rows[0]["available"].ToString();
                        if ("1" == available)
                        {
                            test_available.Checked = true;
                        }
                        else if ("0" == available)
                        {
                            test_available.Checked = false;
                        }
                    }
                    else
                    {
                        Response.Redirect("/platform/basedata_manage_test.aspx");
                    }
                }
            }
            else
            {
                Response.Redirect("/platform/basedata_manage_test.aspx");
            }
        }

        protected void Button_Save_Click(object sender, EventArgs e)
        {
            string name = this.test_name.Value;
            string describe = this.test_describe.Value;
            string available = "";
            if (test_available.Checked)
            {
                available = "1";
            }
            else
            {
                available = "0";
            }

            string sql = new StringBuilder("update sys_test_name set")
                .Append(" name = @name, describe = @describe, available = @available")
                .Append(" where id = @id").ToString();

            SqlParameter[] parameters = {
                    new SqlParameter("@name", name),
                    new SqlParameter("@describe", describe),
                    new SqlParameter("@available", available),
                    new SqlParameter("@id", Session["editing_test_id"]),
            };


            if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
            {
                // 操作成功
                alert_text.InnerText = "保存成功";
                alert.Attributes["class"] = "alert alert-success";
                Session["editing_test_id"] = "";
                Session["current_basedata_test_id"] = "";
                Response.Redirect("/platform/basedata_manage_test.aspx");
            }
            else
            {
                alert_text.InnerText = "操作失败";
            }
            alert.Visible = true;
        }

        protected void Button_Cancel_Click(object sender, EventArgs e)
        {
            Session["editing_test_id"] = "";
            Response.Redirect("/platform/basedata_manage_test.aspx");
        }
    }
}