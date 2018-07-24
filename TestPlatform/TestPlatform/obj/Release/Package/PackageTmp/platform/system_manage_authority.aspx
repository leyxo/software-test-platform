<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="system_manage_authority.aspx.cs" Inherits="TestPlatform.platform.system_manage_authority" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>权限管理 - 系统管理 - 软件测试平台</title>
    
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
                <div class="panel-heading"><b id="B1" runat="server">系统管理 > 权限管理</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <%--主体内容--%>

                    <div style="max-width: 400px;">
                        <h4><strong>权限分配表</strong></h4>
                        <br />
                        <form id="form1" role="form" runat="server">
                            <asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" style='text-align: center;' Font-Size="Small" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="model">
                                <Columns>
                                    <asp:BoundField DataField="id" HeaderText="模块ID" InsertVisible="False" ReadOnly="True" SortExpression="id" Visible="False" />
                                    <asp:BoundField DataField="name" HeaderText="模块名称" SortExpression="name" />
                                    <asp:TemplateField HeaderText="管理员">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="测试组长">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox2" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="测试人员">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox3" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="开发者">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox4" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>

                            <asp:SqlDataSource ID="model" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [model] ORDER BY sort_order"></asp:SqlDataSource>

                            <div id="alert" runat="server" class="alert alert-success alert-dismissible" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <span id="alert_text" runat="server"><strong>保存成功！</strong></span>
                            </div>
                            <asp:Button ID="Button_Save" class="btn btn-primary" runat="server" Text="保存" OnClick="Button_Save_Click" UseSubmitBehavior="False" />
                            &nbsp;<asp:Button ID="Button_Cancel" class="btn btn-default" runat="server" Text="取消" OnClick="Button_Cancel_Click" UseSubmitBehavior="False" />
                        <br />
                            <h6 style="color:#CC0000">* 权限修改后需要立即注销</h6>
                        </form>

                    </div>
                </div>
            </div>
        </div>

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>

</body>
</html>
