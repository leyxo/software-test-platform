﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test_case_describe.aspx.cs" Inherits="TestPlatform.platform.test_case_describe" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>编辑开发描述 - 测试项目 - 测试管理 - 软件测试平台</title>
    
    <%--css--%>
    <link rel="stylesheet" href="../Content/bootstrap.min.css"/>
    <link rel="stylesheet" href="../Content/base.css"/>

    <script src="../Scripts/jquery-2.2.4.js"></script>
    <script src="../Scripts/bootstrap-datepicker.js"></script>

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
                <div class="panel-heading"><b id="B1" runat="server">测试管理 > 测试项目 > 编辑开发描述</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <%--主体内容--%>
                    <div style="max-width: 100%;">
                        <form id="form1" role="form" runat="server">
                            <h4><strong><span id="Title_Test_Name" runat="server">系统名称</span> (<span id="Title_Test_version" runat="server">版本</span>)</span></strong></h4>
                            <br />
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="test_case_name">测试项目名称</label>
                                        <input type="text" runat="server" class="form-control" id="test_case_name" readonly="readonly" style="font-weight: bold;" placeholder="测试项目名称" required="required" />
                                    </div>
                                    <div class="form-group">
                                        <label for="test_case_precondition">前置条件</label>
                                        <input type="text" runat="server" class="form-control" id="test_case_precondition" readonly="readonly" placeholder="" />
                                    </div>
                                    <div class="form-group">
                                        <label for="test_case_process">测试过程及结果</label>
                                        <textarea rows="9" runat="server" class="form-control" style="resize: vertical" id="test_case_process" readonly="readonly" placeholder=""></textarea>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="test_case_suggestion">改进建议</label>
                                        <textarea rows="5" runat="server" class="form-control" style="resize: vertical" id="test_case_suggestion" readonly="readonly" placeholder=""></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="test_case_describes">开发描述</label>
                                        <textarea rows="5" runat="server" class="form-control" style="resize: vertical" id="test_case_describes" placeholder="" autofocus="autofocus"></textarea>
                                    </div>

                                </div>
                            </div>
                            <br />
                            <div id="alert" runat="server" class="alert alert-success alert-dismissible" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <span id="alert_text" runat="server"><strong>保存成功！</strong></span>
                            </div>
                            <asp:Button ID="Button_Save" class="btn btn-primary" runat="server" Text="保存" OnClick="Button_Save_Click" />
                            &nbsp;<asp:Button ID="Button_Cancel" class="btn btn-default" runat="server" Text="取消" OnClick="Button_Cancel_Click" UseSubmitBehavior="False" />
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
