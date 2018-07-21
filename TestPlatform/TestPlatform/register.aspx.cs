using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace TestPlatform
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 已登录跳转回用户主界面
            if (Session["current_user_id"] != null && Session["current_user_id"].ToString() != "" && Session["current_user_id"].ToString() != "0")
            {
                Response.Redirect("/platform/platform_home.aspx");
            }

            alert.Attributes["class"] = "alert alert-danger";
            alert.Visible = false;
        }

        protected void Button_Regist_Click(object sender, EventArgs e)
        {
            Users users = new Users();
            users.name = this.username.Value;
            users.password = md5Helper.MD5Encrypt(this.password.Value);
            string password_confirm = md5Helper.MD5Encrypt(this.password_confirm.Value);
            users.email = this.email.Value;
            users.phone = this.phone.Value;
            users.reg_datetime = DateTime.Now;
            users.department = Convert.ToInt32(this.DropDownList_department.SelectedValue);
            users.role = Convert.ToInt32(this.DropDownList_role.SelectedValue);
            users.reg_status = 1; // 待审核

            string sql = new StringBuilder("insert into users")
                .Append(" (name, password, email, phone, reg_datetime, department, role, reg_status)")
                .Append(" values (@name, @password, @email, @phone, @reg_datetime, @department, @role, @reg_status)").ToString();

            SqlParameter[] parameters = {
                    new SqlParameter("@name", users.name),
                    new SqlParameter("@password", users.password),
                    new SqlParameter("@email", users.email),
                    new SqlParameter("@phone", users.phone),
                    new SqlParameter("@reg_datetime", users.reg_datetime.ToString("yyyy/MM/dd HH:mm:ss")),
                    new SqlParameter("@department", users.department),
                    new SqlParameter("@role", users.role),
                    new SqlParameter("@reg_status", users.reg_status),
            };

            // 邮箱格式正则表达式
            string emailStr = @"([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,5})+";
            string phoneStr = @"(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}";

            if (users.name.Length < 6 || users.name.Length > 16)
            {
                alert_text.InnerText = "用户名长度为6~16位";
            }
            else if (users.password.Length < 6 || users.password.Length > 16)
            {
                alert_text.InnerText = "密码长度为6~16位";
            }
            else if (users.password != password_confirm)
            {
                alert_text.InnerText = "密码不一致";
            }
            else if (users.email != "" && !(System.Text.RegularExpressions.Regex.IsMatch(users.email, emailStr)))
            {
                alert_text.InnerText = "请输入正确的邮箱格式";
            }
            else if (users.phone != "" && !(System.Text.RegularExpressions.Regex.IsMatch(users.phone, phoneStr)))
            {
                alert_text.InnerText = "请输入正确的手机号格式";
            }
            else if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
            {
                // 操作成功
                alert_text.InnerText = "注册申请已提交，等待管理员审核！ 3秒钟后跳转到登录页";
                alert.Attributes["class"] = "alert alert-success";
                //Response.Redirect("~/login.aspx");
                Response.Write("<meta http-equiv='Refresh' content='3; url=login.aspx' /> ");
            }
            else
            {
                alert_text.InnerText = "用户名已存在";
            }
            alert.Visible = true;

        }


        // 判断是否已存在用户
        public bool UserNameExist(string name)
        {
            string sql = "select * from users where name = '" + name + "'";
            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, null);
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }

    }
}