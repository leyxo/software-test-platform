using System;
using System.Data.SqlClient;
using System.Data;
using System.Text;

namespace TestPlatform
{
    public partial class login : System.Web.UI.Page
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

            checkbox.Visible = false;
        }

        protected void Button_Login_Click(object sender, EventArgs e)
        {
            string username = this.username.Value;
            string password = md5Helper.MD5Encrypt(this.password.Value);
            DataSet ds;
            // 验证码
            string checkCode = Session["serverCode"].ToString();
            string getCode = captcha.Value.Trim();
            
            if (getCode != checkCode)
            {
                alert.Attributes["class"] = "alert alert-danger";
                alert.InnerText = "验证码错误";
            }
            else if ((ds = IsLogin(username, password)) != null && ds.Tables[0].Rows.Count > 0) // result==1 验证通过
            {
                // Transfer，保留Request Form
                //Server.Transfer("~/platform_index.aspx", true);

                if (ds.Tables[0].Rows[0]["reg_status"].ToString() == "1")
                {
                    // 审核中
                    alert.Attributes["class"] = "alert alert-warning";
                    alert_text.InnerText = "用户信息正在审核中";
                }
                else if (ds.Tables[0].Rows[0]["reg_status"].ToString() == "4")
                {
                    // 未通过审核
                    alert.Attributes["class"] = "alert alert-danger";
                    alert_text.InnerText = "用户审核未通过";
                }
                else
                {
                    // Session
                    Session["current_user_name"] = ds.Tables[0].Rows[0][1].ToString();
                    Session["current_user_id"] = ds.Tables[0].Rows[0][0].ToString();
                    Session["current_user_department_id"] = ds.Tables[0].Rows[0][9].ToString();
                    Session["current_user_department_name"] = ds.Tables[0].Rows[0][10].ToString();
                    Session["current_user_role_id"] = ds.Tables[0].Rows[0][11].ToString();
                    Session["current_user_role_name"] = ds.Tables[0].Rows[0][12].ToString();
                    Session["current_user_reg_status_id"] = ds.Tables[0].Rows[0]["reg_status"].ToString();

                    Session["editing_user_id"] = "";
                    Session["editing_department_id"] = "";
                    Session["editing_test_id"] = "";
                    Session["current_test_id"] = "";
                    Session["current_test_version"] = "";

                    // 已通过审核，登录成功
                    this.password.Value = password;
                    Response.Redirect("~/platform/platform_home.aspx");
                }
            } 
            else
            {
                alert.Attributes["class"] = "alert alert-danger";
                alert_text.InnerText = "用户名或密码错误";
            }
            alert.Visible = true;
        }


        /// <summary>
        /// 判断是否登录成功，成功则返回一个DataSet，否则为null
        /// </summary>
        public static DataSet IsLogin(string username, string password)
        {
            string sql = new StringBuilder("select * from users, department, role where")
                .Append(" users.department = department.id and")
                .Append(" users.role = role.id and")
                .Append(" users.name = @name and")
                .Append(" users.password = @password").ToString();

            SqlParameter[] parameters = {
                    new SqlParameter("@name", username),    
                    new SqlParameter("@password", password),
            };

            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);            
            if (ds.Tables[0].Rows.Count > 0)
            {
                return ds;
            }
            else
                return null;
        }
    }
}