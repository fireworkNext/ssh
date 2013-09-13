package org.ptbank.base;


import java.util.List;
import java.sql.*;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.ptbank.declare.Common;
import org.ptbank.func.General;


/**
 * 构建统一的标准业务操作返回XML字符串文档
 */
public class ReturnDoc implements java.io.Serializable
{
  private static final long serialVersionUID = 3682545988906963663L;
  private Document m_doc_Self = null;

  /**
   * 实例初始化
   * @param objDoc          Document  XML 文档对象
   */
  public ReturnDoc(Document objDoc) throws Exception
  {
    m_doc_Self = objDoc;
  }

  /**
   * 实例初始化
   * @param strXML          XML 文档字符串
   */
  public ReturnDoc(String strXML) throws Exception
  {
    this(DocumentHelper.parseText(strXML));
  }

  /**
   * 实例初始化
   */
  public ReturnDoc() throws Exception
  {
    this(Common.XML_HEADINFO + "<" + Common.XDOC_ROOT + "/>");

    Element ele_Root = m_doc_Self.getRootElement();

    ele_Root.addAttribute(Common.XML_PROP_SOURCE, Common.PVAL_SOURCE);
    ele_Root.addAttribute(Common.XML_PROP_VERSION, Common.PVAL_VERSION);
  }

  /**
   * 获得查询节点下节点组的数目
   * @param strNodeName     节点名称
   * @return int             查询节点下节点组的数目
   */
  public int getQueryNum(String strNodeName)
  {
    List lst_Temp = m_doc_Self.selectNodes(Common.XDOC_ROOT      + Common.BAR +
                                           Common.XDOC_QUERYINFO + Common.BAR + strNodeName);
    return lst_Temp.size();
  }

  /**
   * 获得错误信息节点下的错误描述节点的值
   * @param strNodeName      节点名称
   * @return String          节点的值
   */
  public String getErrorValue(String strNodeName)
  {
    return XmlFunc.getNodeValue(m_doc_Self,
                                Common.XDOC_ROOT      + Common.BAR +
                                Common.XDOC_ERRORINFO + Common.BAR + strNodeName);
  }

  /**
   * 创建查询返回节点
   *            如果该节点不存在，创建;
   *            如果该节点存在，不创建
   * @return boolean         是否创建成功
   */
  public boolean createQueryInfoNode()
  {
    try
    {
      List lst_QueryInfo = m_doc_Self.selectNodes(Common.XDOC_ROOT + Common.BAR + Common.XDOC_QUERYINFO);

      int int_Size = lst_QueryInfo.size();

      if(int_Size==0)
      {
        Element ele = DocumentHelper.createElement(Common.XDOC_QUERYINFO);
        m_doc_Self.getRootElement().add(ele);
      }

      return true;
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }

    return false;
  }

  public boolean addQueryInfoNode()
  {
    return createQueryInfoNode();
  }

  /**
   * 创建错误返回节点
   *            如果该节点不存在，创建;
   *            如果该节点存在，不创建
   * @return boolean         是否创建成功
   */
  public boolean createErrorInfoNode()
  {
    try
    {
      List lst_ErrorInfo = m_doc_Self.selectNodes(Common.XDOC_ROOT + Common.BAR + Common.XDOC_ERRORINFO);

      int int_Size = lst_ErrorInfo.size();

      if(int_Size==0)
      {
        Element ele_ErrorInfo = DocumentHelper.createElement(Common.XDOC_ERRORINFO);
        m_doc_Self.getRootElement().add(ele_ErrorInfo);
      }
      return true;
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
    return false;
  }

  public boolean addErrorInfoNode()
  {
    return createErrorInfoNode();
  }

  /**
   * 获得查询节点
   * @return Node            查询节点
   */
  public Node getQueryInfoNode()
  {
    return XmlFunc.getNode(m_doc_Self,
                           Common.XDOC_ROOT + Common.BAR + Common.XDOC_QUERYINFO);
  }

  /**
   * 在错误信息节点下添加子节点
   *            如果该节点不存在，则需要创建该节点，并赋值
   *            如果该节点存在，则更新该节点的值
   * @param strNodeName      节点名称
   * @param strResult        节点值
   * @return boolean         是否创建成功
   */
  public boolean setErrorNodeChild(String strNodeName, String strResult) throws Exception
  {
    try
    {
      if (!createErrorInfoNode())
        throw new Exception("ReturnDoc.setErrorNodeChild.创建返回节点时发生错误");

      Node nod_Temp = XmlFunc.getNode(m_doc_Self,
                                      Common.XDOC_ROOT + Common.BAR + Common.XDOC_ERRORINFO);

      if (nod_Temp==null)
        throw new Exception("ReturnDoc.setErrorNodeChild.获取错误根节点时发生错误");

      Node nod_Child = XmlFunc.getNode(m_doc_Self,
                                       Common.XDOC_ROOT      + Common.BAR +
                                       Common.XDOC_ERRORINFO + Common.BAR + strNodeName);

      if (nod_Child==null)
      {
        Node nod_Temp2 = DocumentHelper.createElement(strNodeName);
        nod_Temp2.setText(strResult);
        ((Element)nod_Temp).add(nod_Temp2);
      }
      else
      {
        nod_Child.setText(String.valueOf(strResult));
      }
      return true;
    }
    catch(Exception e)
    {
      throw new Exception(e.getMessage());
    }
  }

  /**
   * 在错误信息节点下添加错误返回值
   *            如果该节点不存在，则需要创建该节点，并赋值
   *            如果该节点存在，则更新该节点的值
   * @param strResult        节点值
   * @return boolean         是否创建成功
   */
  public boolean setErrorResult(String strResult) throws Exception
  {
    return setErrorNodeChild(Common.XDOC_ERRORRESULT, strResult);
  }

  /**
   * 在错误信息节点下添加错误返回值
   *            如果该节点不存在，则需要创建该节点，并赋值
   *            如果该节点存在，则更新该节点的值
   * @param strResult       节点值
   * @return boolean         是否创建成功
   */
  public boolean addErrorResult(String strResult) throws Exception
  {
    return setErrorResult(strResult);
  }

  /**
   * 在错误信息节点下添加错误返回值
   *            如果该节点不存在，则需要创建该节点，并赋值
   *            如果该节点存在，则更新该节点的值
   * @param intResult       节点值
   * @return boolean         是否创建成功
   */
  public boolean setErrorResult(int intResult) throws Exception
  {
    return setErrorResult(String.valueOf(intResult));
  }

  /**
   * 在错误信息节点下添加错误返回值
   *            如果该节点不存在，则需要创建该节点，并赋值
   *            如果该节点存在，则更新该节点的值
   * @param intResult       节点值
   * @return boolean         是否创建成功
   */
  public boolean addErrorResult(int intResult) throws Exception
  {
    return setErrorResult(intResult);
  }

  /**
   * 在错误信息节点下添加错误返回描述
   *            如果该节点不存在，则需要创建该节点，并赋值
   *            如果该节点存在，则更新该节点的值
   * @param strResult         节点值
   * @return boolean         是否创建成功
   */
  public boolean setFuncErrorInfo(String strResult) throws Exception
  {
    return setErrorNodeChild(Common.XDOC_FUNCERROR, strResult);
  }

  /**
   * 在错误信息节点下添加错误返回描述
   *            如果该节点不存在，则需要创建该节点，并赋值
   *            如果该节点存在，则更新该节点的值
   * @param strResult        节点值
   * @return boolean         是否创建成功
   */
  public boolean addFuncErrorInfo(String strResult) throws Exception
  {
    return setFuncErrorInfo(strResult);
  }

  /**
   * 将查询返回的结果集拼装成需要的 XML 的结构
   * @param rst             返回的结果集
   * @return boolean         是否成功
   */
  public boolean getQueryInfo(ResultSet rst) throws Exception
  {
    return getQueryInfo(rst, Common.XDOC_ROW);
  }

  /**
   * 将查询返回的结果集拼装成需要的 XML 的结构
   * @param rst             返回的结果集
   * @param strNodeName     QUERY 子节点下的节点名称
   * @return boolean         是否成功
   */
  public boolean getQueryInfo(ResultSet rst, String strNodeName) throws Exception
  {
    try
    {
      strNodeName = General.empty(strNodeName) ? Common.XDOC_ROW : strNodeName;

      if (!createQueryInfoNode())
        throw new Exception("ReturnDoc.getQueryInfo.创建查询返回节点时发生错误");

      Element ele_Query = XmlFunc.getNodeElement(m_doc_Self, Common.XDOC_ROOT + Common.BAR + Common.XDOC_QUERYINFO);

      if (ele_Query==null)
        throw new Exception("ReturnDoc.getQueryInfo.获得查询返回节点时发生错误");

      boolean bln_HasData = false;

      while (rst.next())
      {
        Element ele_Row = DocumentHelper.createElement(strNodeName);

        for(int i=1; i<rst.getMetaData().getColumnCount()+1; i++)
        {
          int int_Type = rst.getMetaData().getColumnType(i);
          String str_File = "";
          Element ele_Node = DocumentHelper.createElement(rst.getMetaData().getColumnName(i).toUpperCase());

          switch(int_Type)
          {
            case Types.BLOB:
            case Types.BINARY:
              Blob blob = rst.getBlob(i);

              /// 将二进制类型转换为 16 进制编码输出
              if (blob!=null)
              {
                byte[] byt_Temp = new byte[(int)(blob.length())];
                byt_Temp = blob.getBytes(1, byt_Temp.length);
                str_File = General.byte2hex(byt_Temp);
              } /// if (blob!=null)

              ele_Node.setText(str_File);
              break;
            case Types.DATE:
              str_File =rst.getString(i);
           	  if(!General.empty(str_File))
           	  {
   	        	 String sv = General.cDateStr(str_File);
   	        	 ele_Node.setText(str_File);
   	        	 ele_Node.addAttribute("sv",sv);
           	  }
           	  else
           	  {
           		 ele_Node.setText(""); 
           	  }
            default:
              ele_Node.setText(rst.getString(i)==null ? "" : rst.getString(i));

          } /// switch(int_Type)

          ele_Row.add(ele_Node);
        }

        ele_Query.add(ele_Row);
        bln_HasData = true;
      }

      return bln_HasData;
    }
    catch(Exception e)
    {
      throw new Exception(e.getMessage());
    }
  }

  /**
   * 在查询返回数据中，针对某个具体的行，插入一个节点
   *        例如：<EFSFRAME>
   *                <QUERYINFO>
   *                  <ROW>
   *                    <FLD1>FLD1</FLD1>
   *                    <FLD2>FLD2</FLD2>
   *                    <FLD3>FLD3</FLD3>
   *                  </ROW>
   *                </QUERYINFO>
   *              </EFSFRAME>
   * @param strNodeName     QUERY 子节点下的节点名称
   * @param strValue        节点值
   * @return boolean         是否成功
   */
  public boolean addRowToQuery(String strNodeName, String strValue) throws Exception
  {
    return addRowToQuery(strNodeName, strValue, 0);
  }

  /**
   * 在查询返回数据中，针对某个具体的行，插入一个节点
   *        例如：<EFSFRAME>
   *                <QUERYINFO>
   *                  <ROW>
   *                    <FLD1>FLD1</FLD1>
   *                    <FLD2>FLD2</FLD2>
   *                    <FLD3>FLD3</FLD3>
   *                  </ROW>
   *                </QUERYINFO>
   *              </EFSFRAME>
   * @param strNodeName     QUERY 子节点下的节点名称
   * @param strValue        节点值
   * @param intIndex        索引顺序号
   * @return boolean         是否成功
   */
  public boolean addRowToQuery(String strNodeName, String strValue, int intIndex) throws Exception
  {
    try
    {
      Element ele_Row = XmlFunc.getNodeElement(m_doc_Self, Common.XDOC_ROOT + Common.BAR +
                                                           Common.XDOC_QUERYINFO + Common.BAR + Common.XDOC_ROW, intIndex);

      Element ele_Node = DocumentHelper.createElement(strNodeName);

      ele_Node.setText(strValue);
      ele_Row.add(ele_Node);

      return true;
    }
    catch(Exception e)
    {
      throw new Exception(e.getMessage());
    }
  }

  /**
   * 在返回文档根节点下，插入一个节点
   *        例如：<EFSFRAME>
   *                xnodInfo                              * 将该节点添加到返回文档根节点中
   *              </EFSFRAME>
   * @param xnodInfo        待插入的节点
   * @return boolean         是否成功
   */
  public boolean addNode(Node xnodInfo) throws Exception
  {
    try
    {
      Element ele_Root = XmlFunc.getNodeElement(m_doc_Self, Common.XDOC_ROOT);

      if (ele_Root==null)
        throw new Exception("ReturnDoc.addNode.获取查询返回根节点时发生错误");

      ele_Root.add(xnodInfo);

      return true;
    }
    catch(Exception e)
    {
      throw new Exception(e.getMessage());
    }
  }

  /**
   * 向文档根节点中的下一级节点添加一个节点
   *        在本函数中，如果原来已经存在同名节点，则会删除原节点
   *        例如：<EFSFRAME>
   *                <parentName>
   *                  xnodInfo                            * 将该节点添加到返回文档根节点中
   *                </parentName> 
   *              </EFSFRAME>
   * @param strParentName   待插入的父节点的名称
   * @param xnodInfo        待插入的节点
   * @return boolean         是否成功
   */
  public boolean addNodeTo(String strParentName, Node xnodInfo) throws Exception
  {
    try
    {
      Element ele_Node = XmlFunc.getNodeElement(m_doc_Self,Common.XDOC_ROOT + Common.BAR + strParentName.toUpperCase());

      if (ele_Node==null)
        throw new Exception("ReturnDoc.addNodeTo.所添加的父节点为空");

      String str_NodeName = xnodInfo.getName();

      Node tempnode = null;

      if ((tempnode=XmlFunc.getNode(m_doc_Self, Common.XDOC_ROOT + Common.BAR + strParentName.toUpperCase() + Common.BAR + str_NodeName))!=null)
      {
        ele_Node.remove(tempnode);
      }

      ele_Node.add(xnodInfo);
      return true;
    }
    catch(Exception e)
    {
      throw new Exception(e.getMessage());
    }
  }

  /**
   * 向查询返回数据节点中，添加一个节点
   *        在本函数中，如果原来已经存在同名节点，则会删除原节点
   *        例如：<EFSFRAME>
   *                <QUERYINFO>
   *                  xnodInfo                            * 将该节点添加到返回文档根节点中
   *                 </QUERYINFO> 
   *              </EFSFRAME>
   * @param xnodInfo        待插入的节点
   * @return boolean         是否成功
   */
  public boolean addNodeToQueryInfo(Node xnodInfo) throws Exception
  {
    try
    {
      Element ele_Query = XmlFunc.getNodeElement(m_doc_Self, Common.XDOC_ROOT + Common.BAR + Common.XDOC_QUERYINFO);

      if(ele_Query==null)
        throw new Exception("ReturnDoc.addNodeToQueryInfo.获取查询返回根节点时发生错误");

      ele_Query.add(xnodInfo);

      return true;
    }
    catch(Exception e)
    {
      throw new Exception(e.getMessage());
    }
  }

  /**
   * 向查询返回数据节点中，添加属性
   *        在本函数中，如果原来已经存在同名节点，则会删除原节点
   *        例如：<EFSFRAME>
   *                <QUERYINFO> <--  PropInfo
   *                 </QUERYINFO> 
   *              </EFSFRAME>
   * @param strPropName     属性名称
   * @param strPropValue    属性值
   * @return boolean        是否成功
   */
  public boolean addPropToQueryInfo(String strPropName, String strPropValue) throws Exception
  {
    try
    {
      Element ele_Query = XmlFunc.getNodeElement(m_doc_Self, Common.XDOC_ROOT + Common.BAR + Common.XDOC_QUERYINFO);

      if (ele_Query==null)
        throw new Exception("ReturnDoc.addPropToQueryInfo.获取查询返回根节点时发生错误");

      ele_Query.addAttribute(strPropName,strPropValue);

      return true;
    }
    catch(Exception e)
    {
      throw new Exception(e.getMessage());
    }
  }

  /**
   * 创建数据节点
   *            如果该节点不存在，创建
   *            如果该节点存在，不创建
   *        例如：<EFSFRAME>
   *                <DATAINFO>                            * 数据节点
   *                 </DATAINFO> 
   *              </EFSFRAME>
   * @return boolean         是否成功
   */
  public boolean createDataInfoNode()
  {
    try
    {
      List lst_DataInfo = m_doc_Self.selectNodes(Common.XDOC_ROOT + Common.BAR + Common.XDOC_DATAINFO);

      int int_Size = lst_DataInfo.size();

      if (int_Size==0)
      {
        Element ele_DataInfo = DocumentHelper.createElement(Common.XDOC_DATAINFO);
        m_doc_Self.getRootElement().add(ele_DataInfo);
      }
      return true;
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
    return false;
  }

  /**
   * 在数据节点下添加新节点
   *        例如：<EFSFRAME>
   *                <DATAINFO>
   *                  <--  xnodInfo                       * 将该节点添加到返回文档根节点中
   *                 </DATAINFO> 
   *              </EFSFRAME>
   * @param xnodInfo        待插入的节点
   * @return boolean         是否成功
   */
  public boolean addNodeToDataInfo(Node xnodInfo) throws Exception
  {
    try
    {
      Element ele_DataInfo = XmlFunc.getNodeElement(m_doc_Self,Common.XDOC_ROOT + Common.BAR + Common.XDOC_DATAINFO);

      if (ele_DataInfo==null) return false;

      ele_DataInfo.add(xnodInfo);

      return true;
    }
    catch(Exception e)
    {
      return false;
    }
  }

  /**
   * 在数据节点下新属性
   *        例如：<EFSFRAME>
   *                <DATAINFO>
   *                  <--  xnodInfo                       * 将该节点添加到返回文档根节点中
   *                 </DATAINFO> 
   *              </EFSFRAME>
   * @param strPropName       属性名称
   * @param strPropValue       属性值
   * @return boolean         是否成功
   */
  public boolean addPropToDataInfo(String strPropName, String strPropValue) throws Exception
  {
    try
    {
      Element ele_DataInfo = XmlFunc.getNodeElement(m_doc_Self, Common.XDOC_ROOT + Common.BAR + Common.XDOC_DATAINFO);

      if (ele_DataInfo==null)
        throw new Exception("ReturnDoc.addPropToDataInfo.获取查询返回根节点时发生错误");

     ele_DataInfo.addAttribute(strPropName, strPropValue);

     return true;
   }
   catch(Exception e)
   {
     throw new Exception(e.getMessage());
   }
  }

  /**
   * 返回文档的 XML 字符串
   * @return String          文档的 XML 字符串
   */
  public String getXML() throws Exception
  {
    return m_doc_Self.asXML();
  }

  /**
   * 返回文档的XML文档对象
   * @return Document        文档的XML文档对象
   */
  public Document getDocument() throws Exception
  {
    return m_doc_Self;
  }
}
