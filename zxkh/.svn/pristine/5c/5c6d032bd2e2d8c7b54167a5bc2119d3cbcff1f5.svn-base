<%@ page language="java" import="org.ptbank.person.*,org.ptbank.base.XmlFunc,org.dom4j.Document" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   psnDetail.jsp
'** 实现功能：   详细信息
'** 设计人员：   Enjsky
'** 设计日期：   2009-10-14
'*******************************
*/
%>
<%
String strPsnXml = PersonBO.personDetail2(request.getParameter("txtPersonID"));
Document doc = XmlFunc.CreateNewDoc(strPsnXml);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>人员详细信息</title>
  </head>
  
  <body>
    
    <TABLE border="1" align="center">
      <TR>
        <TD>姓名</TD>
        <TD><%=XmlFunc.getNodeValue(doc,"PERSON/NAME") %></TD>
        <TD>性别</TD>
        <TD><%=XmlFunc.getNodeValue(doc,"PERSON/SEX") %></TD>
      </TR>
      <TR>
        <TD>出生日期</TD>
        <TD><%=XmlFunc.getNodeValue(doc,"PERSON/BIRTHDAY") %></TD>
        <TD>籍贯</TD>
        <TD><%=XmlFunc.getNodeValue(doc,"PERSON/PLACECODE") %></TD>
      </TR>
    </TABLE>

<%

strPsnXml = PersonBO.personDetail3(request.getParameter("txtPersonID"));

out.print(strPsnXml);

%>
  </body>

</html>
