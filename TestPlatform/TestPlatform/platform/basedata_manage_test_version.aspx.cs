using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;

namespace TestPlatform.platform
{
    public partial class basedata_manage_test_version : System.Web.UI.Page
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
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/basedata_manage_test_version_add.aspx"))
            {
                Button_Add_Version.Visible = false;
            }
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/basedata_manage_test_version_edit.aspx"))
            {
                GridView1.Columns[8].Visible = false;
                GridView1.Columns[9].Visible = false;
            }
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/test_case.aspx"))
            {
                GridView1.Columns[10].Visible = false;
            }

            alert.Visible = false;

            if (Session["current_basedata_test_id"] != null && Session["current_basedata_test_id"].ToString() == "")
            {
                // 第一次加载时，初始化Session["current_basedata_test_id"]
                // 获取第一个项目id
                string sql = new StringBuilder("select sys_test_name.id from sys_test_name")
                    .Append(" INNER JOIN sys_test_name_grant_users ON sys_test_name_grant_users.test_id = sys_test_name.id WHERE sys_test_name_grant_users.user_id = @user_id and available = 1").ToString();
                SqlParameter[] parameters = {
                    new SqlParameter("@user_id", Session["current_user_id"]),
                };
                DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Session["current_basedata_test_id"] = ds.Tables[0].Rows[0]["id"].ToString();
                }
                else
                {
                    Session["current_basedata_test_id"] = "0";
                }
            }
        }

        /// <summary>
        /// 在测试系统DropDownList数据绑定以后，选中指定默认项   ***注意此坑***
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void DropDownList_test_DataBound(object sender, EventArgs e)
        {
            if (Session["current_basedata_test_id"].ToString() != "" && Session["current_basedata_test_id"].ToString() != "0")
            {
                DropDownList_test.Items.FindByValue(Session["current_basedata_test_id"].ToString()).Selected = true;
            }
        }

        /// <summary>
        /// 在测试系统DropDownList改变选择时
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void DropDownList_test_SelectedIndexChanged(object sender, EventArgs e)
        {
            // 初始化 Session["current_basedata_test_version"]
            Session["current_basedata_test_id"] = DropDownList_test.SelectedValue;
            // 获取第一个版本id
            string sql = new StringBuilder("select id from sys_test_name_version where")
                .Append(" test_id = @test_id").ToString();
            SqlParameter[] parameters = {
                    new SqlParameter("@test_id", Session["current_basedata_test_id"]),
                    };
            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Session["current_basedata_test_version"] = ds.Tables[0].Rows[0]["id"].ToString();
            }
            else
            {
                Session["current_basedata_test_version"] = "0";
            }
        }

        protected void Button_Add_Version_Click(object sender, EventArgs e)
        {
            if (DropDownList_test.Items.Count == 0)
            {
                alert_text.InnerHtml = "没有测试系统";
                alert.Visible = true;
            }
            else
            {
                Response.Redirect("/platform/basedata_manage_test_version_add.aspx");
            }
        }


        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // 编辑选择项目
            if (e.CommandName == "edit")
            {
                Session["editing_test_version_id"] = e.CommandArgument.ToString();
                Response.Redirect("/platform/basedata_manage_test_version_edit.aspx");
            }

            // 开始测试选择项目
            if (e.CommandName == "start")
            {
                // 初始化 Session["current_test_version"]
                Session["current_test_version"] = e.CommandArgument.ToString();
                // 获取第一个版本id
                string sql = new StringBuilder("select test_id from sys_test_name_version where")
                    .Append(" id = @id").ToString();
                SqlParameter[] parameters = {
                    new SqlParameter("@id", Session["current_test_version"]),
                    };
                DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Session["current_test_id"] = ds.Tables[0].Rows[0]["test_id"].ToString();
                }
                else
                {
                    Session["current_test_id"] = "0";
                }

                Response.Redirect("/platform/test_case.aspx");
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Session["current_test_version"] = "";
            Session["current_basedata_test_version"] = "";
            Session["editing_test_version_id"] = "";

            string sql = "delete from sys_test_name_version where id = '" + GridView1.DataKeys[e.RowIndex]["id"].ToString() + "'";
            SqlDataSource_test_version.DeleteCommand = sql;
        }
    }
}