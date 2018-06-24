using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace TestPlatform
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.alert_wrong_userinfo.Visible = false;
        }

        protected void Button_Login_Click(object sender, EventArgs e)
        {
            string username = this.username.Value;
            string password = md5Helper.MD5Encrypt(this.password.Value);

            if (IsLogin(username, password))
            {
                // Session
                Session["current_user"] = username;

                // Transfer，保留Request Form
                //Server.Transfer("~/platform_index.aspx", true);

                Response.Redirect("~/platform_index.aspx");
            }
            else
            {
                this.alert_wrong_userinfo.Visible = true;
            }
        }


        /// <summary>
        /// 判断是否登录成功
        /// </summary>
        public static bool IsLogin(string username, string password)
        {
            string sql = "select * from users where name = '" + username + "' and password = '" + password + "'";
            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, null);            
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }
    }
}