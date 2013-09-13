<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   SpellList.jsp
'** 实现功能：   拼音维护
'** 设计人员：   Enjsky
'** 设计日期：   2006-03-07
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
<title>用户维护</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<SCRIPT language="JavaScript">

var sText = "";
var sSpell = "";
var sASpell = "";

function doGridClick(data){
  sText = data["WORD"]
  sSpell = data["SPELL"]
  sASpell = data["ASPELL"]
  if(sText != ""){
    Efs.getExt("cmdEdit").enable();
  }
}

function objGridDbClick()
{
  onEditEx();
}

function onEditEx()
{
  if(sText == "")
  {
    alert("没有选择汉字");
    return false;
  }
  
  with(document.frmPost)
  {
    action = "<%=strSelfPath%>/SpellEdit.jsp";
    txtText.value = sText;
    txtSpell.value = sSpell;
    txtASpell.value = sASpell;
    submit();
  }
}


function onAddEx()
{
  with(document.frmPost)
  {
    action = "<%=strSelfPath%>/SpellEdit.jsp";
    txtText.value = "";
    txtSpell.value = "";
    txtASpell.value = "";
    submit();
  }
}


var g_XML = Efs.Common.getQryXml();


</SCRIPT>
</HEAD>
<BODY>
<div iconCls="icon-panel" title="汉字及拼音维护" id="affgrid" region="center" xtype="grid" pagingBar="true" pageSize="25" onEfsRowClick="doGridClick()" onEfsRowDblClick="onEditEx()">
     <div xtype="tbar">
     	<span></span>
     	<div iconCls="icon-add" text="增加汉字#A" onEfsClick="onAddEx()"></div>
      <div text="-"></div>
     	<div iconCls="icon-edit" id="cmdEdit" text="编辑汉字#E" onEfsClick="onEditEx()" disabled></div>
      <div text="-"></div>
     	<div iconCls="icon-back" text="返 回" onEfsClick="top.showTask()"></div>      
     </div>
	<div id="affList" xtype="store" url="<%=rootPath%>/ajax?method=getRsQrySpellList" baseParams="{txtXML:g_XML}" autoLoad="true">
		<div xtype="xmlreader" fieldid="WORD" record="ROW" totalRecords="QUERYINFO@records">
			<div name="WORD" mapping="WORD"></div>
			<div name="SPELL" mapping="SPELL"></div>
			<div name="ASPELL"></div>
		</div>
	</div>
	<div xtype="colmodel">
		<div header="字" width="50" sortable="true" dataIndex="WORD"></div>
		<div header="拼音头" width="50" sortable="true" dataIndex="SPELL"></div>
		<div header="全拼" width="50" sortable="true" dataIndex="ASPELL"></div>
	</div>
</div>



<FORM name="frmPost" style="display:none" action="" method="post">
  <INPUT type="hidden" name="txtText">
  <INPUT type="hidden" name="txtSpell">
  <INPUT type="hidden" name="txtASpell">
</FORM>
</BODY>
</HTML>
