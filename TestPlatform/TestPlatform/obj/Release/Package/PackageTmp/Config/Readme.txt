//
//  readme.txt
//  TestPlatform
//
//  Created by LEY's MacBook on 18/06/20.
//  Copyright © 2018年 LEY's MacBook. All rights reserved.
//

当需要获取当前Session信息时，请参考以下项目

[当前登录用户信息]
Session["current_user_name"]			// 用户姓名
Session["current_user_id"]				// 用户ID
Session["current_user_department_id"]	// 用户所属部门ID
Session["current_user_department_name"]	// 用户所属部门名称 (不可靠)
Session["current_user_role_id"]			// 用户角色ID
Session["current_user_role_name"]		// 用户角色名称 (不可靠)
Session["current_user_reg_status_id"]	// 用户注册状态ID

[当前编辑项ID]
Session["editing_user_id"]				// 用户ID
Session["editing_department_id"]		// 用户所属部门ID
Session["editing_test_id"]				// 测试系统ID
Session["editing_issuetype_id"]			// 错误ID
Session["editing_test_case_id"]			// 测试记录ID
Session["editing_test_version_id"]      // 测试版本ID

[当前测试项目]
Session["current_test_id"]				// 测试系统ID (用于保存"测试记录"页下拉列表当前选中项，下同)
Session["current_test_version"]			// 测试版本ID

Session["current_basedata_test_id"]		// 基础数据维护中测试系统ID
Session["current_basedata_test_version"]// 基础数据维护测试版本ID