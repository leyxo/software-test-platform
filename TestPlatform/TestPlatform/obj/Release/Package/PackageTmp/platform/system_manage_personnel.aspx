<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="system_manage_personnel.aspx.cs" Inherits="TestPlatform.platform.system_manage_personnel1" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>人员管理 - 系统管理 - 软件测试平台</title>

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
                <div class="panel-heading"><b id="B1" runat="server">系统管理 > 人员管理</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <h4><strong>待审核人员</strong>&nbsp; <span id="badge_personnel" runat="server" class="badge"></span></h4>
                    <form id="form1" runat="server">
                        <asp:GridView ID="GridView0" Class="table table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataKeyNames="用户ID" DataSourceID="users_under_review" OnRowCommand="GridView0_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="用户ID" HeaderText="用户ID" InsertVisible="False" ReadOnly="True" SortExpression="用户ID" />
                                <asp:BoundField DataField="姓名" HeaderText="姓名" SortExpression="姓名" />
                                <asp:BoundField DataField="邮箱" HeaderText="邮箱" SortExpression="邮箱" />
                                <asp:BoundField DataField="电话" HeaderText="电话" SortExpression="电话" />
                                <asp:BoundField DataField="注册时间" HeaderText="注册时间" SortExpression="注册时间" />
                                <asp:BoundField DataField="注册部门" HeaderText="注册部门" SortExpression="注册部门" />
                                <asp:BoundField DataField="注册角色" HeaderText="注册角色" SortExpression="注册角色" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton_accept" runat="server" CommandArgument='<%# Eval("用户ID") %>' CommandName="accept" ForeColor="Green">批准</asp:LinkButton>
                                        &nbsp;
                                        <asp:LinkButton ID="LinkButton_refuse" runat="server" CommandArgument='<%# Eval("用户ID") %>' CommandName="refuse" ForeColor="IndianRed">拒绝</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                没有待审核人员
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="users_under_review" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT users.id AS 用户ID, users.name AS 姓名, users.email AS 邮箱, users.phone AS 电话, users.reg_datetime AS 注册时间, department.name AS 注册部门, role.name AS 注册角色 FROM users INNER JOIN department ON department.id = users.department INNER JOIN role ON role.id = users.role INNER JOIN reg_status ON reg_status.id = users.reg_status
WHERE users.reg_status = 1"></asp:SqlDataSource>

                    <h4><strong>所有人员</strong></h4>
                        <asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" DataKeyNames="用户ID" AllowPaging="True" DataSourceID="userinfo" AllowSorting="True" OnRowDeleting="GridView1_RowDeleting" OnRowCommand="GridView1_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="用户ID" HeaderText="用户ID" InsertVisible="False" ReadOnly="True" SortExpression="用户ID" />
                                <asp:BoundField DataField="姓名" HeaderText="姓名" SortExpression="姓名" ReadOnly="True" />
                                <asp:BoundField DataField="邮箱" HeaderText="邮箱" SortExpression="邮箱" />
                                <asp:BoundField DataField="电话" HeaderText="电话" SortExpression="电话" />
                                <asp:BoundField DataField="注册时间" HeaderText="注册时间" SortExpression="注册时间" ReadOnly="True" />
                                <asp:TemplateField HeaderText="部门" SortExpression="部门">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownList_department" runat="server" DataSourceID="department" DataTextField="name" DataValueField="id">
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("部门") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="角色" SortExpression="角色">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownList_role" runat="server" DataSourceID="role" DataTextField="name" DataValueField="id">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="role" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [role]"></asp:SqlDataSource>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("角色") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="状态" SortExpression="状态">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownList_reg_status" runat="server" DataSourceID="reg_status" DataTextField="name" DataValueField="id">
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("状态") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowDeleteButton="True" DeleteText="离职" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("用户ID") %>' CommandName="edit">编辑</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                暂无人员数据
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="userinfo" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT users.id AS 用户ID, users.name AS 姓名, users.email AS 邮箱, users.phone AS 电话, users.reg_datetime AS 注册时间, department.name AS 部门, role.name AS 角色, reg_status.name AS 状态 FROM users INNER JOIN department ON department.id = users.department INNER JOIN role ON role.id = users.role INNER JOIN reg_status ON reg_status.id = users.reg_status"></asp:SqlDataSource>

                        <asp:SqlDataSource ID="department" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [department]"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="users" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" DeleteCommand="DELETE FROM [users] WHERE [id] = @id" InsertCommand="INSERT INTO [users] ([name], [email], [phone], [reg_datetime], [department], [role], [reg_status]) VALUES (@name, @email, @phone, @reg_datetime, @department, @role, @reg_status)" SelectCommand="SELECT [id], [name], [email], [phone], [reg_datetime], [department], [role], [reg_status] FROM [users]" UpdateCommand="UPDATE [users] SET [name] = @name, [email] = @email, [phone] = @phone, [reg_datetime] = @reg_datetime, [department] = @department, [role] = @role, [reg_status] = @reg_status WHERE [id] = @id">
                            <DeleteParameters>
                                <asp:Parameter Name="id" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="name" Type="String" />
                                <asp:Parameter Name="email" Type="String" />
                                <asp:Parameter Name="phone" Type="String" />
                                <asp:Parameter Name="reg_datetime" Type="DateTime" />
                                <asp:Parameter Name="department" Type="Int32" />
                                <asp:Parameter Name="role" Type="Int32" />
                                <asp:Parameter Name="reg_status" Type="Int32" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="name" Type="String" />
                                <asp:Parameter Name="email" Type="String" />
                                <asp:Parameter Name="phone" Type="String" />
                                <asp:Parameter Name="reg_datetime" Type="DateTime" />
                                <asp:Parameter Name="department" Type="Int32" />
                                <asp:Parameter Name="role" Type="Int32" />
                                <asp:Parameter Name="reg_status" Type="Int32" />
                                <asp:Parameter Name="id" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="reg_status" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="select * from reg_status"></asp:SqlDataSource>

                    </form>

                </div>
            </div>
        </div>

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>

</body>
</html>
