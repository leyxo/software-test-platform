using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestPlatform.platform
{
    public partial class basedata_manage_issuetype : System.Web.UI.Page
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
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/basedata_manage_issuetype_edit.aspx"))
            {
                GridView1.Columns[3].Visible = false;
                GridView1.Columns[4].Visible = false;
                Table_Add.Visible = false;
            }

            LinkButton linkButton_edit1 = (LinkButton)GridView1.Rows[0].FindControl("LinkButton_edit");
            LinkButton linkButton_edit2 = (LinkButton)GridView1.Rows[1].FindControl("LinkButton_edit");
            LinkButton linkButton_delete_1 = (LinkButton)GridView1.Rows[0].FindControl("LinkButton_delete");
            LinkButton linkButton_delete_2 = (LinkButton)GridView1.Rows[1].FindControl("LinkButton_delete");
            linkButton_edit1.Visible = false;
            linkButton_edit2.Visible = false;
            linkButton_delete_1.Visible = false;
            linkButton_delete_2.Visible = false;


            alert.Attributes["class"] = "alert alert-danger";
            alert.Visible = false;
        }

        protected void Button_Add_Click(object sender, EventArgs e)
        {
            string name = input_add.Value;
            string describe = input_describe.Value;
            string point = input_point.Value;

            string sql = new StringBuilder("insert into test_issue_type")
                .Append(" (name, describe, point)")
                .Append(" values (@name, @describe, @point)").ToString();

            SqlParameter[] parameters = {
                  new SqlParameter("@name", name),
                  new SqlParameter("@describe", describe),
                  new SqlParameter("@point", point),
            };

            if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
            {
                // 操作成功
                Response.AddHeader("Refresh", "0");
                //alert_text.InnerText = "添加成功";
                //alert.Attributes["class"] = "alert alert-success";
                //alert.Visible = true;
            }
            else
            {
                alert_text.InnerText = "添加失败";
                alert.Attributes["class"] = "alert alert-danger";
                alert.Visible = true;
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // 编辑选择
            if (e.CommandName == "edit")
            {
                Session["editing_issuetype_id"] = e.CommandArgument.ToString();
                Response.Redirect("/platform/basedata_manage_issuetype_edit.aspx");
            }

            // 删除选择
            if (e.CommandName == "del")
            {
                if ("1" == e.CommandArgument.ToString() || "2" == e.CommandArgument.ToString())
                {
                    alert_text.InnerText = "基础数据，不可删除";
                    alert.Visible = true;
                }
                else
                {
                    string sql = new StringBuilder("delete from test_issue_type")
                    .Append(" where id = @id").ToString();
                    SqlParameter[] parameters = {
                  new SqlParameter("@id", e.CommandArgument.ToString())
                    };

                    if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
                    {
                        // 操作成功
                        Response.Redirect("/platform/basedata_manage_issuetype.aspx");
                    }
                    else
                    {
                        alert_text.InnerText = "已有测试项目正在使用当前类型，不可删除";
                        alert.Visible = true;
                    }
                }
            }
        }
    }
}