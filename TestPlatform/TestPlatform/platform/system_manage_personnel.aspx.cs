using System;
using System.Linq;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;

namespace TestPlatform.platform
{
    public partial class system_manage_personnel1 : System.Web.UI.Page
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
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/system_manage_personnel_edit.aspx"))
            {
                GridView1.Columns[8].Visible = false;
                GridView2.Columns[8].Visible = false;
                Button_Add.Visible = false;
            }

            alert.Attributes["class"] = "alert alert-danger";
            alert.Visible = false;

            // 待审核人员角标
            if (0 == GridView0.Rows.Count)
            {
                badge_personnel.InnerHtml = "";
            }
            else
            {
                badge_personnel.InnerHtml = GridView0.Rows.Count.ToString();
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string sql = "delete from users where id = '" + GridView1.DataKeys[e.RowIndex]["用户ID"].ToString() + "'";
            userinfo_enabled.DeleteCommand = sql;
        }

        protected void GridView0_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // 批准待审核用户
            if (e.CommandName == "accept")
            {
                string sql = new StringBuilder("update users set")
                .Append(" reg_status = 2")
                .Append(" where id = @id").ToString();

                SqlParameter[] parameters = {
                    new SqlParameter("@id", e.CommandArgument.ToString()),
                };
                sqlHelper.ExecuteNonQuery(sql, parameters);
                Response.AddHeader("Refresh", "0");
            }

            // 拒绝待审核用户
            if (e.CommandName == "refuse")
            {
                string sql = new StringBuilder("update users set")
                .Append(" reg_status = 3")
                .Append(" where id = @id").ToString();

                SqlParameter[] parameters = {
                    new SqlParameter("@id", e.CommandArgument.ToString()),
                };
                sqlHelper.ExecuteNonQuery(sql, parameters);
                Response.AddHeader("Refresh", "0");
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // 编辑选择用户
            if (e.CommandName == "edit")
            {
                Session["editing_user_id"] = e.CommandArgument.ToString();
                Response.Redirect("/platform/system_manage_personnel_edit.aspx");
            }

            // 删除选择
            if (e.CommandName == "del")
            {
                string sql = new StringBuilder("delete from users")
                    .Append(" where id = @id").ToString();
                SqlParameter[] parameters = {
                  new SqlParameter("@id", e.CommandArgument.ToString())
                    };

                if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
                {
                    // 操作成功
                    Response.Redirect("/platform/system_manage_personnel.aspx");
                }
                else
                {
                    alert_text.InnerText = "此用户有正在参与的项目，不可删除";
                    alert.Visible = true;
                }
            }
        }

        /// <summary>
        /// 新建用户
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button_Add_Click(object sender, EventArgs e)
        {
            Response.Redirect("/platform/system_manage_personnel_add.aspx");
        }
    }
}