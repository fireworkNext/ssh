package org.ptbank.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dom4j.Document;
import org.ptbank.base.XmlFunc;
import org.ptbank.baseManage.Dic;
import org.ptbank.baseManage.IdentifyBO;
import org.ptbank.baseManage.IdentifyQueryBO;
import org.ptbank.baseManage.MaxIDTypeBO;
import org.ptbank.baseManage.RoleBO;
import org.ptbank.baseManage.UnitsBO;
import org.ptbank.baseManage.UserBO;
import org.ptbank.cache.UserLogonInfo;
import org.ptbank.classes.ProductBO;
import org.ptbank.func.General;
import org.ptbank.func.PageCommon;
import org.ptbank.person.PersonBO;

public class AjaxDoAction {
	public AjaxDoAction() {
	}

	/**
	 * 获得事务类型列表
	 */
	public void getRsQryAffairTypeList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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
	public void getRsQryEventTypeList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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

	/**
	 * 获得用户类型列表
	 */
	public void getRsQryUserList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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

	public void getUserDetail(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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

	/**
	 * 获得角色类型列表
	 */
	public void getRsQryRoleList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRetXml = IdentifyQueryBO.roleList(request.getParameter("txtXML"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 查询角色权限信息列表（列表返回）
	 */
	public void getRsQryRoleRightList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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
	public void getRsQryRoleUserList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
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
	public void getEventTypeList_AddToRole(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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

	/**
	 * 查询错误日志列表（列表返回）
	 */
	public void getRsQryErrorLogList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRetXml = IdentifyQueryBO.errorLogList(request.getParameter("txtXML"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 查询系统日志列表（列表返回）
	 */
	public void getRsQrySysLogList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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

	/**
	 * 给角色添加用户
	 */
	public void backAddUserToRole(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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
	public void backDropUserfrmRole(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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
	public void backAddEventToRole(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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
	public void backDropEventfrmRole(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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

	/**
	 * 查询单位信息列表（列表返回）
	 */
	public void getRsQryMunitList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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

	// 查询单位详细信息
	public void getMunitDetail(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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

	/**
	 * 获得字典列表
	 */
	public void getRsQryDicList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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

	public void getRsQryDicDataList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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
	public void getRsQrySpellList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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

	/**
	 * 查询任务列表
	 */
	public void qryTaskList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRetXml = IdentifyQueryBO.qryTaskList(request.getParameter("txtXML"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void userList_AddToRole(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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

	// 查询用户权限
	public void getUserRight(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();

			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = IdentifyBO.getUserRightsByUserID(userSession).getXML();
			// String strRetXml = "<EFSFRAME efsframae='urn=www-efsframe-cn' version='1.0'>"
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

	// 添加人员
	public void userAdd(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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
	public void userEdit(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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

	// 单位处理
	public void unitDeal(HttpServletRequest request, HttpServletResponse response, String strQuery) {
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

	// 查询编码列表
	public void getQryMaxTypeList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");

			String strRetXml = IdentifyQueryBO.maxidtypeList(strRet);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 查询单位详细信息
	public void getMaxTYpeDetail(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRetXml = IdentifyQueryBO.maxidtypeDetail(request.getParameter("txtMaxIDType"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 查询已分配编码列表
	public void getQryMaxList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();

			String strRetXml = IdentifyQueryBO.maxidList(strQuery);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 编码处理
	public void maxidTypeDeal(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtOpXml");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXML, userSession);

			String strRetXml = MaxIDTypeBO.dealXml(strToXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 添加学生档案
	public void psnAdd(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			System.out.println(strXML);

			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXML, userSession);

			System.out.println(strToXml);

			String strRetXml = PersonBO.addNew(strToXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//
	public void PsnDeal(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXML, userSession);

			System.out.println(strToXml);

			String strRetXml = PersonBO.dealXml(strToXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 查询学生列表
	public void getPersonList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");

			System.out.println("Con:" + strRet);
			String strRetXml = PersonBO.personList(strRet);
			System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void getPersonListSv(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");

			String strRetXml = PersonBO.personListSv(strRet);

			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 查询学生详细信息
	public void getPersonDetail(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRetXml = PersonBO.personDetail(request.getParameter("txtPersonID"));
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void proAdd(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			System.out.println(strXML);

			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXML, userSession);

			System.out.println(strToXml);

			String strRetXml = ProductBO.AddNew(strToXml);
			System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 查询商品列表
	public void getProList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");

			String strRetXml = ProductBO.proList(strRet);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void getProDetail(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strPId = request.getParameter("txtXML");

			String strRetXml = ProductBO.detail(strPId);
			System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void ordAdd(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");

			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXML, userSession);

			String strRetXml = ProductBO.AddOrd(strToXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void ordAdd2(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");

			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXML, userSession);

			String strRetXml = ProductBO.AddOrd2(strToXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void ordDel(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strOrdID = request.getParameter("txtXML");

			String strRetXml = ProductBO.DelOrd(strOrdID);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void ordEdit(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");

			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXML, userSession);

			String strRetXml = ProductBO.EditOrd(strToXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void getOrdList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");

			String strRetXml = ProductBO.ordList(strRet);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//
	public void getOrdDetail(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strOrdID = request.getParameter("txtXML");

			String strRetXml = ProductBO.ordDetail(strOrdID);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void getOrdProList(HttpServletRequest request, HttpServletResponse response, String strQuery) {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strOrdID = request.getParameter("txtXML");

			String strRetXml = ProductBO.ordproList(strOrdID);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 生成字典文件
	public void toCreateDicFile(HttpServletRequest request, HttpServletResponse response, String strQry) throws Exception {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		// ReturnDoc returnDoc = new ReturnDoc();
		PrintWriter out = response.getWriter();
		String strDicName = request.getParameter("txtXML");
		// String strUrl = request.getParameter("txtNextUrl");
		try {
			General.createDicFileSQL("select gysid,gysmc from SBGYSXX order by gysid", strDicName);
			out.write("生成字典文件成功！");
		} catch (Exception e) {
			out.write("生成字典文件失败！");
		}
	}

}
