<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test_members.aspx.cs" Inherits="TestPlatform.platform.test_members" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>测试报告 - 测试管理 - 软件测试平台</title>

    <%-- css --%>
    <link rel="stylesheet" href="../Content/bootstrap.min.css" />
    <link rel="stylesheet" href="../Content/base.css" />
    

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
                <div class="panel-heading"><b id="B1" runat="server">测试管理 > 测试报告</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <h4><strong>已结束的测试版本</strong></h4>
                    <%--<h4><strong><span id="Title_Department_Name" runat="server">机构成员</span> (<span id="Title_Members_Count" runat="server"></span>人)</strong></h4>--%>
                    <form id="form1" runat="server">
                        <%--<asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataSourceID="users_team_members">
                            <Columns>
                                <asp:BoundField DataField="姓名" HeaderText="姓名" SortExpression="姓名" />
                                <asp:BoundField DataField="邮箱" HeaderText="邮箱" SortExpression="邮箱" />
                                <asp:BoundField DataField="电话" HeaderText="电话" SortExpression="电话" />
                                <asp:BoundField DataField="角色" HeaderText="注册角色" SortExpression="注册角色" />
                                <asp:BoundField DataField="注册时间" HeaderText="注册时间" SortExpression="注册时间" DataFormatString="{0:d}" />
                            </Columns>
                            <EmptyDataTemplate>
                                机构成员为空
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="users_team_members" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT users.name AS 姓名, users.email AS 邮箱, users.phone AS 电话, role.name AS 角色, users.reg_datetime AS 注册时间 
FROM users INNER JOIN department ON department.id = users.department INNER JOIN role ON role.id = users.role INNER JOIN reg_status ON reg_status.id = users.reg_status 
WHERE (department.id = @department_id and users.reg_status &lt;&gt;1 and users.reg_status &lt;&gt; 4)">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="department_id" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <h6>* 机构成员信息仅用于组内交流，切勿泄露！</h6>--%>

                        <asp:GridView ID="GridView2" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataSourceID="SqlDataSource_test_version_submited" DataKeyNames="id,id1" OnRowCommand="GridView2_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="版本ID" SortExpression="id" InsertVisible="False" ReadOnly="True" Visible="False" />
                                <asp:BoundField DataField="name1" HeaderText="系统名称" SortExpression="name1" />
                                <asp:BoundField DataField="name" HeaderText="版本号" SortExpression="name" />
                                <asp:BoundField DataField="start_time" HeaderText="起始日期" SortExpression="start_time" DataFormatString="{0:d}" />
                                <asp:BoundField DataField="end_time" HeaderText="截止日期" SortExpression="end_time" DataFormatString="{0:d}" />
                                <asp:BoundField DataField="creation_date" HeaderText="提交日期" SortExpression="creation_date" DataFormatString="{0:d}"></asp:BoundField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton_report" runat="server" CommandArgument='<%# Eval("id") %>' CommandName="report">查看报告</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                还没有已结束的测试版本
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource_test_version_submited" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [test_version]
INNER JOIN [test] ON test_version.test_id = test.id
INNER JOIN [test_users] ON test_version.test_id = test_users.test_id
WHERE test_version.is_finish = 2 AND test_users.user_id = @user_id
ORDER BY test_version.id">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="current_user_id" Name="user_id"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </form>
                </div>
            </div>
        </div>
        
        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>

</body>
</html>
