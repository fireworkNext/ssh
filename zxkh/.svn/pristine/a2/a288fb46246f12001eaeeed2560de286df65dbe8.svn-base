package org.ptbank.servlet;

import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.ptbank.cache.DicCache;
import org.ptbank.cache.MUnitCache;
import org.ptbank.cache.SpellCache;
import org.ptbank.cache.UserCache;


public class CacheServlet implements Servlet {

	public void destroy() {
		// TODO Auto-generated method stub

	}

	public ServletConfig getServletConfig() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getServletInfo() {
		// TODO Auto-generated method stub
		return null;
	}

	public void init(ServletConfig config) throws ServletException {
		ServletContext obj_Context = config.getServletContext();

	    DicCache obj_DicCache = DicCache.getInstance();
	    obj_Context.setAttribute("g_dic", obj_DicCache);
	    System.out.println("系统框架 字典缓存加载完成……");

	    SpellCache obj_SpellCache = SpellCache.getInstance();
	    obj_Context.setAttribute("g_spell", obj_SpellCache);
	    System.out.println("系统框架 拼音缓存加载完成……");

	    MUnitCache obj_MUnitCache = MUnitCache.getInstance();
	    obj_Context.setAttribute("g_munit",obj_MUnitCache);
	    System.out.println("系统框架 管理单位缓存加载完成……");

	    UserCache obj_UserCache = UserCache.getInstance();
	    obj_Context.setAttribute("g_user",obj_UserCache);
	    System.out.println("系统框架 用户信息缓存加载完成……");
	    
	    // 设置字典路径
	    String str_DicPath = obj_Context.getRealPath("dic");
	    DicCache.setDicPath(str_DicPath);

	}

	public void service(ServletRequest req, ServletResponse res)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

}
