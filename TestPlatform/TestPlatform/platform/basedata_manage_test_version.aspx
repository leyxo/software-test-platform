<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="basedata_manage_test_version.aspx.cs" Inherits="TestPlatform.platform.basedata_manage_test_version" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>测试管理 - 软件测试平台</title>

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
                <div class="panel-heading"><b id="B1" runat="server">测试管理</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <form id="form1" runat="server">
                        <h4><strong><span id="Title_Department_Name" runat="server">测试管理</span></strong></h4>
                        <%--<br />--%>
                        <span style="float: left">
                            测试系统：<asp:DropDownList ID="DropDownList_test" runat="server" DataSourceID="test" DataTextField="name" DataValueField="id" Height="24px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_test_SelectedIndexChanged" OnDataBound="DropDownList_test_DataBound"></asp:DropDownList>
                            &nbsp;</span><span style="float:right;"><asp:Button ID="Button_Add_Version" runat="server" class="btn btn-primary" Text="新增版本" OnClick="Button_Add_Version_Click" UseSubmitBehavior="False" />                       
                        </span>
                        <br />
                        <br />
                        <asp:SqlDataSource ID="test" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT sys_test_name.id AS id, name FROM sys_test_name INNER JOIN sys_test_name_grant_users ON sys_test_name_grant_users.test_id = sys_test_name.id WHERE sys_test_name_grant_users.user_id = @user_id and available = 1">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="current_user_id" Name="user_id"></asp:SessionParameter>
                            </SelectParameters>

                        </asp:SqlDataSource>

                        <asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataSourceID="SqlDataSource_test_version" DataKeyNames="id" OnRowCommand="GridView1_RowCommand" OnRowDeleting="GridView1_RowDeleting">
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="id" Visible="False" />
                                <asp:BoundField DataField="name" HeaderText="版本" SortExpression="name" />
                                <asp:BoundField DataField="number" HeaderText="版本ID" SortExpression="number" Visible="False" />
                                <asp:BoundField DataField="start_time" DataFormatString="{0:d}" HeaderText="起始日期" SortExpression="start_time" />
                                <asp:BoundField DataField="end_time" DataFormatString="{0:d}" HeaderText="截止日期" SortExpression="end_time" />
                                <asp:BoundField DataField="creation_date" DataFormatString="{0:d}" HeaderText="提交日期" SortExpression="creation_date" />
                                <asp:BoundField DataField="total_value" HeaderText="扣分" SortExpression="total_value" />
                                <asp:BoundField DataField="is_finish" HeaderText="状态" SortExpression="is_finish" />
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" Text="删除" CommandName="Delete" CausesValidation="False" ID="LinkButton1" OnClientClick="javascript:return confirm('确定删除该版本？');"></asp:LinkButton>
                                    </ItemTemplate>
                                    <ControlStyle ForeColor="#CC0000"></ControlStyle>
                                    <ItemStyle Width="40px"></ItemStyle>
                                </asp:TemplateField>

                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton_edit" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="edit">编辑</asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Width="40px"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton_Start" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="start">开始测试</asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Width="80px"></ItemStyle>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                版本记录为空
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <h6>* 只包含被指派的测试系统</h6>
                        <asp:SqlDataSource ID="SqlDataSource_test_version" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT id, name, test_id, start_time, end_time, creation_date, replace(replace(replace(is_finish, '0', '测试中'), '1', '已提交'), '2', '已结束') AS is_finish, total_value FROM [sys_test_name_version] WHERE ([test_id] = @test_id)">
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
