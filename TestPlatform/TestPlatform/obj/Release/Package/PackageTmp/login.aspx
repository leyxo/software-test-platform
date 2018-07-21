<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="TestPlatform.login" %>
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
            <div class="panel-heading"><b>登录</b></div>
            <div class="panel-body">
                <form id="form1" method="post" role="form" runat="server">
                    <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-user" id="username_icon" style="position: static"></span>
                        <input type="text" runat="server" class="form-control" id="username" placeholder="用户名" onkeyup="value=value.replace(/[\W]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" required="required">
                    </div>
                    <br />
                    <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-option-horizontal" id="password_icon" style="position: static"></span>
                        <input type="password" runat="server" class="form-control" id="password" placeholder="密码" onkeyup="value=value.replace(/[\W]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" required="required">
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-6">
                            <div class="input-group">
                                <span class="input-group-addon glyphicon glyphicon-tag" id="captcha_icon" style="position: static"></span>
                                <input type="text" runat="server" class="form-control" id="captcha" placeholder="验证码" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" required="required">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="input-group">
                                <img src="../Widget/Captcha.aspx" id="image1" alt="" onclick="aa()" title="换一张" />
                            </div>
                        </div>
                    </div>
                    <div class="checkbox" id="checkbox" runat="server">
                        <label>
                            <input type="checkbox">保持登录状态</label>
                    </div>
                    <br />
                    <div id="alert" runat="server" class="alert alert-danger alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <span id="alert_text" runat="server"><strong>用户名或密码错误！</strong></span>
                    </div>

                    <asp:Button ID="Button_Login" class="btn btn-primary" runat="server" OnClick="Button_Login_Click" Text="登录" Width="100%" />
                    &nbsp;
                    <div>
                        <h6><span class="customer-forget"><a href="forgetpassword.aspx">忘记密码</a> </span>&nbsp; <span>没有账户,<a href="register.aspx">立即注册</a></span></h6>
                    </div>
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