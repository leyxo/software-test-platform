using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace TestPlatform
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 已登录跳转回用户主界面
            if (Session["current_user_id"] != null && Session["current_user_id"].ToString() != "" && Session["current_user_id"].ToString() != "0")
            {
                Response.Redirect("/platform/platform_home.aspx");
            }
        }

        // 解决 控件GirdView必须放在具有 runat=server 的窗体标记内 
        public override void VerifyRenderingInServerForm(Control control)
        {
            //base.VerifyRenderingInServerForm(control);
        }

    }
}