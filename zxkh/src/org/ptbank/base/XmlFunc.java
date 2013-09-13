package org.ptbank.base;

/**
 * Document对象的处理函数
 * 将dom4j对Dom对象的处理进行简单封装，方便调用
 * @author enjsky
 */
import java.util.Iterator;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.ptbank.declare.Common;

public class XmlFunc
{
  /**
   * 将XML中用到的Path格式化为标准的格式
   * @param nodePath     原始的值
   * @return String      格式化之后的Path值
   */
 public static String formatNodePath(String nodePath)
  {
    String strTruePath;
    String strEnd,strBegin;
    strEnd = nodePath.substring(nodePath.length()-1,nodePath.length());
    strBegin = nodePath.substring(0,1);
    if(!strBegin.equals("/"))
      strBegin = "//";
    else
      strBegin = "";
    
    if(strEnd.equals("/"))
    {
      strTruePath = strBegin + nodePath.substring(0,nodePath.length()-1);
    }
    else
    {
      strTruePath = strBegin + nodePath;
    }
    return strTruePath;
  }
  
  
  /**
   * 创建一个Document对象
   * @param              strXml
   * @return             Document 对象
   * @throws             Exception
   */
  public static Document CreateNewDoc(String strXml) throws Exception
  {
    try
    {
      Document doc = DocumentHelper.parseText(strXml);
      return doc;
    }
    catch(Exception e)
    {      
      throw(new Exception("创建一个Document对象失败"));       
    }
  }
  
  /**
   * 获得DOM对象的跟节点     
   * @param doc            Document对象
   * @return               Element对象
   */
  public static Element getRootElement(Document doc)
  {
    return doc.getRootElement();
  }
  
  /**
   * 获得一个Dom对象的子节点组               
   * @param doc          Document对象
   * @param nodePath     Node的路径
   * @return             返回一个Iterator对象
   */
  public static Iterator getIterator(Document doc,String nodePath)
  {
    try
    {
      Element el = getNodeElement(doc,nodePath);
      Iterator itList = el.elementIterator();
      return itList;
    }
    catch(Exception e)
    {
      return null;
    }
  }

  /**
   * 获得一个Dom对象的子节点组           
   * @param doc          Document对象
   * @param nodePath     Node的路径
   * @param i            第i个节点
   * @return             返回一个Iterator对象
   */
  public static Iterator getIterator(Document doc,String nodePath,int i)
  {
    try
    {
      Element el = getNodeElement(doc,nodePath,i);
      Iterator itList = el.elementIterator();
      return itList;
    }
    catch(Exception e)
    {
      return null;
    }
  }

  /**
   * 获得一个Element对象的子节点组             
   * @param el           Element对象
   * @return             返回一个Iterator对象
   */
  public static Iterator getIterator(Element el)
  {
    try
    {
      Iterator itList = el.elementIterator();
      return itList;
    }
    catch(Exception e)
    {
      return null;
    }
  }

  /**
   * 获得一个Dom对象的子节点组           
   * @param doc          Document对象
   * @param nodePath     Node的路径
   * @return             返回一个Iterator对象数组
   */
  public static Iterator[] getIteratorArr(Document doc,String nodePath)
  {
    try
    {
      int nodeLen = doc.selectNodes(formatNodePath(nodePath)).size();
      Iterator[] itList = new Iterator[nodeLen];
      Element el;
      for(int i=0;i<nodeLen;i++)
      {
        el = getNodeElement(doc,nodePath,i);
        itList[i] = el.elementIterator();
      }  
      return itList;
    }
    catch(Exception e)
    {
      return null;
    }
  }
  
  
  /**
   * 获得一个Dom对象中对应节点的一个Element对象数组
   * @param doc          Document对象
   * @param nodePath     Node的路径
   * @return             Element对象数组
   */
  public static Element[] getNodeElementArr(Document doc,String nodePath)
  {
    try
    {
      int nodeLen = doc.selectNodes(formatNodePath(nodePath)).size();
      Element[] elArr = new Element[nodeLen];
      Node node;
      for(int i=0;i<nodeLen;i++)
      {
        node = getNode(doc,nodePath,i);
        elArr[i] = (Element)node;
      }  
      return elArr;
    }
    catch(Exception e)
    {
      return null;
    }
  }


  /**
   * 将一个Node对象数组转换为Element对象数组
   * @param nodeArr         Node对象数组
   * @return             Element对象数组
   */
  public static Element[] getNodeElementArr(Node[] nodeArr)
  {
    try
    {
      Element[] elArr = new Element[nodeArr.length];
      for(int i=0;i<nodeArr.length;i++)
      {
        elArr[i] = (Element)nodeArr[i];
      }
      return elArr;
    }
    catch(Exception e)
    {
      return null;
    }
  }
    

  /**
   * 将一个Node对象转换为Element对象
   * @param node         Node对象
   * @return             Element对象
   */
  public static Element getNodeElement(Node node)
  {
    try
    {
      return (Element)node;
    }
    catch(Exception e)
    {
      return null;
    }
  }
  
  
  /**
   * 获得一个Dom对象中对应节点的一个Element对象
   * @param doc          Document对象
   * @param nodePath     Node的路径
   * @return             Element对象
   */
  public static Element getNodeElement(Document doc,String nodePath)
  {
    try
    {
      Node node = getNode(doc,nodePath);
      return (Element)node;
    }
    catch(Exception e)
    {
      return null;
    }
  }
  
  
  /**
   * 获得一个Dom对象中对应节点的一个Element对象
   * @param doc          Document对象
   * @param nodePath     Node的路径
   * @param i            对应的第几个节点
   * @return             Element对象
   */
  public static Element getNodeElement(Document doc,String nodePath,int i)
  {
    try
    {
      Node node = getNode(doc,nodePath,i);
      return (Element)node;
    }
    catch(Exception e)
    {
      return null;
    }
  }

  
  /**
   * 获得一个Dom对象中对应节点的一个Node对象数组
   * @param doc          Document对象
   * @param nodePath     Node的路径
   * @return             Node对象数组
   */
  public static Node[] getNodeArr(Document doc,String nodePath)
  {
    try
    {
      int nodeLen = doc.selectNodes(formatNodePath(nodePath)).size();
      Node[] nodeArr = new Node[nodeLen];
      for(int i=0;i<nodeLen;i++)
      {
        nodeArr[i] = getNode(doc,nodePath,i);
      }  
      return nodeArr;
    }
    catch(Exception e)
    {
      return null;
    }
  }

  

  /**
   * 获得一个Dom对象中对应节点的一个Node对象
   * @param doc          Document对象
   * @param nodePath     Node的路径
   * @return             Node对象
   */
  public static Node getNode(Document doc,String nodePath)
  {
    try
    {
      String strTruePath = formatNodePath(nodePath);
      Node node = doc.selectSingleNode(strTruePath);
      return node;
    }
    catch(Exception e)
    {
      return null;
    }
  }
  
  /**
   * 获得一个Dom对象中对应节点的一个Node对象
   * @param doc          Document对象
   * @param nodePath     Node的路径
   * @param i            对应的第几个节点
   * @return             Node对象
   */
  public static Node getNode(Document doc,String nodePath,int i)
  {
    try
    {
      Node node = (Node)doc.selectNodes(nodePath).get(i);
      return node;
    }
    catch(Exception e)
    {
      return null;
    }
  }

  /**
   * 获得一个Node对象的值
   * @param node             Document对象
   * @return                 返回Node的值
   */
  public static String getNodeValue(Node node)
  {
    try
    {
      return node.getText();
    }
    catch(Exception e)
    {
      return "";
    }
  }
  
  /**
   * 获得一个Node对象下面的一个子节点的值
   * @param node             Document对象
   * @param childNodeName    子节点名称
   * @return                 返回子节点的值
   */
  public static String getNodeValue(Node node,String childNodeName)
  {
    try
    {
      return node.valueOf("@" + childNodeName);
    }
    catch(Exception e)
    {
      return "";
    }
  }
  
  
  /**
   * 获得一个Dom对象中对应节点的Value值，只查找到单个节点
   * @param doc          Document对象
   * @param nodePath     Node的路径
   * @return             返回节点值
   */
  public static String getNodeValue(Document doc,String nodePath)
  {
    try
    {
      Node node = getNode(doc,nodePath);
      return node.getText();
    }
    catch(Exception e)
    {
      return "";
    }
  }
  
  /**
   * 获得一个Dom对象中对应节点的Value值，只查找到单个节点
   * @param doc          Document对象
   * @param nodePath     Node的路径
   * @param i            对应的第几个节点
   * @return             返回节点值
   */
  public static String getNodeValue(Document doc,String nodePath,int i)
  {
    try
    {
      Node node = getNode(doc,nodePath,i);
      return node.getText();
    }
    catch(Exception e)
    {
      return "";
    }
    
  }

  /**
   * 获得一个Dom对象中对应节点下对应属性的值，只查找到单个节点
   * @param doc           Document对象
   * @param nodePath      Node的路径
   * @param attName       属性名称
   * @return              属性值
   */
  public static String getAttrValue(Document doc,String nodePath,String attName)
  {
    try
    {
      String strTruePath = formatNodePath(nodePath) + "/@" + attName;
      Node node = doc.selectSingleNode(strTruePath);
      return node.getText();
    }
    catch(Exception e)
    {
      return "";
    }
  }

  /**
   * 获得一个Dom对象中对应节点下对应属性的值
   * @param doc           Document对象
   * @param nodePath      Node的路径
   * @param attName       属性名称
   * @param i             第几个节点
   * @return              属性值
   */
  public static String getAttrValue(Document doc,String nodePath,String attName,int i)
  {
    try
    {
      String strTruePath = formatNodePath(nodePath) + "/@" + attName;
      Node node = (Node)doc.selectNodes(strTruePath).get(i);
      return node.getText();
    }
    catch(Exception e)
    {
      return "";
    }
  }
  
  /**
   * 获得一个Element对象中对应属性的值
   * @param el            Element对象
   * @param attName       属性名称
   * @return              属性值
   */
  public static String getAttrValue(Element el,String attName)
  {
    try
    {
      return el.attributeValue(attName);
    }
    catch(Exception e)
    {
      return "";
    }
  }
  
  /**
   * 设置一个Dom对象中对应节点下对应属性的值，只查找到单个节点，没有就创建
   * @param doc           Document对象
   * @param nodePath      Node的路径
   * @param attName       属性名称
   * @param attValue      属性值
   * @return              boolean 是否成功
   */
  public static boolean setAttrValue(Document doc,String nodePath,String attName,String attValue)
  {
    try
    {
        Element el = getNodeElement(doc,nodePath);
        if(el==null)
          return false;
        if(setAttrValue(el,attName,attValue))
          return true;
        else
          return false;
    }
    catch(Exception e)
    {
      return false;
    }
  }
  
  /**
   * 设置一个Dom对象中对应节点下对应属性的值，没有就创建
   * @param doc           Document对象
   * @param nodePath      Node的路径
   * @param attName       属性名称
   * @param attValue      属性值
   * @param index         节点索引
   * @return              boolean 是否成功
   */
  public static boolean setAttrValue(Document doc,String nodePath,String attName,String attValue,int index)
  {
    try
    {
        Element el = getNodeElement(doc,nodePath,index);
        if(el==null)
          return false;
        if(setAttrValue(el,attName,attValue))
          return true;
        else
          return false;
    }
    catch(Exception e)
    {
      return false;
    }
  }
  
  /**
   * 设置一个Element对象中对应属性的值
   * @param el            Element对象
   * @param attName       属性名称
   * @return              boolean 是否成功
   */
  public static boolean setAttrValue(Element el,String attName,String attValue)
  {
    try
    {
      // 不管Element有没有对应的属性都可以这样操作，有就赋值，没有就创建
      el.addAttribute(attName,attValue);
      return true;
    }
    catch(Exception e)
    {
      return false;
    }
  }

  /**
   * 删除一个Element对象中对应属性
   * @param ele           Element对象
   * @param attributeName 属性名
   * @return  boolean     是否成功
   */
  public static boolean  removeAttr(Element ele, String attributeName)
  {
    try
    {
      Attribute att = ele.attribute(attributeName);
      ele.remove(att);
      return true;
    }
    catch(Exception e)
    {
      return false;
    }
  }
  
  /**
   * 删除一个Document对象中指定节点下的对应属性
   * @param doc           Dom对象
   * @param nodePath      节点路径
   * @param attributeName 属性名
   * @return boolean      是否成功
   */
  public static boolean  removeAttr(Document doc,String nodePath, String attributeName)
  {
    try
    {
      Element ele = getNodeElement(doc,nodePath);
      return removeAttr(ele, attributeName);
    }
    catch(Exception e)
    {
      return false;
    }
  }
  
  /**
   * 删除一个Document对象中指定节点下的对应属性
   * @param doc           Dom对象
   * @param nodePath      节点路径
   * @param index         节点索引
   * @param attributeName 属性名
   * @return boolean      是否成功
   */
  public static boolean  removeAttr(Document doc,String nodePath,int index, String attributeName)
  {
    try
    {
      Element ele = getNodeElement(doc,nodePath,index);
      return removeAttr(ele, attributeName);
    }
    catch(Exception e)
    {
      return false;
    }
  }
  
  /**
   * 根据xPath 路径来创建重新构造Document对象，没有的节点自动创建
   * @param doc           Document对象
   * @param nodePath      xPath 路径
   * @return              boolean  是否成功
   */
  public static boolean createNodePath(Document doc,String nodePath)
  {
    try
    {
      String strTmpNodePath = nodePath.toUpperCase();
      Node node = getNode(doc,strTmpNodePath);
      if(node != null)
        return true;
      else
      {
        String strNodeArr[];
        strNodeArr = strTmpNodePath.split(Common.BAR);
        Element rootEle = getRootElement(doc);
        //A ~~~
        // 首先查找最上层节点，如果没有，就在根节点下面创建
        Element el = getNodeElement(doc,strNodeArr[0].toUpperCase()); 
        if(el==null)
        {
          Element ele = DocumentHelper.createElement(strNodeArr[0].toUpperCase());
          rootEle.add(ele);
        }
        // A ~~~
        
        // B~~~
        // 遍历所有的子节点，没有就创建
        for(int i=1;i<strNodeArr.length;i++)
        {
          if(strNodeArr[i] != null)
          {
            String strNodePathTmp = "";
            
            for(int j=0;j<i;j++)
            {
              strNodePathTmp = strNodePathTmp + strNodeArr[j].toUpperCase() + Common.BAR; 
            }
            
            // 得到指定节点
            el = getNodeElement(doc,strNodePathTmp + strNodeArr[i].toUpperCase());
            
            if(el==null)
            {
              el = getNodeElement(doc,strNodePathTmp);
              Element ele = DocumentHelper.createElement(strNodeArr[i].toUpperCase());
              el.add(ele);
            }
          }         
        }
        //B~~
      }
      return true;
    }
    catch(Exception e)
    {
      return false;
    }
  }
  
  /**
   * 设置Node对象的值
   * @param node          Node节点         
   * @param strValue      设定的节点值
   * @return boolean      是否成功
   */
  public static boolean setNodeValue(Node node,String strValue)
  {
    try
    {
      node.setText(strValue);
      return true;
    }
    catch(Exception e)
    {
      return false;
    }
  }
  
  /**
   * 设置Document对象中指定xPath路径节点的值
   * @param doc           Dom对象
   * @param nodePath      节点路径
   * @param strValue      节点值
   * @return boolean      是否成功
   */
  public static boolean setNodeValue(Document doc,String nodePath,String strValue)
  {
    try
    {
      createNodePath(doc,nodePath);
      Node node = getNode(doc,nodePath);
      node.setText(strValue);
      return true;
    }
    catch(Exception e)
    {
      return false;
    }
  }
  
  /**
   * 设置Document对象中指定xPath路径节点的值
   * @param doc           Dom对象
   * @param nodePath      节点路径
   * @param index         节点索引
   * @param strValue      节点值
   * @return boolean      是否成功
   */
  public static boolean setNodeValue(Document doc,String nodePath,int index,String strValue)
  {
    try
    {
      createNodePath(doc,nodePath);
      Node node = getNode(doc,nodePath,index);
      node.setText(strValue);
      return true;
    }
    catch(Exception e)
    {
      return false;
    }
  }
  
  /**
   * 删除Element对象中的一个子Element对象
   * @param parentEle     父Element对象
   * @param childEle      子Element对象
   * @return boolean      是否成功
   */
  public static boolean removeNode(Element parentEle, Element childEle)
  {
    try
    {
      parentEle.remove(childEle);
      return true;
    }
    catch(Exception e)
    {
      return false;
    } 
  }
  
  /**
   * 删除Document对象中的指定路径的子节点
   * @param doc           Dom对象
   * @param nodePath      节点路径
   * @return boolean      是否成功
   */
  public static boolean removeNode(Document doc, String nodePath)
  {
    try
    {
      Element childEle = getNodeElement(doc,nodePath);
      Element parentEle = childEle.getParent();
      return removeNode(parentEle,childEle);
    }
    catch(Exception e)
    {
      return false;
    } 
  }
  
  /**
   * 删除Document对象中的指定路径的子节点
   * @param doc           Dom对象
   * @param nodePath      节点路径
   * @param index         节点索引
   * @return boolean      是否成功
   */
  public static boolean removeNode(Document doc, String nodePath,int index)
  {
    try
    {
      Element childEle = getNodeElement(doc,nodePath,index);
      Element parentEle = childEle.getParent();
      return removeNode(parentEle,childEle);
    }
    catch(Exception e)
    {
      return false;
    } 
  }
  
  
  /**
   * 将一段符合规范的XML字符串添加到一个Element对象中去
   * @param nodeEle       Element节点对象
   * @param strXml        待插入的XML字符串
   * @return              boolean 是否成功
   */
  public static boolean xmlAddToElement(Element nodeEle,String strXml)
  {
    try
    {
      Document doc = CreateNewDoc(strXml);
      Element rootEle = getRootElement(doc);
      nodeEle.add(rootEle);
      return true;
    }
    catch(Exception e)
    {
      return false;
    }
  }
  
  /**
   * 将一段符合规范的XML字符串,根据指定的路径添加到一个Document对象中去
   * @param doc           Document对象
   * @param nodePath      节点路径
   * @param strXML        XML字符串
   * @return boolean      是否成功
   */
  public static boolean setNodeDOM(Document doc,String nodePath,String strXML)
  {
    try
    {
      Element nodeEle = getNodeElement(doc,nodePath);
      if(nodeEle == null)
      {
        if(createNodePath(doc,nodePath))
          nodeEle = getNodeElement(doc,nodePath);
      }
      xmlAddToElement(nodeEle,strXML);
      
      return true;
    }
    catch(Exception e)
    {
      return false;
    }
  }
 
  /**
   * 创建子节点
   * @param eleRootExp  父节点
   * @param nodename    节点名称
   * @param nodevalue   节点值
   * @return            Element对象
   */
  public static Element createSubNode(Element eleRootExp,String nodename,String nodevalue)
  {
    Element ele = DocumentHelper.createElement(nodename);
    ele.setText(nodevalue);
    eleRootExp.add(ele);
    return ele;
  }
  
  /**
   * 给子节点赋值
   * @param eleRootExp  父节点
   * @param nodename    节点名称
   * @param nodevalue   节点值
   */
  public static void setSubNodeValue(Element eleRootExp,String nodename,String nodevalue)
  {
    try
    {
      Element ele = eleRootExp.element(nodename);
      if (ele==null) return;
      ele.setText(nodevalue);
    }
    catch(Exception e)
    {
      
    }
  }  
  
  /**
  * 获得节点的下所有子节点属性
  * @param eleRootExp     父节点
  * @param propName    属性名称
  * @param propValue   属性值
  * @return boolean       是否成功
  */
  public static boolean setAllSubNodeProperty(Element eleRootExp,String propName,String propValue)
  {
    try
    {
      if(eleRootExp == null) return false;
      Iterator it = eleRootExp.elementIterator();
      while(it.hasNext())
      {
        Element ele = (Element)it.next();
        ele.addAttribute(propName,propValue);
      }
      return true;
    }
    catch(Exception e)
    {
      e.printStackTrace();
      return false;
      
    }
  }
  
  // 
  public static void main(String[] args) throws Exception
  {
    Document doc = XmlFunc.CreateNewDoc("<Company><Department_Name>Cai WuBu</Department_Name><Manager>Zhang Bin</Manager></Company>");
    XmlFunc.setNodeValue(doc,"Department_Name", "123");
    System.out.println(doc.asXML());
  }
}
