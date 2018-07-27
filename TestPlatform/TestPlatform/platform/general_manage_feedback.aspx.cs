using System;
using System.Net;
using System.Net.Mail;

namespace TestPlatform.platform
{
    public partial class general_manage_feedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 未登录跳转回登录界面
            if (Session["current_user_id"] == null)
            {
                Response.Redirect("/login.aspx");
            }

            if (!IsPostBack)
            {
                alert.Visible = false;
            }
        }

        protected void Button_Report_Click(object sender, EventArgs e)
        {
            try
            {
                string title = feedback_title.Value;
                string detail = feedback_detail.Value;

                sendEmail(Define.DEVELOPER_EMAIL, title, detail);

                alert_text.InnerText = "您的反馈已提交，谢谢！";
                alert.Attributes["class"] = "alert alert-success";
            }
            catch
            {
                alert_text.InnerText = "反馈提交失败！";
                alert.Attributes["class"] = "alert alert-danger";
            }
        }

        // 发送邮件给我
        private void sendEmail(string email, string title, string detail)
        {
            DateTime dt = DateTime.Now;
            var emailAcount = Define.EMAIL_SERVER_ACCOUNT;
            var emailPassword = Define.EMAIL_SERVER_PASSWORD;
            var reciver = email;
            var content = title + " \n\n" + detail + "\n\n" + Session["current_user_department_name"].ToString() + " " + Session["current_user_name"].ToString() + "\n\n软件测试平台 ver" + System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString() + "\n" + dt.ToString("yyyy/MM/dd HH:mm:ss");
            MailMessage message = new MailMessage();
            //设置发件人,发件人需要与设置的邮件发送服务器的邮箱一致
            MailAddress fromAddr = new MailAddress(emailAcount);
            message.From = fromAddr;
            //设置收件人,可添加多个,添加方法与下面的一样
            message.To.Add(reciver);
            //设置邮件标题
            message.Subject = "[软件测试平台 信息反馈]";
            //设置邮件内容
            message.Body = content;
            //设置邮件发送服务器,服务器根据你使用的邮箱而不同,可以到相应的邮箱管理后台查看
            SmtpClient client = new SmtpClient(Define.EMAIL_SERVER_HOST, Define.EMAIL_SERVER_PORT);
            //设置发送人的邮箱账号和密码
            client.Credentials = new NetworkCredential(emailAcount, emailPassword);
            //启用ssl
            client.EnableSsl = true;
            //发送邮件
            client.Send(message);
        }
    }
}