package org.ptbank.func;

import java.util.*;
import java.io.FileInputStream;
import java.lang.Math;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.stream.StreamSource;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.io.DocumentResult;
import org.dom4j.io.DocumentSource;
import org.ptbank.base.XmlFunc;
import org.ptbank.cache.*;
import org.ptbank.declare.*;


/**
 * 用于对数据交换过程中的标准XML文档字符串进行进一步的分析处理 
 */
public class PageCommon
{

  /**
   * 判断调用组件执行是否成功
   * @param strXML       XML文本数据
   * @return             True 成功，False 失败
   */
  public static boolean IsSucceed(String strXML)
  {
    try
    {
      Document doc = XmlFunc.CreateNewDoc(strXML);
      return IsSucceed(doc);
    }
    catch(Exception e)
    {
      return false;
    }
  }
  
  /**
   * 判断调用组件执行是否成功
   * @param doc   Document对象
   * @return    True 成功，False 失败
   */
  public static boolean IsSucceed(Document doc)
  {
	  try
	    {
	      String strRet = XmlFunc.getNodeValue(doc, Common.XDOC_ERRORINFO + Common.BAR + Common.XDOC_ERRORRESULT);
	      if(strRet != null)
	      {
	        if(strRet.equals(Common.SRT_SUCCESS) || strRet.equals(Common.RT_QUERY_SUCCESS))
	          return true;
	        else
	          return false;
	      }
	      else
	      {
	        return false;
	      }
	    }
	    catch(Exception e)
	    {
	      return false;
	    }
  }
  
  /**
   * 获得调用查询组件的返回结果
   * @param strXML       XML文本数据
   * @return String      返回String
   *                     00 - 表示查询成功
   *                     01 - 表示查询成功,但记录为空
   */
  public static String getQueryResult(String strXML)
  {
    try
    {
      String strRet;
      Document doc = XmlFunc.CreateNewDoc(strXML);

      strRet = XmlFunc.getNodeValue(doc, Common.XDOC_ERRORINFO + Common.BAR + Common.XDOC_ERRORRESULT);

      if(strRet == null) strRet = "99";

      return strRet;
    }
    catch(Exception e)
    {
      return "99";
    }
  }
  
  /**
   * 设置查询页数属性
   * @param strXML              XML文本数据
   * @param intPageSize         页的大小
   * @param intCurrentPage      当前页数
   * @return                    String
   */
  public static String setQueryPageInfo(String strXML,String intPageSize,String intCurrentPage)
  {
    try
    {
      Document doc = XmlFunc.CreateNewDoc(strXML);

      XmlFunc.setAttrValue(doc,Common.XDOC_QUERYCONDITION, Common.XML_PROP_RECORDSPERPAGE, intPageSize);
      XmlFunc.setAttrValue(doc,Common.XDOC_QUERYCONDITION, Common.XML_PROP_CURRENTPAGENUM, intCurrentPage);

      return doc.asXML();
    }
    catch(Exception e)
    {
      return strXML;
    }
  }
 
  /**
   * 设置查询页数属性
   * @param strXML              XML文本数据
   * @param intPageSize         页的大小
   * @param intCurrentPage      当前页数
   * @return                    String
   */
  public static String setQueryPageInfo(String strXML,int intPageSize,int intCurrentPage)
  {
    try
    {
      Document doc = XmlFunc.CreateNewDoc(strXML);
      XmlFunc.setAttrValue(doc,Common.XDOC_QUERYCONDITION, Common.XML_PROP_RECORDSPERPAGE, String.valueOf(intPageSize));
      XmlFunc.setAttrValue(doc,Common.XDOC_QUERYCONDITION, Common.XML_PROP_CURRENTPAGENUM, String.valueOf(intCurrentPage));
      return doc.asXML();
    }
    catch(Exception e)
    {
      return strXML;
    }
  }  
  
  /**
   * 获得一个默认的提交数据Document对象
   * @return Document    Document对象
   */
  public static Document getDefaultXML()
  {
    try
    {
      String strXML = Common.XML_HEADINFO +
                    "<"  + Common.XDOC_ROOT + " efsframe='" + Common.PVAL_SOURCE + "' version='" + Common.PVAL_VERSION + "'>" +
                    "</" + Common.XDOC_ROOT + ">";
      return XmlFunc.CreateNewDoc(strXML);
    }
    catch(Exception e)
    {
      return null;
    }
  }
  
  /**
   * 设置提交给组件的 XML 字符串
   * @param strDataInfo         数据字符串
   * @param userSession         登录用户Session
   * @return                    拼接完成之后的XML 文档字符串
   */
  public static String setDocXML(String strDataInfo,
                                 UserLogonInfo userSession)
  {
    try
    {
      Document doc = getDefaultXML();
      String nodePath = Common.XDOC_ROOT;
      XmlFunc.setNodeDOM(doc,nodePath,strDataInfo);
      
      // 设置用户节点
      String strNodeData = "<USERINFO><USERID>"     + userSession.getUserID() + 
                           "</USERID><USERTITLE>"   + userSession.getUserTitle() + 
                           "</USERTITLE><USERNAME>" + userSession.getUserName() + 
                           "</USERNAME><UNITID>"    + userSession.getUnitID() + 
                           "</UNITID><UNITNAME>"    + userSession.getUnitName() + 
                           "</UNITNAME><MTYPE>"     + userSession.getMUnitType() +
                           "</MTYPE><LOGID>"        + userSession.getLogID() +
                           "</LOGID><USERTYPE>"     + userSession.getUserType() + 
                           "</USERTYPE></USERINFO>";
      nodePath = Common.XDOC_ROOT;

      XmlFunc.setNodeDOM(doc,nodePath,strNodeData);
            
      return doc.asXML();
    }
    catch(Exception e)
    {
      return null;
    }
  }
  
  
  /**
   * 获得调用组件失败的描述
   * @param strXML   标准返回XML文档字符串
   * @return String 错误描述信息
   */
  public static String getErrInfo(String strXML)
  {
    try
    {
      Document doc = XmlFunc.CreateNewDoc(strXML);
      return getErrInfo(doc);
    }
    catch(Exception e)
    {
      return "";
    }
  }
 
  /**
   * 获得调用组件失败的描述
   * @param doc     标准返回XML文档对象
   * @return String 错误描述信息
   */  
  public static String getErrInfo(Document doc)
  {
    try
    {
      String nodePath = Common.XDOC_ROOT + Common.BAR + Common.XDOC_ERRORINFO + Common.BAR + Common.XDOC_FUNCERROR;
      return XmlFunc.getNodeValue(doc, nodePath);
    }
    catch(Exception e)
    {
      return "";
    }
  }
  
  /**
   * 获得查询返回的 XML 结构中的总页数
   * @param strXML  标准查询返回XML文档字符串
   * @return int 页总数
   */
  public static int getTotalPages(String strXML)
  {
    try
    {
      Document doc = XmlFunc.CreateNewDoc(strXML);
      return getTotalPages(doc);
    }
    catch(Exception e)
    {
      return 0;
    }
  }

  /**
   * 获得查询返回的 XML 结构中的总页数
   * @param doc  标准查询返回XML文档对象
   * @return int 页总数
   */  
  public static int getTotalPages(Document doc)
  {
    try
    {
      String nodePath = Common.XDOC_ROOT + Common.BAR + Common.XDOC_QUERYINFO;
      String str_Ret = XmlFunc.getAttrValue(doc,nodePath, Common.XML_PROP_TOTALPAGES);
      if(General.empty(str_Ret))
    	  return 0;
      else
        return Integer.parseInt(str_Ret);
    }
    catch(Exception e)
    {
      return 0;
    }
  }
  
  /**
   * 获得查询返回的 XML 结构中的总记录数 
   * @param strXML 标准查询返回XML文档字符串
   * @return int 总记录数
   */
  public static int getRecords(String strXML)
  {
    try
    {
      Document doc = XmlFunc.CreateNewDoc(strXML);
      return getRecords(doc);
    }
    catch(Exception e)
    {
      return 0;
    }
  }
  
  /**
   * 获得查询返回的 XML 结构中的总记录数 
   * @param doc  标准查询返回XML文档对象
   * @return int 总记录数
   */  
  public static int getRecords(Document doc)
  {
    try
    {
      String nodePath = Common.XDOC_ROOT + Common.BAR + Common.XDOC_QUERYINFO;
      String str_Ret = XmlFunc.getAttrValue(doc,nodePath, Common.XML_PROP_RECORDS);
      if(General.empty(str_Ret))
    	  return 0;
      else
        return Integer.parseInt(str_Ret);
    }
    catch(Exception e)
    {
      return 0;
    }
  }
  
  /**
   * 获得一个随机数
   * @return String 随机数
   */
  public static String getRandom()
  {
    String str_Month = String.valueOf(DateTimeUtil.getCurrentMonth());
    String str_Day = String.valueOf(DateTimeUtil.getCurrentDay());
    String str_Hour = String.valueOf(Calendar.getInstance().get(Calendar.HOUR));
    String str_Minute = String.valueOf(Calendar.getInstance().get(Calendar.MINUTE));
    String str_Second = String.valueOf(Calendar.getInstance().get(Calendar.SECOND));
    String str_RandNum =String.valueOf((int)(Math.random() * 10000));
    String str_Rand = str_Month + str_Day + str_Hour + str_Minute + str_Second + str_RandNum;
    return str_Rand;
  }
  
  
  
  /**
   * 使用XSLT格式化转换XML数据为HTML字符串
   * @param strXML              被格式化的xml文档字符
   * @param strXSLTPath         引用的xslt文档路径
   * @return String             格式化完成之后的HTML字符串
   */
  public static String strXML2Html(String strXML, String strXSLTPath)
  {
    try
    {
    	Document doc = XmlFunc.CreateNewDoc(strXML);

      return strXML2Html(doc,strXSLTPath);
    }
    catch(Exception e)
    {
      e.printStackTrace();
      return null;
    }
  }
  /**
   * 使用XSLT格式化转换XML数据为HTML字符串
   * @param doc                 被格式化的xml文档对象
   * @param strXSLTPath         引用的xslt文档路径
   * @return String             格式化完成之后的HTML字符串
   */
  public static String strXML2Html(Document doc, String strXSLTPath)
  {
    try
    {
      TransformerFactory factory = TransformerFactory.newInstance();
      Transformer transformer = factory.newTransformer(new StreamSource(strXSLTPath));
        
      // now lets style the given document
      DocumentSource source = new DocumentSource(doc);
      DocumentResult result = new DocumentResult();

      transformer.transform(source,result);
      // return the transformed document
      Document transformedDoc = result.getDocument();

      String strXML = transformedDoc.asXML();
      int iIndex = 0;
      while((iIndex = strXML.indexOf("<TEXTAREA",iIndex))!=-1)
      {
         
        int i = strXML.indexOf("/>",iIndex);
        iIndex = i;
        if(i==-1) break;
        String sTemp1 = strXML.substring(0,i);
        String sTemp2 = strXML.substring(i+2);
        strXML = sTemp1 + "></TEXTAREA>" + sTemp2;
      }
      iIndex = 0;
      while((iIndex = strXML.indexOf("<SCRIPT",iIndex))!=-1)
      {
         
        int i = strXML.indexOf("/>",iIndex);
        iIndex = i;
        if(i==-1) break;
        String sTemp1 = strXML.substring(0,i);
        String sTemp2 = strXML.substring(i+2);
        strXML = sTemp1 + "></SCRIPT>" + sTemp2;
      }
      return strXML;
    }
    catch(Exception e)
    {
      e.printStackTrace();
      return null;
    }
  }
  

  /**
   * 将本地unicode编码的文件加载，转化为字符串
   * @param strLocalPath        文件路径
   * @return                    String字符串
   */
  public static String loadLocalFileToStr(String strLocalPath)
  {
    try
    {
      String strRet = "";
      FileInputStream in = new FileInputStream(strLocalPath);
      
      int size = in.available();
      byte bt[] = new byte[size];
      while((in.read(bt,0,size)!=-1)&&(size>0))
      {
        strRet = new String(bt, "Unicode");
      }
      return strRet;
    }
    catch(Exception e)
    {
      e.printStackTrace();
      return "";
    }
  }
  
  
/*
 * 生成一个查询子条件
 * @param strFiledName  字段名
 * @param strOperation  操作符
 * @param strValue      值
 * @return Document     Document对象
 */  
  public static Document makeCondition(String strFiledName,
                                       String strOperation,
                                       String strValue)
  {
    
    String strXML = "<CONDITION alias='' datatype=''>" +
                    "<FIELDNAME>" + strFiledName + "</FIELDNAME>" +
                    "<OPERATION>" + strOperation + "</OPERATION>" +
                    "<VALUE>" + strValue + "</VALUE>" +
                    "</CONDITION>";
    Document doc = null;
    try
    {
       doc = DocumentHelper.parseText(strXML);
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
    return doc;
  }
  
 /*
 * 增加一个查询条件组
 * @param strType
 * @param xmlCon1
 * @param xmlcon2
 * @return Document
 */  
  public static Document addConditionItem(String strType,
                                          Document xmlCon1,
                                          Document xmlcon2)
  {
    String strXML = "<CONDITIONS>" +
                    "<TYPE>" + strType + "</TYPE>" +
                    "</CONDITIONS>";
    Document doc = null;
    try
    {
       doc = DocumentHelper.parseText(strXML);
       if(xmlCon1!=null)
       {
         doc.getRootElement().add(xmlCon1.getRootElement());
       }
       if(xmlcon2!=null)
       {
         doc.getRootElement().add(xmlcon2.getRootElement());
       }
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
    return doc;
  }
  
  /*
   * 构造标准查询XML文档字符串
   */
  public static Document makeQueryCondition(String strPredicate,Document xmlCon)
  {
    String strXML = "<?xml version='1.0'?>" +
             "<" + Common.XDOC_ROOT + " efsframe='" + Common.PVAL_SOURCE + "' version='" + Common.PVAL_VERSION + "'>" +
             "<QUERYCONDITION>" +
             "<PREDICATE>" + strPredicate + "</PREDICATE>" +
             "</QUERYCONDITION>" +
             "</" + Common.XDOC_ROOT + ">";
    Document doc = null;
    try
    {
       doc = DocumentHelper.parseText(strXML);
       if(xmlCon!=null)
       {
         doc.getRootElement().element("QUERYCONDITION").add(xmlCon.getRootElement());
       }
       
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
    return doc;
  }
  

}
