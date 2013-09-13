package org.ptbank.action;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.*;

public class AjaxAction extends HttpServlet {

	private static final long serialVersionUID = 8570481193484982729L;

  public AjaxAction() {}
  public void destroy() {}

  public void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException 
  {
    try
    {
      String strMethodName=request.getParameter("method");
      
      //String strRet=getInputStreamToString(request);
      String strRet=request.getParameter("txtXML");

      doMethod(request,response,strRet,strMethodName);     
      
    }
    catch(Exception e)
    {
    }    
  }
  
  
  public void doPost(HttpServletRequest request, HttpServletResponse response)
  throws ServletException, IOException {
    doGet(request,response);
  }
  
  
  /**
   * 获得request的流对象，并对其进行UTF-8编码返回
   *           注意：Servelet中的输出的编码模式一定要用UTF-8
   * @param request     request对象
   * @return            UTF-8编码字符
   * @throws ServletException
   * @throws IOException
   */
  public static String getInputStreamToString(HttpServletRequest request)
  throws ServletException, IOException
  {
    try
    {
      InputStream in = request.getInputStream();
      String strRet="";
      String temp="";
      // 按照 UTF-8 的编码方式编码
      BufferedReader buffer=new BufferedReader(new InputStreamReader(new BufferedInputStream(in),"UTF-8"));
      // BufferedReader buffer=new BufferedReader(new InputStreamReader(new BufferedInputStream(in)));
      while((temp=buffer.readLine())!=null)
      {
        strRet+=temp;
      }
      buffer.close();
      in.close();
      return strRet;
    }
    catch(Exception e)
    {
      return null;
    }
  }
  
  /**
   * 利用反射的机制 －－ 动态执行一个类对象的方法
   *            主要用在Ajax技术异步后台提交并返回数据
   * @param request     request对象
   * @param response    response对象
   * @param strRet      strRet 用户提交的流字符串
   * @throws ServletException
   * @throws IOException
   */
  public static void doMethod(HttpServletRequest request, HttpServletResponse response,String strRet,String strMethodName)
  {
    try
    {    
      if(strMethodName!=null)
      {
        // A ~~~ Beign : 实例化一个类对象
        
    	  // 设置类的初始化参数类型
        Class[] classParamTypes = new Class[] {};
        Constructor cons = AjaxDoAction.class.getConstructor(classParamTypes);
        Object[] classParamArgs = new Object[] {};
        AjaxDoAction ts = (AjaxDoAction)cons.newInstance(classParamArgs);
        // A ~~~ End
        
        // 设置方法的参数类型
        Class[] methodParamTypes = new Class[] {HttpServletRequest.class,HttpServletResponse.class,String.class};
        // 实例化一个方法
        Method method = ts.getClass().getMethod(strMethodName, methodParamTypes);
        // 设置方法的参数值
        Object[] methodParamArgs = new Object[] {request,response,strRet};
        // 执行该方法
        // Object result = method.invoke(ts, methodParamArgs);
        method.invoke(ts, methodParamArgs);
        // 按照返回的参数类型类转换
        // int value = ((Integer)result).intValue();
        // System.out.println(value);
        // System.out.println("反射执行一个:AjaxDoAction." + strMethodName +"(request,response,strRet) 成功！");
        // result = null;
      }
      else
      {
        throw(new Exception("方法名不能为空"));
      }
    } 
    catch (Exception e) 
    {
      System.out.println("反射发生异常！\n" + e.getMessage());
    }

  }
  
}




