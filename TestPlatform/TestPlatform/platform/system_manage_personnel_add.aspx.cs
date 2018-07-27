using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace TestPlatform.platform
{
    public partial class system_manage_personnel_add : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 未登录跳转回登录界面
            if (Session["current_user_id"] == null)
            {
                Response.Redirect("/login.aspx");
            }

            // 没有权限跳转回用户主页
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/system_manage_personnel_edit.aspx"))
            {
                Response.Redirect("/platform/system_manage_personnel.aspx");
            }

            alert.Attributes["class"] = "alert alert-danger";
            alert.Visible = false;
        }

        protected void Button_Save_Click(object sender, EventArgs e)
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
            users.reg_status = 2; // 有效人员

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

            if (users.name.Length > 16)
            {
                alert_text.InnerText = "用户名长度不超过16位";
            }
            else if (users.password.Length > 16)
            {
                alert_text.InnerText = "密码长度不超过16位";
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
                Response.Redirect("/platform/system_manage_personnel.aspx");
            }
            else
            {
                alert_text.InnerText = "注册失败，用户名可能已存在";
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

        protected void Button_Cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("/platform/system_manage_personnel.aspx");
        }
    }
}