<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="system_manage_department.aspx.cs" Inherits="TestPlatform.platform.system_manage_department" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>机构管理 - 系统管理 - 软件测试平台</title>
    
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
                <div class="panel-heading"><b id="B1" runat="server">系统管理 > 机构管理</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    
                    <div>
                        <form id="form1" role="form" runat="server">
                            <h4><strong>所有机构</strong>
                                <span style="float: right">
                                    <div id="Div_Add_Department" runat="server" class="input-group" style="max-width: 300px; float: right">
                                        <input id="input_add_department" runat="server" type="text" class="form-control" placeholder="新增机构" required="required">
  
                                        <span class="input-group-btn">
                                            <asp:Button ID="Button_Add_Department" class="btn btn-primary" runat="server" Text="添加" OnClick="Button_Add_Department_Click" />
                                        </span>
                                    </div>
                                </span>
                            </h4>
                            <br />
                            <asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource_departmemnt" OnRowDeleting="GridView1_RowDeleting" OnRowCommand="GridView1_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="id" HeaderText="机构ID" InsertVisible="False" ReadOnly="True" SortExpression="机构ID" Visible="False" />
                                    <asp:BoundField DataField="name" HeaderText="机构名称" SortExpression="机构名称" />
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" Text="删除" CommandName="Delete" CausesValidation="False" ID="LinkButton1" OnClientClick="javascript:return confirm('确定删除此机构？');"></asp:LinkButton>
                                        </ItemTemplate>
                                        <ControlStyle ForeColor="#CC0000"></ControlStyle>
                                        <ItemStyle Width="40px"></ItemStyle>
                                    </asp:TemplateField>

                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton_edit" runat="server" CommandArgument='<%# Eval("id") %>' CommandName="edit">编辑</asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Width="40px" />
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    还没有机构...
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource_departmemnt" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [department] ORDER BY [id]"></asp:SqlDataSource>
                        </form>
                        <%--<h6 style="color:red;">* 删除机构还会删除当前机构所有人员数据，请谨慎处理！</h6>--%>
                        <div id="alert" runat="server" class="alert alert-danger alert-dismissible" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <span id="alert_text" runat="server"><strong>机构名称已存在！</strong></span>
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