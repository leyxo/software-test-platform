using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestPlatform.Model
{
    /// <summary>
    /// 权限分配表
    /// </summary>
    public class Role_model
    {
        public int id;         // 权限记录项ID (自增主键) 
        public int role_id;    // 角色ID (外键, 级联删除)
        public int model_id;   // 功能ID (外键, 级联删除)
    }
}