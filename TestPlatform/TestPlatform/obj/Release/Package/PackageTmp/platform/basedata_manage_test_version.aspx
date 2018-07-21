<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="basedata_manage_test_version.aspx.cs" Inherits="TestPlatform.platform.basedata_manage_test_version" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>测试版本维护 - 基础数据管理 - 软件测试平台</title>

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
                <div class="panel-heading"><b id="B1" runat="server">基础数据管理 > 测试版本维护</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <form id="form1" runat="server">
                        <h4><strong><span id="Title_Department_Name" runat="server">版本记录</span></strong></h4>
                        <%--<br />--%>
                        <span style="float: left">
                            测试系统：<asp:DropDownList ID="DropDownList_test" runat="server" DataSourceID="test" DataTextField="name" DataValueField="id" Height="24px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_test_SelectedIndexChanged" OnDataBound="DropDownList_test_DataBound"></asp:DropDownList>
                            &nbsp;</span><span style="float:right;"><asp:Button ID="Button_Add_Version" runat="server" class="btn btn-primary" Text="新增版本" OnClick="Button_Add_Version_Click" UseSubmitBehavior="False" />                       
                        </span>
                        <br />
                        <br />
                        <asp:SqlDataSource ID="test" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT [id], [name] FROM [test] WHERE ([creation_department_id] = @creation_department_id)">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="creation_department_id" SessionField="current_user_department_id" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataSourceID="SqlDataSource_test_version" DataKeyNames="id" OnRowCommand="GridView1_RowCommand" OnRowDeleting="GridView1_RowDeleting">
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="id" Visible="False" />
                                <asp:BoundField DataField="name" HeaderText="版本号" SortExpression="name" />
                                <asp:BoundField DataField="number" HeaderText="版本ID" SortExpression="number" Visible="False" />
                                <asp:BoundField DataField="start_time" DataFormatString="{0:d}" HeaderText="起始日期" SortExpression="start_time" />
                                <asp:BoundField DataField="end_time" DataFormatString="{0:d}" HeaderText="截止日期" SortExpression="end_time" />
                                <asp:BoundField DataField="creation_date" DataFormatString="{0:d}" HeaderText="提交日期" SortExpression="creation_date" />
                                <asp:CommandField ShowDeleteButton="True">
                                <ControlStyle ForeColor="#CC0000" />
                                </asp:CommandField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton_edit" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="edit">编辑</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                版本记录为空
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource_test_version" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [test_version] WHERE ([test_id] = @test_id) ORDER BY [id]">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="test_id" SessionField="current_basedata_test_id" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <div id="alert" runat="server" class="alert alert-danger alert-dismissible" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <span id="alert_text" runat="server"><strong>先创建一个版本！</strong></span>
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
