package org.ptbank.baseManage;

import org.ptbank.base.Operation;
import org.ptbank.cache.DicCache;
import org.ptbank.declare.*;


public class AffairTypeBO
{
 
  /*********************************************************
   * 添加\修改事务类型
   * @param strXml XML 数据信息
   * @return String XML 返回信息
  ***********************************************************/
  public static String addOrEdit(String strXml) throws Exception
  {
    
    String xml = Operation.addOrEdit(strXml,Table.AFFAIRTYPE);
    DicCache.getInstance().refresh("AFFAIRTYPE");
    return xml;
  }
}
