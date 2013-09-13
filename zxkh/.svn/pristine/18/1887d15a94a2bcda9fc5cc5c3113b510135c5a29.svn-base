package org.ptbank.baseManage;

import java.util.Enumeration;
import java.util.Hashtable;

import org.dom4j.Element;
import org.dom4j.Node;
import org.ptbank.base.DataDoc;
import org.ptbank.base.NumAssign;
import org.ptbank.base.ReturnDoc;
import org.ptbank.cache.DicCache;
import org.ptbank.cache.MUnitCache;
import org.ptbank.db.DataStorage;
import org.ptbank.db.SQLAnalyse;
import org.ptbank.declare.Common;
import org.ptbank.declare.Field;
import org.ptbank.declare.Table;
import org.ptbank.func.General;


public class UnitsBO
{
  /*********************************************************
   * 添加管理单位
   * @param strXml            XML 数据信息
   * @return XML              返回信息
  ***********************************************************/

  public static String addOrEdit(String strXml) throws Exception
  {
    DataDoc doc = new DataDoc(strXml);
    // 创建执行对象
    DataStorage storage = new DataStorage();
    int size = doc.getDataNum(Table.MANAGEUNIT);
    Hashtable<String, String> hashId = new Hashtable<String, String>();
    // 解析sql语句
    for(int i=0;i<size;i++)
    {  
      Element ele = (Element)doc.getDataNode(Table.MANAGEUNIT,i);
      Node node = ele.selectSingleNode(Field.MUNITID);
      String strId = node.getText();
      //如果为空,则为增加,否则取传送进来的MUNITID
      if(General.empty(strId)){
    	  strId=NumAssign.assignID_A("000003");
    	  node.setText(strId);
      }
      hashId.put(strId,strId);
      storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
      //System.out.println(SQLAnalyse.analyseXMLSQL(ele));
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
      MUnitCache.getInstance().refresh((String)enums.nextElement());
    }
    DicCache.getInstance().refresh("MANAGEUNIT");
    return returndoc.getXML();  
  }
 
  
}
