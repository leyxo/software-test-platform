using System;

namespace TestPlatform
{
    public partial class Debug : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int count = Request.Headers.Keys.Count;
            for (int i = 0; i < count; i ++)
            {
                string key = Request.Headers.Keys[i];
                this.Label1.Text += key + " : ";
                this.Label1.Text += Request.Headers[key];
                this.Label1.Text += "<br>";
            }
        }
    }
}