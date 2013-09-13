package org.ptbank.cache;

import java.sql.ResultSet;
import java.util.Hashtable;

import org.ptbank.db.DBConnection;
import org.ptbank.declare.*;
import org.ptbank.func.*;


public class MUnitCache implements java.io.Serializable
{
  private static final long serialVersionUID = 2915697131106064790L;
  private static MUnitCache m_obj_MUnitCache;
  private static Hashtable<String, MUnitInfo> m_htb_MUnit;
  
  /**
   * 对象实例化
   */
  private MUnitCache()
  {
    try
    {
      if(m_obj_MUnitCache==null)
        init();
    }
    catch(Exception e)
    {
      e.printStackTrace();
      m_obj_MUnitCache = null;
    }
  }
  
  /**
   * 获得该对象的缓存实例
   * @return MUnitCache
   */
  public static synchronized MUnitCache getInstance()
  {
    if(m_obj_MUnitCache == null)
    {
      m_obj_MUnitCache = new MUnitCache();
    }
    return m_obj_MUnitCache;
  }
  
  /**
   * 初始化该对象的缓存实例
   */
  private void init() throws Exception
  {
	DBConnection dbc = new DBConnection();
    ResultSet rst = null;
	try
	{
      /// 查询所有管理单位信息
      String str_SQL = Common.SELECT + Common.ALL +
                       Common.S_FROM + Table.MANAGEUNIT;
      
      rst = dbc.excuteQuery(str_SQL);

      m_htb_MUnit = new Hashtable<String, MUnitInfo>();

      while(rst.next())
      {
        MUnitInfo obj_MUnitInfo = new MUnitInfo();
        obj_MUnitInfo.setValueByResult(rst);
        m_htb_MUnit.put(obj_MUnitInfo.getMUnitID(), obj_MUnitInfo);
      }
      
      rst.close();
      
      System.out.println("缓存中已载入" + m_htb_MUnit.size() + "个管理单位信息");
    }
    catch(Exception e)
    {
      throw e;
    }
    finally
    {
    	rst.close();
    	dbc.freeConnection();
    }
  }
  
  /**
   * 更新一个单位的缓存信息
   */
  public synchronized void refresh(String strUnitID) throws Exception
  {
	DBConnection dbc = new DBConnection();
	ResultSet rst = null;
	try
	{
      /// 查询该管理单位的信息
      String str_SQL = Common.SELECT  + Common.ALL       +
                       Common.S_FROM  + Table.MANAGEUNIT +
                       Common.S_WHERE + Field.MUNITID    + Common.EQUAL + General.addQuotes(strUnitID) +
                       Common.S_ORDER + Field.MUNITID;
      // 查询
      rst = dbc.excuteQuery(str_SQL);

      if (m_htb_MUnit==null)
      {
        m_htb_MUnit = new Hashtable<String, MUnitInfo>();
      } /// if (m_htb_MUnit==null)

      /// 将管理单位的信息更新到缓存中
      while (rst.next())
      {
        MUnitInfo obj_MUnit = (MUnitInfo)m_htb_MUnit.get(strUnitID);

        if (obj_MUnit==null) obj_MUnit = new MUnitInfo();

        obj_MUnit.setValueByResult(rst);

        m_htb_MUnit.put(strUnitID, obj_MUnit);
      } /// while (rst.next())
    }
    catch(Exception e)
    {
      throw e;
    }
    finally
    {
    	rst.close();
    	dbc.freeConnection();
    }
  }
  
  /**
   * 获得指定管理单位的缓存对象
   * @param strUnitID         单位编号
   * @return MUnitInfo         缓存单位对象
   */
  public MUnitInfo getMUnitByID(String strUnitID) throws Exception
  {
    MUnitInfo obj_MUnit = null;

    if(m_htb_MUnit!=null)
    {
      obj_MUnit = (MUnitInfo)m_htb_MUnit.get(strUnitID);
    }

    return obj_MUnit;
  }

  /**
   * 获得管理单位总数
   * @return int               管理单位总数
   */
  public synchronized int getCount() throws Exception
  {
    return m_htb_MUnit.size();
  }
  
  /// 用于测试
  public static void main(String[] args)
  {
    try
    {
      MUnitCache obj_MUnitCache = new MUnitCache();
      
      System.out.println(obj_MUnitCache.getCount());
      System.out.println(obj_MUnitCache.getMUnitByID("441900000000").getMUnitName());
    }
    catch(Exception e)
    {
    }
  }  
}
