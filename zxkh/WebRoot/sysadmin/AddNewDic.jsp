<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   AddNewDic.jsp
'** 实现功能：   增加新的字典
'** 设计人员：   Enjsky
'** 设计日期：   2006-03-10
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/sysadmin";
%>
<HTML XMLNS:ELEMENT>

<head>
<base href="<%=webRoot%>">
<title>增加新字典</title>
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
  location.href = "<%=strSelfPath%>/diclist.jsp";
}

function toEditableCode(obj)
{
  Efs.getDom("frmPost").txtEditable.value=obj.code;
}
//-->
</SCRIPT>
</HEAD>
<BODY>
<div xtype="panel" title="添加新的字典" autoHeight="true" border="false" buttonAlign="center">
  <form id="frmPost" class="efs-box" method="post" action="<%=rootPath%>/dicAddNew.action">
      <TABLE class="formArea">
        <tr>
          <td class="label">字典名称</td>
          <td><input type="text" class="Edit" kind="text" name="txtDicName" fieldname="DIC_CODE" must="true"></td>
        </tr>
        <tr>
          <td class="label">字典描述</td>
          <td><input type="text" class="Edit" kind="text" name="txtDicDes" fieldname="DIC_TEXT" value="" must="true"></td>
        </tr>
        <tr>
          <td class="label">字典编码长度</td>
          <td><input type="text" class="Edit" kind="float" name="txtCodeLen" fieldname="DIC_TEXT" value="" must="true"></td>
        </tr>
        <tr style="display:none">
          <td class="label">字典文本长度</td>
          <td><input type="text" class="Edit" kind="float" name="txtTextLen" fieldname="DIC_TEXT" value="50" must="true"></td>
        </tr>
        <tr>
          <td class="label">字典修改权限</td>
          <td><input type="text" class="Edit" kind="dic" src="DIC_DICEDITABLE" name="Editable" fieldname="DIC_TEXT" value="" must="true" onblur="toEditableCode(this)"></td>
        </tr>
        <tr style="display:none">
          <td class="label">字典修改编码</td>
          <td><input type="text" class="Edit" kind="text" name="txtEditable" fieldname="DIC_TEXT" value="" must="true"></td>
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

