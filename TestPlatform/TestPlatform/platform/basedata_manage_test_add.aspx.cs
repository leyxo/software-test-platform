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
    public partial class basedata_manage_test_add : System.Web.UI.Page
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
        }

        protected void Button_Save_Click(object sender, EventArgs e)
        {
            string name = this.test_name.Value;
            string describe = this.test_describe.Value;

            string sql = new StringBuilder("insert into test")
                .Append(" (name, describe, creation_department_id, creation_user_id, creation_date)")
                .Append(" values (@name, @describe, @creation_department_id, @creation_user_id, @creation_date)").ToString();

            SqlParameter[] parameters =
                {
                    new SqlParameter("@name", name),
                    new SqlParameter("@describe", describe),
                    new SqlParameter("@creation_department_id", Convert.ToInt32(Session["current_user_department_id"].ToString())),
                    new SqlParameter("@creation_user_id", Convert.ToInt32(Session["current_user_id"].ToString())),
                    new SqlParameter("@creation_date", DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")),
                };

            if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
            {
                // 操作成功
                alert_text.InnerText = "保存成功";
                alert.Attributes["class"] = "alert alert-success";

                // Session["current_test_id"]设为当前添加项
                string sql0 = new StringBuilder("select * from test where")
                   .Append(" name = @name").ToString();
                SqlParameter[] parameters0 = { new SqlParameter("@name", name) };
                DataSet ds0 = sqlHelper.ExecuteSqlDataSet(sql0, parameters0);
                Session["current_test_id"] = ds0.Tables[0].Rows[0]["id"].ToString();

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
            Response.Redirect("/platform/basedata_manage_test.aspx");
        }
    }
}