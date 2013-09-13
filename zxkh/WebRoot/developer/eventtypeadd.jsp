<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   eventtypeadd.jsp
'** 实现功能：   增加事件类型
'** 设计人员：   gwd
'** 设计日期：   2012-12-21
'*******************************
*/
%>

<%
String strSelfPath = rootPath + "/developer";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ELEMENT>

<head>
<base href="<%=webRoot%>">
<title>增加事件类型</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<SCRIPT language="JavaScript">
<!--
function doRet()
{
  location.href = "<%=strSelfPath%>/eventtypelist.jsp";
}

// 提交信息
function doSubmit()
{
	if(Efs.getExt("EventtypeID").getValue().length != 6)
	{
	  alert("事件类型编号不是6位");
	  return false;
	}
	else{
		Efs.getExt("frmPost").submit();
	}
}

//-->
</SCRIPT>
</HEAD>
<BODY>
<div xtype="panel" iconCls="titleIcon" title="新增事件类型" border="false" buttonAlign="center" autoScroll="true">
  <form id="frmPost" class="efs-box" method="post" action="<%=rootPath%>/eventDeal.action">
      <TABLE class="formArea">
        <tr>
          <td class="label">事件类型编号</td>
          <td><input type="text" kind="text" name="EventtypeID" id="EventtypeID" operation="0" writeevent="0" state="0" datatype="0" fieldname="EVENTTYPE/EVENTTYPEID" must="true" maxlength="6"></td>
          <td class="label">事件类型名称</td>
          <td><input type="text" kind="text" fieldname="EVENTTYPE/EVENTTYPENAME" state="0" datatype="0" value="" must="true"></td>
        </tr>
        <tr>
          <td class="label">事务类型</td>
          <td><input type="text" kind="dic" src="AFFAIRTYPE" state="0" datatype="0" fieldname="EVENTTYPE/AFFAIRTYPEID" value="" must="true" maxlength="6"></td>
          <td class="label">是否为起始事件类型</td>
          <td><input type="text" kind="dic" src="DIC_TRUEFALSE" fieldname="EVENTTYPE/BEGINEVENT" state="0" datatype="1" must="true" code="0" value="否"></td>
        </tr>
        <tr>
          <td class="label">操作URL</td>
          <td colspan="3"><input type="text" style="width:465px" kind="text" fieldname="EVENTTYPE/OPURL" state="0" datatype="0"></td>
        </tr>
        <tr>
          <td class="label">是否禁用</td>
          <td><input type="text" kind="dic" src="DIC_TRUEFALSE" fieldname="EVENTTYPE/DISABLED" state="0" datatype="1" must="true" code="0" value="否"></td>
          <td class="label">是否为快捷方式</td>
          <td><input type="text" kind="dic" src="DIC_TRUEFALSE" code="0" value="否" fieldname="EVENTTYPE/SHORTCUT" state="0" datatype="1" must="true"></td>
        </tr>
        <tr>
          <td class="label">是否显示</td>
          <td colspan="3"><input type="text" kind="dic" src="DIC_TRUEFALSE" code="1" value="是" fieldname="EVENTTYPE/VISIBLE" state="0" datatype="1" must="true"></td>
        </tr>
        <tr>
          <td class="label">事件类型描述</td>
          <td colspan="3"><TEXTAREA kind="text" style="height:60px;width:465px" fieldname="EVENTTYPE/EVENTTYPEDES" state="0" datatype="0"></TEXTAREA>
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

