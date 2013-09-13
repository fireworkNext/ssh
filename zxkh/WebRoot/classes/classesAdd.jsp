<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   classAdd.jsp
'** 实现功能：   添加学生基本信息
'** 设计人员：   Enjsky
'** 设计日期：   2009-10-14
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/classes";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ELEMENT>
<head>
<base href="<%=webRoot%>">
<title>添加学生基本信息</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>

<SCRIPT language="JavaScript">
<!--
function doRet()
{
  location.href = "<%=strSelfPath%>/classesList.jsp";
}

// 提交信息
function doSubmit()
{
  Efs.getExt("frmData").submit();
}

//-->
</SCRIPT>
</HEAD>
<BODY>
<div xtype="panel" iconCls="icon-panel" title="添加班级基本信息" border="false" buttonAlign="center" autoScroll="true">
  <form id="frmData" class="efs-box" method="post" action="<%=rootPath%>/classes.do?method=add&txtNextUrl=classes/classesList.jsp" method="post">
      <TABLE class="formArea">
        <tr>
          <td width="100" labelFor="cname">班级名称</td>
          <td colspan="4">
          	<INPUT id="cname" type="text" kind="text" must="true" maxlength="30" fieldname="CLASSES/CNAME" datatype="0" state="0" must="true" />
          </td>
        <tr>
          <td width="100" labelFor="cmemo">备注</td>
          <td colspan="4">
          	<TEXTAREA id="cmemo" class="Edit" kind="text" style="height:60px;width:430px" fieldname="CLASSES/CMEMO" state="0" datatype="0"></TEXTAREA>
          </td>
        <tr style="display:none;">
        	<td colspan="4">
	        	<INPUT type="hidden" kind="text" fieldname="CLASSES/CID" datatype="0" state="0" operation="0" writeevent="0" >
        	</td>
        </tr>
      </TABLE>
	</form>
	 <div xtype="buttons">
     	<div text="确  定" onEfsClick="doSubmit()"></div>
     	<div text="返  回" onEfsClick="doRet()"></div>      
   </div>
</div>

</BODY>
</HTML>

