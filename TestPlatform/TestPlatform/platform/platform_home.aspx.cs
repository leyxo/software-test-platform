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
            // 未登录跳转回登录界面
            if (Session["current_user_id"] == null)
            {
                Response.Redirect("/login.aspx");
            }

            // 根据权限初始化界面控件
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/basedata_manage_test_version.aspx"))
            {
                Div_Test_See_More.Visible = false;
            }
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_members.aspx"))
            {
                Div_Test_Members_See_More.Visible = false;
            }

            //// 初始化首页用户数据
            //// 总人数
            //string sql1 = "select * from users where reg_status = 2";
            //DataSet ds1 = sqlHelper.ExecuteSqlDataSet(sql1, null);
            //label_members_total.InnerHtml = ds1.Tables[0].Rows.Count.ToString();
            //// 所有项目版本
            //string sql2 = "select * from test_version INNER JOIN test ON test.id = test_version.test_id INNER JOIN test_users ON test_users.test_id = test.id WHERE test_users.user_id = " + Session["current_user_id"];
            //DataSet ds2 = sqlHelper.ExecuteSqlDataSet(sql2, null);
            //label_test_all.InnerHtml = ds2.Tables[0].Rows.Count.ToString();
            //// 进行中的版本
            //string sql3 = "select * from test_version INNER JOIN test ON test.id = test_version.test_id INNER JOIN test_users ON test_users.test_id = test.id WHERE test_users.user_id = " + Session["current_user_id"] + " AND (test_version.is_finish = '0')";
            //DataSet ds3 = sqlHelper.ExecuteSqlDataSet(sql3, null);
            //label_test_doing.InnerHtml = ds3.Tables[0].Rows.Count.ToString();

            
        }
    }
}