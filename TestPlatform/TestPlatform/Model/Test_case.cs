using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestPlatform
{
    /// <summary>
    /// 测试项目表
    /// </summary>
    public class Test_case
    {
        public int id;                 // 用例ID (自增主键) 
        public string name;            // 测试项目
        public string precondition;    // 前置条件
        public string process;         // 测试过程及结果
        public string suggestion;      // 改进建议
        public string describe;        // 开发描述
        public int times;              // 测试次数
        public int pass;               // 是否通过
        public int type;               // 缺陷类型 (外键)
        public int creation_user_id;   // 用例创建者ID (外键)
        public DateTime creation_date; // 用例创建时间
        public int version_id;         // 用例所属版本记录ID (外键, 级联删除)
    }
}