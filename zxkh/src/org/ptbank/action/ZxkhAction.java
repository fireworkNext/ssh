package org.ptbank.action;
import java.io.PrintWriter;

import org.ptbank.bo.JyxBO;
import org.ptbank.bo.ZxkhBO;
import org.ptbank.cache.UserLogonInfo;

public class ZxkhAction extends BaseAction{

	/**
	 * 转型客户Action
	 */
	private static final long serialVersionUID = -7571292481903032348L;
	//高端客户基本资料新增
	public void gdkhAdd(){
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = ZxkhBO.gdkhAdd(strRet, userSession);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	//高端客户列表查询
	public void  getGdkhList(){
		try {	   
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			//System.out.print(strRet);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = ZxkhBO.getGdkhList(strRet, userSession);
			//System.out.print(strRetXml);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//家庭情况新增
	public void jtqkAdd(){
		try {	   
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			//System.out.print(strRet);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = ZxkhBO.jtqkAdd(strRet, userSession);
			//System.out.print(strRetXml);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	//返回家庭情况列表
	public void getJtqkList(){
		try {	   
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			//System.out.print(strRet);
			//UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = ZxkhBO.getJtqkList(strRet);
			//System.out.print(strRetXml);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	//资产结构新增
	public void zcjgAdd(){
		try {	   
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			//System.out.print(strRet);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = ZxkhBO.zcjgAdd(strRet, userSession);
			//System.out.print(strRetXml);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	//返回资产结构列表
	public void getZcjgList(){
		try {	   
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			//System.out.print(strRet);
			//UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = ZxkhBO.getZcjgList(strRet);
			//System.out.print(strRetXml);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	//历史成交记录新增
	public void lscjjlAdd(){
		try {	   
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			System.out.print(strRet);
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = ZxkhBO.lscjjlAdd(strRet, userSession);
			//System.out.print(strRetXml);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	//返回历史成交记录列表
	public void getLscjjlList(){
		try {	   
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			//System.out.print(strRet);
			//UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			String strRetXml = ZxkhBO.getLscjjlList(strRet);
			//System.out.print(strRetXml);
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
			String strRetXml =ZxkhBO.getUnit(strRet,userSession);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//权限查询各单位下属部门的客户资料,列表返回
	public void roleGetGdkhList(){
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			//System.out.println(strRet);
			String strRetXml = ZxkhBO.roleGetGdkhList(strRet,userSession);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	//查询单条高端客户基本信息,返回前台用于修改
	public void frmGdkhModQry(){
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			//System.out.println(strRet);
			String strRetXml = ZxkhBO.frmGdkhModQry(strRet,userSession);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	//修改高端客户基本信息
	public void frmGdkhMod(){
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			String strRetXml = ZxkhBO.frmGdkhMod(strRet);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	//查询单条客户家庭情况信息,返回前台用于修改
	public  void frmJtqkModQry(){
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");

			PrintWriter out = response.getWriter();
			String strRet = request.getParameter("txtXML");
			UserLogonInfo userSession = (UserLogonInfo) request.getSession().getAttribute("user");
			System.out.println(strRet);
			String strRetXml = ZxkhBO.frmJtqkModQry(strRet,userSession);
			out.write(strRetXml);
			out.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
}
