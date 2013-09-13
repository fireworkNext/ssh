package org.ptbank.bo;

import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentFactory;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;

import org.ptbank.base.CommonQuery;
import org.ptbank.base.NumAssign;
import org.ptbank.base.Operation;
import org.ptbank.base.QueryDoc;
import org.ptbank.base.ReturnDoc;
import org.ptbank.cache.DicCache;
import org.ptbank.cache.SpellCache;
import org.ptbank.cache.UserLogonInfo;
import org.ptbank.db.DBConnection;
import org.ptbank.db.DataStorage;
import org.ptbank.db.SQLAnalyse;
import org.ptbank.declare.Common;
import org.ptbank.declare.Field;
import org.ptbank.declare.Table;
import org.ptbank.func.General;

public class JyxBO {

	// //////////////////////////////////简易险销售新增/////////////////////////////
	public static String JyxAdd(String strXML, UserLogonInfo userSession)
			throws Exception {
		DataStorage obj_Storage = new DataStorage();
		ReturnDoc obj_ReturnDoc = new ReturnDoc();
		String str_SQL = "";
		try {
			// 设置编号
			String strId = NumAssign.assignID_B("990001", General.curYear4()
					+ General.curMonth() + General.curDay());
			Document doc = DocumentHelper.parseText(strXML);
			Element ele1 = (Element) doc.selectSingleNode("//DATAINFO/T_JYX");
			// System.out.println(ele1);
			ele1.element("TBSJ").setText(
					General.curYear4() + General.curMonth() + General.curDay());
			ele1.element("XSID").setText(strId);
			ele1.element("GZR").setText(userSession.getUserTitle());
			ele1.element("GZRNAME").setText(userSession.getUserName());
			ele1.element("UNITID").setText(userSession.getUnitID());
			ele1.element("UNITNAME").setText(userSession.getUnitName());
			//ele1.element("DEPTID").setText(userSession.getDeptId());
			str_SQL = SQLAnalyse.analyseXMLSQL(ele1);
			obj_Storage.addSQL(str_SQL);
			String str_Return = obj_Storage.runSQL();
			if (!General.empty(str_Return)) {
				obj_ReturnDoc.addErrorResult(Common.RT_FUNCERROR);
				obj_ReturnDoc.setFuncErrorInfo(str_Return);
			} else {
				obj_ReturnDoc.addErrorResult(Common.RT_SUCCESS);
			}

		} catch (Exception e) {
			obj_ReturnDoc.addErrorResult(Common.RT_FUNCERROR);
			obj_ReturnDoc.setFuncErrorInfo(e.getMessage());
		}
		return obj_ReturnDoc.getXML();
	}

	// /////////////////////返回该用户一周内销售列表
	public static String getJyxList(String strXML, UserLogonInfo userSession)
			throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);  
		int int_PageSize = obj_Query.getIntPageSize();
	    int int_CurrentPage = obj_Query.getIntCurrentPage();
		String str_Select = "S.XSID XSID,S.NAME NAME,S.JE JE,S.FS FS,S.SFZ SFZ,S.XZ XZ,S.BZ BZ,S.DH DH,S.UNITNAME UNITNAME,S.GZRNAME GZRNAME,S.TBSJ TBSJ,S.JTZZ JTZZ,S.GZR GZR";
		String str_From = "T_JYX s";
		String cGZR = userSession.getUserTitle();
		//String cDeptid = userSession.getDeptId();
		// String str_Where = Common.WHERE + " GZR =userSession.getUserTitle()";    and DEPTID = '" + cDeptid + "'
		String str_Where = Common.WHERE + " GZR = '" + cGZR + "'  and TBSJ >= sysdate-7";

		// System.out.println(str_Where);

		// 日期型字段列表
		String[] str_DateList = { "TBSJ" };
		// 标准的、统一的分页查询接口
		return CommonQuery.basicListQuery(str_Select, str_From, str_Where,
				"XSID", str_DateList, int_PageSize, int_CurrentPage);
	}
	
	// ////删除销售
	public static String delJyx(String strXML) throws Exception {
		DataStorage obj_Storage = new DataStorage();
		ReturnDoc obj_ReturnDoc = new ReturnDoc();
		String str_SQL = "";
		try {
			str_SQL = "DELETE FROM T_JYX WHERE XSID='" + strXML + "'";
			obj_Storage.addSQL(str_SQL);
			String str_Return = obj_Storage.runSQL();
			if (!General.empty(str_Return)) {
				obj_ReturnDoc.addErrorResult(Common.RT_FUNCERROR);
				obj_ReturnDoc.setFuncErrorInfo(str_Return);
			} else {
				obj_ReturnDoc.addErrorResult(Common.RT_SUCCESS);
			}

		} catch (Exception e) {
			obj_ReturnDoc.addErrorResult(Common.RT_FUNCERROR);
			obj_ReturnDoc.setFuncErrorInfo(e.getMessage());
		}
		return obj_ReturnDoc.getXML();
	}	

	
	//// 查询出销售记录，待修改
	public static String seeJyx(String strXML) throws Exception {
		String str_Select = "S.XSID XSID,S.NAME NAME,S.JE JE,S.FS FS,S.SFZ SFZ,S.XZ XZ,S.BZ BZ,S.DH DH,S.UNITNAME UNITNAME,S.GZRNAME GZRNAME,S.TBSJ TBSJ,S.JTZZ JTZZ,S.GZR GZR";
		String str_From = "T_JYX s";
		String str_Where = Common.WHERE + " XSID = '" + strXML + "'";

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where,
				"XSID", null, null, null, 1, 1, 1, 1, 0, true, "T_JYX");
	}
	// /////////////////////////////销售修改////////////////////////////
	public static String editJyx(String strXML) throws Exception {
		return Operation.dealWithXml(strXML);
	}	

	/**
	 * 根据用户名返回单位字典xml字符串
	 * 
	 * @param sUserTitle
	 * @throws SQLException
	 */
	public static String getUnit(String sUserTitle,UserLogonInfo userSession) {
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strRtn = "";
		try { 
			Document domresult = DocumentFactory.getInstance().createDocument();
			Element root = domresult.addElement("data");
			//String cGZR = userSession.getUserTitle(); 
			String cUnitId =userSession.getUnitID();
			//String cXXX=userSession.getUserType();
			SpellCache spellcache = SpellCache.getInstance();
			rst = dbc.excuteQuery("select munitid,munitname from manageunit start with munitid='"+cUnitId+"' connect by prior munitid=msunitid");
			while (rst.next()) {
				String sCode = rst.getString(1);
				String sText = rst.getString(2);

				String spell = spellcache.getSpell(sText);
				String aspell = spellcache.getASpell(sText);
				Element elerow = DocumentHelper
						.createElement(Common.XML_PROP_ROW);
				elerow.addAttribute(Field.DIC_CODE, sCode);
				elerow.addAttribute(Field.DIC_TEXT, sText);
				elerow.addAttribute(Field.DIC_SPELL, spell);
				elerow.addAttribute(Field.DIC_ASPELL, aspell);
				root.add(elerow);
			}
			rst.close();
			dbc.freeConnection();
			strRtn = domresult.asXML();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbc.freeConnection();
		}
		return strRtn;
	}
	
	
	
	// //////////////////返回个人销售记录列表///带条件
		public static String Qrygrjyx(String strXML, UserLogonInfo userSession) throws Exception {
			QueryDoc obj_Query = new QueryDoc(strXML);
			int int_PageSize = obj_Query.getIntPageSize();
		    int int_CurrentPage = obj_Query.getIntCurrentPage();
		    String cUserTitle = userSession.getUserTitle();
		    String str_Select = "*";
		    String str_From = "T_JYX s";
			String str_Where = obj_Query.getConditions();
			str_Where = General.empty(str_Where) ? Common.WHERE+" GZR='" + cUserTitle + "'" : Common.WHERE+ str_Where+" AND GZR='" + cUserTitle + "'";
			//System.out.println(str_Where);
 
			// 日期型字段列表
			String[] str_DateList = { "TBSJ" };
			
			return CommonQuery.basicListQuery(str_Select, str_From, str_Where,
					"XSID", str_DateList, int_PageSize, int_CurrentPage);
		}
	
		// //////////////////返回按单位销售记录列表///带条件
		public static String Qrydwjyx(String strXML, UserLogonInfo userSession) throws Exception {
			QueryDoc obj_Query = new QueryDoc(strXML);
			int int_PageSize = obj_Query.getIntPageSize();
		    int int_CurrentPage = obj_Query.getIntCurrentPage();
		    String str_Select = "*";
		    String str_From = "T_JYX s";
		    Map<String,String> paraMap = obj_Query.getConditionMap(strXML);
		    String sUnitId = paraMap.get("UNITID");
		    int leng = sUnitId.length()+11;
		    String str_Where = obj_Query.getConditions();
		    String cUnitId = " in(select munitid from manageunit start with munitid='"+sUnitId+"' connect by prior munitid=msunitid)";
		    str_Where = "where "+str_Where.substring(0,str_Where.indexOf("UNITID"))+"UNITID"+cUnitId+str_Where.substring(str_Where.indexOf("UNITID")+leng,str_Where.length());

			// 日期型字段列表
			String[] str_DateList = { "TBSJ" };
			return CommonQuery.basicListQuery(str_Select, str_From, str_Where,
					"XSID", str_DateList, int_PageSize, int_CurrentPage);
		}
	
		// //////////////////查询统计///带条件
		public static String Qrytj1jyx(String strXML, UserLogonInfo userSession) throws Exception {
			QueryDoc obj_Query = new QueryDoc(strXML);
			int int_PageSize = obj_Query.getIntPageSize();
		    int int_CurrentPage = obj_Query.getIntCurrentPage();
		    String str_Select = "S.JE,S.FS,S.XZ,S.UNITID,S.UNITNAME,S.TBSJ,T.MSUNITID";
		    String str_From = "T_JYX S,MANAGEUNIT T";
			String str_Where = obj_Query.getConditions();
			str_Where = Common.WHERE + " S.UNITID=T.MUNITID"+ " AND S."+str_Where;
			//System.out.println(str_Where);
			// 日期型字段列表
			String[] str_DateList = { "TBSJ" };
			
			return CommonQuery.basicListQuery(str_Select, str_From, str_Where,
					"XSID", str_DateList, int_PageSize, int_CurrentPage);
		}
	
//////////////////查询统计///带条件
		public static ArrayList Qrytjjyx(String strXML, UserLogonInfo userSession) throws Exception{
			QueryDoc obj_Query = new QueryDoc(strXML);
			ArrayList al = new ArrayList();
			DBConnection dbc = new DBConnection();
			ResultSet rst = null;
			double dSum1=0.0,dSum2=0.0,dSum3=0.0,dSum4=0.0,dSum5=0.0;
			String str_Where = obj_Query.getConditions();
			try {
				String strSQL = "select S.JE,S.FS,S.XZ,S.UNITID,S.UNITNAME,S.TBSJ,T.MSUNITID from T_JYX S,MANAGEUNIT T where  S.UNITID=T.MUNITID";
			    strSQL =General.empty(str_Where) ?strSQL : strSQL+ " AND S."+str_Where;
				rst = dbc.excuteQuery(strSQL);
				if (rst == null) {
					throw new Exception("获取数据失败");
				}
				
				int colCount = rst.getMetaData().getColumnCount();
				while (rst.next()) {
					ArrayList list = new ArrayList();
					for (int i = 1; i <= colCount; i++) {
						String colName = rst.getMetaData().getColumnName(i);
						list.add(rst.getString(i));

					}
					al.add(list);
				}
				//增加合计部分
				ArrayList list = new ArrayList();
				list.add("合计");
				list.add(dSum1);
				list.add(dSum2);
				list.add(dSum3);
				list.add(dSum4);
				list.add(dSum5);
				al.add(list);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (rst != null)
					try {
						rst.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				dbc.freeConnection();
			}
			return al;
		}
	
	
}
