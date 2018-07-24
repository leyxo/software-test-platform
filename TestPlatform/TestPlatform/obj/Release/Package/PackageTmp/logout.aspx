﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="logout.aspx.cs" Inherits="TestPlatform.logout" %>
<%@ Register Src="~/Widget/TopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>软件测试平台</title>
   
    <%--css--%>
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
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
            <h1>感谢使用!</h1>
            <p>感谢你使用软件测试平台</p>
            <p><a class="btn btn-primary btn-lg" href="login.aspx" role="button">重新登录</a></p>
        </div>
        <br />

        <form id="form1" runat="server">

        </form>


        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>
</body>
</html>
