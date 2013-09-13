package org.ptbank.base;

import org.ptbank.db.*;
import org.ptbank.declare.*;
import org.ptbank.func.General;


public class SystemLog
{
/**
 * 记录系统日志
 * @return String              系统登录编号
 * @param arrSys            系统信息数组
 *          数组说明:
 *            arrSys[0]       用户编号
 *            arrSys[1]       用户名称
 *            arrSys[2]       用户姓名
 *            arrSys[3]       用户人要素编号
 *            arrSys[4]       用户单位编号
 *            arrSys[5]       用户单位名称
 *            arrSys[6]       登录计算机IP
 *            arrSys[7]       登录计算机网卡Mac地址
 */
  public static String addSysLog(String[] arrSys) throws Exception
  {
    /// 获得最大系统日志编号
    String str_LogID = NumAssign.assignID_A(Common.MAX_SYSTEM_LOGID);

  
    String str_FieldList = General.addBracket(Field.LOGID     + Common.COMMA +
                                              Field.USERID    + Common.COMMA +
                                              Field.USERTITLE + Common.COMMA +
                                              Field.USERNAME  + Common.COMMA +
                                              Field.PERSONID  + Common.COMMA +
                                              Field.UNITID    + Common.COMMA +
                                              Field.UNITNAME  + Common.COMMA +
                                              Field.LOGINIP   + Common.COMMA +
                                              Field.MAC       + Common.COMMA +
                                              Field.ENTERTIME);

    String str_ValueList = General.addBracket(General.addQuotes(str_LogID) + Common.COMMA +
                                              General.addQuotes(arrSys[0]) + Common.COMMA +
                                              General.addQuotes(arrSys[1]) + Common.COMMA +
                                              General.addQuotes(arrSys[2]) + Common.COMMA +
                                              General.addQuotes(arrSys[3]) + Common.COMMA +
                                              General.addQuotes(arrSys[4]) + Common.COMMA +
                                              General.addQuotes(arrSys[5]) + Common.COMMA +
                                              General.addQuotes(arrSys[6]) + Common.COMMA +
                                              General.addQuotes(arrSys[7]) + Common.COMMA +
                                              General.dbDatetime());
    
    String str_SQL = Common.INSERT   + Table.SYSLOG +
                     Common.SPACE    + str_FieldList +
                     Common.S_VALUES + str_ValueList;
    
    DataStorage obj_Storage = new DataStorage();
    obj_Storage.addSQL(str_SQL);
    obj_Storage.runSQL();
    
    return str_LogID;
  }
}
