using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestPlatform.platform
{
    public partial class platform_home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //测试内容，需要删掉！！
                //Session["current_user_name"] = "Eric";
                //Session["current_user_id"] = "1";
                //Session["current_user_department_id"] = "3";
                //Session["current_user_role_id"] = "1";
                //Session["current_user_department_name"] = "微信开发部";

                //Session["editing_user_id"] = "";
                //Session["editing_department_id"] = "";
                //Session["editing_test_id"] = "";
                //Session["editing_issuetype_id"] = "";
                //Session["editing_test_case_id"] = "";
                //Session["current_test_id"] = "";
                //Session["current_test_version"] = "";

            }

            // 未登录跳转回登录界面
            if (Session["current_user_id"] == null)
            {
                Response.Redirect("/login.aspx");
            }

            // 根据权限初始化界面控件
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test.aspx"))
            {
                Div_Test_See_More.Visible = false;
            }
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_members.aspx"))
            {
                Div_Test_Members_See_More.Visible = false;
            }

            // 初始化首页用户数据
            // 小组人数
            string sql1 = "select * from users where department = " + Session["current_user_department_id"] + " and reg_status <> 1 and reg_status <> 4";
            DataSet ds1 = sqlHelper.ExecuteSqlDataSet(sql1, null);
            label_members_total.InnerHtml = ds1.Tables[0].Rows.Count.ToString();
            // 所有项目版本
            string sql2 = "select * from test_version INNER JOIN test ON test.id = test_version.test_id WHERE test.creation_department_id = " + Session["current_user_department_id"];
            DataSet ds2 = sqlHelper.ExecuteSqlDataSet(sql2, null);
            label_test_all.InnerHtml = ds2.Tables[0].Rows.Count.ToString();
            // 进行中的版本
            string sql3 = "select * from test_version INNER JOIN test ON test.id = test_version.test_id WHERE creation_department_id = " + Session["current_user_department_id"] + " AND ({ fn NOW() } >= test_version.start_time) AND ({ fn NOW() } < test_version.end_time)";
            DataSet ds3 = sqlHelper.ExecuteSqlDataSet(sql3, null);
            label_test_doing.InnerHtml = ds3.Tables[0].Rows.Count.ToString();

            
        }
    }
}