<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   SpellEdit.jsp
'** 实现功能：   拼音维护
'** 设计人员：   Enjsky
'** 设计日期：   2006-03-07
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/sysadmin";

String strText = request.getParameter("txtText");
String strSpell = request.getParameter("txtSpell");
String strASpell = request.getParameter("txtASpell");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ELEMENT>
<head>
<base href="<%=webRoot%>">
<title>拼音维护</title>
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
  location.href = "<%=strSelfPath%>/spelllist.jsp";
}
//-->
</SCRIPT>
</HEAD>
<BODY>
<div xtype="panel" title="拼音维护" autoHeight="true" border="false" buttonAlign="center">
  <form id="frmPost" class="efs-box" method="post" action="<%=rootPath%>/spellDeal.action">
      <TABLE class="formArea">
        <tr>
          <td class="label">字符</td>
          <td><input type="text" class="Edit" kind="text" name="txtText" fieldname="TEXT" must="true" value="<%=strText%>"></td>
        </tr>
        <tr>
          <td class="label">拼音头</td>
          <td><input type="text" class="Edit" kind="text" name="txtSpell" fieldname="SPELL" value="<%=strSpell%>" must="true"></td>
        </tr>
        <tr>
          <td class="label">全拼</td>
          <td><input type="text" class="Edit" kind="text" name="txtASpell" fieldname="ASPELL" value="<%=strASpell%>" must="true">
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
