<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   sysloglist.jsp
'** 实现功能：   系统日志
'** 设计人员：   Enjsky
'** 设计日期：   2006-03-13
'*******************************
*/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ELEMENT>

<head>
<base href="<%=webRoot%>">
<title>系统日志</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
var g_XML = Efs.Common.getQryXml();
//-->
</SCRIPT>
</HEAD>
<BODY>
<div iconCls="icon-doc" title="登录日志列表" region="center" xtype="grid" pagingBar="true" pageSize="20" buttonAlign="center">
	<div id="affList" xtype="store" url="<%=rootPath%>/getRsQrySysLogList.action" baseParams="{txtXML:g_XML}" autoLoad="true">
		<div xtype="xmlreader" fieldid="LOGID" record="ROW" totalRecords="QUERYINFO@records">
			<div name="LOGID" mapping="LOGID"></div>
			<div name="USERID" mapping="USERID"></div>
			<div name="USERTITLE"></div>
			<div name="USERNAME"></div>
			<div name="UNITNAME"></div>
			<div name="LOGINIP"></div>
			<div name="ENTERTIME"></div>
			<div name="MAC"></div>
		</div>
	</div>
	<div xtype="colmodel">
		<div header="日志编号" width="120" sortable="true" dataIndex="LOGID" ></div>
		<div header="用户登录名" width="160" sortable="true" dataIndex="USERTITLE" ></div>
		<div header="用户姓名" width="100" sortable="true" dataIndex="USERNAME" ></div>
		<div header="用户单位名称" width="200" sortable="true" dataIndex="UNITNAME" ></div>
		<div header="登录IP地址" width="100" sortable="true" dataIndex="LOGINIP" ></div>
		<div header="登录时间" width="140" sortable="true" dataIndex="ENTERTIME" ></div>
		<div header="MAC地址" width="140" sortable="true" dataIndex="MAC" align="left"></div>
	</div>
   <div xtype="buttons">
    <div text="返 回" onEfsClick="top.showTask()"></div>      
   </div>
</div>
</BODY>
</HTML>

