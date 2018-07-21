using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestPlatform.Model
{
    /// <summary>
    /// 测试版本表
    /// </summary>
    public class Test_version
    {
        public int id;                  // 版本ID (自增主键)
        public string name;             // 版本名称 (唯一)
        public int test_id;             // 项目ID (外键, 级联删除)
        public string number;           // 以当前日期生成的表单号 eg: 20180703091002
        public int archived;            // 是否已存档
        public DateTime start_time;     // 开始日期
        public DateTime end_time;       // 截止日期
        public DateTime creation_date;  // 提交时间
    }
}