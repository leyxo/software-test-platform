<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="TestPlatform.login" %>
<%@ Register Src="~/Widget/TopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>登录 - 软件测试平台</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous"/>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="css/base.css"/>
    
</head>
<body>
    <div class="container">
        <topbar:TopBar ID="TopBar" runat="server" />

        <h2>登录</h2>
        <br />

        <form id="form1" method="post" role="form" runat="server">
            <div id="alert_wrong_userinfo" runat="server" class="alert alert-danger" role="alert"><b>用户名或密码错误！</b></div>
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" runat="server" class="form-control" id="username" placeholder="用户名">
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" runat="server" class="form-control" id="password" placeholder="密码">
            </div>
            <div class="checkbox">
                <label>
                    <input type="checkbox">
                    保持登录状态
                </label>
            </div>
            <asp:Button ID="Button_Login" class="btn btn-primary" runat="server" OnClick="Button_Login_Click" Text="登录" /> &nbsp;
            <div>
                <h6><span class="customer-forget"><a href="forgetpassword.aspx">忘记密码</a> </span> &nbsp; <span>没有账户,<a href="register.aspx">立即注册</a> </span> </h6>
            </div>
        </form>

        <footer:Footer ID="Footer" runat="server" />
    </div>


</body>
</html>