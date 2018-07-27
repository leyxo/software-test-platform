<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PlatformTreeMenu.ascx.cs" Inherits="TestPlatform.Widget.PlatformTreeMenu" %>

<div class="row">
    <ul id="main-nav" class="nav nav-tabs nav-stacked" style="">
        <li>
            <a href="../platform/platform_home.aspx">
                <i class="glyphicon glyphicon-th-large"></i> 首页
            </a>
        </li>
        <li runat="server" id="system_manage_menu">
            <a href="#system_manage" class="nav-header collapsed" data-toggle="collapse" data-parent="#main-nav">
                <i class="glyphicon glyphicon-cog"></i> 系统管理 &nbsp; <span id="badge_system_manage" style="color:white" runat="server" class="badge"></span><span class="pull-right glyphicon glyphicon-chevron-down"></span>
            </a>
            <ul id="system_manage" class="nav nav-list collapse secondmenu" style="height: 0px;">
                <li runat="server" id="system_manage_personnel"><a href="../platform/system_manage_personnel.aspx"><i class="glyphicon glyphicon-user"></i> 人员管理&nbsp; <span id="badge_personnel" style="color:white" runat="server" class="badge"></span></a></li>
                <li runat="server" id="system_manage_department"><a href="../platform/system_manage_department.aspx"><i class="glyphicon glyphicon glyphicon-tags"></i> 机构管理</a></li>
                <li runat="server" id="system_manage_authority"><a href="../platform/system_manage_authority.aspx"><i class="glyphicon glyphicon-eye-open"></i> 权限管理</a></li>
            </ul>
        </li>
        <li runat="server" id="basedata_manage_menu">
            <a href="#basedata_manage" class="nav-header collapsed" data-toggle="collapse" data-parent="#main-nav">
                <i class="glyphicon glyphicon glyphicon-inbox"></i> 基础数据管理<span class="pull-right glyphicon glyphicon-chevron-down"></span>
            </a>
            <ul id="basedata_manage" class="nav nav-list collapse secondmenu" style="height: 0px;">
                <li runat="server" id="basedata_manage_issuetype"><a href="../platform/basedata_manage_issuetype.aspx"><i class="glyphicon glyphicon glyphicon-font"></i> 缺陷类型定义</a></li>
                <li runat="server" id="basedata_manage_test"><a href="../platform/basedata_manage_test.aspx"><i class="glyphicon glyphicon glyphicon-tags"></i> 测试系统维护</a></li>
            </ul>
        </li>
        <li runat="server" id="test_manage_menu">
            <a href="#test_manage" class="nav-header collapsed" data-toggle="collapse" data-parent="#main-nav">
                <i class="glyphicon glyphicon glyphicon-inbox"></i> 测试管理<span class="pull-right glyphicon glyphicon-chevron-down"></span>
            </a>
            <ul id="test_manage" class="nav nav-list collapse secondmenu" style="height: 0px;">
                <li runat="server" id="basedata_manage_test_version"><a href="../platform/basedata_manage_test_version.aspx"><i class="glyphicon glyphicon glyphicon-object-align-left"></i> 测试管理</a></li>
                <%--<li runat="server" id="test_case"><a href="../platform/test_case.aspx"><i class="glyphicon glyphicon glyphicon-check"></i> 测试项目</a></li>--%>
                <li runat="server" id="test_members"><a href="../platform/test_members.aspx"><i class="glyphicon glyphicon-pencil"></i> 测试报告</a></li>
            </ul>
        </li>
    </ul>
</div>

<script>
    // 判断菜单展开情况
    var path = location.pathname;
    if (-1 != path.indexOf("platform/basedata_manage_issue") || -1 != path.indexOf("platform/basedata_manage_test.aspx") || -1 != path.indexOf("platform/basedata_manage_test_add") || -1 != path.indexOf("platform/basedata_manage_test_edit")) {
        $('#basedata_manage').collapse({
            toggle: true,
        });
    }
    if (-1 != path.indexOf("platform/test"))
    {
        $('#test_manage').collapse({
            toggle: true,
        });
    }
    if (-1 != path.indexOf("platform/system")) {
        $('#system_manage').collapse({
            toggle: true,
        });
    }

    // 测试版本被修改到测试管理下，相当糟烂的代码 - -，待重构
    if (-1 != path.indexOf("platform/basedata_manage_test_version")) {
        $('#test_manage').collapse({
            toggle: true,
        });
    }
</script>