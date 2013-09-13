package org.ptbank.action;

import java.io.PrintWriter;
import java.util.ArrayList;

import org.apache.struts2.ServletActionContext;
import org.ptbank.func.*;
import org.ptbank.base.*;
import org.ptbank.bo.*;
import org.ptbank.cache.UserLogonInfo;





public class JyxAction extends BaseAction {

	/**
	 * 简易险销售action
	 */
	private static final long serialVersionUID = -7727273812456065576L;

	//*****************简易险销售新增
	public void JyxAdd() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			System.out.print("前台界面传过来的xml="+strRet);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession()
			.getAttribute("user");
			String strRetXml = JyxBO.JyxAdd(strRet,userSession);
			System.out.println("后台返回的xml是:"+ strRetXml);
			
			//DataDoc doc = new DataDoc(strRetXml);
			//int size = doc.getQueryNum("ROW");
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}	

	
	//********************返回该用户一周内销售列表
	public void getJyxList() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession()
			.getAttribute("user");
			//System.out.println("123456");
			System.out.println("qqqqqqqqq" + strRet);
			String strRetXml = JyxBO.getJyxList(strRet,userSession);
			
			//DataDoc doc = new DataDoc(strRetXml);
			//int size = doc.getQueryNum("ROW");
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}	
//////////删除销售
	public void delJyx(){
		 try {
				response.setContentType("text/xml;charset=utf-8");
				request.setCharacterEncoding("UTF-8");

				PrintWriter out = response.getWriter();
				
				String strRet = request.getParameter("txtXML");
				//System.out.println(strRet);
				String strRetXml = JyxBO.delJyx(strRet);
				out.write(strRetXml);
				out.close();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}		
/////////查询出销售记录，待修改////////////////
	public void seeJyx(){
		 try {
				response.setContentType("text/xml;charset=utf-8");
				request.setCharacterEncoding("UTF-8");

				PrintWriter out = response.getWriter();
				String strRet = request.getParameter("txtXML");
				//System.out.println(strRet);
				String strRetXml = JyxBO.seeJyx(strRet);
				out.write(strRetXml);
				out.close();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}	
	
//////////销售修改/////////////////
	public void editJyx(){
		 try {
				response.setContentType("text/xml;charset=utf-8");
				request.setCharacterEncoding("UTF-8");

				PrintWriter out = response.getWriter();
				String strRet = request.getParameter("txtXML");
				//System.out.println(strRet);
				String strRetXml = JyxBO.editJyx(strRet);
				out.write(strRetXml);
				out.close();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}	

	/*
	 * 根据用户返回所属单位及下属单位
	 */
	
	public void getUnit1(){
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			//System.out.println("aaaa:"+strRet);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml =JyxBO.getUnit(strRet,userSession);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//*********************返回个人销售记录列表--带条件
	public void Qrygrjyx() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession()
					.getAttribute("user");
			//System.out.println(strRet);
			String strRetXml = JyxBO.Qrygrjyx(strRet,userSession);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}		
	

	//*********************返回按单位销售记录列表--带条件
	public void Qrydwjyx() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession()
					.getAttribute("user");
			//System.out.println(strRet);
			String strRetXml = JyxBO.Qrydwjyx(strRet,userSession);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}		
	
	//*********************查询统计--带条件
	public void Qrytjjyx() {
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String sYearMonth=General.curYear4()+ General.curMonth() + General.curDay();
			String sFileName = "";
			sFileName += sYearMonth;
			sFileName += ".xls";
			String conf = ServletActionContext.getServletContext().getRealPath("/WEB-INF/classes/conf.properties");
			Configuration rc = new Configuration(conf);
			String realpath = rc.getValue("filepath");
			ArrayList dataList = JyxBO.Qrytjjyx(strRet,userSession);
			
			//excel.saveExcel(realpath + sFileName);
			out.write(sFileName);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}		
///	
	
	
	
	
	
}
