<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   dbfldlist.jsp
'** 实现功能：   数据库字段管理（增删改查）
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
<title>数据库字段管理</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<SCRIPT language="JavaScript">
var g_XML = Efs.Common.getQryXml();
var sPid = "";
var sDbfld = "";

Efs.onReady(function(){
	doQry();
});

function toUpper(){
	var sValue=Efs.getExt('dbfld').getValue();
	Efs.getExt('dbfld').setValue(Ext.util.Format.uppercase(sValue));
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
	Efs.getExt("pid").enable();
	
	Efs.getExt("frmData").reset();
	with(Efs.getExt("win1"))
	{
	  setTitle("添加窗口");
	  show();
	  Efs.getExt("dbfld").focus(true,true);
	}
}

function onEditEx()
{
	if(sPid == "")
	{
	  alert("没有选择记录!");
	  return false;
	}
	Efs.getExt("frmData").reset();
	Efs.Common.ajax("<%=rootPath%>/gzcx_getDbfldDetail.action",sPid,function(succ,response,options){
    if(succ)    // 是否成功
    {
     	var returnXML = response.responseText;
     	Efs.Common.setEditValue(returnXML,Efs.getExt("frmData"), "QUERYINFO");
     	Efs.getDom("pid").setAttribute("operation","1");
		Efs.getDom("pid").setAttribute("state","5");
		Efs.getExt("pid").disable();
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
	sDbfld = data["DBFLD"];
	
	if(sPid != ""){
		try{
			Efs.getExt("cmdEdit").enable();
    		Efs.getExt("cmdDel").enable();
    		Efs.getExt("cmdDic").enable();
		}catch(e){
		}
	}
}

function doOk()
{
	//alert(Efs.getExt("tpl").getValue());
	//alert(Efs.getDom("tpl").getAttribute("code"));
	if(Efs.getExt("frmData").isValid()){
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

//获取异步提交的返回监听函数
function frmPostSubBack1(bln,from,action)
{
  if(bln)
  {
      alert("字典创建成功");
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
	if(sId == "")	
	{
		alert("没有选择记录");
		return false;
	}
	var url="<%=rootPath%>/gzcx/tpl_excel.jsp?tpl="+sTpl;
	document.location=url;
}

//生成字典文件
function onCreateDic()
{
	var sDicName = "DIC_DBFLD";
	var sTableName = "T_DBFLD";
	document.frmPost.setAttribute("url","<%=rootPath%>/gzcx_createDicFile.action");
	document.frmPost.txtDicName.setAttribute("value",sDicName);
	document.frmPost.txtTableName.setAttribute("value",sTableName);
	Efs.getExt("frmPost").submit();
}

</SCRIPT>
</HEAD>
<BODY>

<div iconCls="icon-panel" region="north" height="60" title="查询条件" border="true" collapsible="true" collapseMode="true">
 <form class="formAreaTop" id="frmQry"  method="post">
  <TABLE>
      <tr>
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
	  <span class="Title">数据库字段列表</span>
	  <div text="->"></div>
	  <div iconCls="icon-add" id="cmdAdd" text="增加#A" onEfsClick="onAddEx()"></div>
	  <div iconCls="icon-edit" id="cmdEdit" text="修改#E" onEfsClick="onEditEx()" disabled="disabled"></div>
	  <div iconCls="icon-del" id="cmdDel" text="删除#D" onEfsClick="onDelEx()" disabled="disabled"></div>
	  <div iconCls="icon-dic" id="cmdDic" text="生成字典文件#C" onEfsClick="onCreateDic()" disabled="disabled"></div>  
	</div>
	<div id="list1" xtype="store" url="<%=rootPath%>/gzcx_getDbfldList.action" baseParams="{txtXML:g_XML}" autoLoad="false">
		<div xtype="xmlreader" fieldid="PID" tabName="T_DBFLD" record="ROW" totalRecords="QUERYINFO@records">
			<div name="PID"></div>
			<div name="DBFLD"></div>
			<div name="FLDNAME"></div>
			<div name="EDITFLAG"></div>
		</div>
	</div>
	<div xtype="colmodel">
    	<div type="radio"></div>
		<div header="数据库字段" width="100" sortable="true" dataIndex="DBFLD" align="center"></div>
		<div header="字段名称" width="100" sortable="true" dataIndex="FLDNAME" align="center"></div>
		<div header="编辑标志" width="100" sortable="true" kind="dic" src="DIC_ABLE" dataIndex="EDITFLAG" align="center"></div>
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
      	<td class="label">数据库字段</td>
        <td><input type="text" id="dbfld" name="dbfld" class="Edit" kind="text" fieldname="T_DBFLD/DBFLD" must="true" state="0" datatype="0" onEfsBlur="toUpper();"></td>
        <td>&nbsp;</td>
        <td class="label">字段显示名称</td>
        <td><input type="text" id="fldname" name="fldname" class="Edit" kind="text" fieldname="T_DBFLD/FLDNAME" must="true" state="0" datatype="0"></td>
      </tr>
      <tr>
        <td class="label">是否可编辑</td>
        <td><input type="text" class="Edit" kind="dic" src="DIC_ABLE" fieldname="T_DBFLD/EDITFLAG" must="true" state="0" datatype="0"></td>
        <td>&nbsp;</td>
      </tr>
    </TABLE>
    <input type="hidden" id="pid" name="pid" kind="text" fieldname="T_DBFLD/PID" operation="0" writeevent="0" state="0" datatype="0">
    </form>
  </div>
</div>
<!-- window结束 -->
<FORM id="frmPost" name="frmPost" url="" method="post" style="display:none;" onEfsSuccess="frmPostSubBack1(true)" onEfsFailure="frmPostSubBack1(false)">
  <INPUT type="hidden" name="txtDicName">
  <INPUT type="hidden" name="txtTableName">
  <INPUT type="hidden" name="txtDicDes">
</FORM>
</BODY>
</HTML>

