package org.ptbank.baseManage;

import java.util.Map;

import org.dom4j.Element;
import org.ptbank.base.CommonQuery;
import org.ptbank.base.QueryDoc;
import org.ptbank.declare.Common;
import org.ptbank.declare.Field;
import org.ptbank.declare.Table;
import org.ptbank.func.General;

/**
 * IdentifyQueryBO 类 该类包含身份认证、后台管理部分的所有查询
 */
public class IdentifyQueryBO implements java.io.Serializable {
	private static final long serialVersionUID = 9159083083064620204L;

	/**
	 * 查询用户信息列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @return XML 标准查询返回结构
	 */
	public static String userList(String strXML) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// // 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		//String str_Select = Table.S + Common.DOT + Field.USERID + Common.SPACE + Field.USERID + Common.COMMA + Table.S + Common.DOT + Field.USERTITLE + Common.SPACE + Field.USERTITLE + Common.COMMA + Table.S + Common.DOT + Field.USERNAME + Common.SPACE + Field.USERNAME + Common.COMMA + Table.S + Common.DOT + Field.SEX + Common.SPACE + Field.SEX + Common.COMMA + Table.S + Common.DOT + Field.UNITID + Common.SPACE + Field.UNITID + Common.COMMA + Table.S + Common.DOT + Field.UNITNAME + Common.SPACE + Field.UNITNAME + Common.COMMA + Table.S + Common.DOT + Field.DEPTNAME + Common.SPACE + Field.DEPTNAME + Common.COMMA + Table.S + Common.DOT + Field.DISABLED + Common.SPACE + Field.DISABLED + Common.COMMA + Table.S + Common.DOT + Field.CANEDITPASSWORD + Common.SPACE + Field.CANEDITPASSWORD + Common.COMMA + Table.S + Common.DOT + Field.IDCARD + Common.SPACE + Field.IDCARD + Common.COMMA + Table.S + Common.DOT + Field.BXDM + Common.SPACE + Field.BXDM + Common.COMMA + Table.S + Common.DOT + Field.USERTYPE + Common.SPACE + Field.USERTYPE;

		String str_Select = "*";
		String str_From = Table.VW_USERLIST + Common.SPACE + Table.S;
		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		// str_Where = General.empty(str_Where) ? Common.ORDER + Field.USERID : str_Where + Common.S_ORDER + Field.USERID;
		//System.out.println(str_Where);

		String[] str_DicFieldList = { Field.DISABLED, Field.CANEDITPASSWORD, Field.SEX, Field.USERTYPE, Field.PRINTFLAG };

		String[] str_DicNameList = { Table.DIC_TRUEFALSE, Table.DIC_ABLE, Table.DIC_GENDER, Table.DIC_USERTYPE, Table.DIC_TRUEFALSE };

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.USERID, str_DicFieldList, str_DicNameList, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询用户信息列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @return XML 标准查询返回结构
	 */
	public static String roleList(String strXML) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = Table.S + Common.DOT + Field.ROLEID + Common.SPACE + Field.ROLEID + Common.COMMA + Table.S + Common.DOT + Field.ROLENAME + Common.SPACE + Field.ROLENAME + Common.COMMA + Table.S + Common.DOT + Field.ROLEDES + Common.SPACE + Field.ROLEDES;

		String str_From = Table.ROLEBASIC + Common.SPACE + Table.S;

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		// str_Where = General.empty(str_Where) ? Common.ORDER + Table.S + Common.DOT + Field.ROLEID : str_Where + Common.S_ORDER + Table.S + Common.DOT + Field.ROLEID;

		String[] str_DicFieldList = null;

		String[] str_DicNameList = null;

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.ROLEID, str_DicFieldList, str_DicNameList, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询事务类型列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @return XML 标准查询返回结构
	 */
	public static String affairTypeList(String strXML) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = Table.S + Common.DOT + Field.AFFAIRTYPEID + Common.SPACE + Field.AFFAIRTYPEID + Common.COMMA + Table.S + Common.DOT + Field.AFFAIRTYPENAME + Common.SPACE + Field.AFFAIRTYPENAME + Common.COMMA + Table.S + Common.DOT + Field.AFFAIRTYPEMODE + Common.SPACE + Field.AFFAIRTYPEMODE + Common.COMMA + Table.S + Common.DOT + Field.AFFAIRTYPEDES + Common.SPACE + Field.AFFAIRTYPEDES + Common.COMMA + Table.S + Common.DOT + Field.SYSTEMID + Common.SPACE + Field.SYSTEMID + Common.COMMA + Table.S + Common.DOT + Field.PARENTID + Common.SPACE + Field.PARENTID;

		String str_From = Table.AFFAIRTYPE + Common.SPACE + Table.S;

		String str_Where = obj_Query.getConditions();
		// 组合条件
		String sTj = " affairtypeid!='0'";

		// 构建标准的查询条件
		str_Where = General.empty(str_Where) ? sTj : str_Where + " AND" + sTj;

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		// str_Where = General.empty(str_Where) ? Common.ORDER + Field.AFFAIRTYPEID : str_Where + Common.S_ORDER + Field.AFFAIRTYPEID;

		String[] str_DicFieldList = { Field.AFFAIRTYPEMODE };

		String[] str_DicNameList = { Table.DIC_AFFAIRTYPEMODE };

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.AFFAIRTYPEID, str_DicFieldList, str_DicNameList, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询事务类型列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @return XML 标准查询返回结构
	 */
	public static String eventTypeList(String strXML) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = Table.S + Common.DOT + Field.EVENTTYPEID + Common.SPACE + Field.EVENTTYPEID + Common.COMMA + Table.S + Common.DOT + Field.EVENTTYPENAME + Common.SPACE + Field.EVENTTYPENAME + Common.COMMA + Table.S + Common.DOT + Field.AFFAIRTYPENAME + Common.SPACE + Field.AFFAIRTYPENAME + Common.COMMA + Table.S + Common.DOT + Field.BEGINEVENT + Common.SPACE + Field.BEGINEVENT + Common.COMMA + Table.S + Common.DOT + Field.DISABLED + Common.SPACE + Field.DISABLED + Common.COMMA + Table.S + Common.DOT + Field.SHORTCUT + Common.SPACE + Field.SHORTCUT + Common.COMMA + Table.S + Common.DOT + Field.VISIBLE + Common.SPACE + Field.VISIBLE;

		String str_From = Table.VW_EVENTTYPE + Common.SPACE + Table.S;

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		// str_Where = General.empty(str_Where) ? Common.ORDER + Field.EVENTTYPEID : str_Where + Common.S_ORDER + Field.EVENTTYPEID;

		String[] str_DicFieldList = { Field.BEGINEVENT, Field.DISABLED, Field.SHORTCUT, Field.VISIBLE };
		String[] str_DicNameList = { Table.DIC_TRUEFALSE, Table.DIC_TRUEFALSE, Table.DIC_TRUEFALSE, Table.DIC_TRUEFALSE };

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.EVENTTYPEID, str_DicFieldList, str_DicNameList, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询错误日志列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @return XML 标准查询返回结构
	 */
	public static String errorLogList(String strXML) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = Table.S + Common.DOT + Field.ERRID + Common.SPACE + Field.ERRID + Common.COMMA + Table.S + Common.DOT + Field.USERID + Common.SPACE + Field.USERID + Common.COMMA + Table.S + Common.DOT + Field.USERNAME + Common.SPACE + Field.USERNAME + Common.COMMA + Table.S + Common.DOT + Field.UNITNAME + Common.SPACE + Field.UNITNAME + Common.COMMA + Table.S + Common.DOT + Field.ERRDES1 + Common.SPACE + Field.ERRDES1 + Common.COMMA + Table.S + Common.DOT + Field.ERRDES2 + Common.SPACE + Field.ERRDES2 + Common.COMMA + Table.S + Common.DOT + Field.OPTIME + Common.SPACE + Field.OPTIME;

		String str_From = Table.ERRLOG + Common.SPACE + Table.S;

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;

		String[] str_DicFieldList = null;
		String[] str_DicNameList = null;

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.ERRID, str_DicFieldList, str_DicNameList, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询错误日志列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @return XML 标准查询返回结构
	 */
	public static String sysLogList(String strXML) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = Table.S + Common.DOT + Field.LOGID + Common.SPACE + Field.LOGID + Common.COMMA + Table.S + Common.DOT + Field.USERID + Common.SPACE + Field.USERID + Common.COMMA + Table.S + Common.DOT + Field.USERTITLE + Common.SPACE + Field.USERTITLE + Common.COMMA + Table.S + Common.DOT + Field.USERNAME + Common.SPACE + Field.USERNAME + Common.COMMA + Table.S + Common.DOT + Field.UNITNAME + Common.SPACE + Field.UNITNAME + Common.COMMA + Table.S + Common.DOT + Field.LOGINIP + Common.SPACE + Field.LOGINIP + Common.COMMA + Table.S + Common.DOT + Field.ENTERTIME + Common.SPACE + Field.ENTERTIME + Common.COMMA + Table.S + Common.DOT + Field.LEAVETIME + Common.SPACE + Field.LEAVETIME + Common.COMMA + Table.S + Common.DOT + Field.MAC + Common.SPACE + Field.MAC;

		String str_From = Table.SYSLOG + Common.SPACE + Table.S;

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;

		String[] str_DicFieldList = null;
		String[] str_DicNameList = null;

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.LOGID + Common.SPACE + Common.S_DESC, str_DicFieldList, str_DicNameList, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询角色权限信息列表（列表返回）
	 * 
	 * @param roleid
	 *            角色编号
	 * @return XML 标准查询返回结构
	 */
	public static String roleRightList(String strXML) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;
		String str_Select = Table.S + Common.DOT + Field.ROLEID + Common.SPACE + Field.ROLEID + Common.COMMA + Table.S + Common.DOT + Field.ROLENAME + Common.SPACE + Field.ROLENAME + Common.COMMA + Table.S + Common.DOT + Field.EVENTTYPEID + Common.SPACE + Field.EVENTTYPEID + Common.COMMA + Table.S + Common.DOT + Field.EVENTTYPENAME + Common.SPACE + Field.EVENTTYPENAME + Common.COMMA + Table.S + Common.DOT + Field.DISABLED + Common.SPACE + Field.DISABLED + Common.COMMA + Table.S + Common.DOT + Field.SHORTCUT + Common.SPACE + Field.SHORTCUT + Common.COMMA + Table.S + Common.DOT + Field.VISIBLE + Common.SPACE + Field.VISIBLE;
		String str_From = Table.VW_ROLEPOWER + Common.SPACE + Table.S;

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;

		String[] str_DicFieldList = { Field.DISABLED, Field.SHORTCUT, Field.VISIBLE };
		String[] str_DicNameList = { Table.DIC_TRUEFALSE, Table.DIC_TRUEFALSE, Table.DIC_TRUEFALSE };

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.EVENTTYPEID, str_DicFieldList, str_DicNameList, null, 99999, 1, 99999, 1, 1);
	}

	/**
	 * 查询角色权限信息列表（列表返回）
	 * 
	 * @param roleid
	 *            角色编号
	 * @return XML 标准查询返回结构
	 */
	public static String roleUserList(String strXML) throws Exception {

		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = "DISTINCT "+ Table.S + Common.DOT + Field.USERID + Common.SPACE + Field.USERID + Common.COMMA + Table.S + Common.DOT + Field.USERTITLE + Common.SPACE + Field.USERTITLE + Common.COMMA + Table.S + Common.DOT + Field.USERNAME + Common.SPACE + Field.USERNAME + Common.COMMA + Table.S + Common.DOT + Field.UNITID + Common.SPACE + Field.UNITID + Common.COMMA + Table.S + Common.DOT + Field.UNITNAME + Common.SPACE + Field.UNITNAME + Common.COMMA + Table.S + Common.DOT + Field.DISABLED + Common.SPACE + Field.DISABLED + Common.COMMA + Table.S + Common.DOT + Field.CANEDITPASSWORD + Common.SPACE + Field.CANEDITPASSWORD + Common.COMMA + Table.S + Common.DOT + Field.USERTYPE + Common.SPACE + Field.USERTYPE;
		String str_From = Table.VW_ROLEUSER + Common.SPACE + Table.S;

		String str_Where = obj_Query.getConditions();
		//System.out.println("str_Select:"+str_Select+" str_From:"+str_From);

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;

		String[] str_DicFieldList = { Field.DISABLED, Field.CANEDITPASSWORD, Field.USERTYPE };
		String[] str_DicNameList = { Table.DIC_TRUEFALSE, Table.DIC_ABLE, Table.DIC_USERTYPE };

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.USERID, str_DicFieldList, str_DicNameList, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询角色权限信息列表（列表返回）
	 * 
	 * @param userid
	 *            用户编号
	 * @return XML 标准查询返回结构
	 */
	public static String userRoleList(String userid) throws Exception {
		String str_Select = Table.S + Common.DOT + Field.ROLEID + Common.SPACE + Field.ROLEID + Common.COMMA + Table.S + Common.DOT + Field.ROLENAME + Common.SPACE + Field.ROLENAME;

		String str_From = Table.VW_ROLEUSER + Common.SPACE + Table.S;

		String str_Where = Common.WHERE + Field.USERID + Common.EQUAL + General.addQuotes(userid);

		String[] str_DicFieldList = null;
		String[] str_DicNameList = null;

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.ROLEID, str_DicFieldList, str_DicNameList, null, 99999, 1, 99999, 1, 1);
	}

	/**
	 * 查询事务类型详细信息
	 * 
	 * @param affairTypeid
	 *            事务类型编号
	 * @return XML 标准查询返回结构
	 */
	public static String affairTypeDetail(String affairTypeid) throws Exception {

		String str_Select = Table.S + Common.DOT + Field.AFFAIRTYPEID + Common.SPACE + Field.AFFAIRTYPEID + Common.COMMA + Table.S + Common.DOT + Field.AFFAIRTYPENAME + Common.SPACE + Field.AFFAIRTYPENAME + Common.COMMA + Table.S + Common.DOT + Field.AFFAIRTYPEMODE + Common.SPACE + Field.AFFAIRTYPEMODE + Common.COMMA + Table.S + Common.DOT + Field.PARENTID + Common.SPACE + Field.PARENTID + Common.COMMA + Table.S + Common.DOT + Field.SYSTEMID + Common.SPACE + Field.SYSTEMID + Common.COMMA + Table.S + Common.DOT + Field.AFFAIRTYPEDES + Common.SPACE + Field.AFFAIRTYPEDES;

		String str_From = Table.AFFAIRTYPE + Common.SPACE + Table.S;

		String str_Where = Common.WHERE + Field.AFFAIRTYPEID + Common.EQUAL + General.addQuotes(affairTypeid);

		String[] str_DicFieldList = { Field.AFFAIRTYPEMODE };
		String[] str_DicNameList = { Table.DIC_AFFAIRTYPEMODE };

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.AFFAIRTYPEID, str_DicFieldList, str_DicNameList, null, 1, 1, 1, 1, 0, true, Table.AFFAIRTYPE);
	}

	/**
	 * 查询事件类型详细信息
	 * 
	 * @param eventTypeid
	 *            事件类型编号
	 * @return XML 标准查询返回结构
	 */
	public static String eventTypeDetail(String eventTypeid) throws Exception {

		String str_Select = Table.S + Common.DOT + Field.EVENTTYPEID + Common.SPACE + Field.EVENTTYPEID + Common.COMMA + Table.S + Common.DOT + Field.EVENTTYPENAME + Common.SPACE + Field.EVENTTYPENAME + Common.COMMA + Table.S + Common.DOT + Field.AFFAIRTYPEID + Common.SPACE + Field.AFFAIRTYPEID + Common.COMMA + Table.S + Common.DOT + Field.OPURL + Common.SPACE + Field.OPURL + Common.COMMA + Table.S + Common.DOT + Field.EVENTTYPEDES + Common.SPACE + Field.EVENTTYPEDES + Common.COMMA + Table.S + Common.DOT + Field.BEGINEVENT + Common.SPACE + Field.BEGINEVENT + Common.COMMA + Table.S + Common.DOT + Field.DISABLED + Common.SPACE + Field.DISABLED + Common.COMMA + Table.S + Common.DOT + Field.SHORTCUT + Common.SPACE + Field.SHORTCUT + Common.COMMA + Table.S + Common.DOT + Field.VISIBLE + Common.SPACE + Field.VISIBLE;

		String str_From = Table.VW_EVENTTYPE + Common.SPACE + Table.S;

		String str_Where = Common.WHERE + Field.EVENTTYPEID + Common.EQUAL + General.addQuotes(eventTypeid);

		String[] str_DicFieldList = { Field.AFFAIRTYPEID, Field.BEGINEVENT, Field.DISABLED, Field.SHORTCUT, Field.VISIBLE };
		String[] str_DicNameList = { Table.DIC_AFFAIRTYPE, Table.DIC_TRUEFALSE, Table.DIC_TRUEFALSE, Table.DIC_TRUEFALSE, Table.DIC_TRUEFALSE };

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.EVENTTYPEID, str_DicFieldList, str_DicNameList, null, 1, 1, 1, 1, 0, true, Table.EVENTTYPE);
	}

	/**
	 * 查询角色详细信息
	 * 
	 * @param roleid
	 *            角色编号
	 * @return XML 标准查询返回结构
	 */
	public static String roleDetail(String roleid) throws Exception {

		String str_Select = Table.S + Common.DOT + Field.ROLEID + Common.SPACE + Field.ROLEID + Common.COMMA + Table.S + Common.DOT + Field.ROLENAME + Common.SPACE + Field.ROLENAME + Common.COMMA + Table.S + Common.DOT + Field.ROLEDES + Common.SPACE + Field.ROLEDES;

		String str_From = Table.ROLEBASIC + Common.SPACE + Table.S;

		String str_Where = Common.WHERE + Field.ROLEID + Common.EQUAL + General.addQuotes(roleid);

		String[] str_DicFieldList = null;
		String[] str_DicNameList = null;

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.ROLEID, str_DicFieldList, str_DicNameList, null, 1, 1, 1, 1, 0, false, Table.ROLEBASIC);
	}

	/**
	 * 查询用户详细信息
	 * 
	 * @param userid
	 *            角色编号
	 * @return XML 标准查询返回结构
	 */
	public static String userDetail(String userid) throws Exception {

		//String str_Select = Table.S + Common.DOT + Field.USERID + Common.SPACE + Field.USERID + Common.COMMA + Table.S + Common.DOT + Field.USERTITLE + Common.SPACE + Field.USERTITLE + Common.COMMA + Table.S + Common.DOT + Field.USERNAME + Common.SPACE + Field.USERNAME + Common.COMMA + Table.S + Common.DOT + Field.SEX + Common.SPACE + Field.SEX + Common.COMMA + Table.S + Common.DOT + Field.DUTY + Common.SPACE + Field.DUTY + Common.COMMA + Table.S + Common.DOT + Field.NATION + Common.SPACE + Field.NATION + Common.COMMA + Table.S + Common.DOT + Field.IDCARD + Common.SPACE + Field.IDCARD + Common.COMMA + Table.S + Common.DOT + Field.NATIVEPLACE + Common.SPACE + Field.NATIVEPLACE + Common.COMMA + Table.S + Common.DOT + Field.EDUCATION + Common.SPACE + Field.EDUCATION + Common.COMMA + Table.S + Common.DOT + Field.ADDRESS + Common.SPACE + Field.ADDRESS + Common.COMMA + Table.S + Common.DOT + Field.USERDES + Common.SPACE + Field.USERDES + Common.COMMA + Table.S + Common.DOT + Field.TEMPADDRESS + Common.SPACE + Field.TEMPADDRESS + Common.COMMA + Table.S + Common.DOT + Field.CONTACT + Common.SPACE + Field.CONTACT + Common.COMMA + Table.S + Common.DOT + Field.SMSTEL + Common.SPACE + Field.SMSTEL + Common.COMMA + Table.S + Common.DOT + Field.BIRTHDAY + Common.SPACE + Field.BIRTHDAY + Common.COMMA + Table.S + Common.DOT + Field.UNITID + Common.SPACE + Field.UNITID + Common.COMMA + Table.S + Common.DOT + Field.UNITNAME + Common.SPACE + Field.UNITNAME + Common.COMMA + Table.S + Common.DOT + Field.DEPTID + Common.SPACE + Field.DEPTID + Common.COMMA + Table.S + Common.DOT + Field.DEPTNAME + Common.SPACE + Field.DEPTNAME + Common.COMMA + Table.S + Common.DOT + Field.DISABLED + Common.SPACE + Field.DISABLED + Common.COMMA + Table.S + Common.DOT + Field.CANEDITPASSWORD + Common.SPACE + Field.CANEDITPASSWORD + Common.COMMA + Table.S + Common.DOT + Field.USERTYPE + Common.SPACE + Field.USERTYPE;
		String str_Select = "*";
		String str_From = Table.VW_USERLIST + Common.SPACE + Table.S;

		String str_Where = Common.WHERE + Field.USERID + Common.EQUAL + General.addQuotes(userid);

		String[] str_FieldData = { Field.BIRTHDAY };

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.USERID, null, null, str_FieldData, 1, 1, 1, 1, 0, true, Table.USERLIST);
	}

	/**
	 * 查询角色中不包含的事件类型
	 * 
	 * @param roleid
	 *            角色编号
	 * @return XML 标准查询返回结构
	 */
	public static String eventTypeList_AddToRole(String strXML) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();
		Map<String, String> map = obj_Query.getConditionMap(strXML);

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = Table.S + Common.DOT + Field.EVENTTYPEID + Common.SPACE + Field.EVENTTYPEID + Common.COMMA + Table.S + Common.DOT + Field.EVENTTYPENAME + Common.SPACE + Field.EVENTTYPENAME + Common.COMMA + Table.S + Common.DOT + Field.AFFAIRTYPENAME + Common.SPACE + Field.AFFAIRTYPENAME + Common.COMMA + Table.S + Common.DOT + Field.DISABLED + Common.SPACE + Field.DISABLED + Common.COMMA + Table.S + Common.DOT + Field.SHORTCUT + Common.SPACE + Field.SHORTCUT + Common.COMMA + Table.S + Common.DOT + Field.VISIBLE + Common.SPACE + Field.VISIBLE;

		String str_From = Table.VW_EVENTTYPE + Common.SPACE + Table.S;

		String str_Where = Common.SELECT + Field.EVENTTYPEID + Common.S_FROM + Table.ROLEPOWER + Common.S_WHERE + Field.ROLEID + Common.EQUAL + General.addQuotes(map.get("ROLEID"));

		str_Where = Common.WHERE + Field.EVENTTYPEID + Common.NOT_IN + General.addBracket(str_Where) + Common.S_AND + Field.AFFAIRTYPEID + Common.N_EQUAL + General.addQuotes("000100");

		String[] str_DicFieldList = { Field.DISABLED, Field.SHORTCUT, Field.VISIBLE };
		String[] str_DicNameList = { Table.DIC_TRUEFALSE, Table.DIC_TRUEFALSE, Table.DIC_TRUEFALSE };

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.EVENTTYPEID, str_DicFieldList, str_DicNameList, null, 99999, 1, 99999, 1, 1);
	}

	/**
	 * 查询添加到指定角色中的用户信息列表（列表返回） 该查询只查询出未添加到该角色中的用户信息列表
	 * 
	 * @param strXML
	 *            xml字符串
	 * @return XML 标准查询返回结构
	 */
	public static String userList_AddToRole(String strXML) throws Exception {

		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = Table.S + Common.DOT + Field.USERID + Common.SPACE + Field.USERID + Common.COMMA + Table.S + Common.DOT + Field.USERTITLE + Common.SPACE + Field.USERTITLE + Common.COMMA + Table.S + Common.DOT + Field.USERNAME + Common.SPACE + Field.USERNAME + Common.COMMA + Table.S + Common.DOT + Field.UNITID + Common.SPACE + Field.UNITID + Common.COMMA + Table.S + Common.DOT + Field.UNITNAME + Common.SPACE + Field.UNITNAME + Common.COMMA + Table.S + Common.DOT + Field.DISABLED + Common.SPACE + Field.DISABLED + Common.COMMA + Table.S + Common.DOT + Field.CANEDITPASSWORD + Common.SPACE + Field.CANEDITPASSWORD + Common.COMMA + Table.S + Common.DOT + Field.USERTYPE + Common.SPACE + Field.USERTYPE;

		String str_From = Table.VW_USERLIST + Common.SPACE + Table.S;

		// String str_Where = Common.SELECT + Field.USERID +
		// Common.S_FROM + Table.ROLEUSER +
		// Common.S_WHERE + Field.ROLEID + Common.EQUAL + General.addQuotes(roleid);
		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		//System.out.println("str_Where:"+str_Where);
		// str_Where = Common.WHERE + Field.USERID + Common.NOT_IN + General.addBracket(str_Where);

		String[] str_DicFieldList = { Field.DISABLED, Field.CANEDITPASSWORD, Field.USERTYPE };
		String[] str_DicNameList = { Table.DIC_TRUEFALSE, Table.DIC_ABLE, Table.DIC_USERTYPE };

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.USERID, str_DicFieldList, str_DicNameList, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询管理单位信息列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @return XML 标准查询返回结构
	 */
	public static String munitList(String strXML) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// // 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = "s." + Field.MUNITID + " " + Field.MUNITID + "," + "s." + Field.MUNITNAME + " " + Field.MUNITNAME + "," + "s." + Field.MSUNITID + " " + Field.MSUNITID + "," + "s." + Field.MTYPE + " " + Field.MTYPE + "," + "s." + Field.MLEVEL + " " + Field.MLEVEL + "," + "s." + Field.JGBM + " " + Field.JGBM + "," + "s." + Field.LXDH + " " + Field.LXDH + "," + "s." + Field.VALID + " " + Field.VALID;
		String str_From = Table.MANAGEUNIT + " s";

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;

		if (General.empty(str_Where)) {
			str_Where = " WHERE " + Field.MTYPE + "!=" + General.addQuotes("AA");
		} else {
			str_Where = str_Where + " AND " + Field.MTYPE + "!=" + General.addQuotes("AA");
		}

		String[] str_DicFieldList = { Field.MSUNITID, Field.MTYPE, Field.MLEVEL, Field.VALID };

		String[] str_DicNameList = { Table.DIC_MANAGEUNIT, Table.DIC_MTYPE, Table.DIC_MLEVEL, Table.DIC_TRUEFALSE };
		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.MUNITID, str_DicFieldList, str_DicNameList, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询管理单位信息列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @return XML 标准查询返回结构
	 */
	public static String deptList(String strXML) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// // 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = "s.DEPTID DEPTID,s.MUNITID MUNITID,s.DEPTNAME DEPTNAME,s.DEPTTYPE DEPTTYPE,s.DEPTLEVEL DEPTLEVEL,s.PARENTID PARENTID,s.JGBM JGBM,s.LXDH LXDH,s.VALID VALID";
		String str_From = "DEPT s";

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;

		String[] str_DicFieldList = { "MUNITID", "DEPTTYPE", "DEPTLEVEL", "VALID" };

		String[] str_DicNameList = { Table.DIC_MANAGEUNIT, "DIC_DTYPE", "DIC_DLEVEL", Table.DIC_TRUEFALSE };
		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "DEPTID", str_DicFieldList, str_DicNameList, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询管理单位详细信息
	 * 
	 * @param munitid
	 *            角色编号
	 * @return XML 标准查询返回结构
	 */
	public static String munitDetail(String munitid) throws Exception {
		String str_Select = "s." + Field.MUNITID + " " + Field.MUNITID + "," + "s." + Field.MUNITNAME + " " + Field.MUNITNAME + "," + "s." + Field.MTYPE + " " + Field.MTYPE + "," + "s." + Field.MDES + " " + Field.MDES + "," + "s." + Field.JGBM + " " + Field.JGBM + "," + "s." + Field.LXDH + " " + Field.LXDH + "," + "s." + Field.MSUNITID + " " + Field.MSUNITID + "," + "s." + Field.VALID + " " + Field.VALID + "," + "s." + Field.MLEVEL + " " + Field.MLEVEL;

		String str_From = Table.MANAGEUNIT + " s";

		String str_Where = "WHERE " + Field.MUNITID + "=" + General.addQuotes(munitid);

		String[] str_DicFieldList = { Field.MTYPE, Field.MSUNITID, Field.VALID, Field.MLEVEL };
		String[] str_DicNameList = { Table.DIC_MTYPE, Table.DIC_MANAGEUNIT, Table.DIC_TRUEFALSE, Table.DIC_MLEVEL };
		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.MUNITID, str_DicFieldList, str_DicNameList, null, 1, 1, 1, 1, 0, true, Table.MANAGEUNIT);
	}

	/**
	 * 查询管理单位详细信息
	 * 
	 * @param munitid
	 *            角色编号
	 * @return XML 标准查询返回结构
	 */
	public static String deptDetail(String deptid) throws Exception {
		String str_Select = "s.DEPTID DEPTID,s.MUNITID MUNITID,s.DEPTNAME DEPTNAME,s.DEPTTYPE DEPTTYPE,s.DEPTLEVEL DEPTLEVEL,s.PARENTID PARENTID,s.JGBM JGBM,s.LXDH LXDH,s.VALID VALID,s.DEPTDESC DEPTDESC";
		String str_From = "DEPT s";

		String str_Where = "WHERE deptid=" + General.addQuotes(deptid);

		String[] str_DicFieldList = { "MUNITID", "DEPTTYPE", "DEPTLEVEL", "VALID" };

		String[] str_DicNameList = { Table.DIC_MANAGEUNIT, "DIC_DTYPE", "DIC_DLEVEL", Table.DIC_TRUEFALSE };
		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "DEPTID", str_DicFieldList, str_DicNameList, null, 1, 1, 1, 1, 0, true, "DEPT");
	}

	/**
	 * 查询任务信息列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @return XML 标准查询返回结构
	 */
	public static String qryTaskList(String strXML) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// // 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = Table.S + Common.DOT + Field.TASKID + Common.SPACE + Field.TASKID + Common.COMMA + Table.S + Common.DOT + Field.OBJID + Common.SPACE + Field.OBJID + Common.COMMA + Table.S + Common.DOT + Field.EVENTTYPEID + Common.SPACE + Field.EVENTTYPEID + Common.COMMA + Table.S + Common.DOT + Field.UNITID + Common.SPACE + Field.UNITID + Common.COMMA + Table.S + Common.DOT + Field.NEXTEVENTTYPEID + Common.SPACE + Field.NEXTEVENTTYPEID + Common.COMMA + Table.S + Common.DOT + Field.NEXTUNITID + Common.SPACE + Field.NEXTUNITID + Common.COMMA + Table.S + Common.DOT + Field.AFFAIRTYPEID + Common.SPACE + Field.AFFAIRTYPEID;

		String str_From = Table.VW_TASKSTATE + Common.SPACE + Table.S;
		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		// str_Where = General.empty(str_Where) ? Common.ORDER + Field.TASKID : str_Where + Common.S_ORDER + Field.TASKID;

		String[] str_DicFieldList = { Field.EVENTTYPEID, Field.UNITID, Field.NEXTEVENTTYPEID, Field.NEXTUNITID, Field.AFFAIRTYPEID };

		String[] str_DicNameList = { Table.DIC_EVENTTYPE, Table.DIC_MANAGEUNIT, Table.DIC_EVENTTYPE, Table.DIC_MANAGEUNIT, Table.DIC_AFFAIRTYPE };

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.TASKID, str_DicFieldList, str_DicNameList, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询拼音列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @return XML 标准查询返回结构
	 */
	public static String spellList(String strXML) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = Table.S + Common.DOT + Field.WORD + Common.SPACE + Field.WORD + Common.COMMA + Table.S + Common.DOT + Field.SPELL + Common.SPACE + Field.SPELL + Common.COMMA + Table.S + Common.DOT + Field.ASPELL + Common.SPACE + Field.ASPELL;
		String str_From = Table.SPELL + Common.SPACE + Table.S;

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;

		String[] str_DicFieldList = null;
		String[] str_DicNameList = null;

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.SPELL, str_DicFieldList, str_DicNameList, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询编码类型信息列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @return XML 标准查询返回结构
	 */
	public static String maxidtypeList(String strXML) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// // 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 10 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = Table.S + Common.DOT + Field.IDTYPE + Common.SPACE + Field.IDTYPE + Common.COMMA + Table.S + Common.DOT + Field.IDNAME + Common.SPACE + Field.IDNAME + Common.COMMA + Table.S + Common.DOT + Field.IDSIZE + Common.SPACE + Field.IDSIZE + Common.COMMA + Table.S + Common.DOT + Field.IDPARA + Common.SPACE + Field.IDPARA + Common.COMMA + Table.S + Common.DOT + Field.IDLOOP + Common.SPACE + Field.IDLOOP + Common.COMMA + Table.S + Common.DOT + Field.IDMIN + Common.SPACE + Field.IDMIN + Common.COMMA + Table.S + Common.DOT + Field.IDMAX + Common.SPACE + Field.IDMAX + Common.COMMA + Table.S + Common.DOT + Field.IDDES + Common.SPACE + Field.IDDES;

		String str_From = Table.MAXIDTYPE + Common.SPACE + Table.S;
		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		// str_Where = General.empty(str_Where) ? Common.ORDER + Field.IDTYPE : str_Where + Common.S_ORDER + Field.IDTYPE;

		String[] str_DicFieldList = { Field.IDPARA, Field.IDLOOP };

		String[] str_DicNameList = { Table.DIC_IDPARA, Table.DIC_TRUEFALSE };

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.IDTYPE, str_DicFieldList, str_DicNameList, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询编码规则详细信息
	 * 
	 * @param idtype
	 *            编码类型
	 * @return XML 标准查询返回结构
	 */
	public static String maxidtypeDetail(String idtype) throws Exception {
		String str_Select = Table.S + Common.DOT + Field.IDTYPE + Common.SPACE + Field.IDTYPE + Common.COMMA + Table.S + Common.DOT + Field.IDNAME + Common.SPACE + Field.IDNAME + Common.COMMA + Table.S + Common.DOT + Field.IDSIZE + Common.SPACE + Field.IDSIZE + Common.COMMA + Table.S + Common.DOT + Field.IDPARA + Common.SPACE + Field.IDPARA + Common.COMMA + Table.S + Common.DOT + Field.IDLOOP + Common.SPACE + Field.IDLOOP + Common.COMMA + Table.S + Common.DOT + Field.IDMIN + Common.SPACE + Field.IDMIN + Common.COMMA + Table.S + Common.DOT + Field.IDMAX + Common.SPACE + Field.IDMAX + Common.COMMA + Table.S + Common.DOT + Field.IDDES + Common.SPACE + Field.IDDES;

		String str_From = Table.MAXIDTYPE + Common.SPACE + Table.S;

		String str_Where = Common.WHERE + Common.SPACE + Field.IDTYPE + Common.EQUAL + General.addQuotes(idtype);

		String[] str_DicFieldList = { Field.IDPARA, Field.IDLOOP };

		String[] str_DicNameList = { Table.DIC_IDPARA, Table.DIC_TRUEFALSE };
		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.IDTYPE, str_DicFieldList, str_DicNameList, null, 1, 1, 1, 1, 0, true, Table.MAXIDTYPE);
	}

	/**
	 * 查询编码类型信息列表（列表返回）
	 * 
	 * @param strIDType
	 *            编码编号
	 * @return XML 标准查询返回结构
	 */
	public static String maxidList(String strIDType) throws Exception {

		String str_Select = Table.S + Common.DOT + Field.IDTYPE + Common.SPACE + Field.IDTYPE + Common.COMMA + Table.S + Common.DOT + Field.ID1 + Common.SPACE + Field.ID1 + Common.COMMA + Table.S + Common.DOT + Field.ID2 + Common.SPACE + Field.ID2 + Common.COMMA + Table.S + Common.DOT + Field.MAXID + Common.SPACE + Field.MAXID;

		String str_From = Table.MAXID + Common.SPACE + Table.S;

		String str_Where = Common.WHERE + Field.IDTYPE + Common.EQUAL + General.addQuotes(strIDType);

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, Field.ID1, null, null, null, 0, 0, 9999, 1, 0);
	}

}
