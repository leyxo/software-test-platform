﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="basedata_manage_test_add.aspx.cs" Inherits="TestPlatform.platform.basedata_manage_test_add" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>新建项目 - 系统名称维护 - 基础数据管理 - 软件测试平台</title>
    
    <%--Style Sheet--%>
    <link rel="stylesheet" href="../Content/bootstrap.min.css"/>
    <link rel="stylesheet" href="../Content/bootstrap-theme.min.css"/>
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
                <div class="panel-heading"><b id="B1" runat="server">基础数据管理 > 系统名称维护 > 新建项目</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <%--主体内容--%>
                    <div style="max-width: 400px;">
                        <h4><strong>新建项目</strong></h4>
                        <br />
                        <form id="form1" role="form" runat="server">
                            <div class="input-group">
                                <span class="input-group-addon glyphicon glyphicon-star" style="position: static"></span>
                                <input type="text" runat="server" class="form-control" id="test_name" placeholder="项目名称" style="font-weight:bold;" required="required" />
                            </div>
                            <br />
                            <div class="input-group">
                                <span class="input-group-addon glyphicon glyphicon-edit" style="position: static"></span>
                                <textarea rows="5" runat="server" class="form-control" style="resize:none" id="test_describe" placeholder="备注 (选填)"></textarea>
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