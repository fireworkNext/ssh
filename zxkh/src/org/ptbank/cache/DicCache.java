package org.ptbank.cache;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;

import org.ptbank.db.DBConnection;
import org.ptbank.declare.Common;
import org.ptbank.declare.Field;
import org.ptbank.declare.Table;
import org.ptbank.func.General;


public class DicCache implements java.io.Serializable
{
  private static final long serialVersionUID = -7589021673801786010L;
  
  private static DicCache m_obj_DicCache;
  private static Hashtable<String, ArrayList<String[]>> m_htb_Dic;

  /// 给定一个默认的路径，该路径实际上是无效的
  /// 在缓存初始化的时候，系统会赋予对应实际路径
  private static String m_str_DicPath = "";

  /**
   * 实例初始化
   */
  private DicCache()
  {
    try
    {
      if(m_obj_DicCache==null)
        init();
    }
    catch(Exception e)
    {
      e.printStackTrace();
      m_obj_DicCache = null;
    }
  }

  /**
   * 获得字典缓存的实例
   * @return 字典缓存的实例
   */
  public static synchronized DicCache getInstance()
  {
    if (m_obj_DicCache==null)
    {
      m_obj_DicCache = new DicCache();
    }

    return m_obj_DicCache;
  }
  
  /**
   * 设置字典文件保存的路径
   * @param strPath           字典文件保存的路径
   */
  public static void setDicPath(String strPath)
  {
    m_str_DicPath = strPath;
  }
  
  /**
   * 获得字典文件保存的路径
   * @return 字典文件保存的路径
   */
  public static String getDicPath()
  {
    return m_str_DicPath;
  }

  /**
   * 字典缓存内容的初始化
   */
  private void init() throws Exception
  {
	DBConnection dbc = new DBConnection();
	ResultSet rst = null;
	try
    {
      m_htb_Dic = new Hashtable<String, ArrayList<String[]>>();

      /// 首先查询出所有字典的名称
      String str_SQL = Common.SELECT  + Field.DICNAME +
                       Common.S_FROM  + Table.DICLIST;
      
      rst = dbc.excuteQuery(str_SQL);

      /// 将所有字典名称记入到缓存的 HashTable 中
      while(rst.next())
      {  
        refresh(rst.getString(Field.DICNAME));
      }
      
      rst.close();

      /// 载入系统特殊字典
      refresh(Table.MANAGEUNIT);
      refresh(Table.AFFAIRTYPE);
      refresh(Table.EVENTTYPE);
      refresh(Table.USERLIST);
      refresh("DIC_DBFLD");

      System.out.println(new String(("缓存中已载入" + m_htb_Dic.size() + "个字典").getBytes(),"GBK"));

    }
    catch(Exception e)
    {
      throw new Exception(e.getMessage());
    }  
    finally
    {
    	rst.close();
    	dbc.freeConnection();
    }
  }

  /**
   * 刷新单个字典缓存的内容
   * @param strDicName        字典名称
   */
  public synchronized void refresh(String strDicName) throws Exception
  {
    /// 组织查询字典的 SQL 语句
    String str_SQL = "";
    
    /// 对系统特殊字典进行处理
    if (strDicName.equalsIgnoreCase(Table.MANAGEUNIT))
    {
      str_SQL = Common.SELECT  + Field.MUNITID               + Common.SPACE   + Field.DIC_CODE  + Common.COMMA   +
                                 Field.MUNITNAME             + Common.SPACE   + Field.DIC_TEXT  + Common.COMMA   +
                                 Field.VALID                 + Common.SPACE   + Field.DIC_VALID +
                Common.S_FROM  + Table.MANAGEUNIT            +
                Common.S_WHERE + Field.MTYPE                 + Common.N_EQUAL + General.addQuotes(Common.USERTYPE_SP) +
                Common.S_ORDER + Field.MUNITID;
    }
    else if (strDicName.equalsIgnoreCase(Table.AFFAIRTYPE))
      str_SQL = Common.SELECT  + Field.AFFAIRTYPEID          + Common.SPACE   + Field.DIC_CODE   + Common.COMMA  +
                                 Field.AFFAIRTYPENAME        + Common.SPACE   + Field.DIC_TEXT   + Common.COMMA  +
                          General.addQuotes(Common.FLG_TRUE) + Common.SPACE   + Field.DIC_VALID  +
                Common.S_FROM  + Table.AFFAIRTYPE            +
                Common.S_ORDER + Field.AFFAIRTYPEID;

    else if (strDicName.equalsIgnoreCase(Table.EVENTTYPE))
      str_SQL = Common.SELECT  + Field.EVENTTYPEID           + Common.SPACE   + Field.DIC_CODE   + Common.COMMA  +
                                 Field.EVENTTYPENAME         + Common.SPACE   + Field.DIC_TEXT   + Common.COMMA  +
                                 General.addQuotes(Common.FLG_TRUE) + Common.SPACE   + Field.DIC_VALID  +
                Common.S_FROM  + Table.EVENTTYPE             +
                Common.S_ORDER + Field.EVENTTYPEID;

    else if (strDicName.equalsIgnoreCase(Table.USERLIST))
      str_SQL = Common.SELECT  + Field.USERID                + Common.SPACE   + Field.DIC_CODE   + Common.COMMA  +
                Field.USERNAME                               + Common.SPACE   + Field.DIC_TEXT   + Common.COMMA  +
                General.addQuotes(Common.FLG_TRUE)           + Common.SPACE   + Field.DIC_VALID  +
                Common.S_FROM  + Table.USERLIST              +
                Common.S_WHERE + Field.USERTYPE              + Common.NOT_IN  + General.addBracket(Common.FLG_TRUE + Common.COMMA + Common.FLG_FALSE) +
                Common.S_ORDER + Field.USERID;
    else if (strDicName.equalsIgnoreCase("DIC_DBFLD"))
        str_SQL = Common.SELECT  + "DBFLD"                + Common.SPACE   + Field.DIC_CODE   + Common.COMMA  +
                  "FLDNAME"                               + Common.SPACE   + Field.DIC_TEXT   + Common.COMMA  +
                  General.addQuotes(Common.FLG_TRUE)           + Common.SPACE   + Field.DIC_VALID  +
                  Common.S_FROM  + "T_DBFLD"              +
                  Common.S_WHERE + " fldname is not null " +
                  Common.S_ORDER + "PID";
    else
      str_SQL = Common.SELECT  + Field.DIC_CODE              + Common.COMMA   +
                                 Field.DIC_TEXT              + Common.COMMA   +
                                 Field.DIC_VALID             +
                Common.S_FROM  + Table.DICDATA               +
                Common.S_WHERE + Field.DICNAME               + Common.EQUAL   + General.addQuotes(strDicName)    +
                Common.S_ORDER + Field.DIC_ORD + Common.COMMA + Field.DIC_CODE;
    DBConnection dbc = new DBConnection();
	ResultSet rst = null;
	try
    {
      rst = dbc.excuteQuery(str_SQL);
      ArrayList<String[]> arr_DicContent = new ArrayList<String[]>();

      while(rst.next())
      {
        String str_DicCode  = rst.getString(Field.DIC_CODE);
        String str_DicText  = rst.getString(Field.DIC_TEXT);
        String str_DicVaild = rst.getString(Field.DIC_VALID);

        arr_DicContent.add(new String[]{str_DicCode, str_DicText, str_DicVaild});
      
      }
      m_htb_Dic.put(strDicName, arr_DicContent);

      System.out.println("已将[" + strDicName + "]字典载入到缓存中");
    }
	catch(Exception e)
	{
		
	}
	finally
    {
    	rst.close();
    	dbc.freeConnection();
    }
  }
 
  /**
   * 根据指定字典名称获得字典缓存对象
   * @return ArrayList     字典数组
   */
  public ArrayList getDicByName(String strDicName)
  {
    return (ArrayList)m_htb_Dic.get(strDicName);
  }

  /**
   * 获得指定字典中的字典内容对应的字典编码
   * @param strDicName   字典名称
   * @param strDicText   字典内容
   * @return String        字典编码
   */
  public String getCode(String strDicName, String strDicText) throws Exception
  {
    ArrayList arr_DicContent = (ArrayList)m_htb_Dic.get(strDicName);

    /// 发现指定的字典名称并不存在
    if (arr_DicContent==null)
      return null;

    Iterator it = arr_DicContent.iterator();

    while (it.hasNext())
    {
      String[] str_DicItem = (String[])it.next();

      if (strDicText.equalsIgnoreCase(str_DicItem[1]))
      {
        return str_DicItem[0];
      }
    }

    /// 未查找到对应字典内容
    return null;
  }

  /**
   * 获得指定字典中的字典编码对应的字典内容
   * @param strDicName   字典名称
   * @param strDicCode   字典编码
   * @return String        字典内容
   */
  public String getText(String strDicName, String strDicCode) throws Exception
  {
    ArrayList arr_DicContent = (ArrayList)m_htb_Dic.get(strDicName);
    
    /// 发现指定的字典名称并不存在
    if (arr_DicContent==null)
      return null;

    Iterator it = arr_DicContent.iterator();

    while(it.hasNext())
    {
      String[] str_DicItem = (String[])it.next();

      if (strDicCode.equalsIgnoreCase(str_DicItem[0]))
      {
        return str_DicItem[1];
      }
    }

    /// 未查找到对应字典编码
    return null;
  }

  /**
   * 获得指定字典中的字典代码是否有效的值
   * @param strDicName   字典名称
   * @param strDicCode   字典编码
   * @return String        字典条目是否有效
   */
  public String getValid(String strDicName, String strDicCode) throws Exception
  {
    ArrayList arr_DicContent = (ArrayList)m_htb_Dic.get(strDicName);

    /// 发现指定的字典名称并不存在
    if (arr_DicContent==null)
      return null;

    Iterator it = arr_DicContent.iterator();

    while (it.hasNext())
    {
      String[] str_DicItem = (String[])it.next();

      if (strDicCode.equalsIgnoreCase(str_DicItem[0]))
      {
        return str_DicItem[2];
      }
    }

    /// 未查找到对应字典编码
    return null;
  }
  

}
