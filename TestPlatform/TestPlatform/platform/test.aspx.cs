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
    public partial class test : System.Web.UI.Page
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

            // 初始化表中数据sql语句，选出当前项目组的项目
            //test_all.SelectCommand = "SELECT test.id AS ID, test.name AS 项目名称, users.name AS 创建者, test.describe AS 简介, test.creation_date AS 项目创建日期 FROM test INNER JOIN users ON users.id = test.creation_user_id AND test.creation_user_id = users.id WHERE (test.creation_department_id = '" + Session["current_user_department_id"] + "')";
            Title_All_Test_Count.InnerHtml = GridView1.Rows.Count.ToString();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // 编辑选择项目
            if (e.CommandName == "start")
            {
                // 初始化 Session["current_test_version"]
                Session["current_test_id"] = e.CommandArgument.ToString();
                // 获取第一个版本id
                string sql = new StringBuilder("select id from test_version where")
                    .Append(" test_id = @test_id").ToString();
                SqlParameter[] parameters = {
                    new SqlParameter("@test_id", Session["current_test_id"]),
                    };
                DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Session["current_test_version"] = ds.Tables[0].Rows[0]["id"].ToString();
                }
                else
                {
                    Session["current_test_version"] = "0";
                }

                Response.Redirect("/platform/test_case.aspx");
            }
        }

    }
}