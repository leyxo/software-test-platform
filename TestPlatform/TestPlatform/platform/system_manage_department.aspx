<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="system_manage_department.aspx.cs" Inherits="TestPlatform.platform.system_manage_department" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>部门管理 - 系统管理 - 软件测试平台</title>
    
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
                <div class="panel-heading"><b id="B1" runat="server">系统管理 > 部门管理</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    
                    <div>
                        <form id="form1" role="form" runat="server">
                            <h4><strong>所有部门</strong>
                                <span style="float: right">
                                    <div id="Div_Add_Department" runat="server" class="input-group" style="max-width: 300px; float: right">
                                        <input id="input_add_department" runat="server" type="text" class="form-control" placeholder="新增部门" required="required">
  
                                        <span class="input-group-btn">
                                            <asp:Button ID="Button_Add_Department" class="btn btn-primary" runat="server" Text="添加" OnClick="Button_Add_Department_Click" />
                                        </span>
                                    </div>
                                </span>
                            </h4>
                            <br />
                            <asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource_departmemnt" OnRowDeleting="GridView1_RowDeleting" OnRowCommand="GridView1_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="id" HeaderText="部门ID" InsertVisible="False" ReadOnly="True" SortExpression="部门ID" Visible="False" />
                                    <asp:BoundField DataField="name" HeaderText="部门名称" SortExpression="部门名称" />
                                    <asp:CommandField ShowDeleteButton="True">
                                        <ControlStyle ForeColor="#CC0000" />
                                    <ItemStyle Width="40px" />
                                    </asp:CommandField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton_edit" runat="server" CommandArgument='<%# Eval("id") %>' CommandName="edit">编辑</asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Width="40px" />
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    还没有部门...
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource_departmemnt" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [department] ORDER BY [id]"></asp:SqlDataSource>
                        </form>
                        <%--<h6 style="color:red;">* 删除部门还会删除当前部门所有人员数据，请谨慎处理！</h6>--%>
                        <div id="alert" runat="server" class="alert alert-danger alert-dismissible" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <span id="alert_text" runat="server"><strong>部门名称已存在！</strong></span>
                            </div>
                    </div>
                </div>
            </div>
        </div>

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>

</body>
</html>