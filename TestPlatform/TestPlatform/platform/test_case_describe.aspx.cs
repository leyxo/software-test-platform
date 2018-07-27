using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace TestPlatform.platform
{
    public partial class test_case_describe : System.Web.UI.Page
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
                Response.Redirect("/platform/test_case.aspx");
            }

            alert.Attributes["class"] = "alert alert-danger";
            alert.Visible = false;

            if (null != Session["editing_test_case_id"] && "" != Session["editing_test_case_id"].ToString())
            {
                if (!IsPostBack)
                {
                    // 加载测试项目信息
                    string sql0 = new StringBuilder("select * from sys_test_record where")
                    .Append(" id = @id").ToString();

                    SqlParameter[] parameters0 = {
                    new SqlParameter("@id", Session["editing_test_case_id"]),
                };

                    DataSet ds0 = sqlHelper.ExecuteSqlDataSet(sql0, parameters0);
                    test_case_name.Value = ds0.Tables[0].Rows[0]["name"].ToString();
                    test_case_precondition.Value = ds0.Tables[0].Rows[0]["precondition"].ToString();
                    test_case_process.Value = ds0.Tables[0].Rows[0]["process"].ToString();
                    test_case_suggestion.Value = ds0.Tables[0].Rows[0]["suggestion"].ToString();
                    test_case_describes.Value = ds0.Tables[0].Rows[0]["describe"].ToString();
                }
            }
            else
            {
                Response.Redirect("/platform/test_case.aspx");
            }


            // 获取测试系统名称、版本号
            string sql = new StringBuilder("select name from sys_test_name where").Append(" id = @id").ToString();
            SqlParameter[] parameters = { new SqlParameter("@id", Session["current_test_id"]), };
            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
            string test_name = ds.Tables[0].Rows[0]["name"].ToString();
            Title_Test_Name.InnerHtml = test_name;

            string sql2 = new StringBuilder("select name from sys_test_name_version where").Append(" id = @id").ToString();
            SqlParameter[] parameters2 = { new SqlParameter("@id", Session["current_test_version"]), };
            DataSet ds2 = sqlHelper.ExecuteSqlDataSet(sql2, parameters2);
            string test_version = ds2.Tables[0].Rows[0]["name"].ToString();
            Title_Test_version.InnerHtml = test_version;
        }

        protected void Button_Save_Click(object sender, EventArgs e)
        {
            string describe = test_case_describes.Value;

            string sql = new StringBuilder("update sys_test_record set")
                .Append(" describe = @describe")
                .Append(" where id = @id").ToString();

            SqlParameter[] parameters = {
                    new SqlParameter("@describe", describe),
                    new SqlParameter("@id", Session["editing_test_case_id"]),
            };


            if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
            {
                Session["editing_test_case_id"] = "";
                Response.Redirect("/platform/test_case.aspx");
            }
            else
            {
                alert_text.InnerText = "操作失败";
            }
            alert.Visible = true;
        }

        protected void Button_Cancel_Click(object sender, EventArgs e)
        {
            Session["editing_test_case_id"] = "";
            Response.Redirect("/platform/test_case.aspx");
        }
    }
}