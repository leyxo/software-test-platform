using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

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
            string sql = new StringBuilder("select name from sys_test_name where").Append(" id = @id").ToString();
            SqlParameter[] parameters = { new SqlParameter("@id", Session["current_basedata_test_id"]), };
            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
            string test_name = ds.Tables[0].Rows[0]["name"].ToString();
            Title_Test_Name.InnerHtml = test_name;

            if (null != Session["editing_test_version_id"] && "" != Session["editing_test_version_id"].ToString())
            {
                if (!IsPostBack)
                {
                    // 加载测试项目信息
                    string sql2 = new StringBuilder("select * from sys_test_name_version where")
                    .Append(" id = @id").ToString();

                    SqlParameter[] parameters2 = {
                    new SqlParameter("@id", Session["editing_test_version_id"]),
                };

                    DataSet ds2 = sqlHelper.ExecuteSqlDataSet(sql2, parameters2);
                    if (ds2.Tables[0].Rows.Count > 0)
                    {
                        version_name.Value = ds2.Tables[0].Rows[0]["name"].ToString();
                        if (ds2.Tables[0].Rows[0]["start_time"].ToString() != "")
                        {
                            start_time.Value = Convert.ToDateTime(ds2.Tables[0].Rows[0]["start_time"].ToString()).ToShortDateString().ToString();
                        }
                        if (ds2.Tables[0].Rows[0]["end_time"].ToString() != "")
                        {
                            end_time.Value = Convert.ToDateTime(ds2.Tables[0].Rows[0]["end_time"].ToString()).ToShortDateString().ToString();
                        }
                        if (ds2.Tables[0].Rows[0]["creation_date"].ToString() != "")
                        {
                            creation_date.Value = Convert.ToDateTime(ds2.Tables[0].Rows[0]["creation_date"].ToString()).ToShortDateString().ToString();
                        }
                    }
                    else
                    {
                        Response.Redirect("/platform/basedata_manage_test_version.aspx");
                    }
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
            string start_time = "";
            string end_time = "";
            string creation_date = "";
            if ("" != this.start_time.Value)
            {
                start_time = Convert.ToDateTime(this.start_time.Value).ToString();
            }
            if ("" != this.end_time.Value)
            {
                end_time = Convert.ToDateTime(this.end_time.Value).ToString();
            }
            if ("" != this.creation_date.Value)
            {
                creation_date = Convert.ToDateTime(this.creation_date.Value).ToString();
            }

            string sql = new StringBuilder("update sys_test_name_version set")
                .Append(" name = @name, start_time = @start_time, end_time = @end_time, creation_date = @creation_date")
                .Append(" where id = @id").ToString();

            SqlParameter[] parameters = {
                    new SqlParameter("@name", name),
                    new SqlParameter("@start_time", start_time),
                    new SqlParameter("@end_time", end_time),
                    new SqlParameter("@creation_date", creation_date),
                    new SqlParameter("@id", Session["editing_test_version_id"]),
            };

            // 起止日期允许为空
            if (start_time == "")
            {
                parameters[1].IsNullable = true;
                parameters[1].Value = DBNull.Value;
            }
            if (end_time == "")
            {
                parameters[2].IsNullable = true;
                parameters[2].Value = DBNull.Value;
            }
            if (creation_date == "")
            {
                parameters[3].IsNullable = true;
                parameters[3].Value = DBNull.Value;
            }

            if ("" != this.start_time.Value && "" != this.end_time.Value && Convert.ToDateTime(start_time) > Convert.ToDateTime(end_time))
            {
                alert_text.InnerText = "起始日期不能大于结束日期！";
                alert.Attributes["class"] = "alert alert-danger";
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