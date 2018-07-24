<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="basedata_manage_test_edit_users.aspx.cs" Inherits="TestPlatform.platform.basedata_manage_test_edit_users" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>用户分配 - 测试系统维护 - 基础数据管理 - 软件测试平台</title>
    
    <%--Style Sheet--%>
    <link rel="stylesheet" href="../Content/bootstrap.min.css"/>
    <link rel="stylesheet" href="../Content/base.css"/>
    <link rel="stylesheet" href="../Content/bootstrap-datepicker3.css"/>

    <script src="../Scripts/jquery-2.2.4.js"></script>
    <%--<script src="../Scripts/bootstrap.min.js"></script>--%>
    <script src="../Scripts/bootstrap-datepicker.js"></script>

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
                <div class="panel-heading"><b id="B1" runat="server">基础数据管理 > 测试系统维护 > 用户分配</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <%--主体内容--%>
                    <div style="max-width: 400px;">
                        <h4><strong><span id="Title_Test_Name" runat="server">测试系统</span> - 用户分配</strong></h4>
                        <br />
                        <div style="max-width: 500px;">
                            <form id="form1" role="form" runat="server">
                                <asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="users">
                                    <Columns>
                                        <asp:BoundField DataField="id" HeaderText="用户ID" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                                        <asp:BoundField DataField="department" HeaderText="部门" SortExpression="department" />
                                        <asp:BoundField DataField="name" HeaderText="用户" SortExpression="name" />
                                        <asp:BoundField DataField="name1" HeaderText="角色" SortExpression="name1" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" runat="server" />
                                            </ItemTemplate>
                                            <ItemStyle Width="12px" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>

                                <asp:SqlDataSource ID="users" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT department.name AS department, users.id, users.name, role.name FROM [users] INNER JOIN role ON role.id = users.role INNER JOIN department ON department.id = users.department WHERE users.reg_status = 2">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="department" SessionField="current_user_department_id" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <div id="alert" runat="server" class="alert alert-success alert-dismissible" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <span id="alert_text" runat="server"><strong>保存成功！</strong></span>
                                </div>
                                <asp:Button ID="Button_Save" class="btn btn-primary" runat="server" Text="保存" OnClick="Button_Save_Click" UseSubmitBehavior="False" />
                                &nbsp;<asp:Button ID="Button_Cancel" class="btn btn-default" runat="server" Text="取消" OnClick="Button_Cancel_Click" UseSubmitBehavior="False" />
                                <br />
                            </form>
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
