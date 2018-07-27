using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
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
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // 查看报告
            if (e.CommandName == "report")
            {
                // 设置当前版本ID
                Session["current_test_version"] = e.CommandArgument.ToString();
                // 获取当前系统ID
                string sql = new StringBuilder("select test_id from sys_test_name_version where")
                    .Append(" id = @id").ToString();
                SqlParameter[] parameters = {
                    new SqlParameter("@id", Session["current_test_version"]),
            };
                DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
                Session["current_test_id"] = ds.Tables[0].Rows[0]["test_id"].ToString();

                Response.Write("<script>window.open('/platform/test_report.aspx');</script>");
            }
        }
    }
}