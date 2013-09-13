package org.ptbank.baseManage;

import org.dom4j.*;
import org.ptbank.base.DataDoc;
import org.ptbank.base.NumAssign;
import org.ptbank.base.Operation;
import org.ptbank.base.ReturnDoc;
import org.ptbank.cache.*;
import org.ptbank.db.DBConnection;
import org.ptbank.db.DataStorage;
import org.ptbank.db.SQLAnalyse;
import org.ptbank.declare.*;
import org.ptbank.func.*;

import java.sql.*;
import java.util.*;


public class RoleBO
{

  /*********************************************************
   * 添加角色
   * @param  strXml           XML 数据信息  
   * @return String           XML 返回信息   
  ***********************************************************/
  public static String addNew(String strXml) throws Exception
  {
    DataDoc doc = new DataDoc(strXml);
    // 创建执行对象
    DataStorage storage = new DataStorage();
    ReturnDoc returndoc = new ReturnDoc();
    try
    {
	    int size = doc.getDataNum(Table.ROLEBASIC);
	   
	    // 解析sql语句
	    for(int i=0;i<size;i++)
	    {  
	      Element ele = (Element)doc.getDataNode(Table.ROLEBASIC,i);
	      Node node = ele.selectSingleNode(Field.ROLEID);
	      String strId = NumAssign.assignID_A("000001");
	      
	      node.setText(strId);
	      storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
	    }
	    // 执行
	    String strReturn = storage.runSQL();
	    if(!General.empty(strReturn))
	    {
		    returndoc.addErrorResult(Common.RT_FUNCERROR);
		    returndoc.setFuncErrorInfo(strReturn);
	    }
	    else
	    {  
	      returndoc.addErrorResult(Common.RT_SUCCESS);
	    }
    }
    catch(Exception e)
    {
	    returndoc.addErrorResult(Common.RT_FUNCERROR);
	    returndoc.setFuncErrorInfo(e.getMessage());
    }
    
    return returndoc.getXML();  
  }
 
  /*********************************************************
   * 修改角色
   * @param  strXml           XML 数据信息  
   * @return String           XML 返回信息   
  ***********************************************************/

  public static String edit(String strXml) throws Exception
  {
    return Operation.addOrEdit(strXml,Table.ROLEBASIC);
  }
  
  /*********************************************************
   * 删除角色信息
   * @param  strXml           XML 数据信息  
   * @return String           XML 返回信息   
  ***********************************************************/

  public static String drop(String strXml) throws Exception
  {
    DataDoc doc = new DataDoc(strXml);
    // 创建执行对象
    DataStorage storage = new DataStorage();
    int size = doc.getDataNum(Table.ROLEBASIC);
    Hashtable<String, String> hashId = new Hashtable<String, String>();
    // 解析sql语句
    for(int i=0;i<size;i++)
    {  
      Element ele = (Element)doc.getDataNode(Table.ROLEBASIC,i);
      Node ndRole = ele.selectSingleNode(Field.ROLEID);
      String strRoleId = ndRole==null?null:ndRole.getText();
      String sql = "select userid from roleuser where roleid = '" + strRoleId + "'";

    	DBConnection dbc = new DBConnection();
    	ResultSet rst = null;
      try
      {
       rst = dbc.excuteQuery(sql);
        while(rst.next())
        {
          hashId.put(rst.getString("userid"),rst.getString("userid"));
        }
        //if(conn!=null)
          //conn.close();
      }  
      catch(Exception e)
      {
        //
      }
    	finally
    	{
    	rst.close();
    	dbc.freeConnection();
    	}
      storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
    }
    // 执行
    String strReturn = storage.runSQL();
    ReturnDoc returndoc = new ReturnDoc();
    if(!General.empty(strReturn))
    {
	    returndoc.addErrorResult(Common.RT_FUNCERROR);
	    returndoc.setFuncErrorInfo(strReturn);
    }
    else
    {  
      returndoc.addErrorResult(Common.RT_SUCCESS);
    }
    
    Enumeration enums = hashId.elements();
    while(enums.hasMoreElements())
    {
      UserCache.getInstance().refresh((String)enums.nextElement());
    }
    return returndoc.getXML();  
    
  }
  
  /*********************************************************
   * 向角色添加用户
   * @param  strXml           XML 数据信息  
   * @return String           XML 返回信息   
  ***********************************************************/

  public static String addUserToRole(String strXml) throws Exception
  {
    DataDoc doc = new DataDoc(strXml);
    // 创建执行对象
    DataStorage storage = new DataStorage();
    int size = doc.getDataNum(Table.ROLEUSER);
    Hashtable<String, String> hashId = new Hashtable<String, String>();
    // 解析sql语句
    for(int i=0;i<size;i++)
    {  
      Element ele = (Element)doc.getDataNode(Table.ROLEUSER,i);
      Node node = ele.selectSingleNode(Field.USERID);
      String strId = node==null?null:node.getText();
      hashId.put(strId,strId);
      storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
    }
    // 执行
    String strReturn = storage.runSQL();
    ReturnDoc returndoc = new ReturnDoc();
    if(!General.empty(strReturn))
    {
	    returndoc.addErrorResult(Common.RT_FUNCERROR);
	    returndoc.setFuncErrorInfo(strReturn);
    }
    else
    {  
      returndoc.addErrorResult(Common.RT_SUCCESS);
    }
    
    Enumeration enums = hashId.elements();
    while(enums.hasMoreElements())
    {
      UserCache.getInstance().refresh((String)enums.nextElement());
    }
    return returndoc.getXML();    
  }
  
  /*********************************************************
   * 从角色中删除事件类型权限
   * @param  strXml           XML 数据信息  
   * @return String           XML 返回信息   
  ***********************************************************/

  public static String dropEventFromRole(String strXml) throws Exception
  {
    DataDoc doc = new DataDoc(strXml);
    // 创建执行对象
    DataStorage storage = new DataStorage();
    int size = doc.getDataNum(Table.ROLEPOWER);
    Hashtable<String, String> hashId = new Hashtable<String, String>();
    // 解析sql语句
    for(int i=0;i<size;i++)
    {  
      Element ele = (Element)doc.getDataNode(Table.ROLEPOWER,i);
      Node node = ele.selectSingleNode(Field.ROLEID);
      String strId = node==null?null:node.getText();
      String sql = "select userid from roleuser where roleid = '" + strId + "'";

   	  DBConnection dbc = new DBConnection();
  	  ResultSet rst = null;
      try
      {
        rst = dbc.excuteQuery(sql);
        while(rst.next())
        {
          hashId.put(rst.getString("userid"),rst.getString("userid"));
        }
        
      }
      catch(Exception e)
      {
      }
    	finally
    	{
    	rst.close();
    	dbc.freeConnection();
    	}
      
      storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
    }
    // 执行
    String strReturn = storage.runSQL();
    ReturnDoc returndoc = new ReturnDoc();
    if(!General.empty(strReturn))
    {
	    returndoc.addErrorResult(Common.RT_FUNCERROR);
	    returndoc.setFuncErrorInfo(strReturn);
    }
    else
    {  
      returndoc.addErrorResult(Common.RT_SUCCESS);
    }
    
    Enumeration enums = hashId.elements();
    while(enums.hasMoreElements())
    {
      UserCache.getInstance().refresh((String)enums.nextElement());
    }
    return returndoc.getXML();    
  } 
  
  /*********************************************************
   * 从角色中删除用户
   * @param  strXml           XML 数据信息  
   * @return String           XML 返回信息   
  ***********************************************************/

  public static String dropUserFromRole(String strXml) throws Exception
  {
    DataDoc doc = new DataDoc(strXml);
    // 创建执行对象
    DataStorage storage = new DataStorage();
    int size = doc.getDataNum(Table.ROLEUSER);
    Hashtable<String, String> hashId = new Hashtable<String, String>();
    // 解析sql语句
    for(int i=0;i<size;i++)
    {  
      Element ele = (Element)doc.getDataNode(Table.ROLEUSER,i);
      Node node = ele.selectSingleNode(Field.USERID);
      String strId = node==null?null:node.getText();
      hashId.put(strId,strId);
      storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
    }
    // 执行
    String strReturn = storage.runSQL();
    ReturnDoc returndoc = new ReturnDoc();
    if(!General.empty(strReturn))
    {
	    returndoc.addErrorResult(Common.RT_FUNCERROR);
	    returndoc.setFuncErrorInfo(strReturn);
    }
    else
    {  
      returndoc.addErrorResult(Common.RT_SUCCESS);
    }
    
    Enumeration enums = hashId.elements();
    while(enums.hasMoreElements())
    {
      UserCache.getInstance().refresh((String)enums.nextElement());
    }
    return returndoc.getXML();    
  } 
  
  /*********************************************************
   * 向角色添加事件类型
   * @param  strXml           XML 数据信息  
   * @return String           XML 返回信息   
  ***********************************************************/

  public static String addEventToRole(String strXml) throws Exception
  {
    DataDoc doc = new DataDoc(strXml);
    // 创建执行对象
    DataStorage storage = new DataStorage();
    int size = doc.getDataNum(Table.ROLEPOWER);
    Hashtable<String, String> hashId = new Hashtable<String, String>();
    // 解析sql语句
    for(int i=0;i<size;i++)
    {  
      Element ele = (Element)doc.getDataNode(Table.ROLEPOWER,i);
      Node node = ele.selectSingleNode(Field.ROLEID);
      String strId = node==null?null:node.getText();
      String sql = "select userid from roleuser where roleid = '" + strId + "'";

    	DBConnection dbc = new DBConnection();
    	ResultSet rst = null;
      try
      {
        rst = dbc.excuteQuery(sql);
        while(rst.next())
        {
          hashId.put(rst.getString("userid"),rst.getString("userid"));
        }
        
      }
      catch(Exception e)
      {
        // 不做处理e.printStackTrace();
      }
    	finally
    	{
    	rst.close();
    	dbc.freeConnection();
    	}
      storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
    }
    // 执行
    String strReturn = storage.runSQL();
    ReturnDoc returndoc = new ReturnDoc();
    if(!General.empty(strReturn))
    {
	    returndoc.addErrorResult(Common.RT_FUNCERROR);
	    returndoc.setFuncErrorInfo(strReturn);
    }
    else
    {  
      returndoc.addErrorResult(Common.RT_SUCCESS);
    }
    
    Enumeration enums = hashId.elements();
    while(enums.hasMoreElements())
    {
      UserCache.getInstance().refresh((String)enums.nextElement());
    }
    return returndoc.getXML();    
  } 
  
}
