﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestPlatform.platform
{
    public partial class basedata_manage_issuetype_edit : System.Web.UI.Page
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
                Response.Redirect("/platform/basedata_manage_issuetype.aspx");
            }

            alert.Attributes["class"] = "alert alert-danger";
            alert.Visible = false;

            if ("" != Session["editing_issuetype_id"].ToString())
            {
                if (!IsPostBack)
                {
                    // 加载用户信息
                    string sql = new StringBuilder("select * from test_issue_type where")
                    .Append(" id = @id").ToString();

                    SqlParameter[] parameters = {
                    new SqlParameter("@id", Session["editing_issuetype_id"]),
                };

                    DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
                    issue_name.Value = ds.Tables[0].Rows[0]["name"].ToString();
                    issue_describe.Value = ds.Tables[0].Rows[0]["describe"].ToString();
                }
            }
            else
            {
                Response.Redirect("/platform/system_manage_department.aspx");
            }
        }

        protected void Button_Save_Click(object sender, EventArgs e)
        {
            string name = issue_name.Value;
            string describe = issue_describe.Value;

            string sql = new StringBuilder("update test_issue_type set")
                .Append(" name = @name,")
                .Append(" describe = @describe")
                .Append(" where id = @id").ToString();


            SqlParameter[] parameters = {
                  new SqlParameter("@name", name),
                  new SqlParameter("@describe", describe),
                  new SqlParameter("@id", Session["editing_issuetype_id"].ToString())
            };

            if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
            {
                // 操作成功
                Response.Redirect("/platform/basedata_manage_issuetype.aspx");
            }
            else
            {
                alert_text.InnerText = "操作失败";
                alert.Visible = true;
            }
        }

        protected void Button_Cancel_Click(object sender, EventArgs e)
        {
            Session["editing_issuetype_id"] = "";
            Response.Redirect("/platform/basedata_manage_issuetype.aspx");
        }
    }
}
