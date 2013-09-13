<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   unittpllist.jsp
'** 实现功能：   单位工资模版管理（增删改查）
'** 设计人员：   gwd
'** 设计日期：   2012-12-16
'*******************************
*/
%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.DecimalFormat" %>
<%@ page import = "java.net.URL"%>
<%@ page language="java" import = "java.sql.*" %>
<%@ page import = "java.io.*"%>
<%@ page import = "org.ptbank.db.*,org.ptbank.func.*,org.ptbank.cache.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
UserLogonInfo userSession = (UserLogonInfo)session.getAttribute("user");
String strSelfPath = rootPath + "/gzcx";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<head>
<base href="<%=webRoot%>">
<title>单位薪酬模版列表</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<SCRIPT language="JavaScript">
var g_XML = Efs.Common.getQryXml();
var sPid = "";
var sTpl = "";
var sDbfld = "";
var sDwbm = "";
var sTplpid = "";

Efs.onReady(function(){
	//doQry();
});

function doQry()
{
	var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry"));
	Efs.getDom("list1").setAttribute("txtXML",strXml);
	Efs.getExt("grid1").store.reload();
}

function onAddEx()
{
	Efs.getExt("win1").show();
	var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry1"));
	Efs.getDom("list2").setAttribute("txtXML",strXml);
	Efs.getDom("list2").setAttribute("url","<%=rootPath%>/gzcx_getChooseTplList.action?tpl="+Efs.getDom("tpl").getAttribute("code")+"&dwbm="+sDwbm);
	Efs.getExt("grid2").store.reload();
}

function onEditEx()
{
	if(sTpl == "")
	{
	  alert("没有选择记录!");
	  return false;
	}
	Efs.getExt("frmData").reset();
	Efs.Common.ajax("<%=rootPath%>/gzcx_getUnitTplDetail.action",sPid,function(succ,response,options){
    if(succ)    // 是否成功
    {
     	var returnXML = response.responseText;
     	Efs.Common.setEditValue(returnXML,Efs.getExt("frmData"), "QUERYINFO");
     	Efs.getDom("pid").setAttribute("operation","1");
		Efs.getDom("pid").setAttribute("state","5");
		Efs.getExt("tpl").disable();
		Efs.getExt("dbfld").disable();
		with(Efs.getExt("win1"))
		{
		  setTitle("修改窗口");
		  show();
		}
	}
    else
    {
    	alert("返回数据失败!");
    	return false;
    }
   });
}

// 删除任务
function onDelEx()
{
	if(sPid == "")
	{
		alert("没有选择记录");
		return false;
	}
	if(!confirm("确定要删除吗？"))
		return false;
	Efs.getExt("frmData").submit(Efs.getExt("grid1").getDelXml());
}

function doTreeClick(node){
	sDwbm = node.attributes.id;
	Efs.getDom("dwbm").setAttribute("value",sDwbm);
	if(Efs.getExt("frmQry").isValid()){
		doQry();
	}
}

function doGridClick(data){
	sPid = data["PID"];
	sTpl = data["TPL"];
	sDbfld = data["DBFLD"];
	
	if(sPid != ""){
		try{
    		Efs.getExt("cmdDel").enable();
    		Efs.getExt("cmdExcel").enable();
    		Efs.getExt("cmdExcel1").enable();
		}catch(e){
		}
	}
}

function doGridClick1(data){
	sTplpid = data["PID"];
}

function doOk()
{
	if(sDwbm=="" || sDwbm===undefined){
		alert("请选择单位后再进行后续操作");
		return false;
	}
	
	//根据grid多项选择组织增加语句
	var records = Efs.getExt("grid2").getSelectionModel().getSelections();
	var aXml = "<DATAINFO>";
	Ext.each(records,function(r){
		aXml += "<T_UNIT_TPL operation=\"0\" writeevent=\"0\">";
		aXml +="<PID datatype=\"0\" state=\"0\" />";
		aXml +="<DWBM datatype=\"0\" state=\"0\">"+sDwbm+"</DWBM>";
		aXml +="<TPLPID datatype=\"0\" state=\"0\">"+r.data["PID"]+"</TPLPID>";
		aXml +="</T_UNIT_TPL>";
	});
	aXml += "</DATAINFO>";
	//Efs.getDom("dwbm1").setAttribute("value",sDwbm);
	//Efs.getDom("tplpid1").setAttribute("value",sTplpid);
	//var strXml = Efs.Common.getOpXml(Efs.getExt("frmData"));
	//alert(strXml);
	//alert(aXml);
	Efs.getExt("frmData").submit(aXml);
}

// 获取异步提交的返回监听函数
function frmPostSubBack(bln,from,action)
{
  if(bln)
  {
      Efs.getExt("win1").hide();
      Efs.getExt("grid1").store.load();
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

function onExcelEx(){
	if(sTpl == "")	
	{
		alert("没有选择记录");
		return false;
	}
	if(sDwbm == "")	
	{
		alert("请选择单位后再进行后续操作");
		return false;
	}
	Efs.Common.ajax("<%=rootPath%>/gzcx_expDwTpl.action?tpl="+sTpl+"&dwbm="+sDwbm,sTpl,function(succ,response,options){
	    if(succ)    // 是否成功
	    {
	     	var sFileName = response.responseText;
	     	if(sFileName=="" || typeof sFileName==undefined)
	     	{
	     		alert("文件生成失败");
	     		return false;
	     	}
	     	var url="<%=rootPath%>/download.action?filename="+sFileName;
	     	window.location.href=url;
		}
	    else
	    {
	    	alert("文件生成失败!");
	    	return false;
	    }
	   });
}

function onExcelEx1(){
	if(sTpl == "")	
	{
		alert("没有选择记录");
		return false;
	}
	if(sDwbm == "")	
	{
		alert("请选择单位后再进行后续操作");
		return false;
	}
	Efs.Common.ajax("<%=rootPath%>/gzcx_expDwTplExcel.action?tpl="+sTpl+"&dwbm="+sDwbm,sTpl,function(succ,response,options){
	    if(succ)    // 是否成功
	    {
	     	var sFileName = response.responseText;
	     	if(sFileName=="" || typeof sFileName==undefined)
	     	{
	     		alert("文件生成失败");
	     		return false;
	     	}
	     	var url="<%=rootPath%>/download.action?filename="+sFileName;
	     	window.location.href=url;
		}
	    else
	    {
	    	alert("文件生成失败!");
	    	return false;
	    }
	   });
}
</SCRIPT>
</HEAD>
<BODY>
<div region="west" width="250" title="单位树" autoScroll="true" border="tue" collapsible="true" collapseMode="true">
	<div id="treepanel1" xtype="treepanel" height="100%" autoScroll="true" onEfsClick="doTreeClick()" border="false">
	    <div xtype="loader" id="loader1" url="<%=rootPath%>/getUnitJsonTree.action" txtXML="" parentPath="QUERYINFO"></div>
	</div>
</div>
<div region = "center" border="false">
	<div iconCls="icon-panel" region="north" height="60" title="查询条件" border="true" collapsible="true" collapseMode="true">
	 <form class="formAreaTop" id="frmQry"  method="post">
	  <TABLE>
	      <tr>
	        <td labelfor="tpl" class="label">模版名称</td>
	        <td><input type="text" id="tpl" name="tpl" class="Edit" kind="dic" src="DIC_GZCX_TPL" fieldname="TPL" must="true" value="工资发放明细模版" code="wagedetailtpl" ></td>
	        <td class="label">数据库字段</td>
	        <td><input type="text" class="Edit" kind="text" fieldname="DBFLD" operation="like" hint="模糊查询"></td>
			<td class="label">字段名称</td>
			<td><input type="text" class="Edit" kind="text" fieldname="FLDNAME" operation="like" hint="模糊查询"></td>
			<td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry()"></td>
	      </tr>
	    </TABLE>
	    <input type="hidden" id="dwbm" name="dwbm" kind="text" fieldname="DWBM" must="true" value="<%=userSession.getUnitID() %>" state="0" datatype="0">
	  </form>
	</div>
	
	<div iconCls="icon-panel" id="grid1" region="center" xtype="grid" pagingBar="true" pageSize="20" onEfsRowClick="doGridClick()" onEfsRowDblClick="onEditEx()" buttonAlign="center">
		<div xtype="tbar">
		  <span style="font-size:9pt;font-weight:bold;color:#15428B;">单位薪酬模版列表</span>
		  <div text="->"></div>
		  <div iconCls="icon-add" id="cmdAdd" text="增加#A" onEfsClick="onAddEx()"></div>
		  <div iconCls="icon-del" id="cmdDel" text="删除#D" onEfsClick="onDelEx()" disabled="disabled"></div>
		  <div iconCls="icon-excel" id="cmdExcel" text="导出模版wps#T" onEfsClick="onExcelEx()" disabled="disabled"></div>
		  <div iconCls="icon-excel" id="cmdExcel1" text="导出模版excel#E" onEfsClick="onExcelEx1()" disabled="disabled"></div>   
		</div>
		<div id="list1" xtype="store" url="<%=rootPath%>/gzcx_getUnitTplList.action" baseParams="{txtXML:g_XML}" autoLoad="false">
			<div xtype="xmlreader" fieldid="PID" tabName="T_UNIT_TPL" record="ROW" totalRecords="QUERYINFO@records">
				<div name="PID"></div>
				<div name="DWBM"></div>
				<div name="TPLPID"></div>
				<div name="MUNITNAME"></div>
				<div name="TPL"></div>
				<div name="TPLNAME"></div>
				<div name="DBFLD"></div>
				<div name="FLDNAME"></div>
				<div name="FLDWIDTH"></div>
				<div name="FLDORD"></div>
				<div name="FLAG"></div>
				<div name="IMPFLAG"></div>
				<div name="FLAG1"></div>
				<div name="FLAG2"></div>
			</div>
		</div>
		<div xtype="colmodel">
	    	<div type="checkbox"></div>
	    	<div header="单位编码" width="100" sortable="true" dataIndex="DWBM" align="center"></div>
	    	<div header="单位名称" width="100" sortable="true" dataIndex="MUNITNAME" align="center"></div>
	    	<div header="模版" width="100" sortable="true" dataIndex="TPL" align="center"></div>
			<div header="模版" width="100" sortable="true" dataIndex="TPL" align="center"></div>
			<div header="模版名称" width="120" sortable="true" dataIndex="TPLNAME" align="center"></div>
			<div header="数据库字段" width="100" sortable="true" dataIndex="DBFLD" align="center"></div>
			<div header="字段名称" width="100" sortable="true" dataIndex="FLDNAME" align="center"></div>
			<div header="字段宽度" width="120" sortable="true" dataIndex="FLDWIDTH" align="center"></div>
			<div header="字段顺序" width="80" sortable="true" dataIndex="FLDORD" align="center"></div>
			<div header="启用标志" width="100" sortable="true" kind="dic" src="DIC_TPLFLAG" dataIndex="FLAG" align="center"></div>
			<div header="导入标志" width="100" sortable="true" kind="dic" src="DIC_TPLIMPFLAG" dataIndex="IMPFLAG" align="center"></div>
			<div header="应发应扣标志" width="100" sortable="true" kind="dic" src="DIC_FLAG1" dataIndex="FLAG1" align="center"></div>
			<div header="企业缴纳标志" width="100" sortable="true" kind="dic" src="DIC_FLAG2" dataIndex="FLAG2" align="center"></div>
		</div>
	</div>
</div>

<!-- window开始 -->
<div iconCls="icon-panel" id="win1" xtype="window" width="800" height="400" title="选择窗口" resizable="true" modal="true">
  <div iconCls="icon-panel" id="grid2" region="center" xtype="grid" pagingBar="true" pageSize="9999" onEfsRowClick="doGridClick1()" onEfsRowDblClick="doOk()" buttonAlign="center">
	<div xtype="tbar">
	  <span style="font-size:9pt;font-weight:bold;color:#15428B;">可选择模版列表</span>
	  <div text="->"></div>
	  <div iconCls="icon-add" id="cmdAdd" text="启用#A" onEfsClick="doOk()"></div>
	</div>
	<div id="list2" xtype="store" url="<%=rootPath%>/gzcx_getChooseTplList.action" baseParams="{txtXML:g_XML}" autoLoad="false">
		<div xtype="xmlreader" fieldid="PID" tabName="T_TPL" record="ROW" totalRecords="QUERYINFO@records">
			<div name="PID"></div>
			<div name="TPL"></div>
			<div name="TPLNAME"></div>
			<div name="DBFLD"></div>
			<div name="FLDNAME"></div>
			<div name="FLDWIDTH"></div>
			<div name="FLDORD"></div>
			<div name="FLAG"></div>
			<div name="IMPFLAG"></div>
			<div name="FLAG1"></div>
			<div name="FLAG2"></div>
		</div>
	</div>
	<div xtype="colmodel">
    	<div type="checkbox"></div>
		<div header="模版" width="100" sortable="true" dataIndex="TPL" align="center"></div>
		<div header="模版名称" width="120" sortable="true" dataIndex="TPLNAME" align="center"></div>
		<div header="数据库字段" width="100" sortable="true" dataIndex="DBFLD" align="center"></div>
		<div header="字段名称" width="100" sortable="true" dataIndex="FLDNAME" align="center"></div>
		<div header="字段宽度" width="120" sortable="true" dataIndex="FLDWIDTH" align="center"></div>
		<div header="字段顺序" width="80" sortable="true" dataIndex="FLDORD" align="center"></div>
		<div header="启用标志" width="100" sortable="true" kind="dic" src="DIC_TPLFLAG" dataIndex="FLAG" align="center"></div>
		<div header="导入标志" width="100" sortable="true" kind="dic" src="DIC_TPLIMPFLAG" dataIndex="IMPFLAG" align="center"></div>
		<div header="应发应扣标志" width="100" sortable="true" kind="dic" src="DIC_FLAG1" dataIndex="FLAG1" align="center"></div>
		<div header="企业缴纳标志" width="100" sortable="true" kind="dic" src="DIC_FLAG2" dataIndex="FLAG2" align="center"></div>
	</div>
  </div>
</div>
<!-- window结束 -->

<form id="frmData" style="display:none" method="post" url="<%=rootPath%>/gzcx_dealWithXml.action" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
    <input type="hidden" id="pid1" name="pid1" kind="text" fieldname="T_UNIT_TPL/PID" operation="0" writeevent="0" state="0" datatype="0">
    <input type="hidden" id="dwbm1" name="dwbm1" kind="text" fieldname="T_UNIT_TPL/DWBM" must="true" state="0" datatype="0">
	<input type="hidden" id="tplpid1" name="tplpid1" kind="text" fieldname="T_UNIT_TPL/TPLPID" must="true" state="0" datatype="0">
</form>

<form class="formAreaTop" id="frmQry1"  method="post">
	<input type="hidden" kind="text" fieldname="TPL" must="true" state="0" datatype="0">
</form>
</BODY>
</HTML>

