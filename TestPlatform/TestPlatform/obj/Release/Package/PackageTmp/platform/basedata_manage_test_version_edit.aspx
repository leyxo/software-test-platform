<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="basedata_manage_test_version_edit.aspx.cs" Inherits="TestPlatform.platform.basedata_manage_test_version_edit" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>编辑版本 - 测试版本 - 测试管理 - 软件测试平台</title>
    
    <%--Style Sheet--%>
    <link rel="stylesheet" href="../Content/bootstrap.min.css"/>
    <link rel="stylesheet" href="../Content/base.css"/>
    <link rel="stylesheet" href="../Content/bootstrap-datepicker3.css"/>

    <script src="../Scripts/jquery-2.2.4.js"></script>
    <%--<script src="../Scripts/bootstrap.min.js"></script>--%>
    <script src="../Scripts/bootstrap-datepicker.js"></script>

    <script>
        $(document).ready(function (e) {
            /*点击删除 清空输入框的内容*/
            $(Button_Clear_Date).click(function () {
                $(start_time).val('');
                $(end_time).val('');
                $(creation_date).val('');
            });
        });
    </script>

    <script>
        $.fn.datepicker.defaults.autoclose = "true";
    </script>

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
                <div class="panel-heading"><b id="B1" runat="server">测试管理 > 测试版本 > 编辑版本</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <%--主体内容--%>
                    <div style="max-width: 400px;">
                        <h4><strong>编辑版本 - <span id="Title_Test_Name" runat="server">系统名称</span></strong></h4>
                        <br />
                        <form id="form1" role="form" runat="server">
                            <div class="input-group">
                                <span class="input-group-addon glyphicon glyphicon-star" style="position: static"></span>
                                <input type="text" runat="server" class="form-control" id="version_name" placeholder="版本名称" style="font-weight:bold;" required="required" />
                            </div>
                            <br />
                            <div class="input-group">
                                <span class="input-group-addon glyphicon glyphicon-calendar" style="position: static"></span>
                                <div class="input-group input-daterange">
                                    <input type="text" id="start_time" runat="server" placeholder="测试起始日期" readonly="readonly" style="background-color:white; text-align:left;" class="form-control" data-provide="datepicker" data-date-format="yyyy-mm-dd">
                                    <div class="input-group-addon">至</div>
                                    <input type="text" id="end_time" runat="server" placeholder="测试结束日期" readonly="readonly" style="background-color:white; text-align:left;" class="form-control" data-provide="datepicker" data-date-format="yyyy-mm-dd">
                                </div>
                            </div>
                            <br />
                            <div class="input-group">
                                <span class="input-group-addon glyphicon glyphicon-calendar" style="position: static"></span>
                                    <input type="text" id="creation_date" runat="server" placeholder="测试提交日期" readonly="readonly" style="background-color:white; text-align:left;" class="form-control" data-provide="datepicker" data-date-format="yyyy-mm-dd">
                            </div>
                            <br />
                            <div id="alert" runat="server" class="alert alert-success alert-dismissible" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <span id="alert_text" runat="server"><strong>保存成功！</strong></span>
                            </div>
                            <asp:Button ID="Button_Save" class="btn btn-primary" runat="server" Text="保存" OnClick="Button_Save_Click" />
                            &nbsp;<asp:Button ID="Button_Cancel" class="btn btn-default" runat="server" Text="取消" OnClick="Button_Cancel_Click" UseSubmitBehavior="False" />
                            &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" ID="Button_Clear_Date" value="清空日期" class="btn btn-default" />
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