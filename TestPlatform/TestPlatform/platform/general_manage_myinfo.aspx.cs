using System;
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
    public partial class general_manage_myinfo1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 未登录跳转回登录界面
            if (Session["current_user_id"] == null)
            {
                Response.Redirect("/login.aspx");
            }

            alert.Attributes["class"] = "alert alert-danger";
            alert.Visible = false;

            if (!IsPostBack)
            {
                // 加载用户信息
                string sql = new StringBuilder("select * from users where")
                .Append(" id = @id").ToString();

                SqlParameter[] parameters = {
                    new SqlParameter("@id", Session["current_user_id"]),
            };

                DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
                this.username.Value = ds.Tables[0].Rows[0]["name"].ToString();
                this.email.Value = ds.Tables[0].Rows[0]["email"].ToString();
                this.phone.Value = ds.Tables[0].Rows[0]["phone"].ToString();
                this.DropDownList_department.SelectedValue = ds.Tables[0].Rows[0]["department"].ToString();
                this.DropDownList_role.SelectedValue = ds.Tables[0].Rows[0]["role"].ToString();
            }
        }

        protected void Button_Save_Click(object sender, EventArgs e)
        {
            string name = this.username.Value;
            string email = this.email.Value;
            string phone = this.phone.Value;
            int department = Convert.ToInt32(this.DropDownList_department.SelectedValue);
            int role = Convert.ToInt32(this.DropDownList_role.SelectedValue);

            string sql = new StringBuilder("update users set")
                .Append(" email = @email, phone = @phone")
                .Append(" where id = @id").ToString();

            SqlParameter[] parameters = {
                    new SqlParameter("@email", email),
                    new SqlParameter("@phone", phone),
                    new SqlParameter("@id", Session["current_user_id"]),
            };

            // 邮箱格式正则表达式
            string emailStr = @"([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,5})+";
            string phoneStr = @"(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}";

            if (email != "" && !(System.Text.RegularExpressions.Regex.IsMatch(email, emailStr)))
            {
                alert_text.InnerText = "请输入正确的邮箱格式";
            }
            else if (phone != "" && !(System.Text.RegularExpressions.Regex.IsMatch(phone, phoneStr)))
            {
                alert_text.InnerText = "请输入正确的手机号格式";
            }
            else if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
            {
                // 操作成功
                alert_text.InnerText = "保存成功";
                alert.Attributes["class"] = "alert alert-success";
                Session["current_user_name"] = name;
                Response.Write("<meta http-equiv='Refresh' content='2;' /> ");
            }
            else
            {
                alert_text.InnerText = "操作失败";
            }
            alert.Visible = true;
        }

        protected void Button_Change_Password_Click(object sender, EventArgs e)
        {
            Response.Redirect("/platform/general_manage_myinfo_changepassword.aspx");
        }
    }
}