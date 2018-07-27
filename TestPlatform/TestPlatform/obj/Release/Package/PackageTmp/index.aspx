<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="TestPlatform.Index" %>
<%@ Register Src="~/Widget/TopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>

<%@ OutputCache Duration="5" VaryByControl="none" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>软件测试平台</title>
   
    <%--css--%>
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
    <link rel="stylesheet" href="Content/base.css" />

</head>
<body style="background-color:#FFFFFF;">
    <div class="container" runat="server">
        <%--TopBar--%>
        <topbar:TopBar ID="TopBar" runat="server" />

        <div class="jumbotron">
            <h1>欢迎!</h1>
            <p>欢迎使用软件测试平台</p>
            <p>
                <a class="btn btn-primary btn-lg" href="login.aspx" role="button">马上登录</a> &nbsp;
                <a class="btn btn-default btn-lg" href="help.aspx" role="button">使用帮助</a>
            </p>
        </div>
        <br />

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>
</body>
</html>
