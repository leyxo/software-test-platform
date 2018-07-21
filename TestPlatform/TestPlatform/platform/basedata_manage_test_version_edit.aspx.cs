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
    public partial class basedata_manage_test_version_edit : System.Web.UI.Page
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
                Response.Redirect("/platform/basedata_manage_test_version.aspx");
            }

            alert.Attributes["class"] = "alert alert-danger";
            alert.Visible = false;

            // 获取测试系统名称、版本号
            string sql = new StringBuilder("select name from test where").Append(" id = @id").ToString();
            SqlParameter[] parameters = { new SqlParameter("@id", Session["current_test_id"]), };
            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
            string test_name = ds.Tables[0].Rows[0]["name"].ToString();
            Title_Test_Name.InnerHtml = test_name;

            if (null != Session["editing_test_version_id"] && "" != Session["editing_test_version_id"].ToString())
            {
                if (!IsPostBack)
                {
                    // 加载测试项目信息
                    string sql2 = new StringBuilder("select * from test_version where")
                    .Append(" id = @id").ToString();

                    SqlParameter[] parameters2 = {
                    new SqlParameter("@id", Session["editing_test_version_id"]),
                };

                    DataSet ds2 = sqlHelper.ExecuteSqlDataSet(sql2, parameters2);
                    version_name.Value = ds2.Tables[0].Rows[0]["name"].ToString();
                    start_time.Value = Convert.ToDateTime(ds2.Tables[0].Rows[0]["start_time"].ToString()).ToShortDateString().ToString();
                    end_time.Value = Convert.ToDateTime(ds2.Tables[0].Rows[0]["end_time"].ToString()).ToShortDateString().ToString();
                }
            }
            else
            {
                Response.Redirect("/platform/basedata_manage_test_version.aspx");
            }
        }

        protected void Button_Save_Click(object sender, EventArgs e)
        {
            string name = this.version_name.Value;
            DateTime start_time = Convert.ToDateTime(this.start_time.Value);
            DateTime end_time = Convert.ToDateTime(this.end_time.Value);

            string sql = new StringBuilder("update test_version set")
                .Append(" name = @name, start_time = @start_time, end_time = @end_time")
                .Append(" where id = @id").ToString();

            SqlParameter[] parameters = {
                    new SqlParameter("@name", name),
                    new SqlParameter("@start_time", start_time.ToString()),
                    new SqlParameter("@end_time", end_time.ToString()),
                    new SqlParameter("@id", Session["editing_test_version_id"]),
            };


            if (start_time > end_time)
            {
                alert_text.InnerText = "起始日期不能大于结束日期！";
                alert.Attributes["class"] = "alert alert-danger";
                alert.Visible = true;
            }
            else if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
            {
                // 操作成功
                alert_text.InnerText = "保存成功";
                alert.Attributes["class"] = "alert alert-success";
                Session["editing_test_id"] = "";
                Response.Redirect("/platform/basedata_manage_test_version.aspx");
            }
            else
            {
                alert_text.InnerText = "操作失败";
            }
            alert.Visible = true;
        }

        protected void Button_Cancel_Click(object sender, EventArgs e)
        {
            Session["editing_test_version_id"] = "";
            Response.Redirect("/platform/basedata_manage_test_version.aspx");
        }
    }
}