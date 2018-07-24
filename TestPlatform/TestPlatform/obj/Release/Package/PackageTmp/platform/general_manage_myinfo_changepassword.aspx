<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="general_manage_myinfo_changepassword.aspx.cs" Inherits="TestPlatform.platform.general_manage_myinfo_changepassword" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>密码修改 - 个人信息 - 软件测试平台</title>
    
    <%--Style Sheet--%>
    <link rel="stylesheet" href="../Content/bootstrap.min.css"/>
    <link rel="stylesheet" href="../Content/base.css"/>
    
</head>
<body style="background-color: #fefefe;">
    <div class="container" runat="server">
        <%--TopBar--%>
        <topbar:TopBar ID="TopBar" runat="server" />


        <div class="col-md-2">
            <platformTreeMenu:PlatformTreeMenu ID="PlatformTreeMenu" runat="server" />
        </div>
        <div class="col-md-10">
            <div class="panel panel-default">
                <div class="panel-heading"><b id="B1" runat="server">通用功能 > 个人信息 > 密码修改</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <%--主体内容--%>

                    <div style="max-width: 400px;">
                        <h4><strong>密码修改</strong></h4>
                        <br />
                        <form id="form1" method="post" role="form" runat="server">
                            <div class="input-group">
                                <span class="input-group-addon glyphicon glyphicon-lock" style="position: static"></span>
                                <input type="password" runat="server" class="form-control" id="password_old" placeholder="旧密码" aria-describedby="password_icon" onkeyup="value=value.replace(/[\W]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
                            </div>
                            <br />
                            <div class="input-group">
                                <span class="input-group-addon glyphicon glyphicon-option-horizontal" style="position: static"></span>
                                <input type="password" runat="server" class="form-control" id="password" placeholder="新密码" aria-describedby="password_icon" onkeyup="value=value.replace(/[\W]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
                            </div>
                            <br />
                            <div class="input-group">
                                <span class="input-group-addon glyphicon glyphicon-option-horizontal" style="position: static"></span>
                                <input type="password" runat="server" class="form-control" id="password_confirm" placeholder="确认新密码" aria-describedby="password_icon" onkeyup="value=value.replace(/[\W]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
                            </div>
                            <br />
                            <div id="alert" runat="server" class="alert alert-danger alert-dismissible" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <span id="alert_text" runat="server"><strong>旧密码错误！</strong></span>
                            </div>
                            <asp:Button ID="Button_Save" class="btn btn-primary" runat="server" Text="保存" OnClick="Button_Save_Click" />&nbsp;&nbsp;
                            <asp:Button ID="Button_Back" class="btn btn-default" runat="server" Text="返回" UseSubmitBehavior="False" OnClick="Button_Back_Click" />
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>

</body>
</html>
