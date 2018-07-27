using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;

namespace TestPlatform.platform
{
    public partial class basedata_manage_test_edit_users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 未登录跳转回登录界面
            if (Session["current_user_id"] == null)
            {
                Response.Redirect("/login.aspx");
            }

            // 没有权限跳转回用户主页
            if (!authHelper.hasAuthority(Convert.ToInt32(Session["current_user_role_id"]), "/platform/basedata_manage_test_edit.aspx"))
            {
                Response.Redirect("/platform/basedata_manage_test.aspx");
            }

            alert.Attributes["class"] = "alert alert-danger";
            alert.Visible = false;

            if (null != Session["editing_test_id"] && "" != Session["editing_test_id"].ToString())
            {
                if (!IsPostBack)
                {
                    // 获取测试系统名称
                    string sql0 = new StringBuilder("select name from sys_test_name where").Append(" id = @id").ToString();
                    SqlParameter[] parameters0 = { new SqlParameter("@id", Session["editing_test_id"]), };
                    DataSet ds0 = sqlHelper.ExecuteSqlDataSet(sql0, parameters0);
                    string test_name = ds0.Tables[0].Rows[0]["name"].ToString();
                    Title_Test_Name.InnerHtml = test_name;

                    // 加载用户分配表信息
                    string sql = "select * from sys_test_name_grant_users where test_id = '" + Session["editing_test_id"].ToString() + "'";
                    DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, null);
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        for (int j = 0; j < GridView1.Rows.Count; j++)
                        {
                            // 将已有项的对号添加到对应用户id行
                            if (ds.Tables[0].Rows[i]["user_id"].ToString() == GridView1.Rows[j].Cells[0].Text)
                            {
                                //int test_id = Convert.ToInt32(ds.Tables[0].Rows[i]["test_id"].ToString());
                                //int user_id = Convert.ToInt32(ds.Tables[0].Rows[i]["user_id"].ToString());
                                CheckBox checkBox = (CheckBox)GridView1.Rows[j].FindControl("CheckBox1");
                                checkBox.Checked = true;
                            }
                        }
                    }
                }
            }
            else
            {
                Response.Redirect("/platform/basedata_manage_test.aspx");
            }
        }

        protected void Button_Save_Click(object sender, EventArgs e)
        {
            // 先删除所有当前测试系统项
            string sql_clearAll = "delete from sys_test_name_grant_users where test_id = '" + Session["editing_test_id"].ToString() + "'";
            sqlHelper.ExecuteNonQuery(sql_clearAll, null);

            Session["current_test_id"] = "";
            Session["current_test_version"] = "";
            Session["current_basedata_test_id"] = "";
            Session["current_basedata_test_version"] = "";

            // 如果分配了至少一个用户，写入新的用户分配项
            bool flag = false;
            StringBuilder stringBuilder = new StringBuilder("insert into sys_test_name_grant_users (test_id, user_id) values");
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                CheckBox checkBox = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
                if (true == checkBox.Checked)
                {
                    flag = true;
                    stringBuilder.Append(" (" + Session["editing_test_id"].ToString() + "," + GridView1.Rows[i].Cells[0].Text + "), ");
                }
            }
            if (flag)
            {
                string sql = stringBuilder.ToString();
                sql = sql.Remove(sql.LastIndexOf(","), 1); // 截掉最后一个","

                if (-1 != sqlHelper.ExecuteNonQuery(sql, null))
                {
                    // 操作成功
                    alert_text.InnerText = "保存成功";
                    alert.Attributes["class"] = "alert alert-success";
                }
                else
                {
                    alert_text.InnerText = "操作失败";
                }
                alert.Visible = true;
            }

            Session["editing_test_id"] = "";
            Response.Redirect("/platform/basedata_manage_test.aspx");
        }

        protected void Button_Cancel_Click(object sender, EventArgs e)
        {
            Session["editing_test_id"] = "";
            Response.Redirect("/platform/basedata_manage_test.aspx");
        }
    }
}