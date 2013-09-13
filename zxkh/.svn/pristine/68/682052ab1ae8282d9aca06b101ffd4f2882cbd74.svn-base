package org.ptbank.classes;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.ptbank.base.*;
import org.ptbank.cache.DicCache;
import org.ptbank.cache.UserLogonInfo;
import org.ptbank.db.DataStorage;
import org.ptbank.db.SQLAnalyse;
import org.ptbank.declare.Common;
import org.ptbank.declare.Field;
import org.ptbank.func.General;


public class ProductBO {

	public static String AddNew(String strXML) {
		String strRet = null;
		try {
			// 获取表节点
			Document doc = DocumentHelper.parseText(strXML);

			Element ele = (Element) doc.selectSingleNode("//DATAINFO/PRODUCT");

			// 设置编号
			String strId = NumAssign.assignID_B("100003", "0103");

			ele.element("PID").setText(strId);

			// 创建执行对象
			strRet = Operation.dealWithXml(ele.asXML());

		} catch (Exception e) {

		}
		return strRet;
	}

	public static String proList(String strXml) throws Exception {
		// 构造标准查询XML接口分析类对象
		QueryDoc obj_Query = new QueryDoc(strXml);
		int int_PageSize = obj_Query.getIntPageSize();

		int int_CurrentPage = obj_Query.getIntCurrentPage();

		// 查询字典
		String str_Select = "s.PID PID,s.PTYPE PTYPE,s.PNAME PNAME,s.PRICE PRICE,s.PNUM PNUM";
		// 查询表
		String str_From = "PRODUCT s";
		// 构建标准的查询条件
		String str_Where = obj_Query.getConditions();
		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE
				+ str_Where;

		// 标准的、统一的分页查询接口
		return CommonQuery.basicListQuery(str_Select, str_From, str_Where,
				"PID", null, int_PageSize, int_CurrentPage);
	}

	// /
	public static String detail(String pid) throws Exception {
		String str_Select = "s.PID PID,s.PTYPE PTYPE,s.PNAME PNAME,s.PRICE PRICE,s.PNUM PNUM";
		// 查询表
		String str_From = "PRODUCT s";
		// 构建标准的查询条件
		String str_Where = Common.WHERE + " PID = '" + pid + "'";

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where,
				"PID", null, null, null, 1, 1, 1, 1, 0, true, "PRODUCT");
	}

	/**
	 * 添加订单
	 * 
	 * @param strXML
	 * @return
	 */
	public static String AddOrd(String strXML) {
		String strRet = null;
		try {
			// 设置编号
			String strId = NumAssign.assignID_B("100004", General.curYear4()
					+ General.curMonth() + General.curDay());

			Document doc = DocumentHelper.parseText(strXML);
			Integer len = doc.selectNodes("//ORDERID").size();

			for (int i = 0; i < len; i++) {
				Element ele = (Element) doc.selectNodes("//ORDERID").get(i);
				ele.setText(strId);
			}

			// 创建执行对象
			strRet = Operation.dealWithXml(doc.asXML());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return strRet;
	}

	/**
	 * 添加订单
	 * 
	 * @param strXML
	 * @return
	 */
	public static String AddOrd2(String strXML) throws Exception {
		DataStorage obj_Storage = new DataStorage();
		ReturnDoc obj_ReturnDoc = new ReturnDoc();
		String str_SQL = "";
		try {
			// 设置编号
			String strId = NumAssign.assignID_B("100004", General.curYear4()
					+ General.curMonth() + General.curDay());

			Document doc = DocumentHelper.parseText(strXML);

			// 处理 ORDERLIST insert
			Element ele1 = (Element) doc
					.selectSingleNode("//DATAINFO/ORDERLIST");
			ele1.element("ORDERID").setText(strId);

			str_SQL = SQLAnalyse.analyseXMLSQL(ele1);

			obj_Storage.addSQL(str_SQL);

			// 完成了关联表的sql语句构造
			Integer len = doc.selectNodes("//ORDPRO").size();
			for (int i = 0; i < len; i++) {
				Element ele = (Element) doc.selectNodes("//ORDPRO").get(i);

				str_SQL = "INSERT INTO ORDPRO(ORDERID,PID)VALUES ('" + strId
						+ "','" + ele.element("PID").getText() + "')";
				obj_Storage.addSQL(str_SQL);
			}

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

	/**
	 * 修改订单
	 * 
	 * @param strXML
	 * @return
	 * @throws Exception
	 */
	public static String EditOrd(String strXML) throws Exception {
		DataStorage obj_Storage = new DataStorage();
		ReturnDoc obj_ReturnDoc = new ReturnDoc();
		String str_SQL = "";
		try {
			// 设置编号

			Document doc = DocumentHelper.parseText(strXML);

			// 处理 ORDERLIST insert
			Element ele1 = (Element) doc
					.selectSingleNode("//DATAINFO/ORDERLIST");
			String strOrdID = ele1.element("ORDERID").getText();

			str_SQL = SQLAnalyse.analyseXMLSQL(ele1);

			obj_Storage.addSQL(str_SQL);

			// 完成了关联表的sql语句构造
			// 删除原来的订单商品
			obj_Storage.addSQL("DELETE FROM ORDPRO WHERE ORDERID='" + strOrdID
					+ "'");

			// 循环添加新的商品
			Integer len = doc.selectNodes("//ORDPRO").size();
			for (int i = 0; i < len; i++) {
				Element ele = (Element) doc.selectNodes("//ORDPRO").get(i);

				str_SQL = "INSERT INTO ORDPRO(ORDERID,PID)VALUES ('" + strOrdID
						+ "','" + ele.element("PID").getText() + "')";
				obj_Storage.addSQL(str_SQL);
			}

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

	/**
	 * 删除订单
	 * 
	 * @param strOrdID
	 * @return
	 * @throws Exception
	 */
	public static String DelOrd(String strOrdID) throws Exception {
		DataStorage obj_Storage = new DataStorage();
		ReturnDoc obj_ReturnDoc = new ReturnDoc();
		String str_SQL = "";
		try {
			// 删除原来的订单商品

			obj_Storage.addSQL("DELETE FROM ORDPRO WHERE ORDERID='" + strOrdID
					+ "'");

			str_SQL = "DELETE FROM ORDERLIST WHERE ORDERID='" + strOrdID + "'";
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

	/**
	 * 订单列表查询
	 * 
	 * @param strXml
	 * @return
	 * @throws Exception
	 */
	public static String ordList(String strXml) throws Exception {
		// 构造标准查询XML接口分析类对象
		QueryDoc obj_Query = new QueryDoc(strXml);
		int int_PageSize = obj_Query.getIntPageSize();

		int int_CurrentPage = obj_Query.getIntCurrentPage();

		// 查询字典
		String str_Select = "s.ORDERID ORDERID,s.ORDERPSN ORDERPSN,s.ORDERDATE ORDERDATE,s.ORDERTITLE ORDERTITLE,s.CUSNAME CUSNAME,s.CUSUNIT CUSUNIT";
		// 查询表
		String str_From = "ORDERLIST s";
		// 构建标准的查询条件
		String str_Where = obj_Query.getConditions();
		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE
				+ str_Where;

		System.out.println(str_Where);

		// 日期型字段列表
		String[] str_DateList = { "ORDERDATE" };

		// 标准的、统一的分页查询接口
		return CommonQuery.basicListQuery(str_Select, str_From, str_Where,
				"ORDERID", str_DateList, int_PageSize, int_CurrentPage);
	}

	// 订单包含的商品列表
	public static String ordproList(String ordid) throws Exception {
		String str_Select = "s.ORDERID ORDERID,s.PID PID";
		// 查询表
		String str_From = "ORDPRO s";
		// 构建标准的查询条件
		String str_Where = Common.WHERE + " ORDERID = '" + ordid + "'";

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where,
				"PID", null, null, null, 1, 1, 99999, 1, 0, true, "ROW");
	}

	// 订单详细信息查询
	public static String ordDetail(String ordid) throws Exception {
		String str_Select = "s.ORDERID ORDERID,s.ORDERPSN ORDERPSN,s.ORDERDATE ORDERDATE,s.ORDERTITLE ORDERTITLE,s.CUSNAME CUSNAME,s.CUSUNIT CUSUNIT";
		// 查询表
		String str_From = "ORDERLIST s";
		// 构建标准的查询条件
		String str_Where = Common.WHERE + " ORDERID = '" + ordid + "'";

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where,
				"ORDERID", null, null, null, 1, 1, 1, 1, 0, true, "ORDERLIST");
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
