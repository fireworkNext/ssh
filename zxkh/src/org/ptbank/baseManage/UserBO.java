package org.ptbank.baseManage;

import java.util.Enumeration;
import java.util.Hashtable;

import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.ptbank.base.DataDoc;
import org.ptbank.base.NumAssign;
import org.ptbank.base.ReturnDoc;
import org.ptbank.baseManage.IdentifyBO;
import org.ptbank.cache.DicCache;
import org.ptbank.cache.UserCache;
import org.ptbank.db.DataStorage;
import org.ptbank.db.SQLAnalyse;
import org.ptbank.declare.Common;
import org.ptbank.declare.Field;
import org.ptbank.declare.Table;
import org.ptbank.func.General;

public class UserBO {

	/*********************************************************
	 * 添加用户信息
	 * 
	 * @param strXml
	 *            XML 数据信息
	 * @return XML 返回信息
	 ***********************************************************/

	public static String addNew(String strXml) throws Exception {
		DataDoc doc = new DataDoc(strXml);
		// 创建执行对象
		DataStorage storage = new DataStorage();
		int size = doc.getDataNum(Table.USERLIST);
		Hashtable<String, String> hashId = new Hashtable<String, String>();
		ReturnDoc returndoc = new ReturnDoc();
		// 解析sql语句
		for (int i = 0; i < size; i++) {
			Element ele = (Element) doc.getDataNode(Table.USERLIST, i);
			//判断用户登录名和身份证号是否重复
			if(!IdentifyBO.checkUserTitle(ele.selectSingleNode(Field.USERTITLE).getText()).equals("0")) {
				returndoc.addErrorResult(Common.RT_FUNCERROR);
				returndoc.setFuncErrorInfo("该用户名称已存在,请检查!");
				return returndoc.getXML();
			}
			if(!IdentifyBO.checkUserIdcard(ele.selectSingleNode(Field.IDCARD).getText()).equals("0")) {
				returndoc.addErrorResult(Common.RT_FUNCERROR);
				returndoc.setFuncErrorInfo("该身份证号已存在,请检查!");
				return returndoc.getXML();
			}
			
			Node node = ele.selectSingleNode(Field.USERID);
			String strId = NumAssign.assignID_A("000002");
			hashId.put(strId, strId);
			node.setText(strId);
			// System.out.println(SQLAnalyse.analyseXMLSQL(ele));
			storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
		}
		// 执行
		String strReturn = storage.runSQL();
		
		if (!General.empty(strReturn)) {
			returndoc.addErrorResult(Common.RT_FUNCERROR);
			returndoc.setFuncErrorInfo(strReturn);
		} else {
			returndoc.addErrorResult(Common.RT_SUCCESS);
		}

		Enumeration enums = hashId.elements();
		while (enums.hasMoreElements()) {
			UserCache.getInstance().refresh((String) enums.nextElement());
		}
		DicCache.getInstance().refresh("USERLIST");
		return returndoc.getXML();
	}

	/*********************************************************
	 * 修改用户信息
	 * 
	 * @param strXml
	 *            XML 数据信息
	 * @return XML 返回信息
	 ***********************************************************/

	public static String edit(String strXml) throws Exception {
		DataDoc doc = new DataDoc(strXml);
		// 创建执行对象
		DataStorage storage = new DataStorage();
		int size = doc.getDataNum(Table.USERLIST);
		Hashtable<String, String> hashId = new Hashtable<String, String>();
		// 解析sql语句
		for (int i = 0; i < size; i++) {
			Element ele = (Element) doc.getDataNode(Table.USERLIST, i);
			Node node = ele.selectSingleNode(Field.USERID);
			String strId = node == null ? null : node.getText();
			hashId.put(strId, strId);
			storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
		}
		// 执行
		String strReturn = storage.runSQL();
		ReturnDoc returndoc = new ReturnDoc();
		if (!General.empty(strReturn)) {
			returndoc.addErrorResult(Common.RT_FUNCERROR);
			returndoc.setFuncErrorInfo(strReturn);
		} else {
			returndoc.addErrorResult(Common.RT_SUCCESS);
		}

		Enumeration enums = hashId.elements();
		while (enums.hasMoreElements()) {
			UserCache.getInstance().refresh((String) enums.nextElement());
		}
		DicCache.getInstance().refresh(Table.USERLIST);
		return returndoc.getXML();
	}

	/*********************************************************
	 * 删除用户信息，同步删除掉用户对应的权限文件
	 * 
	 * @param strXml
	 *            XML 数据信息
	 * @return XML 返回信息
	 ***********************************************************/

	public static String drop(String strXml) throws Exception {
		DataDoc doc = new DataDoc(strXml);
		// 创建执行对象
		DataStorage storage = new DataStorage();
		int size = doc.getDataNum(Table.USERLIST);
		Hashtable<String, String> hashId = new Hashtable<String, String>();
		// 解析sql语句
		for (int i = 0; i < size; i++) {
			Element ele = (Element) doc.getDataNode(Table.USERLIST, i);
			Node node = ele.selectSingleNode(Field.USERID);
			String strId = node == null ? null : node.getText();
			hashId.put(strId, strId);
			storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
		}
		// 执行
		String strReturn = storage.runSQL();
		ReturnDoc returndoc = new ReturnDoc();
		if (!General.empty(strReturn)) {
			returndoc.addErrorResult(Common.RT_FUNCERROR);
			returndoc.setFuncErrorInfo(strReturn);
		} else {
			returndoc.addErrorResult(Common.RT_SUCCESS);
		}

		Enumeration enumkeys = hashId.keys();
		while (enumkeys.hasMoreElements()) {
			UserCache.getInstance().remove((String) enumkeys.nextElement());
		}
		DicCache.getInstance().refresh("USERLIST");
		return returndoc.getXML();

	}

	/*********************************************************
	 * 设置用户口令
	 * 
	 * @param strXml
	 *            XML 数据信息
	 * @return XML 返回信息
	 ***********************************************************/
	public static String setPassword(String strXml) throws Exception {
		DataDoc doc = new DataDoc(strXml);
		// 创建执行对象
		DataStorage storage = new DataStorage();
		String str_UserID = "";
		// 解析sql语句
		Element ele = (Element) doc.getDataNode(Table.USERLIST, 0);
		str_UserID = ele.selectSingleNode(Field.USERID).getText();
		storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
		// 执行
		String strReturn = storage.runSQL();
		ReturnDoc returndoc = new ReturnDoc();
		if (!General.empty(strReturn)) {
			returndoc.addErrorResult(Common.RT_FUNCERROR);
			returndoc.setFuncErrorInfo(strReturn);
		} else {
			returndoc.addErrorResult(Common.RT_SUCCESS);
		}

		UserCache.getInstance().refresh(str_UserID);

		return returndoc.getXML();
	}
	
	/*********************************************************
	 * 设置工资单打印标志
	 * 
	 * @param strXml
	 *            XML 数据信息
	 * @return XML 返回信息
	 ***********************************************************/

	public static String setPrintFlag(String strXml) throws Exception {
		DataDoc doc = new DataDoc(strXml);
		// 创建执行对象
		DataStorage storage = new DataStorage();
		int size = doc.getDataNum(Table.USERLIST);
		Hashtable<String, String> hashId = new Hashtable<String, String>();
		// 解析sql语句
		for (int i = 0; i < size; i++) {
			Element ele = (Element) doc.getDataNode(Table.USERLIST, i);
			ele.setAttributeValue("operation", "1");
			Element printFlagEle = DocumentHelper.createElement("PRINTFLAG");
			printFlagEle.addAttribute("datatype", "0");
			printFlagEle.addAttribute("state", "0");
			printFlagEle.setText("1");
			ele.add(printFlagEle);
			Node node = ele.selectSingleNode(Field.USERID);
			String strId = node == null ? null : node.getText();
			hashId.put(strId, strId);
			storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
		}
		// 执行
		String strReturn = storage.runSQL();
		ReturnDoc returndoc = new ReturnDoc();
		if (!General.empty(strReturn)) {
			returndoc.addErrorResult(Common.RT_FUNCERROR);
			returndoc.setFuncErrorInfo(strReturn);
		} else {
			returndoc.addErrorResult(Common.RT_SUCCESS);
		}

		Enumeration enums = hashId.elements();
		while (enums.hasMoreElements()) {
			UserCache.getInstance().refresh((String) enums.nextElement());
		}
		DicCache.getInstance().refresh(Table.USERLIST);
		return returndoc.getXML();
	}
	
	/*********************************************************
	 * 取消工资单打印标志
	 * 
	 * @param strXml
	 *            XML 数据信息
	 * @return XML 返回信息
	 ***********************************************************/

	public static String cancelPrintFlag(String strXml) throws Exception {
		DataDoc doc = new DataDoc(strXml);
		// 创建执行对象
		DataStorage storage = new DataStorage();
		int size = doc.getDataNum(Table.USERLIST);
		Hashtable<String, String> hashId = new Hashtable<String, String>();
		// 解析sql语句
		for (int i = 0; i < size; i++) {
			Element ele = (Element) doc.getDataNode(Table.USERLIST, i);
			ele.setAttributeValue("operation", "1");
			Element printFlagEle = DocumentHelper.createElement("PRINTFLAG");
			printFlagEle.addAttribute("datatype", "0");
			printFlagEle.addAttribute("state", "0");
			printFlagEle.setText("0");
			ele.add(printFlagEle);
			Node node = ele.selectSingleNode(Field.USERID);
			String strId = node == null ? null : node.getText();
			hashId.put(strId, strId);
			storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
		}
		// 执行
		String strReturn = storage.runSQL();
		ReturnDoc returndoc = new ReturnDoc();
		if (!General.empty(strReturn)) {
			returndoc.addErrorResult(Common.RT_FUNCERROR);
			returndoc.setFuncErrorInfo(strReturn);
		} else {
			returndoc.addErrorResult(Common.RT_SUCCESS);
		}

		Enumeration enums = hashId.elements();
		while (enums.hasMoreElements()) {
			UserCache.getInstance().refresh((String) enums.nextElement());
		}
		DicCache.getInstance().refresh(Table.USERLIST);
		return returndoc.getXML();
	}
}
