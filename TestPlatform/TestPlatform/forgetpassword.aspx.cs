using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestPlatform
{
    public partial class forgetpassword : System.Web.UI.Page
    {
        // 临时存储忘记密码部分数据的结构体
        public struct ForgotInfo
        {
            public static string email = ""; // 待发送邮箱
            public static string code = ""; // 当前验证码
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // 已登录跳转回用户主界面
            if (Session["current_user_id"] != null && Session["current_user_id"].ToString() != "" && Session["current_user_id"].ToString() != "0")
            {
                Response.Redirect("/platform/platform_home.aspx");
            }

            if (!IsPostBack)
            {
                alert.Visible = false;
            }
        }

        protected void Button_Login_Click(object sender, EventArgs e)
        {
            Users users = new Users();
            users.name = this.username.Value;
            users.password = md5Helper.MD5Encrypt(this.password.Value);
            string password_confirm = md5Helper.MD5Encrypt(this.password_confirm.Value);

            // 更新密码
            string sql = "update users set password = '" + users.password +"' where name = '" + users.name + "'";

            if ("" == ForgotInfo.code)
            {
                alert_text.InnerText = "还没有发送验证码";
                alert.Attributes["class"] = "alert alert-danger";
            }
            else if (captcha.Value != ForgotInfo.code)
            {
                alert_text.InnerText = "验证码错误";
                alert.Attributes["class"] = "alert alert-danger";
            }
            else if (this.password.Value.Length > 16)
            {
                alert_text.InnerText = "密码长度不超过16位";
                alert.Attributes["class"] = "alert alert-danger";
            }
            else if (users.password != password_confirm)
            {
                alert_text.InnerText = "密码不一致";
                alert.Attributes["class"] = "alert alert-danger";
            }
            else if (-1 != sqlHelper.ExecuteNonQuery(sql, null))
            {
                // 操作成功
                alert_text.InnerText = "密码重置成功，3秒后前往登录页";
                alert.Attributes["class"] = "alert alert-success";
                Response.Write("<meta http-equiv='Refresh' content='3; url=login.aspx' /> ");
            }
            else
            {
                alert_text.InnerText = "操作失败";
                alert.Attributes["class"] = "alert alert-danger";
            }
            alert.Visible = true;
        }

        protected void Button_SendEmail_Click(object sender, EventArgs e)
        {
            string name = this.username.Value;

            //查询是否存在该用户，若有则发送包含验证码的邮件
            string sql = "select email from users where name = '" + name + "'";

            DataSet ds;
            if ((ds = sqlHelper.ExecuteSqlDataSet(sql, null)) != null && ds.Tables[0].Rows.Count > 0)
            {
                // 生成6位验证码
                Random rd = new Random();
                int num = rd.Next(100000, 1000000);
                ForgotInfo.code = num.ToString();
                ForgotInfo.email = ds.Tables[0].Rows[0][0].ToString();
                if (ForgotInfo.email == "")
                {
                    alert_text.InnerText = "用户未填写邮箱";
                    alert.Attributes["class"] = "alert alert-danger";
                }
                else try
                {
                    sendEmail(ForgotInfo.email);

                    // 在新线程中处理60s计数操作
                    //Thread thread_code_process = new Thread(new ThreadStart(codeProcess));
                    //thread_code_process.Start();
                    Button_SendEmail.Text = "已发送";
                    Button_SendEmail.Attributes["disabled"] = "disabled";
                    Button_SendEmail.Attributes["OnClick"] = "return false;";

                    alert_text.InnerText = "验证码已发送到 " + encodeEmail(ForgotInfo.email);
                    alert.Attributes["class"] = "alert alert-success";
                }
                catch
                {
                    alert_text.InnerText = "邮件发送失败！";
                    alert.Attributes["class"] = "alert alert-danger";
                }
            }
            else
            {
                alert_text.InnerText = "用户不存在";
                alert.Attributes["class"] = "alert alert-danger";
            }
            alert.Visible = true;
        }

        // 60s后恢复发送验证码按钮
        private void codeProcess()
        {
            Button_SendEmail.Attributes["OnClick"] = "return false;";
            for (int i = 60; i > 0; i--)
            {
                Button_SendEmail.Text = "  " + i + "s  ";
                Thread.Sleep(1000);
            }
            Button_SendEmail.Attributes["OnClick"] = "Button_SendEmail_Click";
        }

        // 发送包含验证码的邮件
        private void sendEmail(string email)
        {
            DateTime dt = DateTime.Now;
            var emailAcount = Define.EMAIL_SERVER_ACCOUNT;
            var emailPassword = Define.EMAIL_SERVER_PASSWORD;
            var reciver = email;
            var content = "您的验证码是: " + ForgotInfo.code + "\n\n您的账号正在进行密码修改，请确认是您本人进行操作! \n\n软件测试平台 ver" + System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString() + "\n" + dt.ToString("yyyy/MM/dd HH:mm:ss");
            MailMessage message = new MailMessage();
            //设置发件人,发件人需要与设置的邮件发送服务器的邮箱一致
            MailAddress fromAddr = new MailAddress(emailAcount);
            message.From = fromAddr;
            //设置收件人,可添加多个,添加方法与下面的一样
            message.To.Add(reciver);
            //设置邮件标题
            message.Subject = "软件测试平台 - 忘记密码！";
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

        // 邮箱加*
        private string encodeEmail(string email)
        {
            string[] emailArray = email.Split('@');
            string name_0 = emailArray[0].Substring(0, 1);
            string name_1 = emailArray[0].Substring(1, emailArray[0].Length-1);
            name_1 = "***"; // Regex.Replace(name_1, "[a-zA-Z0-9]", "*");
            string encoded_email = name_0 + name_1 + "@" + emailArray[1];

            return encoded_email;
        }
    }
}