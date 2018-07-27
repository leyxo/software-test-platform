<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test_members.aspx.cs" Inherits="TestPlatform.platform.test_members" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>测试报告 - 软件测试平台</title>

    <%-- css --%>
    <link rel="stylesheet" href="../Content/bootstrap.min.css" />
    <link rel="stylesheet" href="../Content/base.css" />
    

</head>
<body>
    <div class="container" runat="server">
        <%--TopBar--%>
        <topbar:TopBar ID="TopBar" runat="server" />


        <div class="col-md-2">
            <platformTreeMenu:PlatformTreeMenu ID="PlatformTreeMenu" runat="server" />
        </div>
        <div class="col-md-10">
            <div class="panel panel-default">
                <div class="panel-heading"><b id="B1" runat="server">测试报告</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <h4><strong>测试报告</strong></h4>
                    <form id="form1" runat="server">
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
                                    <ItemStyle Width="80px"></ItemStyle>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                还没有已结束的测试版本
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <h6>* 只包含已结束的测试版本</h6>
                        <asp:SqlDataSource ID="SqlDataSource_test_version_submited" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [sys_test_name_version]
INNER JOIN [sys_test_name] ON sys_test_name_version.test_id = sys_test_name.id
INNER JOIN [sys_test_name_grant_users] ON sys_test_name_version.test_id = sys_test_name_grant_users.test_id
WHERE sys_test_name_version.is_finish = 2 AND sys_test_name_grant_users.user_id = @user_id AND sys_test_name.available = 1
ORDER BY sys_test_name_version.id">
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
