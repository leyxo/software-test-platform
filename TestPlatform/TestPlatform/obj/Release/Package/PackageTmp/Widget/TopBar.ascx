<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TopBar.ascx.cs" Inherits="TestPlatform.Widget.TopBar" %>

<script src="../Scripts/jquery-2.2.4.js"></script>
<script src="../Scripts/bootstrap.min.js"></script>
<%--jquery要在bootstrap js之前引用！--%>

<nav class="navbar navbar-fixed-top navbar-default">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="../index.aspx"><b>软件测试平台</b></a>
            <%--窄屏幕将navbar项目收缩进更多按钮--%>
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar_item">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="collapse navbar-collapse" id="navbar_item">
            <ul class="nav navbar-nav navbar-right">
                <li id="Login"><a href="/login.aspx">登录</a></li>
                <li id="Register"><a href="/register.aspx">注册</a></li>
            </ul>

            <%--<ul class="nav navbar-nav">
                <li id="About"><a href="/about.aspx">关于</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">更多 <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="/help.aspx">使用帮助</a></li>
                        <li><a href="#">意见反馈</a></li>
                        <li class="divider"></li>
                        <li><a href="#">加入我们</a></li>
                    </ul>
                </li>
            </ul>--%>
        </div>
    </div>
</nav>
