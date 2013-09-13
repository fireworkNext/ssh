package org.ptbank.bo;

import java.io.BufferedOutputStream;
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

public class ZxkhBO {
	//高端客户基础资料新增
	public static String gdkhAdd(String strXML, UserLogonInfo userSession)
			throws Exception {
		//System.out.print(strXML);
		DataStorage obj_Storage = new DataStorage();
		ReturnDoc obj_ReturnDoc = new ReturnDoc();
		String str_SQL = "";
		try {
			// 设置编号
			String strId = NumAssign.assignID_B("990002", General.curYear4()
					+ General.curMonth() + General.curDay());
			Document doc = DocumentHelper.parseText(strXML);
			Element ele1 = (Element) doc.selectSingleNode("//DATAINFO/T_GDKHXXB");
			ele1.element("JDSJ").setText(
					General.curYear4() + General.curMonth() + General.curDay());
			ele1.element("KHID").setText(strId);
			ele1.element("GZR").setText(userSession.getUserTitle());
			ele1.element("GZRNAME").setText(userSession.getUserName());
			ele1.element("UNITID").setText(userSession.getUnitID());
			ele1.element("UNITNAME").setText(userSession.getUnitName());
			str_SQL = SQLAnalyse.analyseXMLSQL(ele1);
			//System.out.print("the sql statment is:"+str_SQL);
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
	
		//高端客户列表查询
		public static String getGdkhList(String strXML, UserLogonInfo userSession) throws Exception{
			String str_gzr = userSession.getUserTitle();
			QueryDoc obj_Query = new QueryDoc(strXML);  
			int int_PageSize = obj_Query.getIntPageSize();
		    int int_CurrentPage = obj_Query.getIntCurrentPage();
		    String str_Select = "*";
		    String str_From = "T_GDKHXXB ";
			String str_Where = obj_Query.getConditions();
			str_Where = Common.WHERE + str_Where + " AND GZR = '"+ str_gzr + "'"  ;
			// 日期型字段列表
			String[] str_DateList = { "JDSJ" };
			// 标准的、统一的分页查询接口
			return CommonQuery.basicListQuery(str_Select, str_From, str_Where,
					"KHID", str_DateList, int_PageSize, int_CurrentPage);
	}
		
		//家庭情况新增
		public static String jtqkAdd(String strXML, UserLogonInfo userSession) throws Exception {
				//System.out.print(strXML);
				DataStorage obj_Storage = new DataStorage();
				ReturnDoc obj_ReturnDoc = new ReturnDoc();
				String str_SQL = "";
				try {
					// 设置编号
					String strId = NumAssign.assignID_B("990002", General.curYear4()
							+ General.curMonth() + General.curDay());
					Document doc = DocumentHelper.parseText(strXML);
					Element ele1 = (Element) doc.selectSingleNode("//DATAINFO/T_JTQK");
					ele1.element("OID").setText(strId);
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
		
		
		//家庭情况列表查询
		public static String getJtqkList(String strRet) throws Exception {
			String str_Select = "*";
		    String str_From = "T_JTQK";
			String str_Where = Common.WHERE  + "KHID = '"+ strRet + "'"  ;
			// 标准的、统一的分页查询接口
			return  CommonQuery.basicListQuery(str_Select, str_From, str_Where,
					"OID",null,9999,1);
		}
		
		//资产结构新增
		public static String zcjgAdd(String strXML, UserLogonInfo userSession) throws Exception {
			DataStorage obj_Storage = new DataStorage();
			ReturnDoc obj_ReturnDoc = new ReturnDoc();
			String str_SQL = "";
			try {
				// 设置编号
				String strId = NumAssign.assignID_B("990002", General.curYear4()
						+ General.curMonth() + General.curDay());
				Document doc = DocumentHelper.parseText(strXML);
				Element ele1 = (Element) doc.selectSingleNode("//DATAINFO/T_ZCJG");
				ele1.element("OID").setText(strId);
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

		//资产结构列表查询
		public static String getZcjgList(String strRet) throws Exception {
			String str_Select = "*";
		    String str_From = "T_ZCJG";
			String str_Where = Common.WHERE  + "KHID = '"+ strRet + "'"  ;
			// 标准的、统一的分页查询接口
			return  CommonQuery.basicListQuery(str_Select, str_From, str_Where,
					"OID",null,9999,1);
		}
		
		
		//历史成交记录新增
		public static String lscjjlAdd(String strXML,UserLogonInfo userSession) throws Exception {
			DataStorage obj_Storage = new DataStorage();
			ReturnDoc obj_ReturnDoc = new ReturnDoc();
			String str_SQL = "";
			try {
				// 设置编号
				String strId = NumAssign.assignID_B("990002", General.curYear4()
						+ General.curMonth() + General.curDay());
				Document doc = DocumentHelper.parseText(strXML);
				Element ele1 = (Element) doc.selectSingleNode("//DATAINFO/T_LSCJJL");
				ele1.element("OID").setText(strId);
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
		//返回历史成交记录列表
		public static String getLscjjlList(String strRet) throws Exception {
			String str_Select = "*";
		    String str_From = "T_LSCJJL";
			String str_Where = Common.WHERE  + "KHID = '"+ strRet + "'"  ;
			// 标准的、统一的分页查询接口
			return  CommonQuery.basicListQuery(str_Select, str_From, str_Where,
					"OID",null,9999,1);
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
				Element elerow = DocumentHelper.createElement(Common.XML_PROP_ROW);
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
	//权限查询各单位下属部门的客户资料,列表返回
		public static String roleGetGdkhList(String strXML,UserLogonInfo userSession) throws Exception {
			QueryDoc obj_Query = new QueryDoc(strXML);
			int int_PageSize = obj_Query.getIntPageSize();
		    int int_CurrentPage = obj_Query.getIntCurrentPage();
		    String str_Select = "*";
		    String str_From = "T_GDKHXXB s";
		    Map<String,String> paraMap = obj_Query.getConditionMap(strXML);
		    String sUnitId = paraMap.get("UNITID");
		    int leng = sUnitId.length()+11;
		    String str_Where = obj_Query.getConditions();
		    String cUnitId = " in(select munitid from manageunit start with munitid='"+sUnitId+"' connect by prior munitid=msunitid)";
		    str_Where = "where "+str_Where.substring(0,str_Where.indexOf("UNITID"))+"UNITID"+cUnitId+str_Where.substring(str_Where.indexOf("UNITID")+leng,str_Where.length());

			// 日期型字段列表
			String[] str_DateList = { "JDSJ" };
			return CommonQuery.basicListQuery(str_Select, str_From, str_Where,
					"KHID", str_DateList, int_PageSize, int_CurrentPage);
		}
		
		//查询单条高端客户基本信息,返回前台用于修改
		public static String frmGdkhModQry(String strRet, UserLogonInfo userSession) throws Exception {
			String str_Select = "*";
		    String str_From = "T_GDKHXXB";
			String str_Where = Common.WHERE  + "KHID = '"+ strRet + "'"  ;
			// 标准的、统一的分页查询接口
			return CommonQuery.basicListQuery(str_Select, str_From, str_Where,
					"KHID", null, null, null, 1, 1, 1, 1, 0, true, "T_GDKHXXB");
		}
		
		//修改高端客户基本信息
		public static String frmGdkhMod(String strRet) throws Exception {
			return Operation.dealWithXml(strRet);
		}
		//查询单条客户家庭情况信息,返回前台用于修改
		public static String frmJtqkModQry(String strRet,UserLogonInfo userSession) throws Exception {
			String str_Select = "*";
		    String str_From = "T_JTQK";
			String str_Where = Common.WHERE  + "OID = '"+ strRet + "'"  ;
			// 标准的、统一的分页查询接口
			return CommonQuery.basicListQuery(str_Select, str_From, str_Where,
					"OID", null, null, null, 1, 1, 1, 1, 0, true, "T_JTQK");
		}
		
		
		
		
		
		
}
