using System;
using System.Web.UI.WebControls;

namespace TestPlatform.platform
{
    public partial class basedata_manage_test : System.Web.UI.Page
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

            // 根据权限初始化界面控件
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/basedata_manage_test_add.aspx"))
            {
                Button_Add_Test.Visible = false;
            }
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/basedata_manage_test_edit.aspx"))
            {
                GridView1.Columns[7].Visible = false;
                GridView1.Columns[8].Visible = false;
                GridView1.Columns[9].Visible = false;
            }

            Title_All_Test_Count.InnerHtml = GridView1.Rows.Count.ToString();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // 编辑选择项目
            if (e.CommandName == "edit")
            {
                Session["editing_test_id"] = e.CommandArgument.ToString();
                Response.Redirect("/platform/basedata_manage_test_edit.aspx");
            }

            // 成员编辑
            if (e.CommandName == "edit_users")
            {
                Session["editing_test_id"] = e.CommandArgument.ToString();
                Response.Redirect("/platform/basedata_manage_test_edit_users.aspx");
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // 删除一项后，置当Session["current_test_id"]，Session["current_test_version"]为空
            Session["current_test_id"] = "";
            Session["current_test_version"] = "";
            Session["current_basedata_test_id"] = "";
            Session["current_basedata_test_version"] = "";
            Session["editing_test_id"] = "";

            string sql = "delete from sys_test_name where id = '" + GridView1.DataKeys[e.RowIndex]["ID"].ToString() + "'";
            test_all.DeleteCommand = sql;
        }

        protected void Button_Add_Test_Click(object sender, EventArgs e)
        {
            Response.Redirect("/platform/basedata_manage_test_add.aspx");
        }

    }
}