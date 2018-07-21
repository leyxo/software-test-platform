using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestPlatform.Model
{
    /// <summary>
    /// 测试系统指定用户分配表
    /// </summary>
    public class Test_users
    {
        public int id;         // 权限记录项ID (自增主键) 
        public int test_id;    // 测试系统ID (外键, 级联删除)
        public int user_id;    // 用户ID (外键, 级联删除)
    }
}