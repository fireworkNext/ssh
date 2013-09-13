package org.ptbank.base;

import java.util.*;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Types;

import org.dom4j.*;
import org.ptbank.cache.*;
import org.ptbank.db.*;
import org.ptbank.declare.*;
import org.ptbank.func.General;

import oracle.jdbc.OracleTypes;

/**
 * 通用查询分析类，封装了普通查询，分页查询等公共函数
 * @author enjsky
 */
public class CommonQuery
{  
  /**
   * 通用查询
   * @param  strSQL                T-SQL查询语句
   * @return ResultSet             查询返回结果集
   */
  public static ResultSet rsQry(String strSQL) throws Exception
  {
    /// 获得连接
    DBConnection dbc = new DBConnection();

    try
    {
      ResultSet rst = dbc.excuteQuery(strSQL);
      return rst;
    }
    catch(Exception e)
    {
      throw e;
    }
    finally
    {
      dbc.freeConnection();
    }
  }
  /*
   * 根据记录集获得查询Xml返回数据
   * @param 该函数不能处理通过缓存组件进行字典翻译的功能
   * @author Enjsky
   * @param rst                 待处理的结果记录集对象
   * @param strDicFieldList     待翻译字典字段列表
   *                            例如：SEX,NATION
   * @param strDicNameList      待翻译字典名称列表
   *                            例如：DIC_SEX,DIC_NATIVE
   *                            注意：strDicFieldList和strDicNameList必须一一对应 
   * @param   strDateFieldList    待处理的日期型字段列表
   *                            例如：BIRTHDAY,COMEDATE
   * @param int_TotalRecords    记录总数
   *                            例如：0
   * @param int_TotalPages      记录总页数
   *                            例如：0
   * @param ListName            生成列表名称
   *                            例如：ROW或者AFFAIRTYPE等
   * @return String             标准的查询 XML 返回结构的字符串
   */
  public static String getQueryXml(ResultSet rst,
								  String[] strDicFieldList,
						          String[] strDicNameList,
						          String[] strDateFieldList,
						          int int_TotalRecords,
						          int int_TotalPages,
						          boolean blnDicInSv,
						          String strListName) throws Exception
  {
	  strListName = strListName==null ? Common.XDOC_ROW : strListName;
		
	  ReturnDoc docReturn = new ReturnDoc();
      try
      {
    	  if (docReturn.getQueryInfo(rst, strListName))
	      {            
          Document doc = docReturn.getDocument();
	        List list = doc.selectNodes(Common.BAR2 + strListName);
	        Iterator it = list.iterator();
	
	        while (it.hasNext())
	        {  
	          Element ele = (Element)it.next();
	          
	          Element ele_Temp;
	          String str_Text;
	
	          /// 处理字典的翻译
	          DicCache obj_DicCache = DicCache.getInstance();
	
	          if (strDicFieldList!=null)
	          {  
	            for (int i=0; i<strDicFieldList.length; i++)
	            {
	              ele_Temp = (Element)ele.selectSingleNode(strDicFieldList[i]);
	              str_Text = ele_Temp.getText().trim();
	
	              if (General.empty(str_Text)) continue;
	
	              String str_SV = obj_DicCache.getText(strDicNameList[i], str_Text); 
	              		              
	
	              if (!blnDicInSv)
	              {
	                if (str_SV!=null) ele_Temp.setText(str_SV); 
	              }
	              else
	              {
	                if (str_SV!=null) ele_Temp.addAttribute(Common.XML_PROP_SV, str_SV);
	              }
	            }
	          }
	
	          /// 处理日期类型的字段
	          if (strDateFieldList!=null)
	          {
	            for(int i=0; i<strDateFieldList.length; i++)
	            {
	              ele_Temp = (Element)ele.selectSingleNode(strDateFieldList[i]);
	              str_Text = ele_Temp.getText();
	              
	              if(General.empty(str_Text)) continue;
	
	              String str_SV = General.cDateStr(str_Text);
	              str_Text = General.strToDate(str_SV);
                  ele_Temp.setText(str_Text);
	
 	              // String str_SV = ele_Temp.attributeValue(Common.XML_PROP_SV) ;
	              // str_SV = DateTimeUtil.getDateTime(DateTimeUtil.parse(str_SV, "yyyyMMdd"), "yyyy年MM月dd日") ;
	              if (blnDicInSv)
	              {
	                  
	            	  if (str_SV!=null) ele_Temp.addAttribute(Common.XML_PROP_SV, str_SV);
	              }
	             }
	          }
	        }
	        docReturn.addErrorResult(Common.RT_QUERY_SUCCESS);
	      }
	      else
	      {
	        docReturn.addErrorResult(Common.RT_QUERY_NOTHING);
	      }
	      docReturn.addPropToQueryInfo(Common.XML_PROP_TOTALPAGES, String.valueOf(int_TotalPages));
	      docReturn.addPropToQueryInfo(Common.XML_PROP_RECORDS, String.valueOf(int_TotalRecords));
	      
      }
      catch(Exception e)
      {
    	e.printStackTrace();  
      }
      return docReturn.getXML();
  }
  /**
   * 基本的分页查询
   * 该函数同时支持Oracle与Ms Sql 2005的分页存储过程查询
   * @param strFieldList        查询字段列表
   *                            例如：s.WORD WORD,s.SPELL SPELL,s.ASPELL ASPELL
   * @param strTableList        查询表列表
   *                            例如：SPELL s
   * @param strOtherClause      其他查询语句
   *                            例如：WHERE s.WORD='李'
   * @param strOrdFld           排序字段
   *                            例如：PERSONID DESC
   * @param strDicFieldList     待翻译字典字段列表
   *                            例如：SEX,NATION
   * @param strDicNameList      待翻译字典名称列表
   *                            例如：DIC_SEX,DIC_NATIVE
   *                            注意：strDicFieldList和strDicNameList必须一一对应 
   * @param strDateFieldList    待处理的日期型字段列表
   *                            例如：BIRTHDAY,COMEDATE
   * @param intTotalRecords     记录总数
   *                            例如：0
   * @param intPageSize         每页记录数
   *                            例如：50
   * @param intCurrentPage      待查询的页数
   *                            例如：2
   * @param intCountTotal       是否需要统计记录总数
   *                            0 - 不用统计记录总数
   *                                在第一次查询后，已经完成了一次记录总数和
   *                                总页数的统计后就可以不用再次的统计总数了
   *                            1 - 需要统计记录总数
   * @param strListName            生成列表名称
   *                            例如：ROW或者AFFAIRTYPE等
   * @return String             标准的查询 XML 返回结构的字符串
   */
  public static String basicListQuery(String strFieldList,
                                      String strTableList,
                                      String strOtherClause,
                                      String strOrdFld,
                                      String[] strDicFieldList,
                                      String[] strDicNameList,
                                      String[] strDateFieldList,
                                      int intTotalRecords,
                                      int intTotalPages,
                                      int intPageSize,
                                      int intCurrentPage,
                                      int intCountTotal,
                                      boolean blnDicInSv,
                                      String strListName) throws Exception
  {
    /// 获得连接
    DBConnection dbc = new DBConnection();
    String strReturnXml = "";
    try
    {
      String str_FieldList = strFieldList.replaceAll(Common.MARK, Common.QUOTE);
      String str_TableList = strTableList.replaceAll(Common.MARK, Common.QUOTE);
      
      String str_OtherClause = null;
      String str_OrdFld = null;

      if (!General.empty(strOtherClause))
      {
        str_OtherClause = strOtherClause.replaceAll(Common.MARK,Common.QUOTE);
      }

      if (!General.empty(strOrdFld))
      {
    	  str_OrdFld = strOrdFld.replaceAll(Common.MARK,Common.QUOTE);
      }

      int int_TotalRecords = intTotalRecords;
      int int_TotalPages   = intTotalPages; 
      
      Connection conn = dbc.getConnection();
      CallableStatement proc = null;
      
      try
      {
    	  ResultSet rst = null;
    	  
    	  if(DBConnection.JDBCTYPE.equalsIgnoreCase("2")) // Oracle 
	      {
    		  // 在oracle中 排序和where条件放一起
    	      if (!General.empty(str_OrdFld))
    	      {
    	    	  if(!General.empty(str_OtherClause))
    	    		  str_OtherClause = str_OtherClause + Common.SPACE + Common.ORDER + str_OrdFld;
    	    	  else
    	    		  str_OtherClause = Common.SPACE + Common.ORDER + str_OrdFld;
    	      }
    		  
    		  StringBuffer Statement = new StringBuffer("{CALL QueryPagination(?,?,?,?,?,?,?,?,?,?)}");
		      
		      proc = conn.prepareCall(Statement.toString());
		      
		      proc.registerOutParameter(5, Types.NUMERIC);
		      proc.registerOutParameter(6, Types.NUMERIC);
		      proc.registerOutParameter(10, OracleTypes.CURSOR);
		      
		      proc.setObject(1, "t");
		
		      if (General.empty(str_FieldList))
		        proc.setNull(2, Types.VARCHAR);
		      else
		        proc.setObject(2, str_FieldList);
		
		      if (General.empty(str_TableList))
		        proc.setNull(3, Types.VARCHAR);
		      else
		        proc.setObject(3, str_TableList);
		      
		      if (General.empty(str_OtherClause))
		        proc.setNull(4, Types.VARCHAR);
		      else
		        proc.setObject(4, str_OtherClause);
		     
		      proc.setInt(5, int_TotalRecords);
		      proc.setInt(6, int_TotalPages);
		      proc.setInt(7, intPageSize);
		      proc.setInt(8, intCurrentPage);
		      proc.setInt(9, intCountTotal);
		
		      proc.execute();
			      
		      rst = (ResultSet)proc.getObject(10);

		      int_TotalRecords = proc.getInt(5);
		      int_TotalPages   = proc.getInt(6);
	      }
    	  else if(DBConnection.JDBCTYPE.equalsIgnoreCase("3")) // Ms Sql Server 2005
    	  {
	    	  StringBuffer Statement = new StringBuffer("{CALL dbo.QueryPagination(?,?,?,?,?,?,?,?,?,?)}");
		      
		      proc = conn.prepareCall(Statement.toString());
		      

		      proc.setObject(1, "t");
		      if (General.empty(str_FieldList))
			        proc.setNull(2, Types.VARCHAR);
		      else
		        proc.setObject(2, str_FieldList);
		
		      if (General.empty(str_TableList))
		        proc.setNull(3, Types.VARCHAR);
		      else
		        proc.setObject(3, str_TableList);
		      
		      if (General.empty(str_OtherClause))
		        proc.setNull(4, Types.VARCHAR);
		      else
		        proc.setObject(4, str_OtherClause);
		     
		      if (General.empty(str_OrdFld))
			        proc.setNull(5, Types.VARCHAR);
			      else
			        proc.setObject(5, str_OrdFld);

		      proc.setInt(6, intCurrentPage);
		      proc.setInt(7, intPageSize);
		      proc.setInt(8, intCountTotal);

		      proc.setInt(9, int_TotalRecords);
		      proc.setInt(10, int_TotalPages);
		      proc.registerOutParameter(9, Types.NUMERIC);
		      proc.registerOutParameter(10, Types.NUMERIC);
		      proc.execute();
		      /*
		       * java 在读取sql server 的存储过程返回记录集的时候
		       * 对out参数的读取一定要在 proc.executeQuery() 之前完成；
		       * 否则 会报 rst 为空的错误。
		       */
		      int_TotalRecords = proc.getInt(9);
		      int_TotalPages   = proc.getInt(10);
		      
		      rst = proc.executeQuery();
    	  }
        else if(DBConnection.JDBCTYPE.equalsIgnoreCase("4")) // MySql
        {
          if (!General.empty(str_OrdFld))
          {
            if(!General.empty(str_OtherClause))
              str_OtherClause = str_OtherClause + Common.SPACE + Common.ORDER + str_OrdFld;
            else
              str_OtherClause = Common.ORDER + str_OrdFld;
          }
          
          // 查询总记录数
          String strSQL = "SELECT COUNT(1) FROM " + strTableList +  Common.SPACE + str_OtherClause;
          rst = dbc.excuteQuery(strSQL);
          while(rst.next())
          {  
            int_TotalRecords = Integer.parseInt(rst.getString(1));
          }
          rst.close();
          
          // 分析出页数
          if(int_TotalRecords % intPageSize == 0)
          {
            int_TotalPages = int_TotalRecords / intPageSize;
          }
          else
          {
            int_TotalPages = int_TotalRecords / intPageSize + 1;
          }
          
          strSQL = "SELECT " + strFieldList + " FROM " + strTableList +  Common.SPACE + str_OtherClause + " LIMIT " + (intCurrentPage - 1) * intPageSize + "," + intPageSize;
          rst = dbc.excuteQuery(strSQL);
        }
	      
    	  strReturnXml = getQueryXml(rst,
            									      strDicFieldList,
            							          strDicNameList,
            							          strDateFieldList,
            							          int_TotalRecords,
            							          int_TotalPages,
            							          blnDicInSv,
            							          strListName);
    	  rst.close();
      }
      finally
      {
    	  if(proc != null)
    	    proc.close();
      }
      return strReturnXml;
    }
    catch(Exception e)
    {
      e.printStackTrace();
      throw e;
    }
    finally
    {
      dbc.freeConnection();
    }
  }
  /**
   * 基本的分页查询
   * 该函数不能处理通过缓存组件进行字典翻译的功能
   * @param strFieldList        查询字段列表
   *                            例如：s.WORD WORD,s.SPELL SPELL,s.ASPELL ASPELL
   * @param strTableList        查询表列表
   *                            例如：SPELL s
   * @param strOtherClause      其他查询语句
   *                            例如：WHERE s.WORD='李'
   * @param strOrdFld           排序字段
   *                            例如：PERSONID DESC
   * @param strDicFieldList     待翻译字典字段列表
   *                            例如：SEX,NATION
   * @param strDicNameList      待翻译字典名称列表
   *                            例如：DIC_SEX,DIC_NATIVE
   *                            注意：strDicFieldList和strDicNameList必须一一对应 
   * @param strDateFieldList    待处理的日期型字段列表
   *                            例如：BIRTHDAY,COMEDATE
   * @param intTotalRecords     记录总数
   *                            例如：0
   * @param intPageSize         每页记录数
   *                            例如：50
   * @param intCurrentPage      待查询的页数
   *                            例如：2
   * @param intCountTotal       是否需要统计记录总数
   *                            0 - 不用统计记录总数
   *                                在第一次查询后，已经完成了一次记录总数和
   *                                总页数的统计后就可以不用再次的统计总数了
   *                            1 - 需要统计记录总数
   * @param strListName            生成列表名称
   *                            例如：ROW或者AFFAIRTYPE等
   * @return String              标准的查询 XML 返回结构的字符串
   */
  public static String basicListQuery(String strFieldList,
                                      String strTableList,
                                      String strOtherClause,
                                      String strOrdFld,
                                      String[] strDicFieldList,
                                      String[] strDicNameList,
                                      String[] strDateFieldList,
                                      String[] strDateTimeFieldList,
                                      int intTotalRecords,
                                      int intTotalPages,
                                      int intPageSize,
                                      int intCurrentPage,
                                      int intCountTotal,
                                      boolean blnDicInSv,
                                      String strListName) throws Exception
  {
    strListName = strListName==null ? Common.XDOC_ROW : strListName;

    /// 获得连接
    DBConnection dbc = new DBConnection();

    ReturnDoc docReturn = new ReturnDoc();
    try
    {
      String str_FieldList = strFieldList.replaceAll(Common.MARK, Common.QUOTE);
      String str_TableList = strTableList.replaceAll(Common.MARK, Common.QUOTE);
      
      String str_OtherClause = null;

      if (!General.empty(strOtherClause))
      {
        str_OtherClause = strOtherClause.replaceAll(Common.MARK,Common.QUOTE);
      }

      int int_TotalRecords = intTotalRecords;
      int int_TotalPages   = intTotalPages; 
      
      Connection conn = dbc.getConnection();
      CallableStatement proc = null;
      
      try
      {
	      StringBuffer Statement = new StringBuffer("{CALL QueryPagination(?,?,?,?,?,?,?,?,?,?)}");
	      
	      proc = conn.prepareCall(Statement.toString());
	      
	      proc.registerOutParameter(5, Types.NUMERIC);
	      proc.registerOutParameter(6, Types.NUMERIC);
	      proc.registerOutParameter(10, OracleTypes.CURSOR);
	      proc.setObject(1, "t");
	
	      if (General.empty(str_FieldList))
	        proc.setNull(2, Types.VARCHAR);
	      else
	        proc.setObject(2, str_FieldList);
	
	      if (General.empty(str_TableList))
	        proc.setNull(3, Types.VARCHAR);
	      else
	        proc.setObject(3, str_TableList);
	      
	      if (General.empty(str_OtherClause))
	        proc.setNull(4, Types.VARCHAR);
	      else
	        proc.setObject(4, str_OtherClause);
	     
	      proc.setInt(5, int_TotalRecords);
	      proc.setInt(6, int_TotalPages);
	      proc.setInt(7, intPageSize);
	      proc.setInt(8, intCurrentPage);
	      proc.setInt(9, intCountTotal);
	
	      proc.execute();
	
//	      ResultSet rst = ((oracle.jdbc.driver.OracleCallableStatement)proc).getCursor(10);
	      ResultSet rst = (ResultSet)proc.getObject(10);
	      try {
					int_TotalRecords = proc.getInt(5);
					int_TotalPages = proc.getInt(6);

					if (docReturn.getQueryInfo(rst, strListName)) {
						Document doc = docReturn.getDocument();
						List list = doc.selectNodes(Common.BAR2 + strListName);
						Iterator it = list.iterator();

						while (it.hasNext()) {
							Element ele = (Element) it.next();

							Element ele_Temp;
							String str_Text;

							// / 处理字典的翻译
							DicCache obj_DicCache = DicCache.getInstance();

							if (strDicFieldList != null) {
								for (int i = 0; i < strDicFieldList.length; i++) {
									ele_Temp = (Element) ele
											.selectSingleNode(strDicFieldList[i]);
									str_Text = ele_Temp.getText().trim();

									if (General.empty(str_Text))
										continue;

									String str_SV = obj_DicCache.getText(
											strDicNameList[i], str_Text);


									if (!blnDicInSv) {
										if (str_SV != null)
											ele_Temp.setText(str_SV);
									} else {
										if (str_SV != null)
											ele_Temp.addAttribute(
													Common.XML_PROP_SV, str_SV);
									}
								}
							}

							// / 处理日期类型的字段
							if (strDateFieldList != null) {
								for (int i = 0; i < strDateFieldList.length; i++) {
									ele_Temp = (Element) ele
											.selectSingleNode(strDateFieldList[i]);
									str_Text = ele_Temp.getText();

									if (General.empty(str_Text))
										continue;

									str_Text = General.cDateStr(str_Text);

									if (str_Text != null) {
										str_Text = General.strToDate(str_Text);
										ele_Temp.setText(str_Text);
									}
								}
							}
							
							/// 处理日期时间类型类型的字段
							if (strDateTimeFieldList != null) {
								for (int i = 0; i < strDateTimeFieldList.length; i++) {
									String sv="" ;
									ele_Temp = (Element) ele
											.selectSingleNode(strDateTimeFieldList[i]);
									str_Text = ele_Temp.getText();

									if (General.empty(str_Text))
										continue;

									str_Text = General.strToDateTime(str_Text);

									if (str_Text != null) {
										sv = General.cDateTimeStr(str_Text);
										ele_Temp.setText(str_Text);
										XmlFunc.setAttrValue(ele_Temp, "sv", sv) ;
									}
								}
							}
						}						
						docReturn.addErrorResult(Common.RT_QUERY_SUCCESS);
					}
          else {
						docReturn.addErrorResult(Common.RT_QUERY_NOTHING);
					}
					docReturn.addPropToQueryInfo(Common.XML_PROP_TOTALPAGES, String.valueOf(int_TotalPages));
					docReturn.addPropToQueryInfo(Common.XML_PROP_RECORDS,String.valueOf(int_TotalRecords));
				} finally {
					rst.close();
				}
      }
      finally
      {
    	  proc.close();
      }
      return docReturn.getXML();
    }
    catch(Exception e)
    {
      e.printStackTrace();
      throw e;
    }
    finally
    {
      dbc.freeConnection();
    }
  }
      
  public static String basicListQuery(String strFieldList,
                                      String strTableList,
                                      String strOtherClause,
                                      String strOrdFld,
                                      String[] strDicFieldList,
                                      String[] strDicNameList,
                                      String[] strDateFieldList,
                                      int intTotalRecords,
                                      int intTotalPages,
                                      int intPageSize,
                                      int intCurrentPage,
                                      int intCountTotal) throws Exception
  {
    return basicListQuery(strFieldList,
                          strTableList,
                          strOtherClause,
                          strOrdFld,
                          strDicFieldList,
                          strDicNameList,
                          strDateFieldList,
                          intTotalRecords,
                          intTotalPages,
                          intPageSize,
                          intCurrentPage,
                          intCountTotal,
                          false,
                          null);
   
  }

  public static String basicListQuery(String strFieldList,
                    										String strTableList, 
                    										String strOtherClause,
                                        String strOrdFld,
                    										String[] strDicFieldList, 
                    										String[] strDicNameList,
                    										String[] strDateFieldList, 
                    										String[] strDateTimeFieldList,
                    										int intTotalRecords, 
                    										int intTotalPages, 
                    										int intPageSize,
                    										int intCurrentPage, 
                    										int intCountTotal) throws Exception {
		return basicListQuery(strFieldList, 
          								strTableList, 
          								strOtherClause,
          								strOrdFld,
          								strDicFieldList, 
          								strDicNameList, 
          								strDateFieldList,
          								strDateTimeFieldList, 
          								intTotalRecords, 
          								intTotalPages,
          								intPageSize, 
          								intCurrentPage, 
          								intCountTotal, 
          								false, 
          								null);

	}
  
  
  public static String basicListQuery(String strFieldList,
      String strTableList,
      String strOtherClause,
      String strOrdFld,
      String[] strDateFieldList,
      int intPageSize,
      int intCurrentPage) throws Exception
  {
  return basicListQuery(strFieldList,
                        strTableList,
                        strOtherClause,
                        strOrdFld,
                        null,
                        null,
                        strDateFieldList,
                        0,
                        0,
                        intPageSize,
                        intCurrentPage,
                        0,
                        false,
                        null);
  
  }
  
  public static void main(String []arg)
  {
    DBConnection dbc = new DBConnection();
    ResultSet rst = null;
    try
    {
      String str_SQL = "SELECT COUNT(1) FROM AFFAIRTYPE s ORDER BY AFFAIRTYPEID";
      
      rst = dbc.excuteQuery(str_SQL);
      while(rst.next())
      {  
        String cc = rst.getString(1);
        System.out.println(cc);
      }
      rst.close();
      
      String strSQL = "SELECT COUNT(1) FROM AFFAIRTYPE s ORDER BY AFFAIRTYPEID";
      rst = rsQry(strSQL);
      while(rst.next())
      {  
        String cc = rst.getString(1);
        System.out.println(cc);
      }
      rst.close();
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
  }

}

