<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test_report.aspx.cs" Inherits="TestPlatform.platform.test_report" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title id="title" runat="server">系统测试报告</title>

    <%-- css --%>
    <link rel="stylesheet" href="../Content/bootstrap.min.css" />
    <link rel="stylesheet" href="../Content/bootstrap-theme.min.css" />
    <link rel="stylesheet" href="../Content/base.css" />
    

</head>
<body>
    <div class="container" style="width:960px" runat="server">

        <form id="form1" runat="server">
            <div class="page-header">
                <h1>系统测试报告&nbsp;<small><span id="Title_Test_Name" runat="server"></span></small></h1>
            </div>
            <%--<h4><strong></strong></h4>--%>
            <div class="container" style="border-color: lightgray; border-style: solid; border-width: 0px; width: 100%; padding: 10px;">
                <div class="row">
                    <div class="col-md-6">
                        测试系统：<asp:Label ID="name" runat="server" Font-Bold="true" Text=""></asp:Label>
                        &nbsp;&nbsp;&nbsp;版本：<asp:Label ID="version" runat="server" Font-Bold="true" Text=""></asp:Label>
                        <br />
                        <br />
                        测试时间：<asp:Label ID="start_time" Font-Bold="true" runat="server" Text=""></asp:Label>
                        <strong>~</strong>&nbsp;<asp:Label ID="end_time" Font-Bold="true" runat="server" Text=""></asp:Label>
                        <br />
                    </div>
                    <div class="col-md-6">
                        报告生成时间：<asp:Label ID="generate_time" Font-Bold="true" runat="server" Text=""></asp:Label>
                        <%--版本编号：<asp:Label ID="version_number" Font-Bold="true" runat="server" Text=""></asp:Label>--%>
                        <%--测试状态：<asp:Label ID="status" Font-Bold="true" runat="server" Text=""></asp:Label>--%>
                        <br />
                        <br />
                        测试人员：<asp:Label ID="user" Font-Bold="true" runat="server" Text=""></asp:Label>
                        &nbsp;&nbsp;&nbsp;版本提交时间：<asp:Label ID="creation_date" Font-Bold="true" runat="server" Text=""></asp:Label>
                        <br />
                    </div>
                </div>
            </div>
            <br />

            <asp:GridView ID="GridView1" Class="table table-striped table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_test_case" DataKeyNames="ID">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                    <asp:BoundField DataField="项目" HeaderText="项目" SortExpression="项目" />
                    <asp:BoundField DataField="前置条件" HeaderText="前置条件" SortExpression="前置条件" />
                    <asp:BoundField DataField="测试过程及结果" HeaderText="测试过程及结果" SortExpression="测试过程及结果" >
                    <ItemStyle Width="200px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="改进建议" HeaderText="改进建议" SortExpression="改进建议" />
                    <asp:BoundField DataField="类型" HeaderText="类型" SortExpression="类型" />
                    <asp:BoundField DataField="结论" HeaderText="结论" SortExpression="结论">
                        <ItemStyle Width="60px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="次数" HeaderText="次数" SortExpression="次数">
                        <ItemStyle Width="40px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="记录者" HeaderText="记录者" SortExpression="记录者" >
                    <ItemStyle Width="50px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="开发描述" HeaderText="开发描述" SortExpression="开发描述" >
                    <ItemStyle Width="100px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="创建时间" HeaderText="创建时间" SortExpression="创建时间" DataFormatString="{0:d}" Visible="False" />
                </Columns>
                <EmptyDataTemplate>
                    测试记录为空
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource_test_case" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT test_case.id AS ID, test_case.name AS 项目, test_case.precondition AS 前置条件, test_case.process AS 测试过程及结果, test_issue_type.name AS 类型, test_case.times AS 次数, test_case.suggestion AS 改进建议, test_case.describe AS 开发描述, pass.name AS 结论, users.name AS 记录者, test_case.creation_date AS 创建时间 FROM test_case INNER JOIN pass ON pass.id = test_case.pass INNER JOIN users ON users.id = test_case.creation_user_id INNER JOIN test_issue_type ON test_case.type = test_issue_type.id WHERE (test_case.version_id = @version_id)">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="0" Name="version_id" SessionField="current_test_version" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <br />
            <h4><strong>总结</strong></h4>
            <asp:Label ID="Label_summery" runat="server" Text=""></asp:Label>

            <br />
            <br />
            <br />
            <h4><strong>以前版本待解决问题</strong></h4>
            <%--SQL条件：(版本号 < 当前版本 and (未通过 or 有修改意见))--%>
            <asp:GridView ID="GridView2" Class="table table-striped table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_test_case_previous" DataKeyNames="ID">
                <Columns>
                    <asp:BoundField DataField="版本" HeaderText="版本" SortExpression="版本" />
                    <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                    <asp:BoundField DataField="项目" HeaderText="项目" SortExpression="项目" />
                    <asp:BoundField DataField="前置条件" HeaderText="前置条件" SortExpression="前置条件" />
                    <asp:BoundField DataField="测试过程及结果" HeaderText="测试过程及结果" SortExpression="测试过程及结果" />
                    <asp:BoundField DataField="改进建议" HeaderText="改进建议" SortExpression="改进建议" />
                    <asp:BoundField DataField="类型" HeaderText="类型" SortExpression="类型" />
                    <asp:BoundField DataField="结论" HeaderText="结论" SortExpression="结论">
                        <ItemStyle Width="60px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="次数" HeaderText="次数" SortExpression="次数">
                        <ItemStyle Width="40px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="记录者" HeaderText="记录者" SortExpression="记录者" />
                    <asp:BoundField DataField="开发描述" HeaderText="开发描述" SortExpression="开发描述" />
                    <asp:BoundField DataField="创建时间" HeaderText="创建时间" SortExpression="创建时间" DataFormatString="{0:d}" Visible="False" />
                </Columns>
                <EmptyDataTemplate>
                    无
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource_test_case_previous" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT test_version.name AS 版本, test_case.id AS ID, test_case.name AS 项目, test_case.precondition AS 前置条件, test_case.process AS 测试过程及结果, test_issue_type.name AS 类型, test_case.times AS 次数, test_case.suggestion AS 改进建议, test_case.describe AS 开发描述, pass.name AS 结论, users.name AS 记录者, test_case.creation_date AS 创建时间 FROM test_case INNER JOIN pass ON pass.id = test_case.pass INNER JOIN users ON users.id = test_case.creation_user_id INNER JOIN test_issue_type ON test_case.type = test_issue_type.id INNER JOIN test_version ON test_version.id = test_case.version_id WHERE (test_version.test_ID = @test_id and test_case.version_id < @version_id and (test_case.pass = 2 or test_case.suggestion <> ''))">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="0" Name="test_id" SessionField="current_test_id" Type="Int32" />
                </SelectParameters>
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="0" Name="version_id" SessionField="current_test_version" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </form>

    </div>

</body>
</html>
