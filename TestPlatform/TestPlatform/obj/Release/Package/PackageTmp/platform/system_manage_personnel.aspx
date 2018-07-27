<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="system_manage_personnel.aspx.cs" Inherits="TestPlatform.platform.system_manage_personnel1" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>人员管理 - 系统管理 - 软件测试平台</title>

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
                <div class="panel-heading"><b id="B1" runat="server">系统管理 > 人员管理</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <h4><strong>待审核人员</strong>&nbsp; <span id="badge_personnel" runat="server" class="badge"></span></h4>
                    <form id="form1" runat="server">
                        <asp:GridView ID="GridView0" Class="table table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataKeyNames="用户ID" DataSourceID="users_under_review" OnRowCommand="GridView0_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="用户ID" HeaderText="用户ID" InsertVisible="False" ReadOnly="True" SortExpression="用户ID" Visible="False" />
                                <asp:BoundField DataField="姓名" HeaderText="姓名" SortExpression="姓名" />
                                <asp:BoundField DataField="邮箱" HeaderText="邮箱" SortExpression="邮箱" />
                                <asp:BoundField DataField="电话" HeaderText="电话" SortExpression="电话" />
                                <asp:BoundField DataField="注册时间" HeaderText="注册时间" SortExpression="注册时间" />
                                <asp:BoundField DataField="注册机构" HeaderText="注册机构" SortExpression="注册机构" />
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
                        <asp:SqlDataSource ID="users_under_review" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT users.id AS 用户ID, users.name AS 姓名, users.email AS 邮箱, users.phone AS 电话, users.reg_datetime AS 注册时间, base_department.name AS 注册机构, base_role.name AS 注册角色 FROM users INNER JOIN base_department ON base_department.id = users.department INNER JOIN base_role ON base_role.id = users.role INNER JOIN base_status_reg ON base_status_reg.id = users.reg_status
WHERE users.reg_status = 1"></asp:SqlDataSource>

                        <h4><strong>所有人员</strong>
                            <span style="float: right;">
                            <asp:Button ID="Button_Add" runat="server" class="btn btn-primary" Text="新建用户" OnClick="Button_Add_Click" UseSubmitBehavior="False" />
                        </span>
                        <br />
                        </h4>
                        <ul id="myTab" class="nav nav-tabs">
                            <li class="active"><a href="#users_enabled" data-toggle="tab">有效人员</a></li>
                            <li><a href="#users_disabled" data-toggle="tab">无效人员</a></li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane fade in active" id="users_enabled">
                                <asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" DataKeyNames="用户ID" AllowPaging="True" DataSourceID="userinfo_enabled" AllowSorting="True" OnRowCommand="GridView1_RowCommand">
                                    <Columns>
                                        <asp:BoundField DataField="用户ID" HeaderText="用户ID" InsertVisible="False" ReadOnly="True" SortExpression="用户ID" Visible="False" />
                                        <asp:BoundField DataField="姓名" HeaderText="姓名" SortExpression="姓名" ReadOnly="True" />
                                        <asp:BoundField DataField="邮箱" HeaderText="邮箱" SortExpression="邮箱" />
                                        <asp:BoundField DataField="电话" HeaderText="电话" SortExpression="电话" />
                                        <asp:BoundField DataField="注册时间" HeaderText="注册时间" SortExpression="注册时间" ReadOnly="True" />
                                        <asp:TemplateField HeaderText="机构" SortExpression="机构">
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="DropDownList_department" runat="server" DataSourceID="department" DataTextField="name" DataValueField="id">
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("机构") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="角色" SortExpression="角色">
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="DropDownList_role" runat="server" DataSourceID="role" DataTextField="name" DataValueField="id">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="role" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [base_role]"></asp:SqlDataSource>
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
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server"  CommandArgument='<%# Eval("用户ID") %>' Text="删除" CommandName="del" CausesValidation="False" ID="LinkButton2" OnClientClick="javascript:return confirm('确定删除？');"></asp:LinkButton>
                                            </ItemTemplate>
                                            <ControlStyle ForeColor="#CC0000"></ControlStyle>
                                            <ItemStyle Width="40px"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("用户ID") %>' CommandName="edit">编辑</asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle Width="40px"></ItemStyle>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        暂无人员数据
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                            <div class="tab-pane fade" id="users_disabled">
                                <asp:GridView ID="GridView2" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" DataKeyNames="用户ID" AllowPaging="True" DataSourceID="userinfo_disabled" AllowSorting="True" OnRowDeleting="GridView1_RowDeleting" OnRowCommand="GridView1_RowCommand">
                                    <Columns>
                                        <asp:BoundField DataField="用户ID" HeaderText="用户ID" InsertVisible="False" ReadOnly="True" SortExpression="用户ID" Visible="False" />
                                        <asp:BoundField DataField="姓名" HeaderText="姓名" SortExpression="姓名" ReadOnly="True" />
                                        <asp:BoundField DataField="邮箱" HeaderText="邮箱" SortExpression="邮箱" />
                                        <asp:BoundField DataField="电话" HeaderText="电话" SortExpression="电话" />
                                        <asp:BoundField DataField="注册时间" HeaderText="注册时间" SortExpression="注册时间" ReadOnly="True" />
                                        <asp:TemplateField HeaderText="机构" SortExpression="机构">
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="DropDownList_department" runat="server" DataSourceID="department" DataTextField="name" DataValueField="id">
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("机构") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="角色" SortExpression="角色">
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="DropDownList_role" runat="server" DataSourceID="role" DataTextField="name" DataValueField="id">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="role" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [base_role]"></asp:SqlDataSource>
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
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server"  CommandArgument='<%# Eval("用户ID") %>' Text="删除" CommandName="del" CausesValidation="False" ID="LinkButton2" OnClientClick="javascript:return confirm('确定删除？');"></asp:LinkButton>
                                            </ItemTemplate>
                                            <ControlStyle ForeColor="#CC0000"></ControlStyle>
                                            <ItemStyle Width="40px"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("用户ID") %>' CommandName="edit">编辑</asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle Width="40px"></ItemStyle>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        暂无人员数据
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                        </div>
                        <asp:SqlDataSource ID="userinfo_enabled" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT users.id AS 用户ID, users.name AS 姓名, users.email AS 邮箱, users.phone AS 电话, users.reg_datetime AS 注册时间, base_department.name AS 机构, base_role.name AS 角色, base_status_reg.name AS 状态 FROM users INNER JOIN base_department ON base_department.id = users.department INNER JOIN base_role ON base_role.id = users.role INNER JOIN base_status_reg ON base_status_reg.id = users.reg_status WHERE users.reg_status IN (1, 2) "></asp:SqlDataSource>
                        <asp:SqlDataSource ID="userinfo_disabled" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT users.id AS 用户ID, users.name AS 姓名, users.email AS 邮箱, users.phone AS 电话, users.reg_datetime AS 注册时间, base_department.name AS 机构, base_role.name AS 角色, base_status_reg.name AS 状态 FROM users INNER JOIN base_department ON base_department.id = users.department INNER JOIN base_role ON base_role.id = users.role INNER JOIN base_status_reg ON base_status_reg.id = users.reg_status WHERE users.reg_status NOT IN (1, 2) "></asp:SqlDataSource>

                        <asp:SqlDataSource ID="department" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [base_department]"></asp:SqlDataSource>
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

                        <asp:SqlDataSource ID="reg_status" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="select * from base_status_reg"></asp:SqlDataSource>

                    </form>
                    <div id="alert" runat="server" class="alert alert-danger alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <span id="alert_text" runat="server"><strong>此用户有正在参与的项目，不可删除</strong></span>
                    </div>
                </div>
            </div>
        </div>

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>

</body>
</html>
