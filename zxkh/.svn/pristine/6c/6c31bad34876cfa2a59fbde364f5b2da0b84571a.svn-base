package org.ptbank.action;

import java.io.PrintWriter;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.ptbank.base.XmlFunc;
import org.ptbank.baseManage.AffairTypeBO;
import org.ptbank.baseManage.DeptBO;
import org.ptbank.baseManage.Dic;
import org.ptbank.baseManage.EventTypeBO;
import org.ptbank.baseManage.IdentifyBO;
import org.ptbank.baseManage.IdentifyQueryBO;
import org.ptbank.baseManage.RoleBO;
import org.ptbank.baseManage.UnitsBO;
import org.ptbank.baseManage.UserBO;
import org.ptbank.bo.GzcxBO;
import org.ptbank.bo.WageUser;
import org.ptbank.cache.SpellCache;
import org.ptbank.cache.UserCache;
import org.ptbank.cache.UserLogonInfo;
import org.ptbank.func.General;
import org.ptbank.func.PageCommon;

public class IdentifyAction extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4253291428080351359L;

	public String login() throws Exception {
		try {
			String strXml = request.getParameter("txtXML");
			Document doc = DocumentHelper.parseText(strXml);
			UserCache usercache = (UserCache) request.getSession().getServletContext().getAttribute("g_user");

			UserLogonInfo user = IdentifyBO.loginOn(doc, usercache);
			if (!General.empty(user.getUserID())) {
				request.getSession().setAttribute("user", user);

				return "success";
			}
			return null;
		} catch (Exception e) {
			request.setAttribute("url", "login.jsp");
			request.setAttribute("msg", e.getMessage());
			return "failed";
		}
	}

	public String wageLogin() throws Exception {
		try {
			String strXml = request.getParameter("txtXML");
			Document doc = DocumentHelper.parseText(strXml);

			WageUser wageUser = GzcxBO.loginOn(doc);
			if (wageUser != null) {
				request.getSession().setAttribute("user", wageUser);
				if ("88888888".equals(wageUser.getPasswd()))
					return "modpasswd";
				else
					return "success";
			}
			return null;
		} catch (Exception e) {
			request.setAttribute("url", "default.jsp");
			request.setAttribute("msg", e.getMessage());
			return "failed";
		}
	}

	// 成功提示并返回
	public String goSuHint(String url, String msg) {
		try {
			String strMsg = msg;
			strMsg = strMsg.replaceAll("'", "＇");
			strMsg = strMsg.replaceAll("\\(", "（");
			strMsg = strMsg.replaceAll("\\)", "）");
			strMsg = strMsg.replaceAll("\n", "<br>");

			request.setAttribute("url", url);
			request.setAttribute("msg", strMsg);
			return "goSuHint";
		} catch (Exception e) {
			request.setAttribute("url", "back");
			request.setAttribute("msg", e.getMessage());
			return "goErHint";
		}
	}

	// 错误提示并返回
	public String goErHint(String url, String msg) {
		try {
			String strMsg = msg;
			strMsg = strMsg.replaceAll("'", "＇");
			strMsg = strMsg.replaceAll("\\(", "（");
			strMsg = strMsg.replaceAll("\\)", "）");
			strMsg = strMsg.replaceAll("\n", "<br>");

			url = General.empty(url) ? "back" : url;
			request.setAttribute("url", url);
			request.setAttribute("msg", strMsg);
			return "goErHint";
		} catch (Exception e) {
			request.setAttribute("url", "back");
			request.setAttribute("msg", e.getMessage());
			return "goErHint";
		}
	}

	// 查询用户权限
	public void getUserRight() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();

			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = IdentifyBO.getUserRightsByUserID(userSession).getXML();
			// String strRetXml =
			// "<EFSFRAME efsframae='urn=www-efsframe-cn' version='1.0'>"
			// +"<QUERYINFO>"
			// +"<AFFAIRTYPE affairtypeid='000100' text='开发配置'>"
			// +"<EVENTTYPE eventtypeid='000101' text='事务类型管理' opurl='developer/affairtypelist.jsp'><EVENTTYPE eventtypeid='11' text='11'/></EVENTTYPE>"
			// +"<EVENTTYPE eventtypeid='000102' text='事件类型管理' opurl='developer/eventtypelist.jsp' />"
			// +"</AFFAIRTYPE></QUERYINFO></EFSFRAME>";
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获得事务类型列表
	 */
	public void getRsQryAffairTypeList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8"); // 这句话最重要
			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");

			String strRetXml = IdentifyQueryBO.affairTypeList(strRet);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获得事件类型列表
	 */
	public void getRsQryEventTypeList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8"); // 这句话最重要
			PrintWriter out = response.getWriter();
			String strRetXml = IdentifyQueryBO.eventTypeList(request.getParameter("txtXML"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 事务处理
	public String affairDeal() throws Exception {

		String strXml = request.getParameter("txtXML");
		// strXml = new String(strXml).getBytes("GBK");

		UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
		String strToXml = PageCommon.setDocXML(strXml, userSession);

		String url = "", msg = "";
		String strRetXml = AffairTypeBO.addOrEdit(strToXml);

		if (PageCommon.IsSucceed(strRetXml)) {
			url = "developer/affairtypelist.jsp";
			msg = "维护事务成功，请重新生成字典文件！";
			return goSuHint(url, msg);
		} else {
			String strErr = PageCommon.getErrInfo(strRetXml);
			url = "developer/affairtypelist.jsp";
			msg = "维护事务失败，失败原因：" + strErr;
			return goErHint(url, msg);
		}
	}

	// 事务处理
	public String eventDeal() throws Exception {
		String strXml = request.getParameter("txtXML");
		UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
		String strToXml = PageCommon.setDocXML(strXml, userSession);

		String url = "", msg = "";
		String strRetXml = EventTypeBO.addOrEdit(strToXml);

		if (PageCommon.IsSucceed(strRetXml)) {
			url = "developer/eventtypelist.jsp";
			msg = "维护事件成功，请重新生成字典文件！";
			return goSuHint(url, msg);
		} else {
			String strErr = PageCommon.getErrInfo(strRetXml);
			url = "developer/eventtypelist.jsp";
			msg = "维护事件失败，失败原因：" + strErr;
			return goErHint(url, msg);
		}
	}

	// 角色处理
	public String roleAddNew() throws Exception {
		String strXml = request.getParameter("txtXML");
		UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
		String strToXml = PageCommon.setDocXML(strXml, userSession);

		String url = "", msg = "";
		String strRetXml = RoleBO.addNew(strToXml);

		if (PageCommon.IsSucceed(strRetXml)) {
			url = "sysadmin/rolelist.jsp";
			msg = "添加角色成功！";
			return goSuHint(url, msg);
		} else {
			String strErr = PageCommon.getErrInfo(strRetXml);
			url = "back";
			msg = "添加角色失败，失败原因：" + strErr;
			return goErHint(url, msg);
		}
	}

	// 角色处理
	public String roleEdit() throws Exception {
		String strXml = request.getParameter("txtXML");
		UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
		String strToXml = PageCommon.setDocXML(strXml, userSession);

		String url = "", msg = "";
		String strRetXml = RoleBO.edit(strToXml);

		if (PageCommon.IsSucceed(strRetXml)) {
			url = "sysadmin/rolelist.jsp";
			msg = "修改角色成功！";
			return goSuHint(url, msg);
		} else {
			String strErr = PageCommon.getErrInfo(strRetXml);
			url = "back";
			msg = "修改角色失败，失败原因：" + strErr;
			return goErHint(url, msg);
		}
	}

	// 角色处理
	public String roleDrop() throws Exception {
		String strXml = request.getParameter("txtXML");
		UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
		String strToXml = PageCommon.setDocXML(strXml, userSession);

		String url = "", msg = "";
		String strRetXml = RoleBO.drop(strToXml);

		if (PageCommon.IsSucceed(strRetXml)) {
			url = "sysadmin/rolelist.jsp";
			msg = "删除角色成功！";
			return goSuHint(url, msg);
		} else {
			String strErr = PageCommon.getErrInfo(strRetXml);
			url = "sysadmin/rolelist.jsp";
			msg = "删除角色失败，失败原因：" + strErr;
			return goErHint(url, msg);
		}
	}

	/**
	 * 查询角色权限信息列表（列表返回）
	 */
	public void getRsQryRoleRightList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRetXml = IdentifyQueryBO.roleRightList(request.getParameter("txtXML"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 查询角色权限信息列表（列表返回）
	 */
	public void getRsQryRoleUserList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			// System.out.println("txtXML:"+request.getParameter("txtXML"));
			String strRetXml = IdentifyQueryBO.roleUserList(request.getParameter("txtXML"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 查询未包含在角色中的权限信息列表（列表返回）
	 */
	public void getEventTypeList_AddToRole() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRetXml = IdentifyQueryBO.eventTypeList_AddToRole(request.getParameter("txtXML"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void userList_AddToRole() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			String strRetXml = IdentifyQueryBO.userList_AddToRole(strXML);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 给角色添加用户
	 */
	public void backAddUserToRole() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();

			String strRetXml = RoleBO.addUserToRole(request.getParameter("txtOpXml"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 从角色删除用户
	 */
	public void backDropUserfrmRole() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRetXml = RoleBO.dropUserFromRole(request.getParameter("txtOpXml"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 给角色添加事件
	 */
	public void backAddEventToRole() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtOpXml");

			String strRetXml = RoleBO.addEventToRole(strXML);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 从角色中删除事件
	 */
	public void backDropEventfrmRole() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRetXml = RoleBO.dropEventFromRole(request.getParameter("txtOpXml"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 删除用户
	public void userDrop() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();

			String strXml = request.getParameter("txtOpXml");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXml, userSession);

			String strRetXml = UserBO.drop(strToXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 修改用户密码
	public void userSetPassword() throws Exception {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();

			String strXml = request.getParameter("txtOpXml");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			strXml = PageCommon.setDocXML(strXml, userSession);

			String strRetXml = UserBO.setPassword(strXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 修改用户密码
	public String modPasswd() throws Exception {
		String strXml = request.getParameter("txtXML");
		// System.out.println("strXml:"+strXml);
		String url = "", msg = "";
		String strRetXml = GzcxBO.modPasswd(strXml);
		UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
		if (PageCommon.IsSucceed(strRetXml)) {
			url = "login.jsp";
			msg = "设置用户密码成功,请重新登录！";
			//UserCache.getInstance().refresh(userSession.getUserID());
			return goSuHint(url, msg);
		} else {
			String strErr = PageCommon.getErrInfo(strRetXml);
			url = "back";
			msg = "设置用户密码失败，失败原因：" + strErr;
			return goErHint(url, msg);
		}
	}

	// 生成字典文件
	public String toCreateDicFile() throws Exception {
		String strDicName = request.getParameter("txtXML");
		String strUrl = request.getParameter("txtNextUrl");
		try {
			General.createDicFile(strDicName);
			return goSuHint(strUrl, "生成字典文件成功！");
		} catch (Exception e) {
			return goErHint(strUrl, "生成字典文件失败！");
		}
	}

	// 生成字典文件
	public void CreateDicFile() {
		try {
			response.setContentType("text/html;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();

			General.createDicFile(request.getParameter("txtDicName"));
			out.write("");
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 添加新字典
	public String dicAddNew() throws Exception {
		String sDicName = request.getParameter("txtDicName");
		String sDicDes = request.getParameter("txtDicDes");
		String sTextLen = request.getParameter("txtTextLen");
		String sCodeLen = request.getParameter("txtCodeLen");
		String sEditable = request.getParameter("txtEditable");

		String url = "", msg = "";
		String strRetXml = Dic.addNewDic(sDicName, sDicDes, sCodeLen, sTextLen, sEditable);

		if (PageCommon.IsSucceed(strRetXml)) {
			url = "sysadmin/diclist.jsp";
			msg = "添加字典成功！";
			return goSuHint(url, msg);
		} else {
			String strErr = PageCommon.getErrInfo(strRetXml);
			url = "sysadmin/diclist.jsp";
			msg = "添加字典失败，失败原因：" + strErr;
			return goErHint(url, msg);
		}
	}

	// 维护字典条目
	public void dicVindicate() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtOpXml");
			Document doc = XmlFunc.CreateNewDoc(strXML);

			String strDicName = XmlFunc.getNodeValue(doc, "DICDATA/DICNAME");
			String strDicCode = XmlFunc.getNodeValue(doc, "DICDATA/DIC_CODE");
			String strDicText = XmlFunc.getNodeValue(doc, "DICDATA/DIC_TEXT");
			String strDicValidCode = XmlFunc.getNodeValue(doc, "DICDATA/DICVALID");
			String strDicOrd = XmlFunc.getNodeValue(doc, "DICDATA/DIC_ORD");

			String strRetXml = Dic.vindicate(strDicName, strDicCode, strDicText, strDicValidCode, strDicOrd);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void dicDelItem() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strDicName = request.getParameter("txtDicName");
			String strDicCode = request.getParameter("txtDicCode");

			String strRetXml = Dic.deleteItem(strDicName, strDicCode);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void dicDel() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strDicName = request.getParameter("txtDicName");

			String strRetXml = Dic.deleteDic(strDicName);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public String spellDeal() throws Exception {
		char sText = (request.getParameter("txtText").toCharArray())[0];
		char sSpell = (request.getParameter("txtSpell").toCharArray())[0];
		String sASpell = request.getParameter("txtASpell");

		String url = "", msg = "";
		try {
			SpellCache.getInstance().update(sText, sSpell, sASpell);
			url = "sysadmin/spelllist.jsp";
			msg = "维护汉字成功！";
			return goSuHint(url, msg);
		} catch (Exception e) {
			url = "back";
			msg = "维护汉字失败，失败原因：" + e.getMessage();
			return goErHint(url, msg);
		}
	}

	// 设置用户密码
	public String SetPassword() throws Exception {
		String strXml = request.getParameter("txtXML");
		UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
		String strToXml = PageCommon.setDocXML(strXml, userSession);

		String url = "", msg = "";
		String strRetXml = UserBO.setPassword(strToXml);

		if (PageCommon.IsSucceed(strRetXml)) {
			url = "task.jsp";
			msg = "设置用户密码成功！";
			return goSuHint(url, msg);
		} else {
			String strErr = PageCommon.getErrInfo(strRetXml);
			url = "back";
			msg = "设置用户密码失败，失败原因：" + strErr;
			return goErHint(url, msg);
		}
	}

	// 查询已分配编码列表
	public void getQryMaxList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();

			String strIDType = request.getParameter("txtXML");

			String strRetXml = IdentifyQueryBO.maxidList(strIDType);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void getDeptList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();

			String strRetXml = IdentifyQueryBO.deptList(request.getParameter("txtXML"));
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void deptDeal() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXML, userSession);

			String strRetXml = DeptBO.addOrEdit(strToXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void getDeptDetail() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRetXml = IdentifyQueryBO.deptDetail(request.getParameter("txtID"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 查询单位详细信息
	public void getMunitDetail() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRetXml = IdentifyQueryBO.munitDetail(request.getParameter("txtUnitID"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 单位处理
	public void unitDeal() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXML, userSession);

			String strRetXml = UnitsBO.addOrEdit(strToXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 查询单位信息列表（列表返回）
	 */
	public void getRsQryMunitList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();

			String strRetXml = IdentifyQueryBO.munitList(request.getParameter("txtXML"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void getUserDetail() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRetXml = IdentifyQueryBO.userDetail(request.getParameter("txtUserID"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 添加人员
	public void userAdd() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXML, userSession);
			String strRetXml = UserBO.addNew(strToXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 修改人员
	public void userEdit() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXML, userSession);
			String strRetXml = UserBO.edit(strToXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String createDeptDicFile() {
		String strDicName = request.getParameter("txtXML");
		String strUrl = request.getParameter("txtNextUrl");
		try {
			DeptBO.createDeptDicFile();
			return goSuHint(strUrl, "生成字典文件成功！");
		} catch (Exception e) {
			return goErHint(strUrl, "生成字典文件失败！");
		}
	}

	public void getUserList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8"); // 这句话最重要
			PrintWriter out = response.getWriter();
			String strRetXml = IdentifyQueryBO.userList(request.getParameter("txtXML"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 返回单位的树结构
	public void getUnitTree() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String sUnitId = request.getParameter("txtXML");
			if (General.empty(sUnitId))
				sUnitId = "0";
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = IdentifyBO.getUnitTreeByUnitId(sUnitId).getXML();
			// String strRetXml =
			// "[{id:1,text:'节点一'},{id:2,text:'节点二',leaf:true}]";
			// System.out.println(strRetXml);
			// String strRetXml = "<EFSFRAME efsframae='urn=www-efsframe-cn'
			// version='1.0'>"
			// +"<QUERYINFO>"
			// +"<AFFAIRTYPE affairtypeid='000100' text='开发配置'>"
			// +"<EVENTTYPE eventtypeid='000101' text='事务类型管理'
			// opurl='developer/affairtypelist.jsp'><EVENTTYPE eventtypeid='11'
			// text='11'/></EVENTTYPE>"
			// +"<EVENTTYPE eventtypeid='000102' text='事件类型管理'
			// opurl='developer/eventtypelist.jsp' />"
			// +"</AFFAIRTYPE></QUERYINFO></EFSFRAME>";
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 异步返回单位的树结构json格式
	public void getUnitJsonTree() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String sUnitId = request.getParameter("node");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			if (General.empty(sUnitId) || sUnitId.indexOf("ynode") != -1) {
				if ("system".equalsIgnoreCase(userSession.getUserTitle()))
					sUnitId = "0";
				else
					sUnitId = "";
			}

			String strRetXml = IdentifyBO.getUnitJsonByUnitId(sUnitId, userSession);
			// String strRetXml =
			// "[{id:1,text:'节点一'},{id:2,text:'节点二',leaf:true}]";
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 异步返回单位的树结构json格式
	public void getUnitJsonCheckTree() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String sUnitId = request.getParameter("node");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			if (General.empty(sUnitId) || sUnitId.indexOf("ynode") != -1) {
				if ("system".equalsIgnoreCase(userSession.getUserTitle()))
					sUnitId = "0";
				else
					sUnitId = "";
			}

			String strRetXml = IdentifyBO.getUnitJsonByUnitIdCheck(sUnitId, userSession);
			// String strRetXml =
			// "[{id:1,text:'节点一'},{id:2,text:'节点二',leaf:true}]";
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 异步返回部门的树结构json格式
	public void getDeptJsonTree() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String sTreeUnitId = request.getParameter("txtXML");
			String sFlag = "";
			String sId = request.getParameter("node");
			if (General.empty(sId) || sId.indexOf("ynode") != -1) {
				sId = sTreeUnitId;
				sFlag = "1";
			} else
				sFlag = "2";
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = IdentifyBO.getDeptJsonById(sFlag, sId, userSession);
			// String strRetXml =
			// "[{id:1,text:'节点一'},{id:2,text:'节点二',leaf:true}]";
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 返回部门的树结构
	public void getDeptTreeByUnitId() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String sUnitId = request.getParameter("txtXML");
			if (General.empty(sUnitId))
				sUnitId = "0";
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = IdentifyBO.getDeptTreeByUnitId(sUnitId).getXML();
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 返回单位的树结构
	public void getSblxTree() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();

			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = IdentifyBO.getSblxTreeById("0").getXML();
			// System.out.println(strRetXml);
			// String strRetXml = "<EFSFRAME efsframae='urn=www-efsframe-cn'
			// version='1.0'>"
			// +"<QUERYINFO>"
			// +"<AFFAIRTYPE affairtypeid='000100' text='开发配置'>"
			// +"<EVENTTYPE eventtypeid='000101' text='事务类型管理'
			// opurl='developer/affairtypelist.jsp'><EVENTTYPE eventtypeid='11'
			// text='11'/></EVENTTYPE>"
			// +"<EVENTTYPE eventtypeid='000102' text='事件类型管理'
			// opurl='developer/eventtypelist.jsp' />"
			// +"</AFFAIRTYPE></QUERYINFO></EFSFRAME>";
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 根据单位代码返回人员信息字典
	public void getUserDicByUnitId() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String sUnitId = request.getParameter("txtXML");
			if (General.empty(sUnitId))
				sUnitId = "0";
			String strRetXml = IdentifyBO.getUserDicByUnitId(sUnitId);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 根据用户id返回可管理单位字典
	public void getUnitDicByUserId() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String sUserId = request.getParameter("txtXML");
			String strRetXml = IdentifyBO.getUnitDicByUserId(sUserId);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 根据用户id返回可管理部门字典
	public void getDeptDicByUserId() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String sUserId = request.getParameter("txtXML");
			String strRetXml = IdentifyBO.getDeptDicByUserId(sUserId);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 可管理单位管理
	public void UserDwSee() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			String strRetXml = IdentifyBO.SeeUserDw(strXML);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 查看可增加的可管理单位manageunit
	public void DwSee() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			String strRetXml = IdentifyBO.SeeDw(strXML);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 增加可管理单位
	public void AddDw() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			String strRetXml = IdentifyBO.DwAdd(strXML);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 删除可管理单位
	public void DelDw() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			String strRetXml = IdentifyBO.DwDel(strXML);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 可管理部门管理
	public void UserBmSee() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			String strRetXml = IdentifyBO.SeeUserBm(strXML);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 查看可增加的可管理部门
	public void BmSee() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			String strRetXml = IdentifyBO.SeeBm(strXML);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 增加可管理部门
	public void AddBm() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			String strRetXml = IdentifyBO.BmAdd(strXML);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 删除可管理部门
	public void DelBm() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			String strRetXml = IdentifyBO.BmDel(strXML);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获得字典列表
	 */
	public void getRsQryDicList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");

			String strRetXml = Dic.dicList(strRet);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void getRsQryDicDataList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			Document doc = XmlFunc.CreateNewDoc(strXML);
			String sDicName = XmlFunc.getAttrValue(doc, "EFSFRAME/QUERYCONDITION", "dicname");
			doc = null;

			String strRetXml = Dic.dicDataList(strXML, sDicName);

			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获得汉字列表
	 */
	public void getRsQrySpellList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRetXml = IdentifyQueryBO.spellList(request.getParameter("txtXML"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 检查用户名称是否存在
	 */
	public void checkUserTitle() {
		try {
			response.setContentType("text/html;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			String strRetXml = IdentifyBO.checkUserTitle(strXML);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 检查用户名称是否存在
	 */
	public void checkUserIdcard() {
		try {
			response.setContentType("text/html;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			String strRetXml = IdentifyBO.checkUserIdcard(strXML);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 修改用户登录名
	public String modUserTitle() throws Exception {
		String strXml = request.getParameter("txtXML");
		// System.out.println("strXml:"+strXml);
		String url = "", msg = "";
		String sUserTitle = DocumentHelper.parseText(strXml).selectSingleNode("//USERTITLE").getText();
		UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
		String strRetXml = GzcxBO.modUserTitle(strXml,userSession);
		if (PageCommon.IsSucceed(strRetXml)) {
			url = "welcome.jsp";
			msg = "设置用户登录名成功！";
			//UserCache.getInstance().refresh(userSession.getUserID());
			userSession.setUserTitle(sUserTitle);
			request.getSession().removeAttribute("user");
			request.getSession().setAttribute("user", userSession);
			return goSuHint(url, msg);
		} else {
			String strErr = PageCommon.getErrInfo(strRetXml);
			url = "back";
			msg = "设置用户登录名失败，失败原因：" + strErr;
			return goErHint(url, msg);
		}
	}

	/*
	 * 根据传回的字典名称，返回字典列表
	 */
	public void getDic() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);
			String strRetXml = IdentifyBO.getDic(strXML, userSession);
			// System.out.println("strRetXml:"+strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 根据传回的字典名称，返回字典列表
	 */
	public void getDicBySQL() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);
			String strRetXml = IdentifyBO.getDicBySQL(strXML, userSession);
			// System.out.println("strRetXml:"+strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 查询系统日志列表（列表返回）
	 */
	public void getRsQrySysLogList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRetXml = IdentifyQueryBO.sysLogList(request.getParameter("txtXML"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 异步返回单位的树结构json格式
	public void getDbobjectJsonTree() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String sId = request.getParameter("node");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			if (General.empty(sId) || sId.indexOf("ynode") != -1) {
					sId = "0";
			}

			String strRetXml = IdentifyBO.getDbObjectJsonById(sId, userSession);
			// String strRetXml =
			// "[{id:1,text:'节点一'},{id:2,text:'节点二',leaf:true}]";
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 批量设置工资单打印标志
	 */
	public void userSetPrintFlag() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtOpXml");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXML, userSession);
			String strRetXml = UserBO.setPrintFlag(strToXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 批量取消工资单打印标志
	 */
	public void userCancelPrintFlag() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtOpXml");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXML, userSession);
			String strRetXml = UserBO.cancelPrintFlag(strToXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
