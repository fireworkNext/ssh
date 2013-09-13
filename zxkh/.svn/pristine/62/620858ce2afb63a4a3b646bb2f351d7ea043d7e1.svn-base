package org.ptbank.action;

import java.io.PrintWriter;
import com.opensymphony.xwork2.ActionSupport;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.util.ServletContextAware;
import org.ptbank.base.Operation;
import org.ptbank.cache.UserLogonInfo;
import org.ptbank.func.General;
import org.ptbank.func.PageCommon;

public class BaseAction extends ActionSupport implements ServletRequestAware,ServletResponseAware,ServletContextAware{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6646237210043659345L;
	String txtXML;
	HttpServletRequest request;
	HttpServletResponse response;
	ServletContext servletContext;

	public void setTxtXML(String txtXML) {
		this.txtXML = txtXML;
	}
	
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response=response;
	}

	public void setServletContext(ServletContext servletContext) {
		this.servletContext=servletContext;
	}

	public BaseAction() {
	}

	/**
	 * 处理通用XML
	 *  
	 */
	public void dealWithXml() {
		PrintWriter out = null;
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			String strXml = this.txtXML;

			//System.out.println(strXml);

			UserLogonInfo userSession = (UserLogonInfo) request.getSession()
					.getAttribute("user");
			String strToXml = PageCommon.setDocXML(strXml, userSession);

			out = response.getWriter();

			// 业务返回
			String strRetXml = Operation.dealWithXml(strToXml);

			out.write(strRetXml);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != out) {
				out.close();
			}
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
}
