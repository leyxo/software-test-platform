<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="platform_home.aspx.cs" Inherits="TestPlatform.platform.platform_home" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>首页 - 软件测试平台</title>
    
    <%--css--%>
    <link rel="stylesheet" href="../Content/bootstrap.min.css"/>
    <link rel="stylesheet" href="../Content/base.css"/>

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
                <div class="panel-heading"><b id="B1" runat="server">首页</b></div>
                <div class="panel-body" id="Div1" runat="server">
                    
                    <form id="form1" runat="server">
                        <h4><strong>测试系统</strong></h4>
                        <asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataSourceID="test_all" DataKeyNames="ID">
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                                <asp:BoundField DataField="项目名称" HeaderText="项目名称" SortExpression="项目名称" />
                                <asp:BoundField DataField="简介" HeaderText="简介" SortExpression="简介" />
                                <asp:BoundField DataField="项目创建日期" HeaderText="项目创建日期" SortExpression="项目创建日期" DataFormatString="{0:d}" />
                                <asp:BoundField DataField="创建者" HeaderText="创建者" SortExpression="创建者" />
                                <asp:BoundField DataField="扣分" HeaderText="扣分" SortExpression="扣分" />
                            </Columns>
                            <EmptyDataTemplate>
                                没有被指派的测试系统
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <h6>* 只包含被指派的测试系统</h6>
                        <asp:SqlDataSource ID="test_all" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT sys_test_name.id AS ID, sys_test_name.name AS 项目名称, users.name AS 创建者, sys_test_name.describe AS 简介, sys_test_name.creation_date AS 项目创建日期, sys_test_name.total_value AS 扣分 FROM sys_test_name INNER JOIN users ON users.id = sys_test_name.creation_user_id AND sys_test_name.creation_user_id = users.id WHERE sys_test_name.available = 1">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="current_user_department_id" SessionField="current_user_department_id" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </form>
                    <br />
 
                </div>
            </div>
        </div>

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>

</body>
</html>
