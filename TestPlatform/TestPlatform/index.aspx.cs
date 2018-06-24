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
        static string strConn = ConfigurationManager.ConnectionStrings["webConnectionString"].ToString();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // 解决 控件GirdView必须放在具有 runat=server 的窗体标记内 
        public override void VerifyRenderingInServerForm(Control control)
        {
            //base.VerifyRenderingInServerForm(control);
        }
    }
}