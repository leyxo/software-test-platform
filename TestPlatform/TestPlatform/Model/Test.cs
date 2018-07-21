using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestPlatform
{
    /// <summary>
    /// 测试项目表
    /// </summary>
    public class Test
    {
        public int id;                      // 项目ID(自增主键)
        public string name;                 // 项目名称 (唯一)
        public string descrive;             // 描述
        public int creation_department_id;  // 计划所属部门 (外键)
        public int creation_user_id;        // 项目创建者ID (外键)
        public DateTime creation_date;      // 项目创建时间
    }
}