<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PlatformTopBar.ascx.cs" Inherits="TestPlatform.Widget.PlatformTopBar" %>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<%--jquery要在bootstrap js之前引用！--%>

<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="../platform_index.aspx">我的工作台</a>
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
                    <a href="javascript:void(0);" id="username" runat="server" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">欢迎您,<%= Session["current_user"] %><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">个人信息</a></li>
                        <li><a href="#">帮助中心</a></li>
                        <li><a href="#">设置</a></li>
                        <li><a href="#">意见反馈</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="../Handler/logoutHandler.ashx">退出登录</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>