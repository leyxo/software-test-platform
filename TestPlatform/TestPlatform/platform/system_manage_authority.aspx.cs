using System;
using System.Data;
using System.Text;
using System.Web.UI.WebControls;

namespace TestPlatform.platform
{
    public partial class system_manage_authority : System.Web.UI.Page
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

            alert.Attributes["class"] = "alert alert-danger";
            alert.Visible = false;

            if (!IsPostBack)
            {
                string sql0 = "select * from base_model";
                DataSet ds0 = sqlHelper.ExecuteSqlDataSet(sql0, null);
                for (int i = 0; i < ds0.Tables[0].Rows.Count; i++)
                {
                    // 菜单等级为1则置为空
                    if (ds0.Tables[0].Rows[i]["menu_level"].ToString() == "1")
                    {
                        CheckBox checkBox1 = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
                        CheckBox checkBox2 = (CheckBox)GridView1.Rows[i].FindControl("CheckBox2");
                        CheckBox checkBox3 = (CheckBox)GridView1.Rows[i].FindControl("CheckBox3");
                        CheckBox checkBox4 = (CheckBox)GridView1.Rows[i].FindControl("CheckBox4");
                        checkBox1.Visible = false;
                        checkBox2.Visible = false;
                        checkBox3.Visible = false;
                        checkBox4.Visible = false;
                        // 设置标题为粗体深蓝左侧对齐
                        GridView1.Rows[i].Cells[1].Font.Bold = true;
                        GridView1.Rows[i].Cells[1].ForeColor = System.Drawing.Color.CornflowerBlue;
                        GridView1.Rows[i].Cells[1].HorizontalAlign = HorizontalAlign.Left;
                    }

                    // 菜单等级为2则粗体左侧对齐
                    if (ds0.Tables[0].Rows[i]["menu_level"].ToString() == "2")
                    {
                        GridView1.Rows[i].Cells[1].Font.Bold = true;
                        GridView1.Rows[i].Cells[1].HorizontalAlign = HorizontalAlign.Left;
                    }
                        // 管理员的权限修改权限需要锁定
                        if (ds0.Tables[0].Rows[i]["name"].ToString() == "权限管理")
                    {
                        CheckBox checkBox1 = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
                        checkBox1.Checked = true;
                        checkBox1.Visible = false;
                    }
                }

                // 加载权限表信息
                string sql = "select * from base_grant_rolemodel";
                DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, null);
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    int model_id = Convert.ToInt32(ds.Tables[0].Rows[i]["model_id"].ToString());
                    int role_id = Convert.ToInt32(ds.Tables[0].Rows[i]["role_id"].ToString());
                    CheckBox checkBox = (CheckBox)GridView1.Rows[model_id - 1].FindControl("CheckBox" + role_id.ToString());
                    checkBox.Checked = true;
                }
                
            }
        }

        protected void Button_Save_Click(object sender, EventArgs e)
        {
            // 先清空权限表
            string sql_clearAll = "truncate table base_grant_rolemodel";
            sqlHelper.ExecuteNonQuery(sql_clearAll, null);

            // 写入新的权限项
            StringBuilder stringBuilder = new StringBuilder("insert into base_grant_rolemodel (role_id, model_id) values");
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                for (int j = 0; j < GridView1.Columns.Count - 2; j++)  // 一共有5列，其中有一列隐藏的ID项，所以-2
                {
                    CheckBox checkBox = (CheckBox)GridView1.Rows[i].FindControl("CheckBox" + (j + 1).ToString());
                    if (true == checkBox.Checked)
                    {
                        stringBuilder.Append(" (" + (j+1).ToString() +"," + (i+1).ToString() +"), ");
                    }
                }
            }
              
            string sql = stringBuilder.ToString();
            sql = sql.Remove(sql.LastIndexOf(","), 1); // 截掉sql语句最后一个","

            if (-1 != sqlHelper.ExecuteNonQuery(sql, null))
            {
                // 操作成功
                alert_text.InnerText = "保存成功！";
                alert.Attributes["class"] = "alert alert-success";

                // Logout
                Session.Clear();    //从会话状态集合中移除所有的键和值
                Session.Abandon();  //取消当前会话
                Response.Redirect("~/login.aspx");   //跳转登录页
            }
            else
            {
                alert_text.InnerText = "操作失败";
                alert.Attributes["class"] = "alert alert-danger";
            }
            alert.Visible = true;
        }

        protected void Button_Cancel_Click(object sender, EventArgs e)
        {
            Response.AddHeader("Refresh", "0");
        }
    }
}