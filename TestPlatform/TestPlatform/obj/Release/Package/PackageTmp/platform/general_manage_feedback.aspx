<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="general_manage_feedback.aspx.cs" Inherits="TestPlatform.platform.general_manage_feedback" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>意见反馈 - 软件测试平台</title>
    
    <%--css--%>
    <link rel="stylesheet" href="../Content/bootstrap.min.css"/>
    <link rel="stylesheet" href="../Content/base.css"/>
    
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
                <div class="panel-heading"><b id="B1" runat="server">意见反馈</b></div>
                <div class="panel-body" id="Div1" runat="server">
                    
                    <%--主体内容--%>
                   
                    <form id="form1" method="post" role="form" runat="server">
                        <div class="form-group">
                            <label for="feedback_title">反馈意见</label>
                            <input type="text" runat="server" class="form-control" id="feedback_title" placeholder="有啥问题，别憋着" required="required" autofocus="autofocus" />
                        </div>
                        <div class="form-group">
                            <label for="feedback_detail">详细说明</label>
                            <textarea rows="5" runat="server" class="form-control" style="resize:vertical" id="feedback_detail" placeholder="说具体点" required="required"></textarea>
                        </div>
                        <div id="alert" runat="server" class="alert alert-success alert-dismissible" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <span id="alert_text" runat="server"><strong>提交成功！</strong></span>
                        </div>
                        <asp:Button ID="Button_Report" class="btn btn-primary" runat="server" Text="提交" OnClick="Button_Report_Click" />
                    </form>

                </div>
            </div>
        </div>

        <%--Footer--%>
        <footer:Footer ID="Footer" runat="server" />
    </div>

</body>
</html>
