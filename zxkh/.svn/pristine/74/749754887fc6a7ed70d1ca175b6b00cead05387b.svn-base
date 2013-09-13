<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   affairtypelist.jsp
'** 实现功能：   事务类型列表
'** 设计人员：   gwd
'** 设计日期：   2012-12-22
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/developer";
%>
<HTML>
<head>
<base href="<%=webRoot%>">
<title>事务类型列表</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>

<SCRIPT language="JavaScript">

var sAffairTypeID = "";
function onEditEx()
{
  if(sAffairTypeID != "")
  	location.href = "<%=strSelfPath%>/AffairtypeEdit.jsp?txtAffairTypeID=" + sAffairTypeID;
}

function onDelEx()
{
  if(sAffairTypeID != ""){
	  Efs.getExt("frmPost").submit(Efs.getExt("affgrid").getDelXml());
  }
}

function onAddEx()
{
   location.href = "<%=strSelfPath%>/AffairtypeAdd.jsp";
}

function onDicEx()
{
	location.href = "<%=rootPath%>/toCreateDicFile.action?txtXML=AFFAIRTYPE&txtNextUrl=<%=strSelfPath%>/affairtypelist.jsp";
}

var g_XML = Efs.Common.getQryXml();


function doGridClick(data){
	sAffairTypeID = data["AFFAIRTYPEID"];
	if(sAffairTypeID != ""){
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

<div iconCls="icon-panel" title="事务类型列表" id="affgrid" region="center" xtype="grid" pagingBar="true" pageSize="25" onEfsRowClick="doGridClick()" onEfsRowDblClick="onEditEx()">
     <div xtype="tbar">
     	<div text="->"></div>
     	<div iconCls="icon-add" text="增加事务#A" onEfsClick="onAddEx()"></div>
      <div text="->"></div>
     	<div iconCls="icon-edit" id="cmdEdit" text="编辑事务#E" onEfsClick="onEditEx()" disabled="disabled"></div>
      <div text="->"></div>
     	<div iconCls="icon-del" id="cmdDel" text="删除事务#D" onEfsClick="onDelEx()" disabled="disabled"></div>
      <div text="->"></div>
     	<div iconCls="icon-dic" text="生成字典文件#T" onEfsClick="onDicEx()"></div>  
     </div>
	<div id="affList" xtype="store" url="<%=rootPath%>/getRsQryAffairTypeList.action" baseParams="{txtXML:g_XML}" autoLoad="true">
		<div xtype="xmlreader" fieldid="AFFAIRTYPEID" tabName="AFFAIRTYPE" record="ROW" totalRecords="QUERYINFO@records">
			<div name="PARENTID" mapping="PARENTID"></div>
			<div name="AFFAIRTYPEID" mapping="AFFAIRTYPEID"></div>
			<div name="AFFAIRTYPENAME" mapping="AFFAIRTYPENAME"></div>
			<div name="AFFAIRTYPEMODE"></div>
			<div name="AFFAIRTYPEDES"></div>
			<div name="SYSTEMID"></div>
		</div>
	</div>
	<div xtype="colmodel">
		<div header="所属应用系统" width="100" kind="dic" src="DIC_SYSTEM" sortable="true" dataIndex="SYSTEMID"></div>
		<div header="上级事务类型" width="100" kind="dic" src="AFFAIRTYPE" sortable="true" dataIndex="PARENTID"></div>
		<div header="事务类型编号" width="100" sortable="true" dataIndex="AFFAIRTYPEID"></div>
		<div header="事务类型名称" width="200" sortable="true" dataIndex="AFFAIRTYPENAME"></div>
		<div header="事务类型模式" width="200" sortable="true" dataIndex="AFFAIRTYPEMODE"></div>
		<div header="事务类型描述" width="200" sortable="true" dataIndex="AFFAIRTYPEDES"></div>
	</div>
</div>

  <FORM id="frmPost" name="frmPost" url="dealWithXml.action" method="post" style="display:none;" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
    <INPUT type="hidden" name="txtOpXml">
  </FORM>

</BODY>
</HTML>
