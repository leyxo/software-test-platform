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
                <div class="panel-heading"><b id="B1" runat="server">首页</b></div>
                <div class="panel-body" id="Div1" runat="server">
                    
                    <form id="form1" runat="server">
                        <h4><strong>我的测试系统</strong></h4>
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
                                没有我参与的测试系统
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="test_all" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT test.id AS ID, test.name AS 项目名称, users.name AS 创建者, test.describe AS 简介, test.creation_date AS 项目创建日期, test.total_value AS 扣分 FROM test INNER JOIN users ON users.id = test.creation_user_id AND test.creation_user_id = users.id WHERE test.available = 1">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="current_user_department_id" SessionField="current_user_department_id" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </form>
                    <br />

                   <%-- <%--主体内容--%>
                    <div class="container-fluid">
                        <%--项目统计--%>
                        <div class="col-md-4" style="width: 300px; border-style: solid; border-radius: 4px; border-color: lightgray; background-color:#fdfdfd; border-width: thin; margin-right:20px;">
                            <%--标题--%>
                            <div class="row">
                                <div class="col-md-6" style="height:55px;">
                                    <h4 style="float:right; position:absolute; bottom:0px;"><strong>项目统计</strong></h4>
                                </div>
                                <div class="col-md-6" style="height:47px;" id="Div_Test_See_More" runat="server">
                                    <a href="basedata_manage_test_version.aspx" style="float:right; position:absolute; bottom:0px; right:15px;">查看详情</a>
                                </div>
                            </div>
                            <%--内容--%>
                            <div class="row" style="padding: 10px;">
                                <div class="col-md-6" style="padding: 5px; padding-right:10px;">
                                    <div style="background-color: #f8f8f8; border-radius:6px; padding: 10px;">
                                        <h5 style="color:darkgray">测试中的版本</h5>
                                        <h1><strong id="label_test_doing" runat="server">0</strong></h1>
                                    </div>
                                </div>
                                <div class="col-md-6" style="padding: 5px; padding-left:10px;">
                                    <div style="background-color: #f8f8f8; border-radius:6px; padding: 10px;">
                                        <h5 style="color:darkgray">所有版本</h5>
                                        <h1><strong id="label_test_all" runat="server">0</strong></h1>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--成员统计--%>
                        <div class="col-md-4" style="width: 300px; border-style: solid; border-radius: 4px; border-color: lightgray; background-color:#fdfdfd; border-width: thin; margin-right:20px;">
                            <%--标题--%>
                            <div class="row">
                                <div class="col-md-6" style="height:55px;">
                                    <h4 style="float:right; position:absolute; bottom:0px;"><strong>成员统计</strong></h4>
                                </div>
                                <div class="col-md-6" style="height:47px;" id="Div_Test_Members_See_More" runat="server">
                                    <%--<a href="test_members.aspx" style="float:right; position:absolute; bottom:0px; right:15px;">查看详情</a>--%>
                                </div>
                            </div>
                            <%--内容--%>
                            <div class="row" style="padding: 10px;">
                                <div class="col-md-12" style="padding: 5px; padding-right:10px;">
                                    <div style="background-color: #f8f8f8; border-radius:6px; padding: 10px;">
                                        <h5 style="color:darkgray">总人数</h5>
                                        <h1><strong id="label_members_total" runat="server">0</strong></h1>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />--%>

                    
                </div>
            </div>
        </div>

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>

</body>
</html>
