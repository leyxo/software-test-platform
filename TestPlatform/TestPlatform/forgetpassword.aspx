<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgetpassword.aspx.cs" Inherits="TestPlatform.forgetpassword" %>
<%@ Register Src="~/Widget/TopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>

<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>登录 - 软件测试平台</title>
    
    <%--Style Sheet--%>
    <link rel="stylesheet" href="Content/bootstrap.min.css"/>
    <link rel="stylesheet" href="Content/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="Content/base.css"/>

</head>
<body style="background-color: #f2f2f2;">
    <div class="login-div container" style="max-width: 400px;">
        <topbar:TopBar ID="TopBar" runat="server" />
        <div class="panel panel-default">
            <div class="panel-heading"><b>忘记密码</b></div>
            <div class="panel-body">
                <form id="form1" method="post" role="form" runat="server">
                    <div class="bs-callout bs-callout-info">
                        <h4><strong>关于重置密码</strong></h4>
                        <p>系统会向你注册时填写的邮箱中发送一封包含验证码的邮件，重置密码须填写此验证码</p>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-user" id="username_icon" style="position: static"></span>
                        <input type="text" runat="server" class="form-control" id="username" placeholder="用户名" aria-describedby="username_icon" onkeyup="value=value.replace(/[\W]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" required="required">
                    </div>
                    <br />
                    <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-tag" id="captcha_icon" style="position: static"></span>
                        <input type="text" runat="server" class="form-control" id="captcha" placeholder="验证码" aria-describedby="captcha_icon" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
                        <span class="input-group-btn">
                            <asp:Button id="Button_SendEmail" runat="server" class="btn btn-default" text="发送验证码" type="button" OnClick="Button_SendEmail_Click"></asp:Button>
                        </span>
                    </div>
                    <br />
                    <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-option-horizontal" id="password_icon" style="position: static"></span>
                        <input type="password" runat="server" class="form-control" id="password" placeholder="新密码" aria-describedby="password_icon" onkeyup="value=value.replace(/[\W]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
                    </div>
                    <br />
                    <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-option-horizontal" id="confirmpassword_icon" style="position: static"></span>
                        <input type="password" runat="server" class="form-control" id="password_confirm" placeholder="确认新密码" aria-describedby="password_icon" onkeyup="value=value.replace(/[\W]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
                    </div>
                    <br />
                    <div id="alert" runat="server" class="alert alert-danger alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <span id="alert_text" runat="server"><strong>用户名或密码错误！</strong></span>
                    </div>
                    <asp:Button ID="Button_ResetPassword" class="btn btn-primary" runat="server" OnClick="Button_Login_Click" Text="重置密码" Width="100%" />
                    
                </form>
            </div>
        </div>
        

        <footer:Footer ID="Footer" runat="server" />
    </div>

    <script type="text/javascript">
        function aa() {
            $("#image1").attr('src', '../Widget/Captcha.aspx?' + Math.random());
        }
    </script>

</body>
</html>