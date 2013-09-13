<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   roleadd.jsp
'** 实现功能：   增加角色
'** 设计人员：   Enjsky
'** 设计日期：   2006-03-13
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/sysadmin";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<head>
<base href="<%=webRoot%>">
<title>增加角色</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<SCRIPT language="JavaScript">
<!--
function doSubmit()
{
  Efs.getExt("frmPost").submit();
}

function doRet()
{
  location.href = "<%=strSelfPath%>/rolelist.jsp";
}
//-->
</SCRIPT>
</HEAD>
<BODY>
<div xtype="panel" title="添加新的角色" autoHeight="true" border="false" buttonAlign="center">
  <form id="frmPost" class="efs-box" method="post" action="<%=rootPath%>/roleAddNew.action">
      <TABLE class="formArea">
        <tr style="display:none">
          <td class="label">角色编号</td>
          <td><input type="text" class="Edit" kind="text" fieldname="ROLEBASIC/ROLEID" operation="0" writeevent="0" state="0" datatype="0"><br><br></td>
        </tr>
        <tr>
          <td class="label">角色名称</td>
          <td><input type="text" class="Edit" kind="text" fieldname="ROLEBASIC/ROLENAME" state="0" datatype="0" must="true"></td>
        </tr>
        <tr>
          <td class="label">角色描述</td>
          <td><TEXTAREA class="Edit" kind="text" style="height:60px;width:380px" fieldname="ROLEBASIC/ROLEDES" state="0" datatype="0"></TEXTAREA>
          </td>
        </tr>
      </TABLE>
      </FORM>
	<div xtype="buttons">
     	<div text="确  定" onEfsClick="doSubmit()"></div>
     	<div text="返  回" onEfsClick="doRet()"></div>
     </div>
</div>    


</BODY>
</HTML>

