package org.ptbank.base;

import org.ptbank.db.*;
import org.ptbank.declare.*;
import org.ptbank.func.General;


public class ErrorLog
{
  /**
   * 记录错误日志
   * @return String              错误日志编号
   * @param arrError            错误信息数组
   *          数组说明:
   *            arrError[0]       对象标识
   *            arrError[1]       事件类型编号
   *            arrError[2]       用户编号
   *            arrError[3]       用户姓名
   *            arrError[4]       用户单位编号
   *            arrError[5]       用户单位名称
   *            arrError[6]       用户登录编号
   *            arrError[7]       错误描述1
   *            arrError[8]       错误描述2
   */
  public static String addErrorLog(String[] arrError) throws Exception
  {
    /// 获得最大错误日志编号
    String str_ErrorID = NumAssign.assignID_A(Common.MAX_ERROR_LOGID);

    String str_FieldList = General.addBracket(Field.ERRID         + Common.COMMA + 
                                              Field.OBJID         + Common.COMMA +
                                              Field.EVENTTYPEID   + Common.COMMA + 
                                              Field.USERID        + Common.COMMA + 
                                              Field.USERNAME      + Common.COMMA + 
                                              Field.UNITID        + Common.COMMA + 
                                              Field.UNITNAME      + Common.COMMA + 
                                              Field.LOGID         + Common.COMMA + 
                                              Field.ERRDES1       + Common.COMMA + 
                                              Field.ERRDES2       + Common.COMMA + 
                                              Field.OPTIME);

    String str_ValueList = General.addBracket(General.addQuotes(str_ErrorID)                            + Common.COMMA +
                                              General.addQuotes(arrError[0])                            + Common.COMMA +
                                              General.addQuotes(arrError[1])                            + Common.COMMA +
                                              General.addQuotes(arrError[2])                            + Common.COMMA +
                                              General.addQuotes(General.checkSingleQuotes(arrError[3])) + Common.COMMA +
                                              General.addQuotes(arrError[4])                            + Common.COMMA +
                                              General.addQuotes(General.checkSingleQuotes(arrError[5])) + Common.COMMA +
                                              General.addQuotes(arrError[6])                            + Common.COMMA +
                                              General.addQuotes(General.checkSingleQuotes(arrError[7])) + Common.COMMA +
                                              General.addQuotes(General.checkSingleQuotes(arrError[8])) + Common.COMMA +
                                              General.dbDatetime());
    
    String str_SQL = Common.INSERT   + Table.ERRLOG +
                     Common.SPACE    + str_FieldList +
                     Common.S_VALUES + str_ValueList;
    
    DataStorage obj_Storage = new DataStorage();
    obj_Storage.addSQL(str_SQL);
    obj_Storage.runSQL();
    
    return str_ErrorID;
  }
}
