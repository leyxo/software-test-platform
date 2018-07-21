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
    public partial class test_members : System.Web.UI.Page
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

            // 获取部门名称
            string sql = new StringBuilder("select department.name from department where")
                .Append(" id = @id").ToString();
            SqlParameter[] parameters = {
                    new SqlParameter("@id", Session["current_user_department_id"]),
            };
            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
            string department_name = ds.Tables[0].Rows[0]["name"].ToString();

            Title_Department_Name.InnerHtml = department_name;
            Title_Members_Count.InnerHtml = GridView1.Rows.Count.ToString();

        }

        protected void Page_init(object sender, EventArgs e)
        {
            try
            {
                // 给SqlDataSource 动态赋值
                users_team_members.SelectParameters["department_id"].DefaultValue = Session["current_user_department_id"].ToString();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}