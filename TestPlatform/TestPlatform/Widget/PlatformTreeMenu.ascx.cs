using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestPlatform.Widget
{
    public partial class PlatformTreeMenu : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 初始化菜单项角标
            string sql = "select * from users where reg_status = 1";

            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, null);
            if (0 == ds.Tables[0].Rows.Count)
            {
                badge_personnel.InnerHtml = "";
                badge_system_manage.InnerHtml = "";
            }
            else
            {
                badge_personnel.InnerHtml = ds.Tables[0].Rows.Count.ToString();
                badge_system_manage.InnerHtml = ds.Tables[0].Rows.Count.ToString();
            }

            // 根据权限初始化菜单项

            // 测试管理
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/basedata_manage_test_version.aspx"))
            {
                basedata_manage_test_version.Visible = false;
            }
            //if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_case.aspx"))
            //{
            //    test_case.Visible = false;
            //}
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_members.aspx"))
            {
                test_members.Visible = false;
            }
            // 测试管理(Menu)
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/basedata_manage_test_version.aspx") && !authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_members.aspx"))
            {
                test_manage_menu.Visible = false;
            }

            // 基础数据管理
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/basedata_manage_issuetype.aspx"))
            {
                basedata_manage_issuetype.Visible = false;
            }
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/basedata_manage_test.aspx"))
            {
                basedata_manage_test.Visible = false;
            }
            // 基础数据管理(Menu)
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/basedata_manage_issuetype.aspx") && !authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/basedata_manage_test.aspx"))
            {
                basedata_manage_menu.Visible = false;
            }

            // 系统管理
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/system_manage_personnel.aspx"))
            {
                badge_personnel.InnerHtml = "";
                badge_system_manage.InnerHtml = "";
                system_manage_personnel.Visible = false;
            }
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/system_manage_department.aspx"))
            {
                system_manage_department.Visible = false;
            }
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/system_manage_authority.aspx"))
            {
                system_manage_authority.Visible = false;
            }
            // 系统管理(Menu)
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/system_manage_personnel.aspx") && !authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/system_manage_department.aspx") && !authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/system_manage_authority.aspx"))
            {
                system_manage_menu.Visible = false;
            }

        }
    }
}