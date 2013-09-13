package org.ptbank.base;

import java.util.*;

import org.dom4j.*;
import org.ptbank.declare.*;



public class DataDoc implements java.io.Serializable
{
  private static final long serialVersionUID = 5208375922929537616L;
  
  private Document m_doc_Self = null;

  /**
   * 实例初始化
   * @param objDoc          Document  XML 文档对象
   */
  public DataDoc(Document objDoc) throws Exception
  {
    m_doc_Self = objDoc;
  }

  /**
   * 实例初始化
   * @param strXML          XML 文档字符串
   */
  public DataDoc(String strXML) throws Exception
  {
    this(DocumentHelper.parseText(strXML));
  }

  /**
   * 实例初始化，默认的根节点
   */
  public DataDoc() throws Exception
  {
    this(Common.XML_HEADINFO + "<" + Common.XDOC_ROOT + "/>");
    
    Element ele_root = m_doc_Self.getRootElement();

    ele_root.addAttribute(Common.XML_PROP_SOURCE, Common.PVAL_SOURCE);
    ele_root.addAttribute(Common.XML_PROP_VERSION, Common.PVAL_VERSION);
  }
  
  /**
   * 获得数据节点下指定节点名称的节点组数目
   * @param strNodeName     节点名称
   * @return int             数据节点下的指定节点名称的节点组数目
   */
  public int getDataNum(String strNodeName)
  {
    List list = m_doc_Self.selectNodes(Common.XDOC_ROOT     + Common.BAR +
                                  Common.XDOC_DATAINFO + Common.BAR + strNodeName);

    return list.size();
  }

  /**
   * 获得查询返回节点下指定节点名称的节点组数目
   * @param strNodeName     节点名称
   * @return int             查询节点下的指定节点名称的节点组数目
   */
  public int getQueryNum(String strNodeName)
  {
    List list = m_doc_Self.selectNodes(Common.XDOC_ROOT      + Common.BAR +
                                       Common.XDOC_QUERYINFO + Common.BAR + strNodeName);

    return list.size();
  }

  /**
   * 获得数据节点下指定节点的内容
   * @param strNodeName     节点名称
   * @return String          数据节点下指定节点的内容
   */
  public String getDataValue(String strNodeName)
  {
    return XmlFunc.getNodeValue(m_doc_Self,
                                Common.XDOC_ROOT     + Common.BAR +
                                Common.XDOC_DATAINFO + Common.BAR + strNodeName);
  }

  /**
   * 获得用户信息节点下指定节点的内容
   * @param strNodeName     节点名称
   * @return String          用户信息节点下指定节点的内容
   */
  public String gettUserValue(String strNodeName)
  {
    return XmlFunc.getNodeValue(m_doc_Self,
                                Common.XDOC_ROOT     + Common.BAR +
                                Common.XDOC_USERINFO + Common.BAR + strNodeName);
  }

  /**
   * 获得事务信息节点下指定节点的内容
   * @param strNodeName     节点名称
   * @return String          事务信息节点下指定节点的内容
   */
  public String getAffairEventValue(String strNodeName)
  {
    return XmlFunc.getNodeValue(m_doc_Self,
                                Common.XDOC_ROOT        + Common.BAR +
                                Common.XDOC_AFFAIREVENT + Common.BAR + strNodeName);
  }

  /**
   * 设置数据节点下指定节点的内容
   * @param strNodeName     节点名称
   * @param strValue        待设置的节点内容
   * @return boolean         是否设置成功
   */
  public boolean setDataValue(String strNodeName, String strValue)
  {
    try
    {
      if (!strNodeName.startsWith(Common.BAR2))
        strNodeName = Common.XDOC_ROOT + Common.BAR + Common.XDOC_DATAINFO + Common.BAR + strNodeName;

      Node nod_Temp = m_doc_Self.selectSingleNode(strNodeName);

      nod_Temp.setText(strValue);

      return true;
    }
    catch(Exception e)
    {
      return false;
    }
  }

  /**
   * 获得数据节点下指定节点（节点组）的内容
   * @param strNodeName     节点名称
   * @param intIndex        节点的索引
   * @return String          数据节点下指定节点的内容
   */
  public String getDataValue(String strNodeName, int intIndex)
  {
     return XmlFunc.getNodeValue(m_doc_Self,
                                 Common.XDOC_ROOT     + Common.BAR +
                                 Common.XDOC_DATAINFO + Common.BAR + strNodeName,
                                 intIndex);
  }

  /**
   * 获得用户信息节点
   * @return Node            用户信息节点
   */
  public Node getUserNode()
  {
     return XmlFunc.getNode(m_doc_Self,
                            Common.XDOC_ROOT + Common.BAR + Common.XDOC_USERINFO);
  } 

  /**
   * 获得数据信息根节点
   * @return Node            数据信息根节点
   */
  public Node getDataRootNode()
  {
     return XmlFunc.getNode(m_doc_Self,
                            Common.XDOC_ROOT + Common.BAR + Common.XDOC_DATAINFO);
  } 
  
  /**
   * 获得事务信息节点
   * @return Node            事务信息节点
   */
  public Node getAffairEventNode()
  {
     return XmlFunc.getNode(m_doc_Self,
                            Common.XDOC_ROOT + Common.BAR + Common.XDOC_AFFAIREVENT);
  } 

  /**
   * 获得数据节点下的节点
   * @param strNodeName     节点名称
   * @return Node            XML 节点
   */
  public Node getDataNode(String strNodeName)
  {
    return XmlFunc.getNode(m_doc_Self,
                           Common.XDOC_ROOT     + Common.BAR +
                           Common.XDOC_DATAINFO + Common.BAR + strNodeName,
                           0);
  }

  /**
   * 获得数据节点下的节点
   * @param strNodeName     节点名称
   * @param intIndex        节点的索引
   * @return Node            XML 节点
   */
  public Node getDataNode(String strNodeName, int intIndex)
  {
    return XmlFunc.getNode(m_doc_Self,
                           Common.XDOC_ROOT     + Common.BAR +
                           Common.XDOC_DATAINFO + Common.BAR + strNodeName,
                           intIndex);
  }

  /**
   * 获得查询节点下的节点
   * @param strNodeName     节点名称
   * @return Node            XML 节点
   */
  public Node getQueryNode(String strNodeName)
  {
    return XmlFunc.getNode(m_doc_Self,
                           Common.XDOC_ROOT      + Common.BAR +
                           Common.XDOC_QUERYINFO + Common.BAR + strNodeName,
                           0);
  }

  /**
   * 获得查询节点下的节点
   * @param strNodeName     节点名称
   * @param intIndex        节点的索引
   * @return Node            XML 节点
   */
  public Node getQueryNode(String strNodeName,int intIndex)
  {
    return XmlFunc.getNode(m_doc_Self,
                           Common.XDOC_ROOT      + Common.BAR +
                           Common.XDOC_QUERYINFO + Common.BAR + strNodeName,
                           intIndex);
  }

  /**
   * 获得数据节点下的节点组
   * @param strNodeName     节点名称
   * @return List            XML 节点组
   */
  public List getDataNodeList(String strNodeName)
  {
    return m_doc_Self.selectNodes(Common.XDOC_ROOT     + Common.BAR +
                                  Common.XDOC_DATAINFO + Common.BAR + strNodeName);
  }

  /**
   * 获得查询节点下的节点组
   * @param strNodeName     节点名称
   * @return List            XML 节点组
   */
  public List getQueryNodeList(String strNodeName)
  {
    return m_doc_Self.selectNodes(Common.XDOC_ROOT      + Common.BAR +
                                  Common.XDOC_QUERYINFO + Common.BAR + strNodeName);
  }

  /**
   * 在文档根节点下添加一个子节点
   *        在本函数中，如果原来已经存在同名节点，则会删除原节点
   *        例如：<EFSFRAME>
   *                 xnodInfo                             * 将该节点添加到文档根节点中
   *              </EFSFRAME>
   * @param xnodInfo         待插入节点
   * @return boolean         是否成功
   */
  public boolean addNode(Node xnodInfo) throws Exception
  {
    try
    {
      Element ele_Root = m_doc_Self.getRootElement();

      if (ele_Root==null) return false;

      String str_NodeName = xnodInfo.getName();

      Node ele_Temp = null;

      /// 检查同名节点是否存在，如果存在，则删除之
      if ((ele_Temp=getDataNode(str_NodeName.toUpperCase()))!=null)
      {
        ele_Root.remove(ele_Temp);
      }

      ele_Root.add(xnodInfo);

      return true;
    }
    catch(Exception e)
    {
      return false;
    }
  }

  /**
   * 在文档数据节点下添加一个 SQL 脚本的子节点
   *        例如：<EFSFRAME>
   *                <DATAINFO>
   *                  <SQLSCRIPT operation="5"/>          * 将该节点添加到文档根节点中
   *                </DATAINFO>
   *              </EFSFRAME>
   * @param strSQL          待插入节点的 SQL 语句
   * @return boolean         是否成功
   */
  public boolean addSQLScript(String strSQL)
  {
    try
    {
      Element ele_DataInfo = XmlFunc.getNodeElement(m_doc_Self,
                                                    Common.XDOC_ROOT + Common.BAR + Common.XDOC_DATAINFO);

      if(ele_DataInfo==null) return false;

      Element ele_Script = DocumentHelper.createElement(Common.XDOC_SQLSCRIPT);

      ele_Script.setText(strSQL);
      ele_Script.addAttribute(Common.XML_PROP_OPERATION, Common.DT_SQLSCRIPT);

      ele_DataInfo.add(ele_Script);

      return true;
    }
    catch(Exception e)
    {
      return false;
    }
  }

  /**
   * 在文档数据节点下添加一个子节点
   *        在本函数中，如果原来已经存在同名节点，则会删除原节点
   *        例如：<EFSFRAME>
   *                <DATAINFO>
   *                  xnodInfo                            * 将该节点添加到文档根节点中
   *                </DATAINFO>
   *              </EFSFRAME>
   * @param xnodInfo        待插入节点
   * @return boolean         是否成功
   */
  public boolean addNodeToDataInfo(Node xnodInfo) throws Exception
  {
    try
    {
      Element ele_DataInfo = XmlFunc.getNodeElement(m_doc_Self,
                                                    Common.XDOC_ROOT + Common.BAR + Common.XDOC_DATAINFO);

      if (ele_DataInfo==null) return false;

      String str_NodeName = xnodInfo.getName();
          
      Node ele_Temp = null;

      if ((ele_Temp=getDataNode(str_NodeName))!=null)
      {
        ele_DataInfo.remove(ele_Temp);
      }

      ele_DataInfo.add(xnodInfo);

      return true;
    }
    catch(Exception e)
    {
      return false;
    }
  }

  /**
   * 在文档根节点下的指定子节点下添加一个子节点
   *        在本函数中，如果原来已经存在同名节点，则会删除原节点
   *        例如：<EFSFRAME>
   *                <strParentName>
   *                  xnodInfo                            * 将该节点添加到文档根节点中
   *                </strParentName>
   *              </EFSFRAME>
   * @param strParentName   上级节点名称
   * @param xnodInfo        待插入节点
   * @return boolean         是否成功
   */
  public boolean AddNodeTo(String strParentName, Node xnodInfo) throws Exception
  {
    try
    {
      Element ele_Data = XmlFunc.getNodeElement(m_doc_Self,
                                                Common.XDOC_ROOT + Common.BAR + strParentName.toUpperCase());

      if (ele_Data==null)
        throw new Exception("DataDoc.AddNodeTo.未找到指定的父节点[" + strParentName.toUpperCase() + "]");

      String str_NodeName = xnodInfo.getName();

      Node ele_Temp = null;

      if ((ele_Temp=XmlFunc.getNode(m_doc_Self,
                                    Common.XDOC_ROOT            + Common.BAR +
                                    strParentName.toUpperCase() + Common.BAR + str_NodeName))!=null)
      {
        ele_Data.remove(ele_Temp);
      }

      ele_Data.add(xnodInfo);

      return true;
    }
    catch(Exception e)
    {
      throw new Exception(e.getMessage());
    }
  }

  /**
   * 在文档根节点下创建数据节点
   *            如果数据节点不存在，创建
   *            如果数据节点存在，不创建
   * @return boolean         是否成功
   */
  public boolean createDataInfoNode()
  {
    try{
      List list = m_doc_Self.selectNodes(Common.XDOC_ROOT + Common.BAR + Common.XDOC_DATAINFO);

      int int_Size = list.size();

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
