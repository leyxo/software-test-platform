using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestPlatform
{
    public partial class platform_index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 未登录时重定向到登录界面
            if (Session["current_user"] == null)
            {
                Response.Redirect("~/login.aspx");
            }
        }
    }
}