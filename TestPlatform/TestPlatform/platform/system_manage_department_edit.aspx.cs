using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace TestPlatform.platform
{
    public partial class system_manage_department_edit : System.Web.UI.Page
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
                Response.Redirect("/platform/system_manage_department.aspx");
            }

            alert.Attributes["class"] = "alert alert-danger";
            alert.Visible = false;

            if (null != Session["editing_department_id"] && "" != Session["editing_department_id"].ToString())
            {
                if (!IsPostBack)
                {
                    // 加载机构信息
                    string sql = new StringBuilder("select * from base_department where")
                    .Append(" id = @id").ToString();

                    SqlParameter[] parameters = {
                    new SqlParameter("@id", Session["editing_department_id"]),
                };

                    DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        department_name.Value = ds.Tables[0].Rows[0]["name"].ToString();
                    }
                    else
                    {
                        Response.Redirect("/platform/system_manage_department.aspx");
                    }
                }
            }
            else
            {
                Response.Redirect("/platform/system_manage_department.aspx");
            }
        }

        protected void Button_Save_Click(object sender, EventArgs e)
        {
            Department department = new Department();
            department.name = this.department_name.Value;

            string sql = new StringBuilder("update base_department set")
                .Append(" name = @name")
                .Append(" where id = @id").ToString();


            SqlParameter[] parameters = {
                  new SqlParameter("@name", department.name),
                  new SqlParameter("@id", Session["editing_department_id"].ToString())
            };

            if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
            {
                // 操作成功
                if (Session["editing_department_id"].ToString() == Session["current_user_department_id"].ToString())
                {
                    Session["current_user_department_name"] = department.name;
                }
                Response.Redirect("/platform/system_manage_department.aspx");
            }
            else
            {
                alert_text.InnerText = "机构名称已存在";
                alert.Visible = true;
            }
        }

        protected void Button_Cancel_Click(object sender, EventArgs e)
        {
            Session["editing_department_id"] = "";
            Response.Redirect("/platform/system_manage_department.aspx");
        }
    }
}