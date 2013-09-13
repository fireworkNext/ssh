<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   errloglist.jsp
'** 实现功能：   错误日志
'** 设计人员：   Enjsky
'** 设计日期：   2006-03-13
'*******************************
*/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ELEMENT>
<head>
<base href="<%=webRoot%>">
<title>错误日志</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var g_XML = Efs.Common.getQryXml();
</SCRIPT>
</HEAD>
<BODY>
<div title="错误日志列表" region="center" xtype="grid" pagingBar="true" pageSize="25" buttonAlign="center">
	<div id="affList" xtype="store" url="<%=rootPath%>/ajax?method=getRsQryErrorLogList" baseParams="{txtXML:g_XML}" autoLoad="true">
		<div xtype="xmlreader" fieldid="ERRID" record="ROW" totalRecords="QUERYINFO@records">
			<div name="ERRID" mapping="ERRID"></div>
			<div name="USERID" mapping="USERID"></div>
			<div name="USERNAME"></div>
			<div name="UNITNAME"></div>
			<div name="ERRDES1"></div>
			<div name="OPTIME"></div>
		</div>
	</div>
	<div xtype="colmodel">
		<div header="错误日志编号" width="100" sortable="true" dataIndex="ERRID" align="center"></div>
		<div header="用户编号" width="100" sortable="true" dataIndex="USERID" align="center"></div>
		<div header="用户姓名" width="100" sortable="true" dataIndex="USERNAME" align="center"></div>
		<div header="用户单位名称" width="200" sortable="true" dataIndex="UNITNAME" align="center"></div>
		<div header="错误描述" width="100" sortable="true" dataIndex="ERRDES1" align="center"></div>
		<div header="操作时间" width="140" sortable="true" dataIndex="OPTIME" align="center"></div>
	</div>
   <div xtype="buttons">
    <div text="返 回" onEfsClick="top.showTask()"></div>      
   </div>
</div>

</BODY>
</HTML>

