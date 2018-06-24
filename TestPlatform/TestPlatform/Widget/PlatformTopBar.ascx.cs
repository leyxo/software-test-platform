using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace TestPlatform.Widget
{
    public partial class PlatformTopBar : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 修改HTML元素文本
            //this.username.InnerText = "欢迎您，" + Request.Form["TextBox_Username"];
        }

        // 修改界面用户名
        // asp用法：<%= getUsername() %>
        public string getUsername()
        {
            string html = Session["current_user"].ToString();
            //string html =  Request.Form["TextBox_Username"];
            return html;
        }


    }
}