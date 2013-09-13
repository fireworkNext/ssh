package org.ptbank.action;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.ptbank.base.Operation;
import org.ptbank.base.QueryDoc;
import org.ptbank.bo.GzcxBO;
import org.ptbank.bo.Rptgzcx;
import org.ptbank.bo.Tpl;
import org.ptbank.bo.WageUser;
import org.ptbank.cache.UserLogonInfo;
import org.ptbank.declare.Common;
import org.ptbank.func.Configuration;
import org.ptbank.func.Encrypt;
import org.ptbank.func.Excel;
import org.ptbank.func.General;
import org.ptbank.func.PageCommon;

public class GzcxAction extends BaseAction {

	/**
	 * 工资查询系统action
	 * 
	 */
	private static final long serialVersionUID = 6316091317076915787L;
	private String tpl;
	private String expdate;
	private File data;
	private String dataContentType;
	private String dataFileName;

	public String getTpl() {
		return tpl;
	}

	public void setTpl(String tpl) {
		this.tpl = tpl;
	}

	public String getExpdate() {
		return expdate;
	}

	public void setExpdate(String expdate) {
		this.expdate = expdate;
	}

	public File getData() {
		return data;
	}

	public void setData(File data) {
		this.data = data;
	}

	public String getDataContentType() {
		return dataContentType;
	}

	public void setDataContentType(String dataContentType) {
		this.dataContentType = dataContentType;
	}

	public String getDataFileName() {
		return dataFileName;
	}

	public void setDataFileName(String dataFileName) {
		this.dataFileName = dataFileName;
	}

	/*
	 * 返回薪酬明细列表
	 */
	public void getSalaryList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.salaryList(strXML, userSession);
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回业务发展奖励列表
	 */
	public void getRewardsList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.RewardsList(strXML, userSession);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 取得绩效工资详细信息
	public void getSalaryDetail() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtSalId");
			// System.out.println(strXML);
			// UserLogonInfo userSession =
			// (UserLogonInfo)request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.salaryDetail(strXML);
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 取得业务发展奖励详细信息
	public void getRewardsDetail() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtRewId");
			// System.out.println(strXML);
			// UserLogonInfo userSession =
			// (UserLogonInfo)request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);
			// System.out.println(strToXml);

			String strRetXml = GzcxBO.rewardsDetail(strXML);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String upload() throws Exception {
		request.setCharacterEncoding("UTF-8");
		int iRet = 0;
		String url = "", msg = "";
		StringBuffer sbMsg = new StringBuffer();
		// String realpath = ServletActionContext.getServletContext().getRealPath("/upload");
		String conf = ServletActionContext.getServletContext().getRealPath("/WEB-INF/classes/conf.properties");
		Configuration rc = new Configuration(conf);
		String realpath = rc.getValue("filepath");
		UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
		// System.out.println(realpath);
		File file = new File(realpath);
		if (!file.exists())
			file.mkdirs();
		FileUtils.copyFile(data, new File(file, dataFileName));
		// System.out.println(dataFileName);
		// System.out.println(request.getParameter("type"));
		// 调用BEAN中的处理函数
		iRet = GzcxBO.impData(tpl, expdate, realpath + "/" + dataFileName, sbMsg, userSession);
		if (iRet == 0) {
			url = "gzcx/impdata.jsp";
			msg = sbMsg.toString();
			return goSuHint(url, msg);
		} else {
			url = "gzcx/impdata.jsp";
			msg = sbMsg.toString();
			return goErHint(url, msg);
		}
	}

	/*
	 * 返回工资发放明细列表
	 */
	public void getWageList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			WageUser userSession = (WageUser) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.wageDetailList(strXML, userSession);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回工资发放明细列表
	 */
	public void getPrizeList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			WageUser userSession = (WageUser) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.prizeDetailList(strXML, userSession);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 更新相关费用说明
	 */
	public void updCostMaintain() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.updCostMaintain(strXML, userSession);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回工资用户列表
	 */
	public void getWageUserList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			WageUser userSession = (WageUser) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.wageUserList(strXML, userSession);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 初始化密码
	 */
	public void initPasswd() throws Exception {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();

			String strXml = request.getParameter("txtOpXml");
			WageUser userSession = (WageUser) request.getSession().getAttribute("user");

			String strRetXml = GzcxBO.initPasswd(strXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回统计信息
	 */
	public void getTotal() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			Map map = new HashMap();
			PrintWriter out = response.getWriter();
			String sYear = request.getParameter("year");
			String strXML = request.getParameter("txtXML");
			// System.out.println("sYear"+sYear+" strXML:"+strXML);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);
			// 解析查询条件
			Document doc = DocumentHelper.parseText(strXML);
			List nodeList = doc.selectNodes("//CONDITION");
			for (int i = 0; i < nodeList.size(); i++) {
				Element ele = (Element) nodeList.get(i);
				String sFieldName = ele.elementText(Common.XDOC_FIELDNAME);
				String sDataValue = ele.elementText(Common.XDOC_VALUE);
				map.put(sFieldName, sDataValue);
			}
			String strRetXml = GzcxBO.getTotal((String) map.get("TPL"), (String) map.get("TPLDETAIL"), sYear, userSession);
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回统计信息
	 */
	public void getTotalAll() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			Map map = new HashMap();
			PrintWriter out = response.getWriter();
			String sYear = request.getParameter("year");
			String strXML = request.getParameter("txtXML");
			// System.out.println("sYear"+sYear+" strXML:"+strXML);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);
			// 解析查询条件
			Document doc = DocumentHelper.parseText(strXML);
			List nodeList = doc.selectNodes("//CONDITION");
			for (int i = 0; i < nodeList.size(); i++) {
				Element ele = (Element) nodeList.get(i);
				String sFieldName = ele.elementText(Common.XDOC_FIELDNAME);
				String sDataValue = ele.elementText(Common.XDOC_VALUE);
				map.put(sFieldName, sDataValue);
			}
			String strRetXml = GzcxBO.getTotalAll(map, userSession);
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回明细信息
	 */
	public void getDetail() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			Map map = new HashMap();
			PrintWriter out = response.getWriter();
			String sYear = request.getParameter("year");
			String strXML = request.getParameter("txtXML");
			// System.out.println("sYear"+sYear+" strXML:"+strXML);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);
			// 解析查询条件
			Document doc = DocumentHelper.parseText(strXML);
			List nodeList = doc.selectNodes("//CONDITION");
			for (int i = 0; i < nodeList.size(); i++) {
				Element ele = (Element) nodeList.get(i);
				String sFieldName = ele.elementText(Common.XDOC_FIELDNAME);
				String sDataValue = ele.elementText(Common.XDOC_VALUE);
				map.put(sFieldName, sDataValue);
			}
			String strRetXml = GzcxBO.getDetail(map.get("TPL").toString(), sYear, userSession.getIDCard(), map.get("TYPE").toString());
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回模版列表
	 */
	public void getTplList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.tplList(strXML, userSession);
			// System.out.println("strRetXml:"+strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回模版详情
	 */
	public void getTplDetail() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.tplDetail(strXML, userSession);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 增删改模版
	public void dealWithXmlTpl() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = GzcxBO.dealWithXmlTpl(strRet, userSession);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 返回已定义模版的字典字符串
	public void getDicTpl() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = GzcxBO.dicTpl(strRet);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回数据库字段列表
	 */
	public void getDbfldList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.dbfldList(strXML, userSession);
			// System.out.println("strRetXml:"+strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回数据库字段详情
	 */
	public void getDbfldDetail() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.dbfldDetail(strXML, userSession);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 增删改模版
	public void dealWithXml() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXml = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXml, userSession);
			String strRetXml = Operation.dealWithXml(strToXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 生成字典文件
	public void createDicFile() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String sDicName = request.getParameter("txtDicName");
			String sTableName = request.getParameter("txtTableName");
			String strRetXml = GzcxBO.createDicFile(sDicName, sTableName);
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回单位模版列表
	 */
	public void getUnitTplList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.unitTplList(strXML, userSession);
			// System.out.println("strRetXml:"+strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回单位模版详情
	 */
	public void getUnitTplDetail() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.unitTplDetail(strXML, userSession);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回可供选择模版列表
	 */
	public void getChooseTplList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			String sTpl = request.getParameter("tpl");
			String sDwbm = request.getParameter("dwbm");
			Map<String, Object> map = new HashMap<String, Object>();
			// System.out.println(strXML);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);
			map.put("txtXML", strXML);
			map.put("tpl", sTpl);
			map.put("dwbm", sDwbm);
			String strRetXml = GzcxBO.chooseTplList(map, userSession);
			// System.out.println("strRetXml:"+strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回历史创建grid所需的信息
	 */
	public void getCreateGridJson() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			String sTpl = request.getParameter("tpl");
			String sCxnd = request.getParameter("cxnd");
			String sZeroFlag = request.getParameter("zeroflag");

			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.createGridJson(sTpl, sCxnd, sZeroFlag, userSession);
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回当前创建grid所需的信息
	 */
	public void getCreateGridJsonCur() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			String sTpl = request.getParameter("tpl");
			String sCxnd = request.getParameter("cxnd");

			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.createGridJsonCur(sTpl, sCxnd, userSession);
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 返回当前创建grid所需的信息
	 */
	public void getCreateGridJsonAll() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			String sTpl = request.getParameter("tpl");

			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.createGridJsonAll(sTpl, userSession);
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 异步校验密码
	 */
	public void validPwd() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String sOldPasswd = request.getParameter("txtXML");

			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);
			String strRetXml = "";
			if (Encrypt.e(sOldPasswd).equals(userSession.getUserPassword())) {
				strRetXml = "0";
			} else {
				strRetXml = "1";
			}
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 按照模版类型和单位导出模版文件并直接下载
	 */
	public void expDwTpl() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			int iRet = 0, i = 0;
			String url = "", msg = "";
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			StringBuffer sbMsg = new StringBuffer();
			String sTpl = request.getParameter("tpl");
			String sDwbm = request.getParameter("dwbm");
			String sFileName = "";
			if (!General.empty(sDwbm))
				sFileName += sDwbm;
			if (!General.empty(sTpl))
				sFileName += sTpl;
			sFileName += ".xls";
			String conf = ServletActionContext.getServletContext().getRealPath("/WEB-INF/classes/conf.properties");
			Configuration rc = new Configuration(conf);
			String realpath = rc.getValue("filepath");
			Excel excel = new Excel();
			Rptgzcx rptgzcx = new Rptgzcx();
			ArrayList al = rptgzcx.getUnitTplList(sDwbm, sTpl);
			for (i = 0; i < al.size(); i++) {
				Tpl tpl = (Tpl) al.get(i);
				excel.setCellValue(i, 0, 0, tpl.getFldname());
			}
			excel.save(realpath + sFileName);
			out.write(sFileName);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 按照模版类型和单位导出模版文件并直接下载
	 */
	public void expDwTplExcel() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			int iRet = 0, i = 0;
			String url = "", msg = "";
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			StringBuffer sbMsg = new StringBuffer();
			String sTpl = request.getParameter("tpl");
			String sDwbm = request.getParameter("dwbm");
			String sFileName = "";
			if (!General.empty(sDwbm))
				sFileName += sDwbm;
			if (!General.empty(sTpl))
				sFileName += sTpl;
			sFileName += ".xls";
			String conf = ServletActionContext.getServletContext().getRealPath("/WEB-INF/classes/conf.properties");
			Configuration rc = new Configuration(conf);
			String realpath = rc.getValue("filepath");
			Excel excel = new Excel();
			Rptgzcx rptgzcx = new Rptgzcx();
			ArrayList al = rptgzcx.getUnitTplList(sDwbm, sTpl);
			for (i = 0; i < al.size(); i++) {
				Tpl tpl = (Tpl) al.get(i);
				excel.setCellValue(i, 0, 0, tpl.getFldname());
			}
			excel.save(realpath + sFileName);
			out.write(sFileName);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 按照模版类型导出模版文件并直接下载
	 */
	public void expTpl() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			int iRet = 0, i = 0;
			String url = "", msg = "";
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			StringBuffer sbMsg = new StringBuffer();
			String sTpl = request.getParameter("tpl");
			String sFileName = "";
			if (General.empty(sTpl))
				sFileName += sTpl;
			sFileName += ".et";
			String conf = ServletActionContext.getServletContext().getRealPath("/WEB-INF/classes/conf.properties");
			Configuration rc = new Configuration(conf);
			String realpath = rc.getValue("filepath");
			Excel excel = new Excel();
			Rptgzcx rptgzcx = new Rptgzcx();
			ArrayList al = rptgzcx.getTplList(sTpl);
			for (i = 0; i < al.size(); i++) {
				excel.setCellValue(i, 0, 0, al.get(i));
			}
			excel.save(realpath + sFileName);
			out.write(sFileName);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 按照模版类型和单位导出导入的数据
	 */
	public void expSalaryData() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			int iRet = 0, i = 0, m = 0, n = 0;
			String url = "", msg = "";
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			StringBuffer sbMsg = new StringBuffer();
			String strXML = request.getParameter("txtXML");
			QueryDoc obj_Query = new QueryDoc(strXML);
			Map<String,String> conditionMap = obj_Query.getConditionMap(strXML);
			String sTpl = conditionMap.get("TPL");
			String sYear = conditionMap.get("YEAR");
			String sMonth = conditionMap.get("MONTH");
			String sFileName = "";
			if (!General.empty(sYear))
				sFileName += sYear;
			if (!General.empty(sMonth))
				sFileName += sMonth;
			if (!General.empty(sTpl))
				sFileName += sTpl;
			sFileName += ".et";

			String conf = ServletActionContext.getServletContext().getRealPath("/WEB-INF/classes/conf.properties");
			Configuration rc = new Configuration(conf);
			String realpath = rc.getValue("filepath");
			Excel excel = new Excel();
			Rptgzcx rptgzcx = new Rptgzcx();

			if (sTpl.contains("tot")) {
				// 得到导出字段名称
				ArrayList al = GzcxBO.getAllFldnameList(sTpl, userSession);
				for (i = 0; i < al.size(); i++) {
					excel.setCellValue(i, 0, 0, al.get(i));
				}
				String strDataXml = GzcxBO.getTotalAll(obj_Query.getConditionMap(strXML), userSession);
				Document doc = DocumentHelper.parseText(strDataXml);
				List nodeList = doc.selectNodes("//ROW");
				for (i = 0; i < nodeList.size(); i++) {
					Element ele = (Element) nodeList.get(i);
					List eleList = ele.elements();
					for (m = 0; m < eleList.size(); m++) {
						Element eleTmp = (Element) eleList.get(m);
						if (m == 0)
							excel.setCellValue(m, i + 1, 0, eleTmp.getText());
						else
							excel.setCellValue(m, i + 1, 0, Double.parseDouble(eleTmp.getText()));
					}
				}
			} else {
				// 得到导出字段名称
				ArrayList al = GzcxBO.getAllFldnameList(sTpl, userSession);
				for (i = 0; i < al.size(); i++) {
					excel.setCellValue(i, 0, 0, al.get(i));
				}
				// 得到数据
				ArrayList dataList = GzcxBO.getSalaryData(strXML, userSession);
				for (m = 0; m < dataList.size(); m++) {
					ArrayList list = (ArrayList) dataList.get(m);
					for (n = 0; n < list.size(); n++) {
						excel.setCellValue(n, m + 1, 0, list.get(n));
					}
				}
			}
			excel.save(realpath + sFileName);
			out.write(sFileName);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 按照模版类型和单位导出导入的数据
	 */
	public void expSalaryDataExcel() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			int iRet = 0, i = 0, m = 0, n = 0;
			String url = "", msg = "";
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			StringBuffer sbMsg = new StringBuffer();
			String strXML = request.getParameter("txtXML");
			QueryDoc obj_Query = new QueryDoc(strXML);
			Map<String,String> conditionMap = obj_Query.getConditionMap(strXML);
			String sTpl = conditionMap.get("TPL");
			String sYear = conditionMap.get("YEAR");
			String sMonth = conditionMap.get("MONTH");
			String sFileName = "";
			if (!General.empty(sYear))
				sFileName += sYear;
			if (!General.empty(sMonth))
				sFileName += sMonth;
			if (!General.empty(sTpl))
				sFileName += sTpl;
			sFileName += ".xls";
			
			String conf = ServletActionContext.getServletContext().getRealPath("/WEB-INF/classes/conf.properties");
			Configuration rc = new Configuration(conf);
			String realpath = rc.getValue("filepath");
			Excel excel = new Excel();
			Rptgzcx rptgzcx = new Rptgzcx();
			if (sTpl.contains("tot")) {
				// 得到导出字段名称
				ArrayList al = GzcxBO.getAllFldnameList(sTpl, userSession);
				for (i = 0; i < al.size(); i++) {
					excel.setCellValue(i, 0, 0, al.get(i));
				}
				String strDataXml = GzcxBO.getTotalAll(obj_Query.getConditionMap(strXML), userSession);
				Document doc = DocumentHelper.parseText(strDataXml);
				List nodeList = doc.selectNodes("//ROW");
				for (i = 0; i < nodeList.size(); i++) {
					Element ele = (Element) nodeList.get(i);
					List eleList = ele.elements();
					for (m = 0; m < eleList.size(); m++) {
						Element eleTmp = (Element) eleList.get(m);
						if (m == 0)
							excel.setCellValue(m, i + 1, 0, eleTmp.getText());
						else
							excel.setCellValue(m, i + 1, 0, Double.parseDouble(eleTmp.getText()));
					}
				}
			} else {
				// 得到导出字段名称
				ArrayList al = GzcxBO.getAllFldnameList(sTpl, userSession);
				for (i = 0; i < al.size(); i++) {
					excel.setCellValue(i, 0, 0, al.get(i));
				}
				// 得到数据
				ArrayList dataList = GzcxBO.getSalaryData(strXML, userSession);
				for (m = 0; m < dataList.size(); m++) {
					ArrayList list = (ArrayList) dataList.get(m);
					for (n = 0; n < list.size(); n++) {
						excel.setCellValue(n, m + 1, 0, list.get(n));
					}
				}
			}
			excel.save(realpath + sFileName);
			out.write(sFileName);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 异步校验用户登录名是否存在
	 */
	public void validUserTitle() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String sUserTitle = request.getParameter("txtXML");

			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);
			String strRetXml = GzcxBO.validUserTitle(sUserTitle, userSession);
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * chart图表测试
	 */
	public void getCharts() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			Map map = new HashMap();
			PrintWriter out = response.getWriter();
			String sYear = request.getParameter("year");
			String strXML = request.getParameter("txtXML");
			// System.out.println("sYear"+sYear+" strXML:"+strXML);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);
			// 解析查询条件
			Document doc = DocumentHelper.parseText(strXML);
			List nodeList = doc.selectNodes("//CONDITION");
			for (int i = 0; i < nodeList.size(); i++) {
				Element ele = (Element) nodeList.get(i);
				String sFieldName = ele.elementText(Common.XDOC_FIELDNAME);
				String sDataValue = ele.elementText(Common.XDOC_VALUE);
				map.put(sFieldName, sDataValue);
			}
			map.put("YEAR", sYear);
			map.put("DWBM", "('" + userSession.getUnitID() + "')");
			map.put("SFZHM", userSession.getIDCard());
			String strRetXml = GzcxBO.getCharts(map, userSession);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 增删改模版
	public void delImpData() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = GzcxBO.delImpData(strRet, userSession);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 返回当前创建grid所需的信息
	 */
	public void getObjectCreateGridJsonAll() {
		try {
			response.setContentType("text/json;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			QueryDoc obj_Query = new QueryDoc(strXML);
			
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.objectCreateGridJsonAll(obj_Query.getConditionMap(strXML), userSession);
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 返回数据对象列表
	 */
	public void getDbobjectList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strXML = request.getParameter("txtXML");
			// System.out.println(strXML);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			// String strToXml = PageCommon.setDocXML(strXML,userSession);

			String strRetXml = GzcxBO.dbobjectList(strXML, userSession);
			// System.out.println(strRetXml);
			out.write(strRetXml);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
