<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TopBar.ascx.cs" Inherits="TestPlatform.Widget.TopBar" %>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
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
                <li id="Login"><a href="../login.aspx">登录</a></li>
                <li id="Register"><a href="../register.aspx">注册</a></li>
            </ul>
        <%--</div>
        <div class="collapse navbar-collapse" id="navbar_item">--%>
            <ul class="nav navbar-nav">
                <li id="IndexPage"><a href="#">首页</a></li>
                <li id="About"><a href="#">关于</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">更多 <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="#">使用帮助</a></li>
                        <li><a href="#">没有</a></li>
                        <li><a href="#">更多</a></li>
                        <li class="divider"></li>
                        <li><a href="#">了</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
