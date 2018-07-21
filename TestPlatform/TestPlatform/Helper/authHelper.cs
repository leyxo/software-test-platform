using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Text;

namespace TestPlatform
{
    public class authHelper
    {
        /// <summary>
        /// 判断用户角色是否授权给某项功能，返回结果为bool类型
        /// </summary>
        /// <param name="role_id">用户角色ID，可以从Session["current_user_role_id"]获取</param>
        /// <param name="path">功能模块path</param>
        /// <returns>判断结果，为bool类型</returns>
        static public bool hasAuthority(int role_id, string path)
        {
            string sql = new StringBuilder("select * from role_model INNER JOIN model ON role_model.model_id = model.id where")
                .Append(" role_id = @role_id and")
                .Append(" path = @path").ToString();

            SqlParameter[] parameters = {
                    new SqlParameter("@role_id", role_id),
                    new SqlParameter("@path", path),
            };

            DataSet ds = sqlHelper.ExecuteSqlDataSet(sql, parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                return true;
            }
            else
                return false;
        }
    }
}