using System;
using System.Data;

namespace TestPlatform.platform
{
    public partial class general_manage_myinfo_changepassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 未登录跳转回登录界面
            if (Session["current_user_id"] == null)
            {
                Response.Redirect("/login.aspx");
            }

            if (!IsPostBack)
            {
                alert.Visible = false;
            }
        }

        protected void Button_Save_Click(object sender, EventArgs e)
        {
            string password_old = md5Helper.MD5Encrypt(this.password_old.Value);
            string password = md5Helper.MD5Encrypt(this.password.Value);
            string password_confirm = md5Helper.MD5Encrypt(this.password_confirm.Value);

            //查询旧密码是否正确
            string sql = "select password from users where id = " + Session["current_user_id"];
            DataSet ds;
            if ((ds = sqlHelper.ExecuteSqlDataSet(sql, null)) != null && ds.Tables[0].Rows[0][0].ToString() == password_old)
            {
                // 旧密码输入正确，开始修改密码
                string sql_updatePassword = "update users set password = '" + password + "' where id = " + Session["current_user_id"];

                if (this.password.Value.Length > 16)
                {
                    alert_text.InnerText = "密码长度不超过16位";
                    alert.Attributes["class"] = "alert alert-danger";
                }
                else if (password != password_confirm)
                {
                    alert_text.InnerText = "密码不一致";
                    alert.Attributes["class"] = "alert alert-danger";
                }
                else if (-1 != sqlHelper.ExecuteNonQuery(sql_updatePassword, null))
                {
                    // 操作成功
                    alert_text.InnerText = "密码修改成功！";
                    alert.Attributes["class"] = "alert alert-success";
                }
                else
                {
                    alert_text.InnerText = "操作失败";
                    alert.Attributes["class"] = "alert alert-danger";
                }
                alert.Visible = true;
            }
            else
            {
                alert_text.InnerText = "旧密码输入错误";
                alert.Attributes["class"] = "alert alert-danger";
            }
            alert.Visible = true;
        }

        protected void Button_Back_Click(object sender, EventArgs e)
        {
            Response.Redirect("/platform/general_manage_myinfo.aspx");
        }
    }
}