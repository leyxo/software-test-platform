<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PlatformTopBar.ascx.cs" Inherits="TestPlatform.Widget.PlatformTopBar" %>

<script src="../Scripts/jquery-2.2.4.js"></script>
<script src="../Scripts/bootstrap.min.js"></script>
<%--jquery要在bootstrap js之前引用！--%>

<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="../platform/platform_home.aspx"><b>软件测试平台</b></a>
            <%--窄屏幕将navbar项目收缩进更多按钮--%>
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar_item">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="collapse navbar-collapse" id="navbar_item">
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a  id="username" runat="server" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%= Session["current_user_department_name"] %>，<strong><%= Session["current_user_name"] %></strong><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="../platform/general_manage_help.aspx">帮助</a></li>
                        <li><a href="../platform/general_manage_feedback.aspx">意见反馈</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="../platform/general_manage_myinfo.aspx">个人信息</a></li>
                    </ul>
                </li>
                <li><a href="../Handler/logoutHandler.ashx">退出</a></li>
            </ul>
        </div>
    </div>
</nav>