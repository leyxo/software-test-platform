﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="basedata_manage_test.aspx.cs" Inherits="TestPlatform.platform.basedata_manage_test" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>测试系统维护 - 基础数据管理 - 软件测试平台</title>
    
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
                <div class="panel-heading"><b id="B1" runat="server">基础数据管理 > 测试系统维护</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <%--主体内容--%>

                    <form id="form1" runat="server">
                        <h4><strong><span id="Title_All_Test" runat="server">所有测试系统</span> (<span id="Title_All_Test_Count" runat="server"></span>个)</strong>
                            <span style="float: right">
                                <table>
                                    <tr>
                                        <th>
                                            <asp:Button ID="Button_Add_Test" class="btn btn-primary" runat="server" Text="新建项目" OnClick="Button_Add_Test_Click" />
                                    </tr>
                                </table>
                            </span>
                        </h4>
                        <br />
                        <asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataSourceID="test_all" DataKeyNames="ID" OnRowCommand="GridView1_RowCommand" OnRowDeleting="GridView1_RowDeleting">
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                                <asp:BoundField DataField="项目名称" HeaderText="项目名称" SortExpression="项目名称" />
                                <asp:BoundField DataField="简介" HeaderText="简介" SortExpression="简介" />
                                <asp:BoundField DataField="项目创建日期" HeaderText="项目创建日期" SortExpression="项目创建日期" DataFormatString="{0:d}" />
                                <asp:BoundField DataField="创建者" HeaderText="创建者" SortExpression="创建者" />
                                <asp:BoundField DataField="扣分" HeaderText="扣分" SortExpression="扣分" />
                                <asp:BoundField DataField="状态" HeaderText="状态" SortExpression="状态" />
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" Text="删除" CommandName="Delete" CausesValidation="False" ID="LinkButton1" OnClientClick="javascript:return confirm('确定删除此测试系统？');"></asp:LinkButton>
                                    </ItemTemplate>
                                    <ControlStyle ForeColor="#CC0000"></ControlStyle>
                                    <ItemStyle Width="40px"></ItemStyle>
                                </asp:TemplateField>

                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton_edit" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="edit">编辑</asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Width="40px" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton_edit_users" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="edit_users">用户分配</asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Width="80px" />
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                还没有项目？开始一个<a href="basedata_manage_test_add.aspx">新项目</a>
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="test_all" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT sys_test_name.id AS ID, sys_test_name.name AS 项目名称, users.name AS 创建者, sys_test_name.describe AS 简介, sys_test_name.creation_date AS 项目创建日期, replace(replace(available, '0', '无效'), '1', '有效') AS 状态, sys_test_name.total_value AS 扣分 FROM sys_test_name INNER JOIN users ON users.id = sys_test_name.creation_user_id AND sys_test_name.creation_user_id = users.id">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="current_user_department_id" SessionField="current_user_department_id" />
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
