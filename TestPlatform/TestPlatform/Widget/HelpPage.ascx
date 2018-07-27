<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HelpPage.ascx.cs" Inherits="TestPlatform.Widget.HelpPage" %>

<div class="page-header">
    <h1>使用帮助 <small>软件测试平台</small></h1>
</div>

<form id="form1" runat="server">
    <h4 style="margin-top: 20px;"><strong>系统管理</strong></h4>
    <div style="margin-left: 30px; margin-top:20px;">
        <h4>人员管理</h4>
        <p><a href="../platform/system_manage_personnel.aspx">人员管理</a>负责系统内所有人员信息管理。可以修改用户机构、角色和状态，可以新增和删除用户，可以批准或拒绝待审核用户。</p>
        <p>只能删除未参与测试系统的用户。</p>
    </div>
    <div style="margin-left: 30px; margin-top:20px;">
        <h4>机构管理</h4>
        <p><a href="../platform/system_manage_department.aspx">机构管理</a>维护系统内用户可选择的所属机构数据。</p>
        <p>只能删除未包含用户的机构。</p>
    </div>
    <div style="margin-left: 30px; margin-top:20px;">
        <h4>权限管理</h4>
        <p><a href="../platform/system_manage_authority.aspx">权限管理</a>负责设置系统各功能模块与用户角色之间的权限关系。</p>
    </div>

    <h4 style="margin-top: 20px;"><strong>基础数据管理</strong></h4>
    <div style="margin-left: 30px; margin-top:20px;">
        <h4>缺陷类型定义</h4>
        <p><a href="../platform/basedata_manage_issuetype.aspx">缺陷类型定义</a>负责维护测试记录可选择的缺陷类型数据。</p>
        <p>只能删除未在测试记录中使用过的缺陷类型。</p>
    </div>
    <div style="margin-left: 30px; margin-top:20px;">
        <h4>测试系统维护</h4>
        <p><a href="../platform/basedata_manage_test.aspx">测试系统维护</a>列出平台中所有测试系统。测试系统状态为<span style="color:darkgreen;"><strong>有效</strong></span>时为可测试状态，状态为<span style="color:darkred;"><strong>无效</strong></span>时，测试系统不会出现在测试管理中。</p>
        <div style="margin-left: 30px;">
            <p>用户分配：分配当前测试系统可参与的用户。</p>
        </div>
    </div>

    <h4 style="margin-top: 20px;"><strong>测试管理</strong></h4>
    <div style="margin-left: 30px; margin-top:20px;">
        <h4>测试管理</h4>
        <p><a href="../platform/basedata_manage_test_version.aspx">测试管理</a>包含当前用户被指派的测试系统。</p>
        <p>对于每一个测试版本有三种状态：<span style="color: darkgreen"><strong>测试中</strong></span>，<span style="color: darkorange"><strong>已提交</strong></span>，<span style="color: black"><strong>已结束</strong></span>。点击“提交/结束”按钮，版本状态会由“测试中”依次变为“已提交”和“已完成”。</p>
        <div style="margin-left: 30px;">
            <p><span style="color: darkgreen"><strong>测试中</strong></span>：测试者可以添加、修改测试记录</p>
            <p><span style="color: darkorange"><strong>已提交</strong></span>：测试者可以撰写当前版本测试总结</p>
            <p><span style="color: black"><strong>已结束</strong></span>：可以查看当前版本测试报告，开发者可以撰写开发回馈</p>
        </div>
        <p>测试项目界面包含当前版本测试记录、以前版本待解决问题和当前版本测试总结。其中，以前版本待解决记录包含测试未通过记录和缺陷类型为建议修改的记录。</p>
        <img src="../images/help/test_case.png" alt=""  style="max-width: 90%; box-shadow: 1px 1px 2px 2px #D5D5D5;" />
    </div>
    <div style="margin-left: 30px; margin-top:20px;">
        <h4>测试报告</h4>
        <p><a href="../platform/test_members.aspx">测试报告</a>列出所有已经结束的测试版本。只有结束的测试版本才支持查看测试报告。</p>
        <p>测试报告页面尺寸为A4纸张大小，便于打印。</p>
    </div>

    <h4 style="margin-top: 20px;"><strong>通用功能</strong></h4>
    <div style="margin-left: 30px; margin-top:20px;">
        <h4>个人信息管理</h4>
        <p>查看个人信息，并支持修改当前用户邮箱电话及密码。</p>
    </div>
    <div style="margin-left: 30px; margin-top:20px;">
        <h4>意见反馈</h4>
        <p><a href="../platform/system_manage_department.aspx">意见反馈</a>为用户提供在使用软件测试平台中对发现的问题或提出的修改意见的反馈。</p>
    </div>
</form>