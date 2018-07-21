<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="help.aspx.cs" Inherits="TestPlatform.help" %>
<%@ Register Src="~/Widget/TopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/HelpPage.ascx" TagName="HelpPage" TagPrefix="helppage" %>


<!DOCTYPE html>

<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>帮助 - 软件测试平台</title>
    
    <%--Style Sheet--%>
    <link rel="stylesheet" href="Content/bootstrap.min.css"/>
    <link rel="stylesheet" href="Content/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="Content/base.css"/>


</head>
<body>
    <div class="container" runat="server">
        <%--TopBar--%>
        <topbar:TopBar ID="TopBar" runat="server" />

        <%--HelpPage--%>
        <helppage:HelpPage ID="HelpPage" runat="server" />

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>
</body>
</html>
