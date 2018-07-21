<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="TestPlatform.Index" %>
<%@ Register Src="~/Widget/TopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>

<%@ OutputCache Duration="5" VaryByControl="none" %>

<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>软件测试平台</title>
   
    <%--css--%>
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
    <link rel="stylesheet" href="Content/bootstrap-theme.min.css" />
    <link rel="stylesheet" href="Content/base.css" />

    <%--Bootstrap Table--%>
    <script src="Content/bootstrap-table/bootstrap-table.js"></script>
    <link href="Content/bootstrap-table/bootstrap-table.css" rel="stylesheet" />
    <script src="Content/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>

</head>
<body>
    <div class="container" runat="server">
        <%--TopBar--%>
        <topbar:TopBar ID="TopBar" runat="server" />

        <div class="jumbotron">
            <h1>欢迎!</h1>
            <p>欢迎使用软件测试平台，为你的团队工作效率带来提高</p>
            <p>
                <a class="btn btn-primary btn-lg" href="login.aspx" role="button">马上登录</a> &nbsp;
                <%--<a class="btn btn-default btn-lg" href="about.aspx" role="button">了解更多</a>--%>
            </p>
        </div>
        <br />

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>
</body>
</html>
