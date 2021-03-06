<%@ page language="java" import="org.ptbank.cache.*" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp"%>
<%!
/**
	 '*******************************
	 '** 程序名称：   JyxCxTj.jsp
	 '** 实现功能：   简易险查询统计
	 '** 设计人员：   杨一心
	 '** 设计日期：   2013-07-18
	 '*******************************
*/
%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.DecimalFormat" %>
<%@ page import = "java.net.URL"%>
<%@ page language="java" import = "java.sql.*" %>
<%@ page import = "java.io.*"%>
<%@ page import = "org.ptbank.db.*,org.ptbank.func.*,org.ptbank.bo.*,org.ptbank.cache.*,com.alibaba.fastjson.JSON"%>
<%
UserLogonInfo userSession = (UserLogonInfo)request.getSession().getAttribute("user");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<head>
<base href="<%=webRoot%>">
<title>简易险查询统计</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>

<SCRIPT language="JavaScript">

Efs.onReady(
  		function(){
  			doLoadDynaDic();
  			
  		});
  		
//根据用户名返回单位字典
function doLoadDynaDic() {
    var sUserTitle= "<%=userSession.getUserTitle()%>";
    Efs.Common.ajax("<%=rootPath%>/jyx_getUnit1.action",sUserTitle,function(succ,response,options){
       if(succ)    // 是否成功
       { 
           var xmlReturnDoc = response.responseXML;
           Efs.getDom("dynaDicXml").loadXML(xmlReturnDoc.xml);
       }
       else
       {
        alert("加载数据失败!");
       }
      }); 
}


function doQry()
{
	if(!Efs.getExt("frmQry").isValid())
    	return false;
	Efs.getDom("xsStore").txtXML = Efs.Common.getQryXml(Efs.getExt("frmQry"));
	Efs.getDom("xsStore").url="<%=rootPath%>/jyx_Qrytjjyx.action";
    Efs.getExt("xsGrid").store.load();
    var q = "<%=rootPath%>";
  	alert("dddd"+ q);
}

function ToEt()
{
	var elTable = document.getElementById("xsGrid"); //xsGrid 为导出数据所在的表格ID；
	var oRangeRef = document.body.createTextRange();
	oRangeRef.moveToElementText(elTable);
	oRangeRef.execCommand("Copy");
	try{
		var appEt = new  ActiveXObject("ET.Application");
		}catch(e)
		{
		  alert("无法调用ET对象，请确保您的机器已安装了WPS办公软件并已将本系统的站点名加入到IE的信任站点列表中！");
		  return;
		}
	appEt.Visible = true;
	appEt.Workbooks.Add().Worksheets.Item(1).Paste();
	appEt = null;
}

</SCRIPT>
</head>
<body>
	<div iconCls="icon-panel" region="north" height="70" title="简易险查询统计" border="false" buttonAlign="center" autoScroll="true">
	<form id="frmQry" method="post" url="" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
		<TABLE class="formAreaTop"  cellpadding="10" cellspacing="10">
	      <tr>
	        <TD>单  位</TD>
			<TD><INPUT type="text" class="Edit" must="true"  kind="dic" src="#dynaDicXml" fieldname="UNITID"></TD>
	        <TD>险  种</TD>
			<TD align="left"><INPUT type="text" class="Edit" kind="dic" src="DIC_XZ" must="true" fieldname="XZ"></TD>
	        <td>起始时间</td>
	        <td><input type="text" class="Edit" kind="date" fieldname="TO_CHAR(TBSJ,'YYYYMMDD')" operation="&gt;="></td>
	        <td>结束时间</td>
	        <td><input type="text" class="Edit" kind="date" fieldname="TO_CHAR(TBSJ,'YYYYMMDD')" operation="&lt;="></td>
    	    <td><input iconCls="icon-qry" type="button" value="查  询" onEfsClick="doQry()"></td>
    	   <td><input iconCls="icon-qry" type="button" value="导出到 表格" onEfsClick="ToEt()"></td>
    	  </tr>
		</TABLE>
	</form>
	</div>
	
	<div id="xsGrid" region="center" border="flase" xtype="grid" iconCls="icon-panel"  pagingBar="true" pageSize="20">
	   	<div xtype="tbar">
	   		<span style="font-size: 9pt; font-weight: bold; color: #15428B;">明细列表</span>
	    </div>
	   <div id="xsStore" xtype="store" txtXML="" autoLoad="false">
			<div xtype="xmlreader" fieldid="XSID" record="ROW">
				<div name="XZ"></div>
				<div name="FS"></div>
				<div name="JE"></div>
				<div name="UNITID"></div>
				<div name="UNITNAME"></div>
				<div name="MSUNITID"></div>
				<div name="TBSJ"></div>
			</div>]5
		</div>
		<div xtype="colmodel">
			<div header="险  种" width="120" sortable="true"  align="center" dataIndex="XZ" kind="dic" src="DIC_XZ" align="center"></div>
			<div header="份  数" width="120" sortable="true" align="center" dataIndex="FS"></div>
			<div header="金  额" width="120" sortable="true" align="center" dataIndex="JE"></div>
			<div header="单位ID" width="120" sortable="true" align="center" dataIndex="UNITID"></div>
			<div header="单  位" width="120" sortable="true" align="center" dataIndex="UNITNAME"></div>
			<div header="上级单位ID" width="120" sortable="true" align="center" dataIndex="MSUNITID"></div>
			<div header="时  间" width="120" sortable="true" align="center"	dataIndex="TBSJ"></div>
		</div>
	</div>

<!--动态组成字典列表例子  -->
<div style="display:none">
	<xml id="dynaDicXml">
	</xml>
	<form id="frm" method="post" url="" >
		<input type="text" id="UNITID1" fieldname="UNITID"/>
	</form>
</div>

</body>
</html>

