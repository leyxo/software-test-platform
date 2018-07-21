﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test_case.aspx.cs" Inherits="TestPlatform.platform.test_case" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>测试记录 - 测试管理 - 软件测试平台</title>

    <%-- css --%>
    <link rel="stylesheet" href="../Content/bootstrap.min.css" />
    <link rel="stylesheet" href="../Content/bootstrap-theme.min.css" />
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
                <div class="panel-heading"><b id="B1" runat="server">测试管理 > 测试记录</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <form id="form1" runat="server">
                        <h4><strong><span id="Title_Department_Name" runat="server">测试记录维护</span></strong></h4>
                        <div class="container" style="border-color: lightgray; border-style: solid; border-width: 1px; width: 100%; padding: 10px;">
                            <div class="row">
                                <div class="col-md-6">
                                    测试系统：<asp:DropDownList ID="DropDownList_test" runat="server" DataSourceID="test" DataTextField="name" DataValueField="id" Height="24px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_test_SelectedIndexChanged" OnDataBound="DropDownList_test_DataBound"></asp:DropDownList>
                                    &nbsp;&nbsp;版本：<asp:DropDownList ID="DropDownList_test_version" runat="server" DataSourceID="test_version" DataTextField="name" DataValueField="id" Height="24px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_test_version_SelectedIndexChanged" OnDataBound="DropDownList_test_version_DataBound"></asp:DropDownList>
                                    <br />
                                    <br />
                                    起始日期：<asp:Label ID="start_time" Font-Bold="true" runat="server" Text=""></asp:Label>
                                    &nbsp;&nbsp;&nbsp;截止日期：<asp:Label ID="end_time" Font-Bold="true" runat="server" Text=""></asp:Label>
                                    <br />
                                </div>
                                <div class="col-md-6">
                                    测试人员：<asp:Label ID="user" Font-Bold="true" runat="server" Text=""></asp:Label>
                                    &nbsp;&nbsp;&nbsp;测试状态：<asp:Label ID="status" Font-Bold="true" runat="server" Text=""></asp:Label>
                                    <br />
                                    <br />
                                    提交时间：<asp:Label ID="creation_date" Font-Bold="true" runat="server" Text=""></asp:Label>
                                    <br />
                                </div>
                            </div>
                        </div>
                        <br />
                        <span style="float: right;">
                            <button id="Button_Submit" runat="server" type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal">提交当前版本</button>
                            &nbsp;<asp:Button ID="Button_Generate_Report" runat="server" class="btn btn-primary" Text="查看测试报告" OnClick="Button_Generate_Report_Click" UseSubmitBehavior="False" />
                            <asp:Button ID="Button_Add_Case" runat="server" class="btn btn-primary" Text="新建测试记录" OnClick="Button_Add_Case_Click" UseSubmitBehavior="False" />
                        </span>
                        <br />

                        <asp:SqlDataSource ID="test" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT test.id, test.name FROM [test]
INNER JOIN test_users ON test_users.test_id = test.id AND test_users.user_id = @user_id">
                            <SelectParameters>
                                <asp:SessionParameter Name="user_id" SessionField="current_user_id" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="test_version" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [test_version] WHERE ([test_id] = @test_id)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList_test" DefaultValue="0" Name="test_id" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <ul id="myTab" class="nav nav-tabs">
                            <li class="active"><a href="#test_case" data-toggle="tab">测试记录</a></li>
                            <li><a href="#test_case_previous" data-toggle="tab">以前版本待解决</a></li>
                            <li><a href="#test_case_summary" data-toggle="tab">总结</a></li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane fade in active" id="test_case">
                                <asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataSourceID="SqlDataSource_test_case" DataKeyNames="ID" OnRowCommand="GridView1_RowCommand" OnRowDeleting="GridView1_RowDeleting">
                                    <Columns>
                                        <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                                        <asp:BoundField DataField="项目" HeaderText="项目" SortExpression="项目" />
                                        <asp:BoundField DataField="前置条件" HeaderText="前置条件" SortExpression="前置条件" />
                                        <asp:BoundField DataField="测试过程及结果" HeaderText="测试过程及结果" SortExpression="测试过程及结果" />
                                        <asp:BoundField DataField="改进建议" HeaderText="改进建议" SortExpression="改进建议" />
                                        <asp:BoundField DataField="类型" HeaderText="类型" SortExpression="类型" />
                                        <asp:BoundField DataField="结论" HeaderText="结论" SortExpression="结论">
                                            <ItemStyle Width="60px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="次数" HeaderText="次数" SortExpression="次数">
                                            <ItemStyle Width="40px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="记录者" HeaderText="记录者" SortExpression="记录者" />
                                        <asp:BoundField DataField="开发描述" HeaderText="开发描述" SortExpression="开发描述" />
                                        <asp:BoundField DataField="创建时间" HeaderText="创建时间" SortExpression="创建时间" DataFormatString="{0:d}" Visible="False" />
                                        <asp:CommandField ShowDeleteButton="True">
                                            <ControlStyle ForeColor="#CC0000" />
                                            <ItemStyle Width="40px" />
                                        </asp:CommandField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton_edit" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="edit">编辑</asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle Width="40px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton_edit_describe" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="describe">开发描述</asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        测试记录为空
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                            <%--SQL条件：(版本号 < 当前版本 and (未通过 or 有修改意见))--%>
                            <div class="tab-pane fade" id="test_case_previous">
                                <asp:GridView ID="GridView2" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataSourceID="SqlDataSource_test_case_previous" DataKeyNames="ID" OnRowCommand="GridView1_RowCommand" OnRowDeleting="GridView1_RowDeleting">
                                    <Columns>
                                        <asp:BoundField DataField="版本" HeaderText="版本" SortExpression="版本" />
                                        <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                                        <asp:BoundField DataField="项目" HeaderText="项目" SortExpression="项目" />
                                        <asp:BoundField DataField="前置条件" HeaderText="前置条件" SortExpression="前置条件" />
                                        <asp:BoundField DataField="测试过程及结果" HeaderText="测试过程及结果" SortExpression="测试过程及结果" />
                                        <asp:BoundField DataField="改进建议" HeaderText="改进建议" SortExpression="改进建议" />
                                        <asp:BoundField DataField="类型" HeaderText="类型" SortExpression="类型" />
                                        <asp:BoundField DataField="结论" HeaderText="结论" SortExpression="结论">
                                            <ItemStyle Width="60px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="次数" HeaderText="次数" SortExpression="次数">
                                            <ItemStyle Width="40px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="记录者" HeaderText="记录者" SortExpression="记录者" />
                                        <asp:BoundField DataField="开发描述" HeaderText="开发描述" SortExpression="开发描述" />
                                        <asp:BoundField DataField="创建时间" HeaderText="创建时间" SortExpression="创建时间" DataFormatString="{0:d}" Visible="False" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton_edit_previous" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="edit">编辑</asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle Width="40px" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        测试记录为空
                                    </EmptyDataTemplate>
                                </asp:GridView>
                                <h6>* 包含测试未通过记录和含有改进意见的记录</h6>
                            </div>
                            <%--测试总结--%>
                            <div class="tab-pane fade" id="test_case_summary">
                                <div class="form-group">
                            <label for="feedback_detail"></label>
                            <textarea rows="8" runat="server" class="form-control" style="resize:vertical" id="textfield_summary" placeholder="不超过500字" maxlength="1000"></textarea>
                        </div>
                        <asp:Button ID="Button_Save" class="btn btn-primary" runat="server" Text="保存" OnClick="Button_Save_Click" />
                            </div>
                        </div>

                        
                        <asp:SqlDataSource ID="SqlDataSource_test_case" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT test_case.id AS ID, test_case.name AS 项目, test_case.precondition AS 前置条件, test_case.process AS 测试过程及结果, test_issue_type.name AS 类型, test_case.times AS 次数, test_case.suggestion AS 改进建议, test_case.describe AS 开发描述, pass.name AS 结论, users.name AS 记录者, test_case.creation_date AS 创建时间 FROM test_case INNER JOIN pass ON pass.id = test_case.pass INNER JOIN users ON users.id = test_case.creation_user_id INNER JOIN test_issue_type ON test_case.type = test_issue_type.id WHERE (test_case.version_id = @version_id)">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="version_id" SessionField="current_test_version" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <%--SQL条件：(版本号 < 当前版本 and (未通过 or 有修改意见))--%>
                        <asp:SqlDataSource ID="SqlDataSource_test_case_previous" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT test_version.name AS 版本, test_case.id AS ID, test_case.name AS 项目, test_case.precondition AS 前置条件, test_case.process AS 测试过程及结果, test_issue_type.name AS 类型, test_case.times AS 次数, test_case.suggestion AS 改进建议, test_case.describe AS 开发描述, pass.name AS 结论, users.name AS 记录者, test_case.creation_date AS 创建时间 FROM test_case INNER JOIN pass ON pass.id = test_case.pass INNER JOIN users ON users.id = test_case.creation_user_id INNER JOIN test_issue_type ON test_case.type = test_issue_type.id INNER JOIN test_version ON test_version.id = test_case.version_id WHERE (test_version.test_ID = @test_id and test_case.version_id < @version_id and (test_case.pass = 2 or test_case.suggestion <> ''))">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="test_id" SessionField="current_test_id" Type="Int32" />
                            </SelectParameters>
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="version_id" SessionField="current_test_version" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <div id="alert" runat="server" class="alert alert-danger alert-dismissible" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <span id="alert_text" runat="server"><strong>先创建一个版本！</strong></span>
                        </div>

                        <!-- Modal -->
                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="myModalLabel"><strong>提交当前版本？</strong></h4>
                                    </div>
                                    <div class="modal-body">
                                        <p>提交后，当前版本状态及测试记录不可被修改</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                        <asp:Button ID="Button1" runat="server" class="btn btn-primary" Text="提交" OnClick="Button_Submit_Click" UseSubmitBehavior="False" />
                                    </div>
                                </div>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
        
        
        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>

</body>
</html>