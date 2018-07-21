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
    public partial class test_report : System.Web.UI.Page
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

            // 加载页头信息
            if (Session["current_test_id"] != null && Session["current_test_version"] != null && Session["current_test_id"].ToString() != "" && Session["current_test_version"].ToString() != "")
            {
                // 系统名称
                string sql = new StringBuilder("select * from test where")
                        .Append(" id = @id").ToString();
                SqlParameter[] parameters = {
                    new SqlParameter("@id", Session["current_test_id"]),
                };
                DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Title_Test_Name.InnerHtml = ds.Tables[0].Rows[0]["name"].ToString();
                    title.Text = ds.Tables[0].Rows[0]["name"].ToString();
                    name.Text = ds.Tables[0].Rows[0]["name"].ToString();
                }

                // 系统版本
                string sql2 = new StringBuilder("select * from test_version where")
                            .Append(" id = @id").ToString();
                SqlParameter[] parameters2 = {
                    new SqlParameter("@id", Session["current_test_version"]),
                    };
                DataSet ds2 = sqlHelper.ExecuteSqlDataSet(sql2, parameters2);
                if (ds2.Tables[0].Rows.Count > 0)
                {
                    version.Text = ds2.Tables[0].Rows[0]["name"].ToString();
                    title.Text += ds2.Tables[0].Rows[0]["name"].ToString() + " - 系统测试报告";
                }

                // 报告生成时间
                generate_time.Text = DateTime.Now.ToString();

                // 加载当前版本信息
                setVersionInfo();
            }
        }

        
        protected void setVersionInfo()
        {
            string sql = "select * from test_version where id = " + Session["current_test_version"];
            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, null);
            if (ds.Tables[0].Rows.Count > 0)
            {
                creation_date.Text = ds.Tables[0].Rows[0]["creation_date"].ToString();
                start_time.Text = ds.Tables[0].Rows[0]["start_time"].ToString().Split(' ')[0]; ;
                end_time.Text = ds.Tables[0].Rows[0]["end_time"].ToString().Split(' ')[0];
                Label_summery.Text = ds.Tables[0].Rows[0]["summary"].ToString();
                if (Label_summery.Text == "")
                {
                    Label_summery.Text = "无";
                }
                user.Text = Session["current_user_name"].ToString();
            }
            else
            {
                name.Text = "";
                version.Text = "";
                creation_date.Text = "";
                start_time.Text = "";
                end_time.Text = "";
                user.Text = "";
            }
        }
}
}