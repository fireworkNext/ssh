package org.ptbank.action;

import java.io.PrintWriter;

import org.ptbank.classes.ClassesBO;

public class ClassesAction extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6046237766979462997L;
	private ClassesBO service;

	public ClassesAction() {
		service = new ClassesBO();
	}
	
	/**
	 * 根据msg信息选择跳转，如果msg为null为成功，否则跳转到失败页面
	 * @param url 成功跳转路径
	 * @param msg 成功为null，不为null则为失败提示信息
	 * @param mapping
	 * @param request
	 * @return ActionForward
	 */
	private String forward(String url,String msg){
		if(null == msg){
			request.setAttribute("url", url);
			request.setAttribute("msg", "操作成功!");
			return "goSuHint";
		} else {
			request.setAttribute("url", "back");
			request.setAttribute("msg", msg);
			return "goErHint";
		}
	}

	// 新增班级
	public String add(){
		// 获取默认参数
		String strXml = request.getParameter("txtXML");
		// 操作成功后跳转页面路径
		String strNextUrl = request.getParameter("txtNextUrl");
		
		String strRetXml = service.add(strXml);
		
		return forward(strNextUrl,strRetXml);
	}
	
	// 班级列表
	public void list(){		
		PrintWriter out = null;
		
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			// 获取默认参数
			String strXml = request.getParameter("txtXML");
			
			out= response.getWriter();
			
			// 业务返回
			String strRetXml = service.list(strXml);
			
			out.write(strRetXml);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(null != out){
				out.close();
			}
		}
	}
	
	// 查看班级详细信息
	public void detail(){
		
		PrintWriter out = null;
		
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			// 获取默认参数
			String strXml = request.getParameter("txtXML");
			
			out= response.getWriter();
			
			// 业务返回
			String strRetXml = service.detail(strXml);
			
			out.write(strRetXml);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(null != out){
				out.close();
			}
		}
	}
	
	// 学生列表（含班级编号）
	public void personList(){
		
		PrintWriter out = null;
		
		try {
			response.setContentType("text/xml;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			// 获取默认参数
			String strXml = request.getParameter("txtXML");
			
			out= response.getWriter();
			
			// 业务返回
			String strRetXml = service.personList(strXml);
			
			out.write(strRetXml);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(null != out){
				out.close();
			}
		}
	}
}
