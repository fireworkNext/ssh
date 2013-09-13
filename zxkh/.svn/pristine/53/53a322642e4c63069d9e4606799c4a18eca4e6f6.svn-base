package org.ptbank.baseManage;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.dom4j.Document;
import org.dom4j.DocumentFactory;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.ptbank.base.CommonQuery;
import org.ptbank.base.NumAssign;
import org.ptbank.base.ReturnDoc;
import org.ptbank.base.SystemLog;
import org.ptbank.base.XmlFunc;
import org.ptbank.bo.UserRight;
import org.ptbank.cache.MUnitCache;
import org.ptbank.cache.SpellCache;
import org.ptbank.cache.UserCache;
import org.ptbank.cache.UserLogonInfo;
import org.ptbank.db.DBConnection;
import org.ptbank.db.DataStorage;
import org.ptbank.declare.Common;
import org.ptbank.declare.Field;
import org.ptbank.declare.Table;
import org.ptbank.func.Encrypt;
import org.ptbank.func.General;
import org.ptbank.func.TreeNode;
import org.ptbank.func.TreeNodeChecked;

import com.alibaba.fastjson.JSON;

public class IdentifyBO {

	/***************************************************************************
	 * 用户登录
	 * 
	 * @param doc
	 *            XML 数据文档
	 * @param usercache
	 *            用户缓存信息
	 * @return UserLogonInfo 返回信息
	 **************************************************************************/
	public static UserLogonInfo loginOn(Document doc, UserCache usercache) throws Exception {
		String strUsertitle = XmlFunc.getNodeValue(doc, Common.XDOC_LOGININFO + Common.BAR + Field.USERTITLE);
		String strPassWord = Encrypt.e(XmlFunc.getNodeValue(doc, Common.XDOC_LOGININFO + Common.BAR + Field.USERPASSWORD));
		String strIP = XmlFunc.getNodeValue(doc, Common.XDOC_LOGININFO + Common.BAR + Field.LOGINIP);
		String strMac = XmlFunc.getNodeValue(doc, Common.XDOC_LOGININFO + Common.BAR + Field.MAC);
		
		UserLogonInfo user = getUserLogonInfo(strUsertitle);

		if (General.empty(user.getUserID())) {
			throw new Exception("用户名/身份证号不存在");
		} else {
			if (!strPassWord.equals(user.getUserPassword())) {
				throw new Exception("用户名/身份证号和密码不匹配");
			}
			user.setLoginIP(strIP);
			user.setMAC(strMac);

			MUnitCache munit = MUnitCache.getInstance();
			user.setUnitName(munit.getMUnitByID(user.getUnitID()).getMUnitName());
			user.setMUnitType(munit.getMUnitByID(user.getUnitID()).getMType());
			user.setMLevel(munit.getMUnitByID(user.getUnitID()).getMLevel());
			String[] arrSys = { user.getUserID(), user.getUserTitle(), user.getUserName(), "", user.getUnitID(), user.getUnitName(), user.getLoginIP(), user.getMAC() };
			String logid = SystemLog.addSysLog(arrSys);
			user.setLogID(logid);
		}
		return user;
	}

	/**
	 * 更新单个用户缓存对象的内容
	 * 
	 * @param strUserTitle
	 *            用户名
	 */
	public static UserLogonInfo getUserLogonInfo(String strUserTitle) throws Exception {
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		UserLogonInfo obj_UserLogonInfo = new UserLogonInfo();
		try {
			String str_SQL = "";
			if (getUserCount(strUserTitle, "2") > 0) {
				// 根据usertitle判断
				str_SQL = Common.SELECT + Common.ALL + Common.S_FROM + Table.VW_USERLIST + Common.S_WHERE + Field.IDCARD + Common.EQUAL + General.addQuotes(strUserTitle);
			} else if (getUserCount(strUserTitle, "1") > 0) {
				// 根据idcard判断
				str_SQL = Common.SELECT + Common.ALL + Common.S_FROM + Table.VW_USERLIST + Common.S_WHERE + Field.USERTITLE + Common.EQUAL + General.addQuotes(strUserTitle);
			} else {
				// 根据userid判断
				str_SQL = Common.SELECT + Common.ALL + Common.S_FROM + Table.VW_USERLIST + Common.S_WHERE + Field.USERID + Common.EQUAL + General.addQuotes(strUserTitle);
			}
			rst = dbc.excuteQuery(str_SQL);

			while (rst.next()) {
				obj_UserLogonInfo.setValueByResult(rst);
			}

		} catch (Exception e) {
			throw e;
		} finally {
			if(rst!=null)
				rst.close();
			dbc.freeConnection();
		}
		return obj_UserLogonInfo;
	}
	
	/**
	 * 根据身份证号或用户登录名判断记录数
	 * 
	 * @param strUserID
	 *            用户编号
	 * @param type
	 *            类型
	 */
	public static int getUserCount(String strUser, String type) throws Exception {
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		int iCnt = 0;
		String str_SQL = "";
		try {
			// / 查询出该用户的信息
			if (type.equals("1")) {
				str_SQL = "select nvl(count(*),0) cnt from userlist where usertitle=" + General.addQuotes(strUser);
			} else if (type.equals("2")) {
				str_SQL = "select nvl(count(*),0) cnt from userlist where idcard=" + General.addQuotes(strUser);
			} else {
				str_SQL = "select nvl(count(*),0) cnt from userlist where userid=" + General.addQuotes(strUser);
			}

			rst = dbc.excuteQuery(str_SQL);

			while (rst.next()) {
				iCnt = rst.getInt(1);
			}

		} catch (Exception e) {
			throw e;
		} finally {
			if(rst!=null)
				rst.close();
			dbc.freeConnection();
		}
		return iCnt;
	}
	
	/**
	 * 根据用户编号刷新该用户的权限功能树文档对象
	 * 
	 * @param strUserID
	 *            用户编号
	 * @return ReturnDoc 该用户的权限功能树文档对象
	 */
	public static ReturnDoc getUserRightsByUserID(UserLogonInfo user) throws Exception {
		// / 查询出该用户的权限信息,根据应用系统和用户来区分显示菜单
		String str_SQL = "";
		// 当用户时system的时候，各应用系统菜单全部显示
		if ("system".equals(user.getUserTitle()))
			str_SQL = Common.SELECT + Common.DISTINCT + Common.ALL + Common.S_FROM + Table.VW_USERRIGHTTREE + Common.S_WHERE + Field.USERID + Common.EQUAL + General.addQuotes(user.getUserID()) + Common.AND + Field.SYSTEMID + Common.IN + "('01','03')" + Common.S_ORDER + Field.AFFAIRTYPEID + Common.COMMA + Field.EVENTTYPEID;
		else
			str_SQL = Common.SELECT + Common.DISTINCT + Common.ALL + Common.S_FROM + Table.VW_USERRIGHTTREE + Common.S_WHERE + Field.USERID + Common.EQUAL + General.addQuotes(user.getUserID()) + Common.AND + Field.SYSTEMID + Common.IN + "('01','03')" + Common.S_ORDER + Field.AFFAIRTYPEID + Common.COMMA + Field.EVENTTYPEID;

		DBConnection dbc = new DBConnection();
		ResultSet rst_UserRight = null;
		try {
			rst_UserRight = dbc.excuteQuery(str_SQL);

			if (rst_UserRight == null) {
				throw new Exception("获得用户权限失败");
			}

			String str_PreAffairTypeID = "";
			String str_PreEventTypeID = "";

			ReturnDoc doc_RightTree = new ReturnDoc();

			Element ele_Root = null;
			Element ele_Query = null;
			Element ele_AffairType = null;

			// / 对结果集进行遍历，用来生成功能树
			while (rst_UserRight.next()) {
				// / 创建查询返回节点
				if (!doc_RightTree.createQueryInfoNode()) {
					throw new Exception("UserCache.setUserRightsByUserID.创建查询返回节点时发生错误");
				} // / if (!doc_RightTree.createQueryInfoNode())

				ele_Root = ele_Root == null ? (Element) doc_RightTree.getQueryInfoNode() : ele_Root;

				String str_AffairTypeID = rst_UserRight.getString(Field.AFFAIRTYPEID);
				String str_AffairTypeName = rst_UserRight.getString(Field.AFFAIRTYPENAME);
				String str_EventTypeID = rst_UserRight.getString(Field.EVENTTYPEID);
				String str_EventTypeName = rst_UserRight.getString(Field.EVENTTYPENAME);
				String str_OpURL = rst_UserRight.getString(Field.OPURL);

				int int_AffairTypeID = Integer.parseInt(str_AffairTypeID);

				Element ele_EventType = null;

				// / 查询事务
				if (int_AffairTypeID == 4) {
					ele_AffairType = DocumentHelper.createElement(Common.XDOC_OPERATION);
					ele_AffairType.addAttribute(Common.XML_PROP_AFFAIRTYPEID, str_AffairTypeID);
					ele_AffairType.addAttribute(Common.XML_PROP_NAME, str_AffairTypeName);
					// ele_AffairType.addAttribute("expanded", "true");
					ele_Query = ele_AffairType;
					ele_Root.add(ele_AffairType);
				} // / if (int_AffairTypeID==4)
				else {
					if (!str_PreAffairTypeID.endsWith(str_AffairTypeID)) {
						ele_AffairType = DocumentHelper.createElement(Table.AFFAIRTYPE);
						ele_AffairType.addAttribute(Common.XML_PROP_AFFAIRTYPEID, str_AffairTypeID);
						ele_AffairType.addAttribute(Common.XML_PROP_TEXT, str_AffairTypeName);
						// ele_AffairType.addAttribute("expanded", "true");
						str_PreAffairTypeID = str_AffairTypeID;
						ele_Root.add(ele_AffairType);
					} // / if
						// (!str_PreAffairTypeID.endsWith(str_AffairTypeID))
				} // / else if(int_AffairTypeID<100000 ||
					// (int_AffairTypeID>=111000 &&
					// int_AffairTypeID<=111999) || int_AffairTypeID>300000)

				// / 相同的事件类型，则不用重复创建
				if (!str_PreEventTypeID.equals(str_EventTypeID)) {
					ele_EventType = DocumentHelper.createElement(Table.EVENTTYPE);
					ele_EventType.addAttribute(Common.XML_PROP_EVENTTYPEID, str_EventTypeID);
					ele_EventType.addAttribute(Common.XML_PROP_TEXT, str_EventTypeName);
					ele_EventType.addAttribute(Common.XML_PROP_OPURL, str_OpURL);
					ele_AffairType.add(ele_EventType);
					str_PreEventTypeID = str_EventTypeID;
				} // / if (!str_PreEventTypeID.equals(str_EventTypeID))
			} // / while (rst_UserRight.next())

			// / 将查询事务节点，追加到权限功能树的最后
			if (ele_Query != null) {
				Element ele_TempQuery = (Element) ele_Query.clone();
				Element ele_QueryInfo = (Element) doc_RightTree.getQueryInfoNode();
				ele_QueryInfo.remove(ele_Query);
				ele_QueryInfo.add(ele_TempQuery);
			} // / if (ele_Query!=null)

			if (!doc_RightTree.addErrorResult(Common.RT_QUERY_SUCCESS)) {
				throw new Exception("添加函数返回结果失败");
			} // / if (!doc_RightTree.addErrorResult(Common.RT_QUERY_SUCCESS))

			return doc_RightTree;
		} catch (Exception e) {
			throw e;
		} finally {
			rst_UserRight.close();
			dbc.freeConnection();
		}
	}

	/**
	 * 根据单位编号递归查询该单位的树文档对象
	 * 
	 * @param sUnitId
	 *            单位编号编号
	 * @return ReturnDoc 该单位的树文档对象
	 */
	public static ReturnDoc getUnitTreeByUnitId(String sUnitId) throws Exception {
		// 查询出该用户的权限信息
		String str_SQL = "select * from manageunit where msunitid='" + sUnitId + "'";

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		try {
			rst = dbc.excuteQuery(str_SQL);

			if (rst == null) {
				throw new Exception("获得单位结果集失败");
			}
			ReturnDoc docUnitTree = new ReturnDoc();

			// 创建查询返回节点
			if (!docUnitTree.createQueryInfoNode()) {
				throw new Exception("IdentifyBO.getUnitByUnitId.创建查询返回节点时发生错误");
			}

			Element eleRoot = null;
			Element eleUnit = null;
			eleRoot = eleRoot == null ? (Element) docUnitTree.getQueryInfoNode() : eleRoot;

			// / 对结果集进行遍历，用来生成功能树
			while (rst.next()) {
				eleUnit = DocumentHelper.createElement(Table.MANAGEUNIT);
				eleUnit.addAttribute("munitid", rst.getString("MUNITID"));
				eleUnit.addAttribute("text", rst.getString("MUNITNAME"));
				eleUnit.addAttribute("leaf", "false");
				eleRoot.add(eleUnit);
			} // / while (rst.next())
				// 递归取子单位
			if (eleRoot.elements().size() > 0)
				getChildByParentElement(eleUnit);

			return docUnitTree;
		} catch (Exception e) {
			throw e;
		} finally {
			rst.close();
			dbc.freeConnection();
		}
	}

	public static void getChildByParentElement(Element parentElement) throws Exception {
		// 根据父单位号码返回子单位信息
		String str_SQL = "select * from manageunit where msunitid='" + parentElement.attributeValue("munitid") + "' order by munitid";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		try {
			rst = dbc.excuteQuery(str_SQL);

			if (rst == null) {
				throw new Exception("获得数据集失败");
			}
			while (rst.next()) {
				Element ele = DocumentHelper.createElement("MANAGEUNIT");
				ele.addAttribute("munitid", rst.getString("MUNITID"));
				ele.addAttribute("text", rst.getString("MUNITNAME"));
				parentElement.add(ele);
				getChildByParentElement(ele);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			rst.close();
			dbc.freeConnection();
		}
	}

	/**
	 * 根据单位编号递归查询该单位下属的所有部门的树文档对象
	 * 
	 * @param sUnitId
	 *            单位编号编号
	 * @return ReturnDoc 该单位的树文档对象
	 */
	public static ReturnDoc getDeptTreeByUnitId(String sUnitId) throws Exception {
		// 查询出该用户的权限信息
		String str_SQL = "select * from dept where munitid='" + sUnitId + "'";

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		try {
			rst = dbc.excuteQuery(str_SQL);

			if (rst == null) {
				throw new Exception("获得部门结果集失败");
			}
			ReturnDoc docTree = new ReturnDoc();

			// 创建查询返回节点
			if (!docTree.createQueryInfoNode()) {
				throw new Exception("IdentifyBO.getDeptTreeByUnitId.创建查询返回节点时发生错误");
			}

			Element eleRoot = null;
			Element ele = null;
			eleRoot = eleRoot == null ? (Element) docTree.getQueryInfoNode() : eleRoot;
			// / 对结果集进行遍历，用来生成功能树
			while (rst.next()) {
				ele = DocumentHelper.createElement("DEPT");
				ele.addAttribute("deptid", rst.getString("DEPTID"));
				ele.addAttribute("text", rst.getString("DEPTNAME"));
				eleRoot.add(ele);
			} // / while (rst.next())
				// 递归取子部门
				// System.out.println("rst.getRow:"+rst.getRow());
			if (eleRoot.elements().size() > 0)
				getDeptChildByParentElement(ele);

			return docTree;
		} catch (Exception e) {
			throw e;
		} finally {
			rst.close();
			dbc.freeConnection();
		}
	}

	public static void getDeptChildByParentElement(Element parentElement) throws Exception {
		// 根据父单位号码返回子单位信息
		String str_SQL = "select * from dept where parentid='" + parentElement.attributeValue("deptid") + "' order by deptid";

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		try {
			rst = dbc.excuteQuery(str_SQL);

			if (rst == null) {
				throw new Exception("获得数据集失败");
			}
			while (rst.next()) {
				Element ele = DocumentHelper.createElement("DEPT");
				ele.addAttribute("deptid", rst.getString("DEPTID"));
				ele.addAttribute("text", rst.getString("DEPTNAME"));
				parentElement.add(ele);
				getChildByParentElement(ele);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			rst.close();
			dbc.freeConnection();
		}
	}

	/*
	 * 功能：异步返回单位树结构
	 * 
	 * @param sUnitId 单位编号
	 */

	public static String getUnitJsonByUnitId(String sUnitId, UserLogonInfo userSession) throws Exception {
		ArrayList arr = null;
		StringBuffer parentBuffer = null;
		String sqlStr = null;
		String sqlStr1 = null;

		if (General.empty(sUnitId)) {
			sqlStr = "select * from manageunit where munitid=" + General.addQuotes(userSession.getUnitID());
		} else {
			sqlStr = "select * from manageunit where msunitid=" + General.addQuotes(sUnitId);
		}
		DBConnection dbc = new DBConnection();
		DBConnection dbc1 = new DBConnection();
		ResultSet rst = null;
		ResultSet rst1 = null;
		try {
			sqlStr1 = "select distinct msunitid from manageunit where msunitid!='0'";
			rst = dbc.excuteQuery(sqlStr1);
			// System.out.println(sqlStr1);
			if (rst == null) {
				throw new Exception("获得数据集失败,sql语句:" + sqlStr1);
			}
			parentBuffer = new StringBuffer();
			parentBuffer.append("|");
			while (rst.next()) {
				parentBuffer.append(rst.getString("msunitid"));
				parentBuffer.append("|");
			}

			// 得到所有的parentMenuBuffer列表（这是一个巧妙的算法^_^）
			String parentString = parentBuffer.toString();
			// System.out.println(parentString);
			arr = new ArrayList();
			rst = dbc.excuteQuery(sqlStr);
			if (rst == null) {
				throw new Exception("获得数据集失败,sql语句:" + sqlStr);
			}
			while (rst.next()) {
				TreeNode treeNode = new TreeNode();
				treeNode.setId(rst.getString("munitid"));
				treeNode.setText(rst.getString("munitname"));
				treeNode.setFlag("1");
				if (parentString.indexOf("|" + rst.getString("munitid") + "|") >= 0) // 父节点
				{
					treeNode.setLeaf(false);
					// treeNode.setExpandable(false);
				} else // 子节点
				{
					treeNode.setLeaf(true);
					// treeNode.setExpandable(false);
				}
				arr.add(treeNode);
			}

			return JSON.toJSONString(arr);// 返回JSON数据
		} catch (Exception e) {
			throw e;
		} finally {
			if (rst != null)
				rst.close();
			if (dbc != null)
				dbc.freeConnection();
			if (rst1 != null)
				rst1.close();
			if (dbc1 != null)
				dbc1.freeConnection();
		}
	}

	/*
	 * 功能：异步返回单位树结构带多选功能
	 * 
	 * @param sUnitId 单位编号
	 */

	public static String getUnitJsonByUnitIdCheck(String sUnitId, UserLogonInfo userSession) throws Exception {
		ArrayList arr = null;
		StringBuffer parentBuffer = null;
		String sqlStr = null;
		String sqlStr1 = null;

		if (General.empty(sUnitId)) {
			sqlStr = "select * from manageunit where munitid=" + General.addQuotes(userSession.getUnitID());
		} else {
			sqlStr = "select * from manageunit where msunitid=" + General.addQuotes(sUnitId);
		}
		DBConnection dbc = new DBConnection();
		DBConnection dbc1 = new DBConnection();
		ResultSet rst = null;
		ResultSet rst1 = null;
		try {
			sqlStr1 = "select distinct msunitid from manageunit where msunitid!='0'";
			rst = dbc.excuteQuery(sqlStr1);
			// System.out.println(sqlStr1);
			if (rst == null) {
				throw new Exception("获得数据集失败,sql语句:" + sqlStr1);
			}
			parentBuffer = new StringBuffer();
			parentBuffer.append("|");
			while (rst.next()) {
				parentBuffer.append(rst.getString("msunitid"));
				parentBuffer.append("|");
			}

			// 得到所有的parentMenuBuffer列表（这是一个巧妙的算法^_^）
			String parentString = parentBuffer.toString();
			// System.out.println(parentString);
			arr = new ArrayList();
			rst = dbc.excuteQuery(sqlStr);
			if (rst == null) {
				throw new Exception("获得数据集失败,sql语句:" + sqlStr);
			}
			while (rst.next()) {
				TreeNodeChecked treeNode = new TreeNodeChecked();
				treeNode.setId(rst.getString("munitid"));
				treeNode.setText(rst.getString("munitname"));
				treeNode.setFlag("1");
				if (parentString.indexOf("|" + rst.getString("munitid") + "|") >= 0) // 父节点
				{
					treeNode.setLeaf(false);
					// treeNode.setExpandable(false);
				} else // 子节点
				{
					treeNode.setLeaf(true);
					// treeNode.setExpandable(false);
				}
				arr.add(treeNode);
			}

			return JSON.toJSONString(arr);// 返回JSON数据
		} catch (Exception e) {
			throw e;
		} finally {
			if (rst != null)
				rst.close();
			if (dbc != null)
				dbc.freeConnection();
			if (rst1 != null)
				rst1.close();
			if (dbc1 != null)
				dbc1.freeConnection();
		}
	}

	/*
	 * 功能：异步返回部门树结构
	 * 
	 * @param flag 1表示传进单位id，2表示传进部门id
	 * 
	 * @param sId 单位id或者部门id
	 */

	public static String getDeptJsonById(String flag, String sId, UserLogonInfo userSession) throws Exception {
		ArrayList arr = null;
		StringBuffer parentBuffer = null;
		String sqlStr = null;
		String sqlStr1 = null;

		// 过滤掉system所在单位
		if ("1".equals(flag))
			sqlStr = "select * from dept where parentid is null and munitid!='420100000000' and munitid=" + General.addQuotes(sId);
		else
			sqlStr = "select * from dept where munitid!='420100000000' and parentid=" + General.addQuotes(sId);

		// System.out.println(sqlStr);
		DBConnection dbc = new DBConnection();
		DBConnection dbc1 = new DBConnection();
		ResultSet rst = null;
		ResultSet rst1 = null;
		try {
			if ("1".equals(flag))
				sqlStr1 = "select distinct parentid from dept start with munitid=" + General.addQuotes(sId) + " connect by nocycle prior deptid=parentid";
			else
				sqlStr1 = "select distinct parentid from dept start with parentid=" + General.addQuotes(sId) + " connect by nocycle prior deptid=parentid";
			rst = dbc.excuteQuery(sqlStr1);
			// System.out.println(sqlStr1);
			if (rst == null) {
				throw new Exception("获得数据集失败,sql语句:" + sqlStr1);
			}
			while (rst.next()) {
				parentBuffer = new StringBuffer();
				parentBuffer.append("|");
				while (rst.next()) {
					parentBuffer.append(rst.getString("parentid"));
					parentBuffer.append("|");
				}
			}

			// 得到所有的parentMenuBuffer列表（这是一个巧妙的算法^_^）
			String parentString = parentBuffer == null ? "" : parentBuffer.toString();
			// System.out.println(parentString);
			arr = new ArrayList();
			rst = dbc.excuteQuery(sqlStr);
			if (rst == null) {
				throw new Exception("获得数据集失败,sql语句:" + sqlStr);
			}
			while (rst.next()) {
				TreeNode treeNode = new TreeNode();
				treeNode.setId(rst.getString("deptid"));
				treeNode.setText(rst.getString("deptname"));
				treeNode.setFlag("2");
				// 判断当前用户是否有管理权限,system为超级管理员,具有所有权限
				if ("system".equals(userSession.getUserTitle()))
					treeNode.setRight(true);
				else {
					String sqlStr2 = "select * from userauth where type='2' and authorg=" + General.addQuotes(rst.getString("deptid")) + " and userid=" + General.addQuotes(userSession.getUserID());
					// System.out.println(sqlStr2);
					rst1 = dbc1.excuteQuery(sqlStr2);
					if (rst1 == null) {
						throw new Exception("获得数据集失败,sql语句:" + sqlStr2);
					}
					if (rst1.next() && rst1.getRow() > 0)
						treeNode.setRight(true);
					else
						treeNode.setRight(false);
					// System.out.println("rst1.getRow:"+rst1.getRow());
				}
				if (parentString.indexOf("|" + rst.getString("deptid") + "|") >= 0) // 父节点
				{
					treeNode.setLeaf(false);
					// treeNode.setExpandable(false);
				} else // 子节点
				{
					treeNode.setLeaf(true);
					// treeNode.setExpandable(false);
				}
				arr.add(treeNode);
			}

			// JSONArray jsonarr = JSONArray.fromObject(arr); // 得到JSON数组
			// System.out.println(Json.toJson(arr));
			return JSON.toJSONString(arr);// 返回JSON数据
		} catch (Exception e) {
			throw e;
		} finally {
			if (rst != null)
				rst.close();
			if (dbc != null)
				dbc.freeConnection();
			if (rst1 != null)
				rst1.close();
			if (dbc1 != null)
				dbc1.freeConnection();
		}
	}

	/**
	 * 根据id递归查询设备类型的树文档对象
	 * 
	 * @param sId
	 *            设备类型id
	 * @return ReturnDoc 设备类型的树文档对象
	 */
	public static ReturnDoc getSblxTreeById(String sId) throws Exception {
		String str_SQL = "select * from sblx where valid='1' and parentId='" + sId + "'";

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		try {
			rst = dbc.excuteQuery(str_SQL);

			if (rst == null) {
				throw new Exception("获得设备类型结果集失败");
			}
			ReturnDoc docTree = new ReturnDoc();

			// 创建查询返回节点
			if (!docTree.createQueryInfoNode()) {
				throw new Exception("IdentifyBO.getSblxTreeById.创建查询返回节点时发生错误");
			}

			Element eleRoot = null;
			Element ele = null;

			// / 对结果集进行遍历，用来生成功能树
			while (rst.next()) {
				eleRoot = eleRoot == null ? (Element) docTree.getQueryInfoNode() : eleRoot;
				String sUnitId1 = rst.getString("ID");
				String sUnitName = rst.getString("NAME");
				ele = DocumentHelper.createElement("SBLX");
				ele.addAttribute("id", rst.getString("ID"));
				ele.addAttribute("text", rst.getString("NAME"));
				eleRoot.add(ele);
				// 递归取子单位
				getSblxChildByParentElement(ele);
			} // / while (rst.next())

			return docTree;
		} catch (Exception e) {
			throw e;
		} finally {
			rst.close();
			dbc.freeConnection();
		}
	}

	public static void getSblxChildByParentElement(Element parentElement) throws Exception {
		// 根据父号码返回子信息
		String str_SQL = "select * from sblx where valid='1' and parentId='" + parentElement.attributeValue("id") + "' order by id";

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		try {
			rst = dbc.excuteQuery(str_SQL);

			if (rst == null) {
				throw new Exception("获得数据集失败");
			}
			while (rst.next()) {
				Element ele = DocumentHelper.createElement("SBLX");
				ele.addAttribute("id", rst.getString("ID"));
				ele.addAttribute("text", rst.getString("NAME"));
				parentElement.add(ele);
				getChildByParentElement(ele);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			rst.close();
			dbc.freeConnection();
		}
	}

	/*
	 * 根据单位代码返回人员信息字典
	 */
	public static String getUserDicByUnitId(String sUnitId) throws Exception {
		SpellCache spellcache = SpellCache.getInstance();
		Document domresult = DocumentFactory.getInstance().createDocument();
		Element root = domresult.addElement("data");

		String strSQL = "SELECT USERID,USERNAME USERNAME FROM VW_USERLIST WHERE USERID NOT IN ('4201000001') AND UNITID=" + General.addQuotes(sUnitId);
		// System.out.println(strSQL);
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		rst = dbc.excuteQuery(strSQL);
		while (rst.next()) {
			String sCode = rst.getString("USERID");
			String sText = rst.getString("USERNAME");

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
		return domresult.asXML();
	}

	/*
	 * 根据用户id返回可管理单位字典
	 */
	public static String getUnitDicByUserId(String sUserId) throws Exception {
		SpellCache spellcache = SpellCache.getInstance();
		Document domresult = DocumentFactory.getInstance().createDocument();
		Element root = domresult.addElement("data");

		String strSQL = "SELECT B.MUNITID UNITID,B.MUNITNAME UNITNAME FROM USERAUTH A,MANAGEUNIT B WHERE A.AUTHORG=B.MUNITID AND A.TYPE='1' AND A.USERID=" + General.addQuotes(sUserId);
		// System.out.println(strSQL);
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		rst = dbc.excuteQuery(strSQL);
		while (rst.next()) {
			String sCode = rst.getString("UNITID");
			String sText = rst.getString("UNITNAME");

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
		return domresult.asXML();
	}

	/*
	 * 根据用户id返回可管理部门字典
	 */
	public static String getDeptDicByUserId(String sUserId) throws Exception {
		SpellCache spellcache = SpellCache.getInstance();
		Document domresult = DocumentFactory.getInstance().createDocument();
		Element root = domresult.addElement("data");

		String strSQL = "SELECT B.DEPTID DEPTID,B.DEPTNAME DEPTNAME FROM USERAUTH A,DEPT B WHERE A.AUTHORG=B.DEPTID AND A.TYPE='2' AND A.USERID=" + General.addQuotes(sUserId);
		// System.out.println(strSQL);
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		rst = dbc.excuteQuery(strSQL);
		while (rst.next()) {
			String sCode = rst.getString("DEPTID");
			String sText = rst.getString("DEPTNAME");

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
		return domresult.asXML();
	}

	// 可管理单位管理
	public static String SeeUserDw(String sUserID) throws Exception {
		String str_Select = "s.AUTHID AUTHID,s.USERID USERID,s.AUTHORG AUTHORG,s.TYPE TYPE";
		// 查询表
		String str_From = "USERAUTH s";
		// 构建标准的查询条件
		String str_Where = Common.WHERE + "USERID ='" + sUserID + "' AND TYPE='1'";

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "AUTHID", null, 9999, 1);
	}

	// //查看可增加的可管理单位manageunit
	public static String SeeDw(String sUserID) throws Exception {
		String str_Select = "s.MUNITID MUNITID,s.MUNITNAME MUNITNAME";
		// 查询表
		String str_From = "MANAGEUNIT s";
		// 构建标准的查询条件
		String str_Where = Common.WHERE + "MUNITID NOT IN (SELECT AUTHORG FROM USERAUTH WHERE USERID='" + sUserID + "' AND TYPE='1') AND MUNITID!='EFS000000000' AND MUNITID!='420100000000'";

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "MUNITID", null, 9999, 1);
	}

	// 增加可管理单位
	public static String DwAdd(String strXML) throws Exception {
		DataStorage obj_Storage = new DataStorage();
		ReturnDoc obj_ReturnDoc = new ReturnDoc();
		String str_SQL = "";
		String strOrdID = "";
		String sUSERID = "";
		String strId = "";
		try {
			Document doc = DocumentHelper.parseText(strXML);
			// System.out.println(strXML);
			Integer len = doc.selectNodes("//MANAGEUNIT").size();
			Element ele1 = (Element) doc.selectSingleNode("//DATAINFO/USERLIST");
			sUSERID = ele1.element("USERID").getText();// /////////
			// 循环增加设备
			for (int i = 0; i < len; i++) {
				strId = NumAssign.assignID_B("000012", General.curYear4() + General.curMonth() + General.curDay());
				Element ele = (Element) doc.selectNodes("//MANAGEUNIT").get(i);
				strOrdID = ele.element("MUNITID").getText();
				str_SQL = "INSERT INTO USERAUTH(AUTHID,USERID,AUTHORG,TYPE) VALUES('" + strId + "','" + sUSERID + "','" + strOrdID + "','1')";
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

	// 删除可管理单位
	public static String DwDel(String strXML) throws Exception {
		DataStorage obj_Storage = new DataStorage();
		ReturnDoc obj_ReturnDoc = new ReturnDoc();
		String str_SQL = "";
		String strOrdID = "";
		String sUSERID = "";
		try {
			Document doc = DocumentHelper.parseText(strXML);
			// System.out.println(strXML);
			Integer len = doc.selectNodes("//USERAUTH").size();
			Element ele1 = (Element) doc.selectSingleNode("//DATAINFO/USERLIST");
			sUSERID = ele1.element("USERID").getText();// /////////
			// 循环增加设备
			for (int i = 0; i < len; i++) {
				Element ele = (Element) doc.selectNodes("//USERAUTH").get(i);
				strOrdID = ele.element("AUTHORG").getText();
				str_SQL = "DELETE FROM USERAUTH WHERE AUTHORG='" + strOrdID + "'  AND USERID='" + sUSERID + "' AND TYPE='1'";
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

	// 可管理部门管理
	public static String SeeUserBm(String sUserID) throws Exception {
		String str_Select = "s.AUTHID AUTHID,s.USERID USERID,s.AUTHORG AUTHORG,s.TYPE TYPE";
		// 查询表
		String str_From = "USERAUTH s";
		// 构建标准的查询条件
		String str_Where = Common.WHERE + "USERID ='" + sUserID + "' AND TYPE='2'";

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "AUTHID", null, 9999, 1);
	}

	// //查看可增加的可管理部门
	public static String SeeBm(String sUserID) throws Exception {
		String str_Select = "s.DEPTID DEPTID,s.DEPTNAME DEPTNAME,s.MUNITID MUNITID";
		// 查询表
		String str_From = "DEPT s";
		// 构建标准的查询条件
		String str_Where = Common.WHERE + "DEPTID NOT IN (SELECT AUTHORG FROM USERAUTH WHERE USERID='" + sUserID + "' AND TYPE='2') AND MUNITID!='EFS000000000' AND MUNITID!='420100000000'";

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "DEPTID", null, 9999, 1);
	}

	// 增加可管理部门
	public static String BmAdd(String strXML) throws Exception {
		DataStorage obj_Storage = new DataStorage();
		ReturnDoc obj_ReturnDoc = new ReturnDoc();
		String str_SQL = "";
		String strOrdID = "";
		String sUSERID = "";
		String strId = "";
		String str_Return = "";
		try {
			Document doc = DocumentHelper.parseText(strXML);
			// System.out.println(strXML);
			Integer len = doc.selectNodes("//DEPT").size();
			Element ele1 = (Element) doc.selectSingleNode("//DATAINFO/USERLIST");
			sUSERID = ele1.element("USERID").getText();// /////////
			// 循环增加可管理部门
			for (int i = 0; i < len; i++) {
				strId = NumAssign.assignID_B("000012", General.curYear4() + General.curMonth() + General.curDay());
				Element ele = (Element) doc.selectNodes("//DEPT").get(i);
				strOrdID = ele.element("DEPTID").getText();
				str_SQL = "INSERT INTO USERAUTH(AUTHID,USERID,AUTHORG,TYPE) VALUES('" + strId + "','" + sUSERID + "','" + strOrdID + "','2')";
				obj_Storage.addSQL(str_SQL);
				// 判断该部门的单位是否存在可管理单位表中
				if (isExistsUnit(strOrdID, sUSERID) < 1) {
					String sUnitId = getUnitIdByDeptId(strOrdID);
					String strId1 = NumAssign.assignID_B("000012", General.curYear4() + General.curMonth() + General.curDay());
					str_SQL = "INSERT INTO USERAUTH(AUTHID,USERID,AUTHORG,TYPE) VALUES('" + strId1 + "','" + sUSERID + "','" + sUnitId + "','1')";
					obj_Storage.addSQL(str_SQL);
				}
				str_Return = obj_Storage.runSQL();
				obj_Storage.clear();
			}

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

	// 根据部门id及用户id判断userauth表中部门所属单位是否存在
	public static int isExistsUnit(String deptid, String userid) throws Exception {
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		int rtn = 0;
		try {
			String sql = "select count(*) cnt from userauth a,dept b where a.authorg=b.munitid and b.deptid='" + deptid + "' and a.userid='" + userid + "'";
			rst = dbc.excuteQuery(sql);
			while (rst.next()) {
				rtn = rst.getInt("cnt");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			rst.close();
			dbc.freeConnection();
		}
		return rtn;
	}

	// 根据部门id返回所属单位id
	public static String getUnitIdByDeptId(String deptid) throws Exception {
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String sUnitId = "";
		try {
			String sql = "select munitid from dept where deptid='" + deptid + "'";
			rst = dbc.excuteQuery(sql);
			while (rst.next()) {
				sUnitId = rst.getString("munitid");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			rst.close();
			dbc.freeConnection();
		}
		return sUnitId;
	}

	// 删除可管理部门
	public static String BmDel(String strXML) throws Exception {
		DataStorage obj_Storage = new DataStorage();
		ReturnDoc obj_ReturnDoc = new ReturnDoc();
		String str_SQL = "";
		String strOrdID = "";
		String sUSERID = "";
		try {
			Document doc = DocumentHelper.parseText(strXML);
			// System.out.println(strXML);
			Integer len = doc.selectNodes("//USERAUTH").size();
			Element ele1 = (Element) doc.selectSingleNode("//DATAINFO/USERLIST");
			sUSERID = ele1.element("USERID").getText();// /////////
			// 循环增加设备
			for (int i = 0; i < len; i++) {
				Element ele = (Element) doc.selectNodes("//USERAUTH").get(i);
				strOrdID = ele.element("AUTHORG").getText();
				str_SQL = "DELETE FROM USERAUTH WHERE AUTHORG='" + strOrdID + "'  AND USERID='" + sUSERID + "' AND TYPE='2'";
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

	/*
	 * 根据用户权限生成用户的权限菜单
	 */
	public static ArrayList getUserRightAffair(String affairtypeid, UserLogonInfo user) throws Exception {
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		ArrayList<UserRight> al = new ArrayList<UserRight>();
		String sParentId = "";
		try {
			if (General.empty(affairtypeid)) {
				sParentId = "0";
			} else {
				sParentId = affairtypeid;
			}
			String sql = "select distinct affairtypeid,affairtypename from vw_userright where parentid=" + General.addQuotes(sParentId) + " and userid=" + General.addQuotes(user.getUserID());
			sql += " order by to_number(affairtypeid)";
			rst = dbc.excuteQuery(sql);
			while (rst.next()) {
				UserRight userRight = new UserRight();
				userRight.setAffairtypeId(rst.getString("affairtypeid"));
				userRight.setAffairtypeName(rst.getString("affairtypename"));
				al.add(userRight);
			}
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

	/*
	 * 根据用户权限生成用户的权限菜单
	 */
	public static ArrayList getUserRightEvent(String affairtypeid, UserLogonInfo user) throws Exception {
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		ArrayList<UserRight> al = new ArrayList<UserRight>();
		String sParentId = "";
		try {
			if (General.empty(affairtypeid)) {
				sParentId = "0";
			} else {
				sParentId = affairtypeid;
			}
			String sql = "select distinct eventtypeid,eventtypename,opurl from vw_userright where affairtypeid=" + General.addQuotes(sParentId) + " and userid=" + General.addQuotes(user.getUserID());
			sql += " order by to_number(eventtypeid)";
			rst = dbc.excuteQuery(sql);
			while (rst.next()) {
				UserRight userRight = new UserRight();
				userRight.setEventtypeId(rst.getString("eventtypeid"));
				userRight.setEventtypeName(rst.getString("eventtypename"));
				userRight.setOpurl(rst.getString("opurl"));
				al.add(userRight);
			}
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

	/*
	 * 根据usertilte检查用户名称是否存在
	 */
	public static String checkUserTitle(String strXML) throws Exception {
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strCount = "0";
		try {
			String sql = "select nvl(count(*),0) cnt from userlist where usertitle=" + General.addQuotes(strXML);
			rst = dbc.excuteQuery(sql);
			while (rst.next()) {
				strCount = rst.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			rst.close();
			dbc.freeConnection();
		}
		return strCount;
	}
	
	/*
	 * 根据idcard检查用户身份证是否存在
	 */
	public static String checkUserIdcard(String strXML) throws Exception {
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strCount = "0";
		try {
			String sql = "select nvl(count(*),0) cnt from userlist where idcard=" + General.addQuotes(strXML);
			rst = dbc.excuteQuery(sql);
			while (rst.next()) {
				strCount = rst.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			rst.close();
			dbc.freeConnection();
		}
		return strCount;
	}
	
	/*
	 * 根据字典名返回字典列表
	 */
	public static String getDic(String sDic,UserLogonInfo userSession) throws Exception {
		SpellCache spellcache = SpellCache.getInstance();
		Document domresult = DocumentFactory.getInstance().createDocument();
		Element root = domresult.addElement("data");		
		//根据字典数据自动生成
		String strSQL = "select dic_code,dic_text from dicdata where dic_valid='1' and dicname="+General.addQuotes(sDic);
		strSQL +=" order by dic_ord";
		// System.out.println(strSQL);
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		rst = dbc.excuteQuery(strSQL);
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
		return domresult.asXML();
	}
	
	/*
	 * 根据字典名返回字典列表
	 */
	public static String getDicBySQL(String strSQL,UserLogonInfo userSession) throws Exception {
		SpellCache spellcache = SpellCache.getInstance();
		Document domresult = DocumentFactory.getInstance().createDocument();
		Element root = domresult.addElement("data");		
		// System.out.println(strSQL);
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		rst = dbc.excuteQuery(strSQL);
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
		return domresult.asXML();
	}
	
	/*
	 * 功能：异步返回数据对象树结构
	 * 
	 * @param sId 编号
	 */

	public static String getDbObjectJsonById(String sId, UserLogonInfo userSession) throws Exception {
		ArrayList arr = null;
		StringBuffer parentBuffer = null;
		String sqlStr = null;
		String sqlStr1 = null;

		if("0".equals(sId)){
			sqlStr = "select object_type id,object_type text from user_objects group by object_type order by object_type";
		}else{
			sqlStr = "select object_id id,object_name text from user_objects where object_type=" + General.addQuotes(sId);
		}
		
		DBConnection dbc = new DBConnection();
		DBConnection dbc1 = new DBConnection();
		ResultSet rst = null;
		ResultSet rst1 = null;
		try {
			sqlStr1 = "select distinct object_type from user_objects order by object_type";
			rst = dbc.excuteQuery(sqlStr1);
			// System.out.println(sqlStr1);
			if (rst == null) {
				throw new Exception("获得数据集失败,sql语句:" + sqlStr1);
			}
			parentBuffer = new StringBuffer();
			parentBuffer.append("|");
			while (rst.next()) {
				parentBuffer.append(rst.getString(1));
				parentBuffer.append("|");
			}

			// 得到所有的parentMenuBuffer列表（这是一个巧妙的算法^_^）
			String parentString = parentBuffer.toString();
			// System.out.println(parentString);
			arr = new ArrayList();
			rst = dbc.excuteQuery(sqlStr);
			if (rst == null) {
				throw new Exception("获得数据集失败,sql语句:" + sqlStr);
			}
			while (rst.next()) {
				TreeNode treeNode = new TreeNode();
				treeNode.setId(rst.getString("id"));
				treeNode.setText(rst.getString("text"));
				treeNode.setFlag("1");
				if (parentString.indexOf("|" + rst.getString("id") + "|") >= 0) // 父节点
				{
					treeNode.setLeaf(false);
					// treeNode.setExpandable(false);
				} else // 子节点
				{
					treeNode.setLeaf(true);
					// treeNode.setExpandable(false);
				}
				arr.add(treeNode);
			}

			return JSON.toJSONString(arr);// 返回JSON数据
		} catch (Exception e) {
			throw e;
		} finally {
			if (rst != null)
				rst.close();
			if (dbc != null)
				dbc.freeConnection();
			if (rst1 != null)
				rst1.close();
			if (dbc1 != null)
				dbc1.freeConnection();
		}
	}
}
