<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="basedata_manage_issuetype.aspx.cs" Inherits="TestPlatform.platform.basedata_manage_issuetype" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>缺陷类型定义 - 基础数据管理 - 软件测试平台</title>
    
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
                <div class="panel-heading"><b id="B1" runat="server">基础数据管理 > 缺陷类型定义</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    
                    <div>
                        <form id="form1" role="form" runat="server">
                            <h4><strong>缺陷类型</strong>
                                <span style="float: right">
                                    <table id="Table_Add" runat="server">
                                        <tr>
                                            <th>
                                                <input id="input_add" runat="server" type="text" style="max-width: 150px;" class="form-control" placeholder="名称" required="required"></th>
                                            <th>&nbsp;</th>
                                            <th>
                                                <input id="input_point" runat="server" type="text" style="font-weight:normal; max-width: 60px;" class="form-control" placeholder="扣分" required="required" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" ></th>
                                            <th>&nbsp;</th>
                                            <th>
                                                <input id="input_describe" runat="server" type="text" style="font-weight:normal; width: 400px;" class="form-control" placeholder="描述(选填)"></th>
                                            <th>&nbsp;</th>
                                            <th>
                                                
                                                <asp:Button ID="Button_Add" class="btn btn-primary" runat="server" Text="添加" OnClick="Button_Add_Click" /></th>
                                        </tr>
                                        </table>
                                </span>
                            </h4>
                            <br />
                            <asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource_departmemnt" OnRowCommand="GridView1_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="id" HeaderText="缺陷类型ID" InsertVisible="False" ReadOnly="True" SortExpression="缺陷类型ID" Visible="False" />
                                    <asp:BoundField DataField="name" HeaderText="名称" SortExpression="名称" />
                                    <asp:BoundField DataField="point" HeaderText="扣分" SortExpression="扣分" />
                                    <asp:BoundField DataField="describe" HeaderText="缺陷类型描述" SortExpression="缺陷类型描述" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton_delete" runat="server" CommandArgument='<%# Eval("id") %>' CommandName="del" OnClientClick="javascript:return confirm('确定删除该缺陷类型？');">删除</asp:LinkButton>
                                        </ItemTemplate>
                                        <ControlStyle ForeColor="#CC0000" />
                                        <ItemStyle Width="40px" />
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
                            <asp:SqlDataSource ID="SqlDataSource_departmemnt" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [test_issue_type] ORDER BY [id]"></asp:SqlDataSource>
                        </form>
                        <div id="alert" runat="server" class="alert alert-danger alert-dismissible" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <span id="alert_text" runat="server"><strong>已有测试项目正在使用当前类型，不可删除</strong></span>
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