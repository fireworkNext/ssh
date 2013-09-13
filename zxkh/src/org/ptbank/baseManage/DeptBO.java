package org.ptbank.baseManage;

import java.sql.ResultSet;
import java.util.Enumeration;
import java.util.Hashtable;

import org.dom4j.Element;
import org.dom4j.Node;
import org.ptbank.base.DataDoc;
import org.ptbank.base.NumAssign;
import org.ptbank.base.ReturnDoc;
import org.ptbank.cache.DicCache;
import org.ptbank.cache.MUnitCache;
import org.ptbank.db.DBConnection;
import org.ptbank.db.DataStorage;
import org.ptbank.db.SQLAnalyse;
import org.ptbank.declare.Common;
import org.ptbank.func.General;


public class DeptBO {
	/*********************************************************
	   * 添加部门
	   * @param strXml            XML 数据信息
	   * @return XML              返回信息
	  ***********************************************************/

	  public static String addOrEdit(String strXml) throws Exception
	  {
	    DataDoc doc = new DataDoc(strXml);
	    // 创建执行对象
	    DataStorage storage = new DataStorage();
	    int size = doc.getDataNum("DEPT");
	    Hashtable<String, String> hashId = new Hashtable<String, String>();
	    // 解析sql语句
	    for(int i=0;i<size;i++)
	    {  
	      Element ele = (Element)doc.getDataNode("DEPT",i);
	      Node node = ele.selectSingleNode("DEPTID");
	      String strId = node.getText();
	      //如果为空,则为增加,否则取传送进来的DEPTID
	      if(General.empty(strId)){
	    	  strId=NumAssign.assignID_A("000005");
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
	    DicCache.getInstance().refresh("DEPT");
	    return returndoc.getXML();  
	  }
	  
	  /*********************************************************
	   * 创建部门字典
	   * 首先生成部门全部字典集，为了配合单位选择，还需以单位为标志生成该单位下的所有部门
	  ***********************************************************/

	  public static void createDeptDicFile() throws Exception{
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		String munitid = "";

		// 生成DEPT字典
		General.createDicFileSQL("SELECT DEPTID,DEPTNAME FROM DEPT WHERE VALID='1' ORDER BY DEPTID","DEPT");
		
		try {
			rst = dbc.excuteQuery("SELECT MUNITID FROM DEPT GROUP BY MUNITID ORDER BY MUNITID");
			while (rst.next()) {
				munitid = rst.getString("MUNITID");
				strSQL = "SELECT DEPTID,DEPTNAME FROM DEPT START WITH MUNITID='"
						+ munitid
						+ "' CONNECT BY PRIOR PARENTID=DEPTID ORDER BY DEPTID";
				General.createDicFileSQL(strSQL, "DEPT" + munitid);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			rst.close();
			dbc.freeConnection();
		}
	}
}
