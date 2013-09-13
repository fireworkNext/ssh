package org.ptbank.servlet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.ptbank.cache.DicCache;
import org.ptbank.cache.MUnitCache;
import org.ptbank.cache.SpellCache;
import org.ptbank.cache.UserCache;


public class TestServlet extends HttpServlet {
	private static final long serialVersionUID = 4474502560294377202L;

	@Override
	public void init() throws ServletException {
		ServletContext obj_Context = this.getServletContext();

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

}
