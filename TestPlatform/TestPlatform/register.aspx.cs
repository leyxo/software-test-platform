using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestPlatform
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.alert_userexisted.Visible = false;
        }

        protected void Button_Regist_Click(object sender, EventArgs e)
        {
            string name = this.username.Value;
            string password = md5Helper.MD5Encrypt(this.password.Value);
            string email = this.email.Value;
            string phone = this.phone.Value;
            int department = Convert.ToInt32(this.DropDownList_department.SelectedValue);
            int role = Convert.ToInt32(this.DropDownList_role.SelectedValue);
            int reg_status = 1; // 待审核

            string sql = "insert into users (name, password, email, phone, reg_datetime, department, role, reg_status) values ('" + name + "','" + password + "','" + email + "','" + phone + "','" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "'," + department + "," + role + "," + reg_status + ")";

            if (-1 != sqlHelper.ExecuteNonQuery(sql, null))
            {
                // 操作成功
                Response.Write("<script>alert('注册申请已提交，等待管理员审核！')</script>");
                Response.Redirect("~/login.aspx");
            }
            else
            {
                this.alert_userexisted.Visible = true;
            }

        }

        protected void Button_Back_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/index.aspx");
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