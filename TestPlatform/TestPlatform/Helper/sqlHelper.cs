using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace TestPlatform
{
    public class sqlHelper
    {
        public static string strConn = ConfigurationManager.ConnectionStrings["webConnectionString"].ToString();

        /// <summary>
        /// 执行单条SQL语句，并返回一个DataSet，用于查询
        /// </summary>
        public static DataSet ExecuteSqlDataSet(string strSQL, SqlParameter[] pmts)
        {
            SqlConnection conn = new SqlConnection(strConn);
            try
            {
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(strSQL, conn);
                sda.SelectCommand.CommandType = CommandType.Text;
                if (pmts != null)
                {
                    foreach (SqlParameter p in pmts)
                    {
                        if (p != null)
                        {
                            sda.SelectCommand.Parameters.Add(p);
                        }
                    }
                }
                DataSet ds = new DataSet("ds");
                sda.Fill(ds);
                return ds;
            }
            catch (System.Data.SqlClient.SqlException e)
            {
                throw new Exception(e.Message);
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// 执行单条SQL语句，用于增删改
        /// </summary>
        public static int ExecuteNonQuery(string strSQL, SqlParameter[] pmts)
        {
            SqlConnection conn = new SqlConnection(strConn);
            SqlCommand cmd = new SqlCommand(strSQL, conn);
            try
            {
                conn.Open();
                if (pmts != null)
                {
                    foreach (SqlParameter p in pmts)
                    {
                        if (p != null)
                        {
                            cmd.Parameters.Add(p);
                        }
                    }
                }
                return cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                //throw new Exception(e.Message); // 上线时需要注释
                return -1;
            }
            finally
            {
                cmd.Dispose();
                conn.Close();
            }
        }

    }
}