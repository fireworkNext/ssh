package org.ptbank.baseManage;

import java.util.*;

import org.dom4j.Element;
import org.ptbank.base.CommonQuery;
import org.ptbank.base.QueryDoc;
import org.ptbank.base.ReturnDoc;
import org.ptbank.cache.*;
import org.ptbank.db.*;
import org.ptbank.declare.*;
import org.ptbank.func.*;


public class Dic
{
  /**
   * 查询字典内容的简单列表
   * @param strXML            标准 XML 数据信息
   * @param strDicName        字典名称
   * @return XML               标准 XML 返回结构
   */
  public static String dicDataList(String strXML, String strDicName) throws Exception
  {
    QueryDoc obj_Query = new QueryDoc(strXML);
    Element ele_Condition = obj_Query.getCondition();
    
    /// 获得每页记录数
    String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
    int int_PageSize = str_Return==null ? 10 : Integer.parseInt(str_Return);

    /// 获得当前待查询页码
    str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
    int int_CurrentPage = str_Return==null ? 1 : Integer.parseInt(str_Return);

    /// 获得记录总数
    str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
    int int_TotalRecords = str_Return==null ? 0 : Integer.parseInt(str_Return);

    int int_CountTotal = int_TotalRecords>0 ? 1 : 0;
    
    int int_TotalPages = 0;
    
    String str_Select = Table.S + Common.DOT  + Field.DIC_CODE  + Common.SPACE + Field.DIC_CODE + Common.COMMA +
                        Table.S + Common.DOT  + Field.DIC_TEXT  + Common.SPACE + Field.DIC_TEXT + Common.COMMA +
                        Table.S + Common.DOT  + Field.DIC_VALID + Common.SPACE + Field.DIC_VALID + Common.COMMA +
                        Table.S + Common.DOT  + Field.DIC_ORD   + Common.SPACE + Field.DIC_ORD;
    
    String str_From   = Table.DICDATA + Common.SPACE + Table.S;
    
    String str_Where = obj_Query.getConditions();
    
    str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
    str_Where = !General.empty(str_Where) ?
                str_Where      +
                Common.SPACE   + Field.DICNAME + Common.EQUAL + General.addQuotes(strDicName) :
                Common.S_WHERE + Field.DICNAME + Common.EQUAL + General.addQuotes(strDicName);
    
    // str_Where += Common.S_ORDER + Field.DIC_CODE;
  
    String[] str_DicFieldList = {Field.DIC_VALID};
    
    String[] str_DicNameList  = {Table.DIC_VALID };
    
    return CommonQuery.basicListQuery(str_Select,
                                      str_From,
                                      str_Where,
                                      Field.DIC_CODE,
                                      str_DicFieldList,
                                      str_DicNameList,
                                      null,
                                      int_TotalRecords,
                                      int_TotalPages,
                                      int_PageSize,
                                      int_CurrentPage,
                                      int_CountTotal);
  }

  /**
   * 查询字典列表
   * @param strXML            标准 XML 数据信息
   * @return XML               标准 XML 返回结构
   */
  public static String dicList(String strXML) throws Exception
  {
    QueryDoc obj_Query = new QueryDoc(strXML);
    Element ele_Condition = obj_Query.getCondition();
    
    /// 获得每页记录数
    String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
    int int_PageSize = str_Return==null ? 10 : Integer.parseInt(str_Return);

    /// 获得当前待查询页码
    str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
    int int_CurrentPage = str_Return==null ? 1 : Integer.parseInt(str_Return);

    /// 获得记录总数
    str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
    int int_TotalRecords = str_Return==null ? 0 : Integer.parseInt(str_Return);

    int int_CountTotal = int_TotalRecords>0 ? 1 : 0;
    int int_TotalPages = 0;

    String str_Select = Table.S + Common.DOT  + Field.DICNAME  + Common.SPACE + Field.DICNAME + Common.COMMA +
                        Table.S + Common.DOT  + Field.DICDES   + Common.SPACE + Field.DICDES  + Common.COMMA +
                        Table.S + Common.DOT  + Field.CODELEN  + Common.SPACE + Field.CODELEN + Common.COMMA +
                        Table.S + Common.DOT  + Field.TEXTLEN  + Common.SPACE + Field.TEXTLEN + Common.COMMA +
                        Table.S + Common.DOT  + Field.EDITABLE + Common.SPACE + Field.EDITABLE;
    String str_From   = Table.DICLIST + Common.SPACE + Table.S;

    String str_Where = obj_Query.getConditions();

    str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
    // str_Where = !General.empty(str_Where) ? str_Where + Common.S_ORDER + Field.DICNAME : Common.S_ORDER + Field.DICNAME;

    String[] str_DicFieldList = {Field.EDITABLE};
    String[] str_DicNameList  = {Table.DIC_DICEDITABLE};

    return CommonQuery.basicListQuery(str_Select,
                                      str_From,
                                      str_Where,
                                      Field.DICNAME,
                                      str_DicFieldList,
                                      str_DicNameList,
                                      null,
                                      int_TotalRecords,
                                      int_TotalPages,
                                      int_PageSize,
                                      int_CurrentPage,
                                      int_CountTotal);
  }

  /**
   * 增加一个新的字典
   * @param strDicName      字典名称
   * @param strDicDes       字典描述
   * @param strCodeLen      字典编码长度
   * @param strEditable     字典修改权限
   * @return XML             标准 XML 返回结构
   */
  public static String addNewDic(String strDicName,
                                 String strDicDes,
                                 String strCodeLen,
                                 String strTextLen,
                                 String strEditable) throws Exception
  {
    strDicName = strDicName.toUpperCase();

    String str_SysDics = Table.DICLIST        + Common.COMMA + 
                         Table.DIC_MANAGEUNIT + Common.COMMA +
                         Table.DIC_AFFAIRTYPE + Common.COMMA +
                         Table.DIC_EVENTTYPE  + Common.COMMA + 
                         Table.DIC_USERLIST;

    if (str_SysDics.indexOf(strDicName)>-1)
      throw new Exception("字典名 [" + strDicName + "] 为系统字典，不能使用该名称做为字典名称");
    
    ArrayList arr_Dic = DicCache.getInstance().getDicByName(strDicName);
    
    if (arr_Dic!=null)
    {
      throw new Exception("同名字典 [" + strDicName + "(" + strDicDes +  ")] 已经存在，不能重复创建");
    }
    
    /// 更新数据库中的字典内容
    String str_FieldList = General.addBracket(Field.DICNAME + Common.COMMA +
                                              Field.DICDES  + Common.COMMA +
                                              Field.CODELEN + Common.COMMA +
                                              Field.TEXTLEN + Common.COMMA +
                                              Field.EDITABLE);

    String str_ValueList = General.addBracket(General.addQuotes(strDicName) + Common.COMMA +
                                              General.addQuotes(strDicDes)  + Common.COMMA +
                                              strCodeLen                    + Common.COMMA +
                                              strTextLen                    + Common.COMMA +
                                              strEditable);

    String str_SQL = Common.INSERT   + Table.DICLIST +
                     Common.SPACE    + str_FieldList +
                     Common.S_VALUES + str_ValueList;

    DataStorage obj_Storage = new DataStorage();
    obj_Storage.addSQL(str_SQL);

    //  执行
    String str_Return = obj_Storage.runSQL();
    ReturnDoc obj_ReturnDoc = new ReturnDoc();
    if (!General.empty(str_Return))
    {
    	obj_ReturnDoc.addErrorResult(Common.RT_FUNCERROR);
	    obj_ReturnDoc.setFuncErrorInfo(str_Return);
    }
    else
    {
      obj_ReturnDoc.addErrorResult(Common.RT_SUCCESS);
    }

    /// 刷新字典缓存内容
    DicCache.getInstance().refresh(strDicName);

    /// 返回
    return obj_ReturnDoc.getXML();
  }

  /**
   * 维护字典内容
   *        如果是已有的字典条目则更新，如果是新的字典条目则增加
   * @param strDicName      字典名称
   * @param strDicCode      字典编码
   * @param strDicText      字典文本内容
   * @param strDicValid     字典条目是否有效
   * @return XML             标准 XML 返回结构
   */
  public static String vindicate(String strDicName,
                                 String strDicCode,
                                 String strDicText,
                                 String strDicValid,
                                 String strDicOrd) throws Exception
  {
    strDicName = strDicName.toUpperCase();
    ArrayList arr_Dic = DicCache.getInstance().getDicByName(strDicName);
    if (arr_Dic==null) throw new Exception("指定的字典并不存在于字典缓存中");

    boolean bln_New = true;
    Iterator it_Dic = arr_Dic.iterator();
    while (it_Dic.hasNext())
    {
      String[] str_DicItem = (String[])it_Dic.next();
      if (str_DicItem[0].equals(strDicCode))
      {
        bln_New = false;
        break;
      }
    }

    String str_SQL = "";

    DataStorage obj_Storage = new DataStorage();

    if (bln_New)
    {
      /// 更新数据库中的字典内容
      String str_FieldList = General.addBracket(Field.DICNAME  + Common.COMMA +
                                                Field.DIC_CODE + Common.COMMA +
                                                Field.DIC_TEXT + Common.COMMA +
                                                Field.DIC_VALID + Common.COMMA +
                                                Field.DIC_ORD);

      String str_ValueList = General.addBracket(General.addQuotes(strDicName) + Common.COMMA +
                                                General.addQuotes(strDicCode) + Common.COMMA +
                                                General.addQuotes(strDicText) + Common.COMMA +
                                                General.addQuotes(strDicValid) + Common.COMMA +
                                                General.addQuotes(strDicOrd));

      str_SQL = Common.INSERT   + Table.DICDATA +
                Common.SPACE    + str_FieldList +
                Common.S_VALUES + str_ValueList;
    }
    else
    {
      /// 更新数据库中的字典内容
      str_SQL = Common.UPDATE  + Table.DICDATA   +
                Common.S_SET   + Field.DIC_TEXT  + Common.EQUAL + General.addQuotes(strDicText)  + Common.COMMA +
                                 Field.DIC_VALID + Common.EQUAL + General.addQuotes(strDicValid) + Common.COMMA +
                                 Field.DIC_ORD + Common.EQUAL + General.addQuotes(strDicOrd) +
                Common.S_WHERE + Field.DIC_CODE  + Common.EQUAL + General.addQuotes(strDicCode)  +
                Common.S_AND   + Field.DICNAME   + Common.EQUAL + General.addQuotes(strDicName);
    }

    obj_Storage.addSQL(str_SQL);

    String str_Return = obj_Storage.runSQL();
    ReturnDoc obj_ReturnDoc = new ReturnDoc();
    if (!General.empty(str_Return))
    {
    	obj_ReturnDoc.addErrorResult(Common.RT_FUNCERROR);
	    obj_ReturnDoc.setFuncErrorInfo(str_Return);
    }
    else
    {
      obj_ReturnDoc.addErrorResult(Common.RT_SUCCESS);
    }

    /// 刷新字典缓存信息
    DicCache.getInstance().refresh(strDicName);

    /// 返回
    return obj_ReturnDoc.getXML();
  }

  /**
   * 删除字典条目
   * @param strDicName      字典名称
   * @param strDicCode      字典编码
   * @return XML             标准 XML 返回结构
   */
  public static String deleteItem(String strDicName, String strDicCode) throws Exception
  {
    strDicName = strDicName.toUpperCase();
    ArrayList arr_Dic = DicCache.getInstance().getDicByName(strDicName);
    if (arr_Dic==null) throw new Exception("指定的字典并不存在于字典缓存中");

    String str_SQL = "";
    DataStorage obj_Storage = new DataStorage();

    /// 删除数据库中的字典内容
    str_SQL = Common.DELETE  + Table.DICDATA  +
              Common.S_WHERE + Field.DICNAME  + Common.EQUAL + General.addQuotes(strDicName) +
              Common.S_AND   + Field.DIC_CODE + Common.EQUAL + General.addQuotes(strDicCode);

    obj_Storage.addSQL(str_SQL);

    String str_Return = obj_Storage.runSQL();
    ReturnDoc obj_ReturnDoc = new ReturnDoc();
    if(!General.empty(str_Return))
    {
    	obj_ReturnDoc.addErrorResult(Common.RT_FUNCERROR);
	    obj_ReturnDoc.setFuncErrorInfo(str_Return);
    }
    else
    {
      obj_ReturnDoc.addErrorResult(Common.RT_SUCCESS);
    }

    /// 刷新字典缓存信息
    DicCache.getInstance().refresh(strDicName);

    /// 返回
    return obj_ReturnDoc.getXML();
  }
  
  /**
   * 删除字典
   * @param strDicName      字典名称
   * @return XML             标准 XML 返回结构
   */
  public static String deleteDic(String strDicName) throws Exception
  {
    strDicName = strDicName.toUpperCase();
    
    String str_SQL = "";
    DataStorage obj_Storage = new DataStorage();

    /// 删除数据库中的字典
    str_SQL = Common.DELETE  + Table.DICLIST  +
              Common.S_WHERE + Field.DICNAME  + Common.EQUAL + General.addQuotes(strDicName);

    obj_Storage.addSQL(str_SQL);

    /// 删除数据库中的字典内容
    str_SQL = Common.DELETE  + Table.DICDATA  +
              Common.S_WHERE + Field.DICNAME  + Common.EQUAL + General.addQuotes(strDicName);

    obj_Storage.addSQL(str_SQL);

    String str_Return = obj_Storage.runSQL();
    ReturnDoc obj_ReturnDoc = new ReturnDoc();
    if(!General.empty(str_Return))
    {
      obj_ReturnDoc.addErrorResult(Common.RT_FUNCERROR);
      obj_ReturnDoc.setFuncErrorInfo(str_Return);
    }
    else
    {
      obj_ReturnDoc.addErrorResult(Common.RT_SUCCESS);
    }

    /// 返回
    return obj_ReturnDoc.getXML();
  }  
}
