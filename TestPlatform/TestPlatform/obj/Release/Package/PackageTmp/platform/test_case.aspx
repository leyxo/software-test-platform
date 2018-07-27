<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test_case.aspx.cs" Inherits="TestPlatform.platform.test_case" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>测试项目 - 测试管理 - 软件测试平台</title>

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
                <div class="panel-heading"><b id="B1" runat="server">测试管理 > 测试项目</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <form id="form1" runat="server">
                        <h4><strong><span id="Title_Department_Name" runat="server">测试项目</span></strong>
                            <span style="float: right">
                                <asp:Button ID="Button_Back" class="btn btn-default" runat="server" Text="返回" OnClick="Button_Back_Click" />
                            </span>
                        </h4>
                        <br />
                        <div class="container" style="border-color: lightgray; border-style: solid; border-width: 1px; width: 100%; padding: 10px;">
                            <div class="row">
                                <div class="col-md-6">
                                    测试系统：<asp:Label ID="label_test" Font-Bold="true" runat="server" Text=""></asp:Label> 
                                    &nbsp;&nbsp;版本：<asp:Label ID="label_test_version" Font-Bold="true" runat="server" Text=""></asp:Label>
                                    <br /><br />
                                    起始日期：<asp:Label ID="start_time" Font-Bold="true" runat="server" Text=""></asp:Label>
                                    &nbsp;&nbsp;&nbsp;截止日期：<asp:Label ID="end_time" Font-Bold="true" runat="server" Text=""></asp:Label>
                                    <br />
                                </div>
                                <div class="col-md-6">
                                    提交日期：<asp:Label ID="creation_date" Font-Bold="true" runat="server" Text=""></asp:Label>
                                    <br /><br />
                                    测试状态：<span id ="test_case_status" runat="server"></span>
                                    <br />
                                </div>
                            </div>
                        </div>
                        <br />
                        <span style="float: right;">
                            <asp:Button ID="Button_Submit" runat="server" class="btn btn-default" Text="提交" OnClientClick="javascript:return confirm('确定要提交此测试版本？');" OnClick="Button_Submit_Click" />
                            &nbsp;
                            <asp:Button ID="Button_Finish" runat="server" class="btn btn-primary" Text="完成测试" OnClientClick="javascript:return confirm('确定要结束此测试版本？');" OnClick="Button_Finish_Click" />
                            <asp:Button ID="Button_Generate_Report" runat="server" class="btn btn-primary" Text="查看测试报告" OnClick="Button_Generate_Report_Click" UseSubmitBehavior="False" />
                            <asp:Button ID="Button_Add_Case" runat="server" class="btn btn-primary" Text="新建测试项目" OnClick="Button_Add_Case_Click" UseSubmitBehavior="False" />
                        </span>
                        <br />

                        <ul id="myTab" class="nav nav-tabs" role="tablist">
                            <li id="li_test_case" runat="server" class="active"><a href="#tab_test_case" data-toggle="tab">测试项目</a></li>
                            <li id="li_test_case_previous" runat="server"><a href="#tab_test_case_previous" data-toggle="tab">以前版本待解决</a></li>
                            <li id="li_test_case_summary" runat="server"><a href="#tab_test_case_summary" data-toggle="tab">总结</a></li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane active" id="tab_test_case" runat="server">
                                <asp:GridView ID="GridView1" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataSourceID="SqlDataSource_test_case" DataKeyNames="ID" OnRowCommand="GridView1_RowCommand" OnRowDeleting="GridView1_RowDeleting">
                                    <Columns>
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
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" Text="删除" CommandName="Delete" CausesValidation="False" ID="LinkButton1" OnClientClick="javascript:return confirm('确定删除此测试系统？');"></asp:LinkButton>
                                            </ItemTemplate>

                                            <ControlStyle ForeColor="#CC0000"></ControlStyle>

                                            <ItemStyle Width="40px"></ItemStyle>
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton_edit" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="edit">编辑</asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle Width="40px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton_edit_describe" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="describe">开发描述</asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        测试项目为空
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                            <%--SQL条件：(版本号 < 当前版本 and (未通过 or 修改意见=2建议修改))--%>
                            <div class="tab-pane" id="tab_test_case_previous" runat="server">
                                <br />
                                    <div class="input-group" style="float:right; width: 350px;">
                                        <input id="search_previous" runat="server" type="text" style="width: 300px;" class="form-control" placeholder="搜索范围：测试过程及结果、改进建议"></th>
                                            <div class="input-group-btn">
                                                <asp:Button ID="Button_Search_Previous" class="btn btn-default" runat="server" Text="搜索" OnClick="Button_Search_Previous_Click" /></th>
                                            </div>
                                    </div>
                                <br /><br />
                                <asp:GridView ID="GridView2" Class="table table-striped table-hover table-bordered table-condensed" Font-Size="Small" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataSourceID="SqlDataSource_test_case_previous" DataKeyNames="ID" OnRowCommand="GridView2_RowCommand">
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
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton_edit_previous" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="edit">编辑</asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle Width="40px" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        测试项目为空
                                    </EmptyDataTemplate>
                                </asp:GridView>
                                <h6>* 包含测试未通过记录和缺陷类型为建议修改的记录</h6>
                            </div>
                            <%--测试总结--%>
                            <div class="tab-pane" id="tab_test_case_summary">
                                <div class="form-group">
                                    <label for="feedback_detail"></label>
                                    <textarea rows="8" runat="server" class="form-control" style="resize: vertical" id="textfield_summary" placeholder="不超过500字" maxlength="1000"></textarea>
                                </div>
                                <span style="float: right;">
                                    <asp:Button ID="Button_Save" class="btn btn-primary" runat="server" Text="保存" OnClick="Button_Save_Click" UseSubmitBehavior="False" />
                                </span>
                            </div>
                        </div>

                        
                        <asp:SqlDataSource ID="SqlDataSource_test_case" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT sys_test_record.id AS ID, sys_test_record.name AS 项目, sys_test_record.precondition AS 前置条件, sys_test_record.process AS 测试过程及结果, base_issuetype.name AS 类型, sys_test_record.times AS 次数, sys_test_record.suggestion AS 改进建议, sys_test_record.describe AS 开发描述, base_status_pass.name AS 结论, users.name AS 记录者, sys_test_record.creation_date AS 创建时间 FROM sys_test_record INNER JOIN base_status_pass ON base_status_pass.id = sys_test_record.pass INNER JOIN users ON users.id = sys_test_record.creation_user_id INNER JOIN base_issuetype ON sys_test_record.type = base_issuetype.id WHERE (sys_test_record.version_id = @version_id)">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="version_id" SessionField="current_test_version" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <%--SQL条件：(版本号 < 当前版本 and (未通过 or 缺陷类型=2建议修改))--%>
                        <asp:SqlDataSource ID="SqlDataSource_test_case_previous" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT sys_test_name_version.name AS 版本, sys_test_record.id AS ID, sys_test_record.name AS 项目, sys_test_record.precondition AS 前置条件, sys_test_record.process AS 测试过程及结果, base_issuetype.name AS 类型, sys_test_record.times AS 次数, sys_test_record.suggestion AS 改进建议, sys_test_record.describe AS 开发描述, base_status_pass.name AS 结论, users.name AS 记录者, sys_test_record.creation_date AS 创建时间 FROM sys_test_record INNER JOIN base_status_pass ON base_status_pass.id = sys_test_record.pass INNER JOIN users ON users.id = sys_test_record.creation_user_id INNER JOIN base_issuetype ON sys_test_record.type = base_issuetype.id INNER JOIN sys_test_name_version ON sys_test_name_version.id = sys_test_record.version_id WHERE (sys_test_name_version.test_ID = @test_id and sys_test_record.version_id < @version_id and (sys_test_record.pass = 2 or sys_test_record.type = 2))">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="test_id" SessionField="current_test_id" Type="Int32" />
                            </SelectParameters>
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="version_id" SessionField="current_test_version" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
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

    <script>
        //搜索框内有内容时，显示第二个tab
        $(function () {
            var search_content = document.getElementById('search_previous').value;
            if (search_content != '') {
                $('#myTab a:eq(1)').tab('show');//显示第2个tab
            }
        })
    </script>
</body>
</html>
