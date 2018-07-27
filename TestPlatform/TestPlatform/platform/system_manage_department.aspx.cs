using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;

namespace TestPlatform.platform
{
    public partial class system_manage_department : System.Web.UI.Page
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
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/system_manage_department_edit.aspx"))
            {
                GridView1.Columns[2].Visible = false;
                GridView1.Columns[3].Visible = false;
                Div_Add_Department.Visible = false;
            }

            alert.Attributes["class"] = "alert alert-danger";
            alert.Visible = false;
        }

        protected void Button_Add_Department_Click(object sender, EventArgs e)
        {
            Department department = new Department();
            department.name = this.input_add_department.Value;

            string sql = new StringBuilder("insert into base_department")
                .Append(" (name)")
                .Append(" values (@name)").ToString();

            SqlParameter[] parameters = {
                  new SqlParameter("@name", department.name),
            };

            if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
            {
                // 操作成功
                Response.AddHeader("Refresh", "0");
            }
            else
            {
                alert_text.InnerText = "机构名称已存在";
                alert.Visible = true;
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string sql = "delete from base_department where id = 0";

            // 如果当前机构没有人则可以删除
            string sql0 = new StringBuilder("select * from users where")
                .Append(" department = @department").ToString();
            SqlParameter[] parameters = { new SqlParameter("@department", GridView1.DataKeys[e.RowIndex]["id"].ToString()) };
            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql0, parameters);
            if (ds.Tables[0].Rows.Count == 0)
            {
                // 删除
                Session["editing_department_id"] = "";
                sql = "delete from base_department where id = '" + GridView1.DataKeys[e.RowIndex]["id"].ToString() + "'";
            }
            else
            {
                alert_text.InnerText = "该机构包含成员，不能删除";
                alert.Visible = true;
            }
            SqlDataSource_departmemnt.DeleteCommand = sql;
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // 编辑选择用户
            if (e.CommandName == "edit")
            {
                Session["editing_department_id"] = e.CommandArgument.ToString();
                Response.Redirect("/platform/system_manage_department_edit.aspx");
            }
        }
    }
}