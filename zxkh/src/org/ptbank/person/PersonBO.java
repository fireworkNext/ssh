package org.ptbank.person;

import java.sql.ResultSet;

import org.dom4j.*;
import org.ptbank.base.CommonQuery;
import org.ptbank.base.DataDoc;
import org.ptbank.base.NumAssign;
import org.ptbank.base.Operation;
import org.ptbank.base.QueryDoc;
import org.ptbank.base.ReturnDoc;
import org.ptbank.db.DBConnection;
import org.ptbank.db.DataStorage;
import org.ptbank.db.SQLAnalyse;
import org.ptbank.declare.*;
import org.ptbank.func.*;


public class PersonBO {

  /*********************************************************
   * 添加学生档案信息
   * @param  strXml           XML 数据信息  
   * @return String           XML 返回信息   
  ***********************************************************/
  public static String addNew(String strXml) throws Exception
  {
    DataDoc doc = new DataDoc(strXml);
    // 创建数据层执行对象
    DataStorage storage = new DataStorage();
    // 创建标准返回结构Dom类对象
    ReturnDoc returndoc = new ReturnDoc();
    try
    {
      int size = doc.getDataNum(Table.PERSON);
     
      // 解析sql语句
      for(int i=0;i<size;i++)
      {  
        Element ele = (Element)doc.getDataNode(Table.PERSON,i);
        
        //A.001~~~~
        // 为PersonID分配唯一编码
        Node node = ele.selectSingleNode(Field.PERSONID);
        String strId = NumAssign.assignID_B("100001",General.curYear2() + General.curMonth());        
        node.setText(strId);
        //end A.001~~~~
        
        storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
      }
      // 执行SQL
      String strReturn = storage.runSQL();
      if(!General.empty(strReturn))
      {
        // 执行失败，返回异常描述
        returndoc.addErrorResult(Common.RT_FUNCERROR);
        returndoc.setFuncErrorInfo(strReturn);
      }
      else
        // 执行成功，返回成功节点
        returndoc.addErrorResult(Common.RT_SUCCESS);
    }
    catch(Exception e)
    {
      // 发生异常，返回异常描述
      returndoc.addErrorResult(Common.RT_FUNCERROR);
      returndoc.setFuncErrorInfo(e.getMessage());
    }
    // 标准的返回XML结构文档
    return returndoc.getXML();
  }
 
  /*********************************************************
   * 修改\删除档案信息
   * @param  strXml           XML 数据信息  
   * @return String           XML 返回信息   
  ***********************************************************/
  public static String dealXml(String strXml) throws Exception
  {
    return Operation.dealWithXml(strXml);
  }

  /*********************************************************
   * 查询学生档案列表
   * @param      strXML            标准查询条件结构
   * @return       XML               标准查询返回结构
   */
    public static String personList(String strXML) throws Exception
    {
      // 构造标准查询XML接口分析类对象
      QueryDoc obj_Query = new QueryDoc(strXML);
      int int_PageSize = obj_Query.getIntPageSize();

      int int_CurrentPage = obj_Query.getIntCurrentPage();

      String str_Where = obj_Query.getConditions();
      

      // 查询字典
      String str_Select = "s.PERSONID PERSONID,s.NAME NAME,s.IDCARD IDCARD,s.SEX SEX,s.PLACECODE PLACECODE,s.BIRTHDAY BIRTHDAY,s.TEL TEL";
      // 查询表
      String str_From   = Table.PERSON + Common.SPACE + Table.S;
      // 构建标准的查询条件
      
      str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
      
      // 日期型字段列表
      String[] str_DateList  = {Field.BIRTHDAY};
      
      // 标准的、统一的分页查询接口
      return CommonQuery.basicListQuery(str_Select,
                                        str_From,
                                        str_Where,
                                        Field.PERSONID,
                                        str_DateList,
                                        int_PageSize,
                                        int_CurrentPage);
    }

    
    public static String personListSv(String strXML) throws Exception
    {
      // 构造标准查询XML接口分析类对象
      QueryDoc obj_Query = new QueryDoc(strXML);
      int int_PageSize = obj_Query.getIntPageSize();

      int int_CurrentPage = obj_Query.getIntCurrentPage();

      String str_Where = obj_Query.getConditions();

      // 查询字典
      String str_Select = "s.PERSONID PERSONID,s.NAME NAME,s.IDCARD IDCARD,s.SEX SEX,s.PLACECODE PLACECODE,s.BIRTHDAY BIRTHDAY,s.TEL TEL";
      // 查询表
      String str_From   = Table.PERSON + Common.SPACE + Table.S;
      // 构建标准的查询条件
      
      str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
      
      // 日期型字段列表
      String[] str_DateList  = {Field.BIRTHDAY};
      String[] str_DicFieldList  = {"SEX","PLACECODE"};
      String[] str_DicNameList  = {"DIC_GENDER","DIC_CODE"};
      
      // 标准的、统一的分页查询接口
      return CommonQuery.basicListQuery(str_Select,
                                        str_From,
                                        str_Where,
                                        Field.PERSONID,
                                        str_DicFieldList,
                                        str_DicNameList,
                                        str_DateList,
                                        0,
                                        0,
                                        int_PageSize,
                                        int_CurrentPage,
                                        0);

    }
    
    
    /**
     * 查询学生详细档案信息
     * @param      sPersonID         学生编号
     * @return     XML               标准查询返回结构
     */
    public static String personDetail(String sPersonID) throws Exception
    {
      String str_Select = "s.PERSONID PERSONID,s.NAME NAME,s.IDCARD IDCARD,s.SEX SEX,s.BIRTHDAY BIRTHDAY,s.PLACECODE PLACECODE,s.YEAROLD YEAROLD,s.EMAIL EMAIL,s.TEL TEL,s.BAK BAK";

      String str_From   = "PERSON s";
    
      String str_Where = Common.WHERE + Common.SPACE + Field.PERSONID + Common.EQUAL + General.addQuotes(sPersonID);
      
      String[] str_DateList  = {Field.BIRTHDAY};
      return CommonQuery.basicListQuery(str_Select, 
                                        str_From, 
                                        str_Where,
                                        Field.PERSONID,
                                        null, 
                                        null, str_DateList, 1, 1, 1, 1, 0, true,
                                        Table.PERSON);
    }   
    
    
    /**
     * 有字典翻译的信息查询
     * @param sPersonID
     * @return
     * @throws Exception
     */
    public static String personDetail2(String sPersonID) throws Exception
    {
      String str_Select = "s.PERSONID PERSONID,s.NAME NAME,s.IDCARD IDCARD,s.SEX SEX,s.BIRTHDAY BIRTHDAY,s.PLACECODE PLACECODE,s.YEAROLD YEAROLD,s.EMAIL EMAIL,s.TEL TEL,s.BAK BAK";

      String str_From   = "PERSON s";
    
      String str_Where = Common.WHERE + Common.SPACE + Field.PERSONID + Common.EQUAL + General.addQuotes(sPersonID);
      
      String[] str_DateList  = {"BIRTHDAY"};
      String[] str_DicFieldList  = {"SEX","PLACECODE"};
      String[] str_DicNameList  = {"DIC_GENDER","DIC_CODE"};
      
      return CommonQuery.basicListQuery(str_Select, 
                                        str_From, 
                                        str_Where,
                                        Field.PERSONID,
                                        str_DicFieldList, 
                                        str_DicNameList, 
                                        str_DateList, 
                                        1, 1, 1, 1, 0, false,"PERSON");
    }
    
    
    // 通过sql语句直接获得rst,通过rst直接转换为xml
    public static String personDetail3(String sPersonID) throws Exception
    {
      String str_SQL = "SELECT * FROM PERSON WHERE PERSONID=" + General.addQuotes(sPersonID);
      DBConnection dbc = new DBConnection();
      ReturnDoc docReturn = new ReturnDoc();
      
      ResultSet rst = null;
      
      rst = dbc.excuteQuery(str_SQL);

      docReturn.getQueryInfo(rst, "PERSON");
      
      rst.close();
      dbc.freeConnection();

      
      return docReturn.getXML();
      
    }

}
