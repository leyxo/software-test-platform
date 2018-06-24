<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="TestPlatform.register" %>
<%@ Register Src="~/Widget/TopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>新用户注册 - 软件测试平台</title>
    <!-- Latest compiled and minified CSS -->
    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous"/>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
    <link href="http://cdn.bootcss.com/bootstrap-validator/0.5.3/css/bootstrapValidator.min.css" rel="stylesheet" />
    <script src="http://cdn.bootcss.com/bootstrap-validator/0.5.3/js/bootstrapValidator.min.js"></script>
    <script src="js/registerValidator.js"></script>

    <link rel="stylesheet" href="css/base.css"/>

</head>
<body>
    <div class="container">
        <topbar:TopBar ID="TopBar" runat="server" />

        <h2>新用户注册</h2>
        <br />

        <form id="form1" method="post" role="form" runat="server">
            <div id="alert_userexisted" runat="server" class="alert alert-danger" role="alert"><b>用户名已存在！</b></div>
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" runat="server" class="form-control" id="username" placeholder="用户名">
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" runat="server" class="form-control" id="password" placeholder="密码">
            </div>
            <div class="form-group">
                <label for="password_confirm">确认密码</label>
                <input type="text" runat="server" class="form-control" id="password_confirm" placeholder="确认密码">
            </div>
            <div class="form-group">
                <label for="email">邮箱</label>
                <input type="password" runat="server" class="form-control" id="email" placeholder="邮箱">
            </div>
            <div class="form-group">
                <label for="phone">手机号</label>
                <input type="text" runat="server" class="form-control" id="phone" placeholder="手机号">
            </div>
            <div class="form-group">
                <label for="DropDownList_department">部门</label>
                <asp:DropDownList ID="DropDownList_department" runat="server" DataSourceID="SqlDataSource_register_department" DataTextField="name" DataValueField="id" Height="22px" Width="128px"></asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_register_department" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [department]"></asp:SqlDataSource>
            </div>
            <div class="form-group">
                <label for="DropDownList_role">身份</label>
                <asp:DropDownList ID="DropDownList_role" runat="server" DataSourceID="SqlDataSource_register_role" DataTextField="name" DataValueField="id" Height="22px" Width="128px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_register_role" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [role]"></asp:SqlDataSource>
            </div>
            <asp:Button ID="Button_Regist" class="btn btn-primary" runat="server" Text="注册" OnClick="Button_Regist_Click"/>
            &nbsp;
            <asp:Button ID="Button_Back" class="btn btn-default" runat="server" Text="返回" OnClick="Button_Back_Click" CausesValidation="False" />
        </form>

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />

    </div>
</body>
</html>
