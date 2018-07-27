<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="system_manage_personnel_edit.aspx.cs" Inherits="TestPlatform.platform.system_manage_personnel_edit" %>
<%@ Register Src="~/Widget/PlatformTopBar.ascx" TagName="TopBar" TagPrefix="topbar" %>
<%@ Register Src="~/Widget/Footer.ascx" TagName="Footer" TagPrefix="footer" %>
<%@ Register Src="~/Widget/PlatformTreeMenu.ascx" TagName="PlatformTreeMenu" TagPrefix="platformTreeMenu" %>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>人员信息编辑 - 人员管理 - 系统管理 - 软件测试平台</title>
    
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
                <div class="panel-heading"><b id="B1" runat="server">系统管理 > 人员管理 > 人员信息编辑</b></div>
                <div class="panel-body" id="Div1" runat="server">

                    <%--主体内容--%>

                    <div style="max-width: 400px;">
                        <form id="form1" role="form" runat="server">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="input-group">
                                        <span class="input-group-addon glyphicon glyphicon-user" id="username_icon" style="position: static"></span>
                                        <input type="text" runat="server" class="form-control" id="username" placeholder="用户名" required="required" onkeyup="value=value.replace(/[\W]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" disabled="disabled" />
                                    </div>
                                    <br />
                                    <div class="input-group">
                                        <span class="input-group-addon glyphicon glyphicon-envelope" id="emil_icon" style="position: static"></span>
                                        <input type="text" runat="server" class="form-control" id="email" placeholder="邮箱" disabled="disabled" />
                                    </div>
                                    <br />
                                    <div class="input-group">
                                        <span class="input-group-addon glyphicon glyphicon-phone" id="phone_icon" style="position: static"></span>
                                        <input type="text" runat="server" class="form-control" id="phone" placeholder="手机号" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" disabled="disabled" />
                                    </div>
                                    <br />
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group">
                                        <span class="input-group-addon" style="position: static">机构</span>
                                        <asp:DropDownList ID="DropDownList_department" runat="server" DataSourceID="SqlDataSource_register_department" DataTextField="name" DataValueField="id" Height="34px" Width="160px"></asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource_register_department" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [base_department]"></asp:SqlDataSource>
                                    </div>
                                    <br />
                                    <div class="input-group">
                                        <span class="input-group-addon" style="position: static">角色</span>
                                        <asp:DropDownList ID="DropDownList_role" runat="server" DataSourceID="SqlDataSource_register_role" DataTextField="name" DataValueField="id" Height="34px" Width="160px"></asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource_register_role" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [base_role]"></asp:SqlDataSource>
                                    </div>
                                    <br />
                                    <div class="input-group">
                                        <span class="input-group-addon" style="position: static">状态</span>
                                        <asp:DropDownList ID="DropDownList_reg_status" runat="server" DataSourceID="SqlDataSource_register_reg_status" DataTextField="name" DataValueField="id" Height="34px" Width="160px"></asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource_register_reg_status" runat="server" ConnectionString="<%$ ConnectionStrings:webConnectionString %>" SelectCommand="SELECT * FROM [base_status_reg]"></asp:SqlDataSource>
                                    </div>
                                    <br />
                                </div>
                            </div>
                            <div id="alert" runat="server" class="alert alert-success alert-dismissible" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <span id="alert_text" runat="server"><strong>保存成功！</strong></span>
                            </div>
                            <asp:Button ID="Button_Save" class="btn btn-primary" runat="server" Text="保存" OnClick="Button_Save_Click" UseSubmitBehavior="False" />
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
