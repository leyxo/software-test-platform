using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace TestPlatform
{
    public class logoutHandler : IHttpHandler, IRequiresSessionState
    {
        bool IHttpHandler.IsReusable
        {
            get { return true; }
        }

        public void ProcessRequest(HttpContext context)
        {
            context.Session.Clear();    //从会话状态集合中移除所有的键和值
            context.Session.Abandon();  //取消当前会话
            context.Response.Redirect("~/logout.aspx");   //跳转登录页
        }
    }
}