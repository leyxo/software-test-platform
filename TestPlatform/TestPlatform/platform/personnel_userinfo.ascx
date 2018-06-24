<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="personnel_userinfo.ascx.cs" Inherits="TestPlatform.platform.personnel_userinfo" %>


<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="用户ID" DataSourceID="userinfo" AllowPaging="True">
    <Columns>
        <asp:BoundField DataField="用户ID" HeaderText="用户ID" InsertVisible="False" ReadOnly="True" SortExpression="用户ID" />
        <asp:BoundField DataField="姓名" HeaderText="姓名" SortExpression="姓名" />
        <asp:BoundField DataField="邮箱" HeaderText="邮箱" SortExpression="邮箱" />
        <asp:BoundField DataField="电话" HeaderText="电话" SortExpression="电话" />
        <asp:BoundField DataField="注册时间" HeaderText="注册时间" SortExpression="注册时间" />
        <asp:BoundField DataField="部门" HeaderText="部门" SortExpression="部门" />
        <asp:BoundField DataField="身份" HeaderText="身份" SortExpression="身份" />
        <asp:BoundField DataField="状态" HeaderText="状态" SortExpression="状态" />
        <asp:ButtonField ButtonType="Button" Text="修改" />
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="userinfo" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT users.id AS 用户ID, users.name AS 姓名, users.email AS 邮箱, users.phone AS 电话, users.reg_datetime AS 注册时间, department.name AS 部门, role.name AS 身份, reg_status.name AS 状态 FROM users INNER JOIN department ON department.id = users.department INNER JOIN role ON role.id = users.role INNER JOIN reg_status ON reg_status.id = users.reg_status"></asp:SqlDataSource>
