<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   eventtypelist.jsp
'** 实现功能：   事件类型列表
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
<title>事件类型列表</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>

<SCRIPT language="JavaScript">

var g_XML = Efs.Common.getQryXml();

var sEventTypeID = "";
function onEditEx()
{
  if(sEventTypeID != "")
  	location.href = "<%=strSelfPath%>/eventtypeedit.jsp?txtEventTypeID=" + sEventTypeID;
}

function onDelEx()
{
  if(sEventTypeID != ""){
	  Efs.getExt("frmPost").submit(Efs.getExt("affgrid").getDelXml());
  }
}

function onAddEx()
{
  location.href = "<%=strSelfPath%>/eventtypeadd.jsp";
}

function onDicEx()
{
  location.href = "<%=rootPath%>/toCreateDicFile.action?txtXML=EVENTTYPE&txtNextUrl=<%=strSelfPath%>/eventtypelist.jsp";
}

function doGridClick(data){
	sEventTypeID = data["EVENTTYPEID"];
	if(sEventTypeID != ""){
		Efs.getExt("cmdEdit").enable();
		Efs.getExt("cmdDel").enable();
	}
}

//获取异步提交的返回监听函数
function frmPostSubBack(bln,from,action)
{
  
  if(bln)
  {
	Efs.getExt("affgrid").store.load();
  }
  else
  {
    var xml_http = action.response;
    if(xml_http != null)
    {
    	var objXML = xml_http.responseXML;
        alert("交易失败：" + Efs.Common.getNodeValue(objXML,"//FUNCERROR",0));
        objXML = null;
    }
    xml_http = null;
  }
}
</SCRIPT>
</HEAD>
<BODY>

<div iconCls="icon-panel" id="affgrid" region="center" xtype="grid" title="事件类型列表" pagingBar="true" pageSize="25" onEfsRowClick="doGridClick()" onEfsRowDblClick="onEditEx()" buttonAlign="center">
	<div id="affList" xtype="store" url="<%=rootPath%>/getRsQryEventTypeList.action" baseParams="{txtXML:g_XML}" autoLoad="true">
		<div xtype="xmlreader" fieldid="EVENTTYPEID" tabName="EVENTTYPE" record="ROW" totalRecords="QUERYINFO@records">
			<div name="EVENTTYPEID" mapping="EVENTTYPEID"></div>
			<div name="EVENTTYPENAME" mapping="EVENTTYPENAME"></div>
			<div name="AFFAIRTYPENAME"></div>
			<div name="DISABLED"></div>
			<div name="VISIBLE"></div>
		</div>
	</div>
	<div xtype="colmodel">
		<div type="checkbox"></div>
		<div header="事件类型编号" width="80" sortable="true" dataIndex="EVENTTYPEID" align="center"></div>
		<div header="事件类型名称" width="120" sortable="true" dataIndex="EVENTTYPENAME" align="center"></div>
		<div header="事务类型名称" width="120" sortable="true" dataIndex="AFFAIRTYPENAME" align="center"></div>
		<div header="是否禁用" width="60" sortable="true" dataIndex="DISABLED" align="center"></div>
		<div header="是否显示" width="60" sortable="true" dataIndex="VISIBLE" align="center"></div>
	</div>

     <div xtype="buttons">
     	<div iconCls="icon-add" text="增加事件类型#A" onEfsClick="onAddEx()"></div>
     	<div iconCls="icon-edit" id="cmdEdit" text="编辑事件类型#E" onEfsClick="onEditEx()" disabled></div>
     	<div iconCls="icon-del" id="cmdDel" text="删除事件类型#D" onEfsClick="onDelEx()" disabled="disabled"></div>
     	<div iconCls="icon-dic" text="生成字典文件#T" onEfsClick="onDicEx()"></div>  
     </div>
</div>

<FORM id="frmPost" name="frmPost" url="dealWithXml.action" method="post" style="display:none;" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
  <INPUT type="hidden" name="txtOpXml">
</FORM>
</BODY>
</HTML>
