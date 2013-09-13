<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   tpllist.jsp
'** 实现功能：   工资模版管理（增删改查）
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
<title>工资模版管理</title>
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

Efs.onReady(function(){
	doLoadDic("DIC_GZCX_TPL");
	doLoadDicBySQL("DIC_DBFLD","select dbfld,fldname from t_dbfld where fldname is not null");
	doQry();
});

function doLoadDic(sDic){
	Efs.Common.ajax("<%=rootPath%>/getDic.action",sDic,function(succ,response,options){
	    if(succ)    // 是否成功
	    {
	     	var returnXML = response.responseText;
	     	Efs.getDom(sDic).loadXML(returnXML);
		}
	    else
	    {
	    	alert("动态获取字典"+sDic+"失败!");
	    	return false;
	    }
	   });
}

function doLoadDicBySQL(sDic,sSQL){
	Efs.Common.ajax("<%=rootPath%>/getDicBySQL.action",sSQL,function(succ,response,options){
	    if(succ)    // 是否成功
	    {
	     	var returnXML = response.responseText;
	     	Efs.getDom(sDic).loadXML(returnXML);
		}
	    else
	    {
	    	alert("动态获取字典"+sDic+"失败!");
	    	return false;
	    }
	   });
}

function doQry()
{
	var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry"));
	Efs.getDom("list1").setAttribute("txtXML",strXml);
	Efs.getExt("grid1").store.reload();
}

function onAddEx()
{
	Efs.getDom("pid").setAttribute("operation","0");
	Efs.getDom("pid").setAttribute("state","0");
	Efs.getExt("tpl").enable();
	Efs.getExt("dbfld").enable();
	
	Efs.getExt("frmData").reset();
	with(Efs.getExt("win1"))
	{
	  setTitle("添加窗口");
	  show();
	  Efs.getExt("tpl").focus(true,true);
	}
}

function onEditEx()
{
	if(sTpl == "")
	{
	  alert("没有选择记录!");
	  return false;
	}
	Efs.getExt("frmData").reset();
	Efs.Common.ajax("<%=rootPath%>/gzcx_getTplDetail.action",sPid,function(succ,response,options){
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

function doGridClick(data){
	sPid = data["PID"];
	sTpl = data["TPL"];
	sDbfld = data["DBFLD"];
	
	if(sPid != ""){
		try{
			Efs.getExt("cmdEdit").enable();
    		Efs.getExt("cmdDel").enable();
    		Efs.getExt("cmdExcel").enable();
		}catch(e){
		}
	}
}

function doOk()
{
	//alert(Efs.getExt("tpl").getValue());
	//alert(Efs.getDom("tpl").getAttribute("code"));
	if(Efs.getExt("frmData").isValid()){
		Efs.getExt("tplname").setValue(Efs.getExt("tpl").getValue());
		var strXml = Efs.Common.getOpXml(Efs.getExt("frmData"));
		Efs.getExt("frmData").submit(strXml);
	}
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
	Efs.Common.ajax("<%=rootPath%>/gzcx_expTpl.action?tpl="+sTpl,sTpl,function(succ,response,options){
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

<div iconCls="icon-panel" region="north" height="60" title="查询条件" border="true" collapsible="true" collapseMode="true">
 <form class="formAreaTop" id="frmQry"  method="post">
  <TABLE>
      <tr>
        <td class="label">模版名称</td>
        <td><input type="text" class="Edit" kind="dic" src="#DIC_GZCX_TPL" fieldname="TPL" ></td>
        <td class="label">数据库字段</td>
        <td><input type="text" class="Edit" kind="text" fieldname="DBFLD" operation="like" hint="模糊查询"></td>
		<td class="label">字段名称</td>
		<td><input type="text" class="Edit" kind="text" fieldname="FLDNAME" operation="like" hint="模糊查询"></td>
		<td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry()"></td>
      </tr>
    </TABLE>
  </form>
</div>

<div iconCls="icon-panel" id="grid1" region="center" xtype="grid" pagingBar="true" pageSize="20" onEfsRowClick="doGridClick()" onEfsRowDblClick="onEditEx()" buttonAlign="center">
	<div xtype="tbar">
	  <span style="font-size:9pt;font-weight:bold;color:#15428B;">模版列表</span>
	  <div text="->"></div>
	  <div iconCls="icon-add" id="cmdAdd" text="增加#A" onEfsClick="onAddEx()"></div>
	  <div iconCls="icon-edit" id="cmdEdit" text="修改#E" onEfsClick="onEditEx()" disabled="disabled"></div>
	  <div iconCls="icon-del" id="cmdDel" text="删除#D" onEfsClick="onDelEx()" disabled="disabled"></div>
	  <div iconCls="icon-excel" id="cmdExcel" text="导出模版#T" onEfsClick="onExcelEx()" disabled="disabled"></div>   
	</div>
	<div id="list1" xtype="store" url="<%=rootPath%>/gzcx_getTplList.action" baseParams="{txtXML:g_XML}" autoLoad="false">
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
			<div name="SHOWFLAG"></div>
		</div>
	</div>
	<div xtype="colmodel">
    	<div type="radio"></div>
		<div header="模版" width="100" sortable="true" dataIndex="TPL" align="center"></div>
		<div header="模版名称" width="120" sortable="true" dataIndex="TPLNAME" align="center"></div>
		<div header="数据库字段" width="100" sortable="true" dataIndex="DBFLD" align="center"></div>
		<div header="字段名称" width="100" sortable="true" dataIndex="FLDNAME" align="center"></div>
		<div header="字段宽度" width="120" sortable="true" dataIndex="FLDWIDTH" align="center"></div>
		<div header="字段顺序" width="80" sortable="true" dataIndex="FLDORD" align="center"></div>
		<div header="启用标志" width="100" sortable="true" kind="dic" src="DIC_TPLFLAG" dataIndex="FLAG" align="center"></div>
		<div header="导入标志" width="100" sortable="true" kind="dic" src="DIC_TPLIMPFLAG" dataIndex="IMPFLAG" align="center"></div>
		<div header="显示标志" width="100" sortable="true" kind="dic" src="DIC_FLAG2" dataIndex="SHOWFLAG" align="center"></div>
		<div header="应发应扣标志" width="100" sortable="true" kind="dic" src="DIC_FLAG1" dataIndex="FLAG1" align="center"></div>
		<div header="企业缴纳标志" width="100" sortable="true" kind="dic" src="DIC_FLAG2" dataIndex="FLAG2" align="center"></div>
	</div>
</div>

<!-- window开始 -->
<div iconCls="icon-panel" id="win1" xtype="window" width="600" height="400" title="编辑窗口" resizable="true" modal="true">
  <div region="center" xtype="panel" title="" border="false" autoScroll="true">
    <div xtype="tbar">
      <div text="->"></div>
      <div iconCls="icon-add" id="cmdUser" text="确  定" onEfsClick="doOk()"></div>
    </div>
    <form id="frmData" class="efs-box" method="post" url="<%=rootPath%>/gzcx_dealWithXml.action" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
    <TABLE>
      <tr>
        <td class="label">模版</td>
        <td><input type="text" id="tpl" name="tpl" class="Edit" kind="dic" src="#DIC_GZCX_TPL" fieldname="T_TPL/TPL" state="0" datatype="0" must="true"></td>
      	<td>&nbsp;</td>
      	<td class="label">数据库字段</td>
        <td><input type="text" id="dbfld" name="dbfld" class="Edit" kind="dic" src="#DIC_DBFLD" fieldname="T_TPL/DBFLD" must="true" state="0" datatype="0"></td>
      </tr>
      <tr>
        <td class="label">字段宽度</td>
        <td><input type="text" class="Edit" kind="int" fieldname="T_TPL/FLDWIDTH" must="true" state="0" datatype="0"></td>
        <td>&nbsp;</td>
        <td class="label">字段顺序</td>
        <td><input type="text" class="Edit" kind="text" fieldname="T_TPL/FLDORD" must="true" state="0" datatype="0"></td>
      </tr>
      <tr>
        <td class="label">是否启用</td>
        <td><input type="text" class="Edit" kind="dic" src="DIC_TPLFLAG" fieldname="T_TPL/FLAG" must="true" state="0" datatype="0"></td>
        <td>&nbsp;</td>
        <td class="label">是否导入</td>
        <td><input type="text" class="Edit" kind="dic" src="DIC_TPLIMPFLAG" fieldname="T_TPL/IMPFLAG" must="true" state="0" datatype="0"></td>
      </tr>
      <tr>
        <td class="label">应发应扣标志</td>
        <td><input type="text" class="Edit" kind="dic" src="DIC_FLAG1" fieldname="T_TPL/FLAG1" must="true" state="0" datatype="0"></td>
        <td>&nbsp;</td>
        <td class="label">企业缴纳标志</td>
        <td><input type="text" class="Edit" kind="dic" src="DIC_FLAG2" fieldname="T_TPL/FLAG2" must="true" state="0" datatype="0"></td>
      </tr>
      <tr>
        <td class="label">显示标志</td>
        <td><input type="text" class="Edit" kind="dic" src="DIC_FLAG2" fieldname="T_TPL/SHOWFLAG" must="true" state="0" datatype="0"></td>
      </tr>
    </TABLE>
    <input type="hidden" id="tplname" name="tplname" class="Edit" kind="text" fieldname="T_TPL/TPLNAME" must="true" state="0" datatype="0">
    <input type="hidden" id="pid" name="pid" kind="text" fieldname="T_TPL/PID" operation="0" writeevent="0" state="0" datatype="0">
    </form>
  </div>
</div>
<!-- window结束 -->
<div style="display:none">
<xml id="DIC_GZCX_TPL">
</xml>
<xml id="DIC_DBFLD">
</xml>
</div>
</BODY>
</HTML>

