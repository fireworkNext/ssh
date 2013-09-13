<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   reportot.jsp
'** 实现功能：   收入汇总报表
'** 设计人员：   gwd
'** 设计日期：   2012-01-18
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/gzcx";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<head>
<base href="<%=webRoot%>">
<title>收入汇总报表</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>

<SCRIPT language="JavaScript">
var g_XML = Efs.Common.getQryXml();

function onExportExcelEx1()
{
	var url="<%=rootPath%>/gzcx/reporttot_excel.jsp?year="+Efs.getDom("foryear1").value;
	//alert(url);
	window.location.href=url;
}

</SCRIPT>
</HEAD>
<BODY>

<div xtype="panel" autoHeight="true" border="false" buttonAlign="center">
	  <form id="frmQry1" class="efs-box" method="post" >
	      <TABLE class="formArea">
	        <tr>
	          <td labelFor="foryear1">统计年度：</td>
	          <td><input type="text" kind="date" format="Y" fieldname="YEAR" must="true" id="foryear1"></td>
	        </tr>
	      </TABLE>
	  </form>
	  <div xtype="buttons">
    	    <div text="统计" onEfsClick="onExportExcelEx1();"></div>
         </div>
</div>
</BODY>
</HTML>

