<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="TestPlatform.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>软件测试平台</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous"/>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        登陆
    </div>
        用户名<asp:TextBox ID="TextBox_Username" runat="server"></asp:TextBox>
        <br />
        密码<asp:TextBox ID="TextBox_Password" runat="server"></asp:TextBox>
        <br />

        <asp:Button ID="Button_Login" class="btn btn-default" runat="server" OnClick="Button1_Click" Text="登陆" />
        <p>
        <asp:repeater runat="server" ID="repeater_user">
            <ItemTemplate >
                <asp:TextBox ID="TextBox_UserName" runat="server"  Text='<%#Eval("password") %>'  >
                </asp:TextBox>
            </ItemTemplate>
        </asp:repeater>

        </p>
    </form>
</body>
</html>
