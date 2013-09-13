package org.ptbank.base;

import java.sql.*;

import org.ptbank.db.*;
import org.ptbank.func.General;


/**
 * 统一的编码分配类对象
 * 根据数据库MAXIDTYPE,MAXID表和相关存储过程，分配唯一在最大编码
 */
public class NumAssign
{
  /**
   * 分配指定类型的一级最大编号
   * @param strIDType       编号类型
   * @return string 最大一级编号
   */
  public static String assignID_A(String strIDType) throws Exception
  {
    /// 获得连接
    DBConnection dbc = new DBConnection();
    Connection conn = dbc.getConnection();

    try
    {
      conn.setAutoCommit(false);

      String[] para = {"t", strIDType, ""};

      int[] out = {3};

      Pub.executeProcedure(conn, "pMaxID_A", para, out);

      conn.commit();

      return para[2];
    }
    catch(Exception e)
    {
      try
      {
        if(conn!=null)
        {  
          conn.rollback();
        }
      }
      catch(Exception ex)
      {
        throw new Exception(ex.getMessage());
      }
      throw e;
    }
    finally
    {
      dbc.freeConnection();
    }
  }

  /**
   * 分配指定类型的二级最大编号
   * @param strIDType       编号类型
   *        strMaxID1       一级编号
   * @return String          最大二级编号
   */
  public static String assignID_B(String strIDType,
                                  String strMaxID1)
  {
    /// 获得连接
    DBConnection dbc = new DBConnection();
    Connection conn = dbc.getConnection();

    try
    {
      conn.setAutoCommit(false);

      String[] para = {"t",strIDType,strMaxID1,""};

      int[] out = {4};

      Pub.executeProcedure(conn,"pMaxID_B",para,out);

      conn.commit();

      return para[3];
    }
    catch(Exception e)
    {
      try
      {
        if(conn!=null)
        {
          conn.rollback();
        }
      }
      catch(Exception ex)
      {
        return ex.getMessage();
      }
      return e.getMessage();
    }
    finally
    {
      dbc.freeConnection();
    }
  }

  /**
   * 分配指定类型的三级最大编号
   * @param strIDType       编号类型
   *        strMaxID1       一级编号
   *        strMaxID2       二级编号
   * @return String         最大三级编号
   */
  public static String assignID_C(String strIDType,
                                  String strMaxID1,
                                  String strMaxID2) throws Exception
  {
    /// 获得连接
    DBConnection dbc = new DBConnection();
    Connection conn = dbc.getConnection();

    try
    {
      conn.setAutoCommit(false);

      String[] para = {"t",strIDType,strMaxID1,strMaxID2,""};
      
      int[] out ={5};

      Pub.executeProcedure(conn,"pMaxID_B",para,out);

      conn.commit();

      return para[4];
    }
    catch(Exception e)
    {
      try
      {
        if(conn!=null)
        {  
          conn.rollback();
        }
      }
      catch(Exception ex)
      {
        throw new Exception(ex.getMessage());
      }
      throw e;
    }
    finally
    {
      dbc.freeConnection();
    }
  }
  
  public static String assignID_D(String strIDType)
  {
	  String strId = assignID_B(strIDType,General.curYear2() + General.curMonth());  
	  return strId;
  }
  
  public static void main(String []arg)
  {
    try
    {
      System.out.println(assignID_B("100002","201002"));
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
  }

}
