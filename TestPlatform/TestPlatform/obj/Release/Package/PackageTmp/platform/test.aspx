<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="TestPlatform.platform.test" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>测试系统 - 测试管理 - 软件测试平台</title>
    
    <%--Style Sheet--%>
    <link rel="stylesheet" href="../Content/bootstrap.min.css"/>
    <link rel="stylesheet" href="../Content/bootstrap-theme.min.css"/>
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
                <div class="panel-heading"><b id="B1" runat="server">测试管理 > 测试系统</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <%--主体内容--%>

                    <form id="form1" runat="server">
                        <h4><strong><span id="Title_All_Test" runat="server">我的测试系统</span> (<span id="Title_All_Test_Count" runat="server"></span>个)</strong></h4>
                        <asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataSourceID="test_all" DataKeyNames="ID" OnRowCommand="GridView1_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                                <asp:BoundField DataField="项目名称" HeaderText="项目名称" SortExpression="项目名称" />
                                <asp:BoundField DataField="简介" HeaderText="简介" SortExpression="简介" />
                                <asp:BoundField DataField="项目创建日期" HeaderText="项目创建日期" SortExpression="项目创建日期" DataFormatString="{0:d}" />
                                <asp:BoundField DataField="创建者" HeaderText="创建者" SortExpression="创建者" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton_edit" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="start">开始测试</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                还没有项目
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="test_all" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT test.id AS ID, test.name AS 项目名称, users.name AS 创建者, test.describe AS 简介, test.creation_date AS 项目创建日期 
FROM test_users
INNER JOIN test ON test.id = test_users.test_id
INNER JOIN users ON users.id = test.creation_user_id
WHERE test_users.user_id = @user_id">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="current_user_id" Name="user_id"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </form>
                    <h6>* 只包含被指派的测试系统</h6>
                </div>
            </div>
        </div>

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>

</body>
</html>
