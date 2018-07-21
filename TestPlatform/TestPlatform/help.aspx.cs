using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestPlatform
{
    public partial class help : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 已登录跳转回用户主界面
            if (Session["current_user_id"] != null && Session["current_user_id"].ToString() != "" && Session["current_user_id"].ToString() != "0")
            {
                Response.Redirect("/platform/platform_home.aspx");
            }
        }
    }
}