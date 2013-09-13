<%@ page language="java" import="org.ptbank.cache.*,org.ptbank.bo.*,org.ptbank.func.*,org.ptbank.baseManage.*,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ include file="inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：  main.jsp
'** 实现功能：   主界面
'** 设计人员：   gwd
'** 设计日期：   2012-12-15
'*******************************
*/
%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

UserLogonInfo userSession = (UserLogonInfo)request.getSession().getAttribute("user");
SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
String sBgnDate = General.curYear4()+"-01-01";
String sEndDate = sf.format(DateTimeUtil.addDays(-1));
String isManager = "1";
if(!(userSession.getUserType().equals("10"))){
	isManager = "1";
}
%>
<HTML>
<HEAD>
<base href="<%=basePath%>">
<title>莆田邮政简易险销售管理系统</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<style>
<!--
.efs-box td{
  padding :5;
  font:normal normal normal 12px Arial;
}
.title{
  font:18pt 黑体;
  color:#ffffff;
}

td{
  font-size:9pt;
}

a  { font:normal 12px ; color:#FFFFFF; text-decoration:none; }
a:hover  { color:#FFFFFF;text-decoration: underline; }

@media print{ 
body {display:none} 
}
-->
</style>

<script type="text/javascript">
var sWebRoot = '<%=rootPath%>';
var sIsManager = <%=isManager%>;

// 显示任务
function showTask(strEventTypeID)
{
	var datNow = new Date();
	var obj = top.famRMain;
	var sRandom = datNow.getUTCFullYear() + datNow.getUTCMonth() +
		datNow.getUTCDate() + datNow.getUTCHours() + datNow.getUTCMinutes() +
		datNow.getMinutes() + datNow.getUTCSeconds() + datNow.getUTCMilliseconds();
	var sUrl = sWebRoot + "/task.jsp?random=" + sRandom;

	if (strEventTypeID) {
		if (strEventTypeID.length > 0) {
			sUrl += "&EventTypeID=" + strEventTypeID;
		}
	}
	obj.location = unescape(sUrl);
}

function wageEvent(strEventTypeID,opurl)
{
	var obj = top.famRMain;
	var sUrl = sWebRoot + "/"+opurl;
	if(strEventTypeID=="030610"){
		document.location = unescape(sUrl);
	}else{
		obj.location = unescape(sUrl);
	}
}

// 帮助
function doHelp()
{
	alert("帮助");
}

// 退出
function doQuit()
{
  famRMain.location = sWebRoot + "/logoff.jsp";
}

// 退出
function _doExit()
{
	document.location = sWebRoot;
}

function logOff()
{
	try
	{
		alert("登录超时，请重新登录");
		_doExit();
	}
	catch(e){}
}

Efs.onReady(
	function(){
		var sUrl = "";
		if(sIsManager=="1"){
  			sUrl = sWebRoot + "/welcome.jsp";
		}else {
			sUrl = sWebRoot + "/portal.jsp";
		}
  		Efs.getDom("famRMain").setAttribute("src",sUrl);
    	//Efs.getExt("treepanel").expandAll();
});
</script>

</HEAD>
<BODY>

<div region="north" height="50" border="false" title="功能菜单" iconCls="icon-doc">
	<div xtype="toolbar">
		<% 
	  		ArrayList al1 = IdentifyBO.getUserRightAffair("0",userSession);
	  		for(int i=0;i<al1.size();i++){
	  			UserRight userRightAffair = (UserRight)al1.get(i);
	  	%>
	  	<div text="<%=userRightAffair.getAffairtypeName() %>" iconCls="icon-pub">
	  	
	  	<%
	  			ArrayList al2 = IdentifyBO.getUserRightEvent(userRightAffair.getAffairtypeId(), userSession);
	  			for(int j=0;j<al2.size();j++){
	  				UserRight userRightEvent = (UserRight)al2.get(j);
	  	%>
	  		<div text="<%=userRightEvent.getEventtypeName() %>" iconCls="icon-pub" onEfsClick="wageEvent('<%=userRightEvent.getEventtypeId() %>','<%=userRightEvent.getOpurl()%>');"></div> <!--单个按钮-->
	  	<%
	  			}
	  	%>
	  	</div>
	  	<div text="-"></div><!--分隔符-->
	  	<%
	  		}
	  	%>
	  <div id="cmdQuit" text="注销" iconCls="icon-quit" onEfsClick="doQuit();"></div>
	</div>
</div>

<div region="center" border="false" title="个人基本信息">
	<div iconCls="icon-panel" region="north" xtype="panel" border="false" height="60">
		<form id="frmData" method="post" action="">
	     <TABLE class="formAreaTop" width="100%" height="100%" cellpadding="0" cellspacing="0">
	        <tr>
	          <td width="200">&nbsp;</td>
	          <td align="center">姓名：</td>
	          <td align="left"><input type="text" class="Edit" kind="text" readOnly="true" value="<%=userSession.getUserName()%>"></td>
	          <td align="center">身份证号码：</td>
	          <td align="left"><input type="text" class="Edit" kind="text" readOnly="true" value="<%=userSession.getIDCard()%>"></td>
	        </tr>
	        <tr align="center">
	          <td width="200">&nbsp;</td>
	          <td align="center">单位：</td>
	          <td align="left"><input type="text" class="Edit" kind="text" readOnly="true" value="<%=userSession.getUnitName()%>"></td>
	          <td align="center">部门：</td>
	          <td align="left"><input type="text" class="Edit" kind="text" readOnly="true" value="<%=userSession.getBmmc()%>"></td>
	        </tr>
	      </TABLE>
	    </form>
	</div>
	<div id="main" region="center" border="false">
		<iframe id="famRMain" name="famRMain" region="center" frameborder="no" height="100%" width="100%" src=""></iframe>
	</div>
</div>
<div region="south" xtype="panel" height="20" border="false">
	<div align="center"><font color="#15428b" style="font-size:12px;font-weight:bold">莆田邮政简易险销售管理系统 版本V1.0　　莆田邮政信息技术中心研发　</font></div>
</div>

</BODY>
</HTML>