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
    public partial class test_case_edit : System.Web.UI.Page
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

            if (null != Session["current_test_version"])
            {
                // 没有选中issue，返回前页
                if ("" == Session["current_test_version"].ToString() || "0" == Session["current_test_version"].ToString())
                {
                    Response.Redirect("/platform/test_case.aspx");
                }
                // 当前测试系统已经提交
                //else
                //{
                //    string sql0 = new StringBuilder("select is_finish from test_version where").Append(" id = @id").ToString();
                //    SqlParameter[] parameters0 = { new SqlParameter("@id", Session["current_test_version"]), };
                //    DataSet ds0 = sqlHelper.ExecuteSqlDataSet(sql0, parameters0);
                //    string is_finish = ds0.Tables[0].Rows[0]["is_finish"].ToString();
                //    if ("1" == is_finish)
                //    {
                //        Response.Redirect("/platform/test_case.aspx");
                //    }
                //}
            }

            if (null != Session["editing_test_case_id"] && "" != Session["editing_test_case_id"].ToString())
            {
                if (!IsPostBack)
                {
                    // 加载测试项目信息
                    string sql0 = new StringBuilder("select * from test_case where")
                    .Append(" id = @id").ToString();

                    SqlParameter[] parameters0 = {
                    new SqlParameter("@id", Session["editing_test_case_id"]),
                };

                    DataSet ds0 = sqlHelper.ExecuteSqlDataSet(sql0, parameters0);
                    test_case_name.Value = ds0.Tables[0].Rows[0]["name"].ToString();
                    test_case_precondition.Value = ds0.Tables[0].Rows[0]["precondition"].ToString();
                    test_case_process.Value = ds0.Tables[0].Rows[0]["process"].ToString();
                    test_case_suggestion.Value = ds0.Tables[0].Rows[0]["suggestion"].ToString();
                    test_case_describe.Value = ds0.Tables[0].Rows[0]["describe"].ToString();
                    test_case_times.Value = ds0.Tables[0].Rows[0]["times"].ToString();
                    DropDownList_type.SelectedValue = ds0.Tables[0].Rows[0]["type"].ToString();
                    string pass = ds0.Tables[0].Rows[0]["pass"].ToString();
                    if ("1" == pass)
                    {
                        test_case_pass.Checked = true;
                    }
                    else if ("2" == pass)
                    {
                        test_case_pass.Checked = false;
                    }
                }
            }
            else
            {
                Response.Redirect("/platform/test_case.aspx");
            }


            // 获取测试系统名称、版本号
            string sql = new StringBuilder("select name from test where").Append(" id = @id").ToString();
            SqlParameter[] parameters = { new SqlParameter("@id", Session["current_test_id"]), };
            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
            string test_name = ds.Tables[0].Rows[0]["name"].ToString();
            Title_Test_Name.InnerHtml = test_name;

            //string sql2 = new StringBuilder("select name from test_version where").Append(" id = @id").ToString();
            //SqlParameter[] parameters2 = { new SqlParameter("@id", Session["current_test_version"]), };
            //DataSet ds2 = sqlHelper.ExecuteSqlDataSet(sql2, parameters2);
            //string test_version = ds2.Tables[0].Rows[0]["name"].ToString();
            //Title_Test_version.InnerHtml = test_version;
        }

        protected void Button_Save_Click(object sender, EventArgs e)
        {
            string name = test_case_name.Value;
            string precondition = test_case_precondition.Value;
            string process = test_case_process.Value;
            string suggestion = test_case_suggestion.Value;
            string describe = test_case_describe.Value;
            string times = test_case_times.Value;
            int type = Convert.ToInt32(this.DropDownList_type.SelectedValue);
            string pass = "";
            if (test_case_pass.Checked)
            {
                pass = "1";
            }
            else
            {
                pass = "2";
            }

            string sql = new StringBuilder("update test_case set")
                .Append(" name = @name, precondition = @precondition, process = @process, suggestion = @suggestion, describe = @describe, times = @times, pass = @pass, type = @type")
                .Append(" where id = @id").ToString();

            SqlParameter[] parameters = {
                    new SqlParameter("@name", name),
                    new SqlParameter("@precondition", precondition),
                    new SqlParameter("@process", process),
                    new SqlParameter("@suggestion", suggestion),
                    new SqlParameter("@describe", describe),
                    new SqlParameter("@times", times),
                    new SqlParameter("@pass", pass),
                    new SqlParameter("@type", type),
                    new SqlParameter("@id", Session["editing_test_case_id"]),
            };


            if (-1 != sqlHelper.ExecuteNonQuery(sql, parameters))
            {
                // 操作成功
                //alert_text.InnerText = "保存成功";
                //alert.Attributes["class"] = "alert alert-success";
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