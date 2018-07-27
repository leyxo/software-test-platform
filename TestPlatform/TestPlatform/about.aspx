<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="TestPlatform.about" %>
<%@ Register Src="~/Widget/TopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>关于 - 软件测试平台</title>

    <%--css--%>
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
    <link rel="stylesheet" href="Content/base.css" />

</head>
<body style="background-color:#FFFFFF;">
    <div class="container" runat="server">
        <%--TopBar--%>
        <topbar:TopBar ID="TopBar" runat="server" />
        
        <div class="page-header">
            <h1>关于</h1>
        </div>

        <%--幻灯页--%>
        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" style="max-width: 900px">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <img src="images/1.svg" alt="..." />
                    <div class="carousel-caption">
                        <h3>产品特色</h3>
                        <p>前端使用了流行的Bootstrap框架，产品高度可定制</p>
                    </div>
                </div>
                <div class="item">
                    <img src="images/2.svg" alt="..." />
                    <div class="carousel-caption">
                        <h3>我们的目标</h3>
                        <p>做服务于中小企业的最好软件测试平台</p>
                    </div>
                </div>
                <div class="item">
                    <img src="images/3.svg" alt="..." />
                    <div class="carousel-caption">
                        <h3>加入我们</h3>
                        <p>校园招聘和社会招聘今年秋季开始</p>
                    </div>
                </div>
            </div>
            <!-- Controls -->
            <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>
</body>
</html>
