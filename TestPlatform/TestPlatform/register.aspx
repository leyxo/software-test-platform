<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="TestPlatform.register" %>
<%@ Register Src="~/Widget/TopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>新用户注册 - 软件测试平台</title>

    <%--Style Sheet--%>
    <link rel="stylesheet" href="Content/bootstrap.min.css"/>
    <link rel="stylesheet" href="Content/base.css"/>
    <%--Script--%>
    <script src="../Scripts/jquery-2.2.4.js"></script>
    <%--<script src="../Scripts/bootstrap.min.js"></script>--%>
    
</head>
<body style="background-color: #f2f2f2;">
    <div class="register-div container" style="max-width: 400px">
        <topbar:TopBar ID="TopBar" runat="server" />

        <div class="panel panel-default">
            <div class="panel-heading"><b>新用户注册</b></div>
            <div class="panel-body">
                <form id="form1" method="post" role="form" runat="server">
                    <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-user" id="username_icon" style="position: static"></span>
                        <input type="text" runat="server" class="form-control" id="username" placeholder="用户名" onkeyup="value=value.replace(/[\W]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" required="required" maxlength="16" />
                    </div>
                    <br />
                    <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon glyphicon-lock" id="password_icon" style="position: static"></span>
                        <input type="password" runat="server" class="form-control" id="password" placeholder="密码" onkeyup="value=value.replace(/[\W]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" required="required" />
                    </div>
                    <br />
                    <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-option-horizontal" id="password_confirm_icon" style="position: static"></span>
                        <input type="password" runat="server" class="form-control" id="password_confirm" placeholder="确认密码" onkeyup="value=value.replace(/[\W]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" required="required" />
                    </div>
                    <br />
                    <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-envelope" id="emil_icon" style="position: static"></span>
                        <input type="text" runat="server" class="form-control" id="email" placeholder="邮箱 (选填，用于找回密码)" />
                    </div>
                    <br />
                    <div class="input-group">
                        <span class="input-group-addon glyphicon glyphicon-phone" id="phone_icon" style="position: static"></span>
                        <input type="text" runat="server" class="form-control" id="phone" placeholder="手机号 (选填)" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
                    </div>
                    <br />
                    <div class="input-group">
                        <span class="input-group-addon" style="position: static">机构</span>
                        <asp:DropDownList ID="DropDownList_department" runat="server" DataSourceID="SqlDataSource_register_department" DataTextField="name" DataValueField="id" Height="34px" Width="128px"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource_register_department" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [department]"></asp:SqlDataSource>
                    </div>
                    <br />
                    <div class="input-group">
                        <span class="input-group-addon" style="position: static">角色</span>
                        <asp:DropDownList ID="DropDownList_role" runat="server" DataSourceID="SqlDataSource_register_role" DataTextField="name" DataValueField="id" Height="34px" Width="128px"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource_register_role" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [role]"></asp:SqlDataSource>
                    </div>
                    <br />
                    <div id="alert" runat="server" class="alert alert-danger alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <span id="alert_text" runat="server"><strong>用户名已存在！</strong></span>
                    </div>
                    <asp:Button ID="Button_Regist" class="btn btn-primary" runat="server" Text="注册" OnClick="Button_Regist_Click" Width="100%" />
                </form>
            </div>
        </div>

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />

    </div>
</body>
</html>
