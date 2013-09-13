package org.ptbank.baseManage;

import org.ptbank.base.Operation;
import org.ptbank.cache.DicCache;
import org.ptbank.declare.Table;


public class EventTypeBO
{
 
  /*********************************************************
   * 添加事件类型
   * @param strXml            XML 数据信息
   * @return XML              返回信息
  ***********************************************************/

  public static String addOrEdit(String strXml) throws Exception
  {
    String xml = Operation.addOrEdit(strXml,Table.EVENTTYPE);
    DicCache.getInstance().refresh("EVENTTYPE");
    return xml;
  }
}
