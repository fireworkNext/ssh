<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   maxidtypeList.jsp
'** 实现功能：   号码分配列表
'** 设计人员：   Enjsky
'** 设计日期：   2006-03-10
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/sysadmin";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<head>
<title>号码分配列表</title>
<link rel="stylesheet" type="text/css" href="../css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="../css/efs-all.css" />
<script type="text/javascript" src="../js/loadmask.js"></script>
<script type="text/javascript" src="../js/efs-all.js"></script>

<SCRIPT language="JavaScript">

var g_XML = Efs.Common.getQryXml();

var sMaxIDType = "";
function onEditEx()
{
  if(sEventTypeID != "")
  	location.href = "<%=strSelfPath%>/eventtypeedit.jsp?txtEventTypeID=" + sEventTypeID;
}


function onAddEx()
{
  Efs.getDom("IDType").operation = "0";
  Efs.getDom("IDType").state = "0";

  Efs.getExt("frmData").reset();
  with(Efs.getExt("MaxTypeWin"))
  {
    setTitle("添加编码规则");
    show();
  }
}

function onEditEx()
{
  if(sMaxIDType == "")
  {
    alert("没有选择编码规则");
    return false;
  }
  Efs.getExt("frmData").reset();
  var xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
  xmlhttp.Open("POST","<%=rootPath%>/ajax?method=getMaxTYpeDetail&txtMaxIDType=" + sMaxIDType,false);
  xmlhttp.Send();
  var xmlReturnDoc = new ActiveXObject("MSXML2.DOMDocument");
  xmlReturnDoc = xmlhttp.responseXML;
  Efs.Common.setEditValue(xmlReturnDoc.xml,Efs.getExt("frmData"), "QUERYINFO");
  xmlReturnDoc = null;
  xmlhttp = null;
  Efs.getDom("IDType").operation = "1";
  Efs.getDom("IDType").state = "5";
  
  
  with(Efs.getExt("MaxTypeWin"))
  {
    setTitle("修改用户");
    show();
  }
  
}
// 删除编码规则
function onDelEx()
{
  if(sMaxIDType == "")
  {
    alert("没有选择编码规则");
    return false;
  }
  if(!confirm("确定要删除吗？"))
    return false;
    
  with(document.frmPost)
  {
    url = "<%=rootPath%>/ajax?method=maxidTypeDeal";
    var strXml = "<DATAINFO><MAXIDTYPE writeevent='0' operation='2'><IDTYPE datatype='0' state='5'>" + sMaxIDType + "</IDTYPE></MAXIDTYPE></DATAINFO>";
    txtOpXml.value = strXml;
  }
  Efs.getExt("frmPost").submit();
}

function doGridClick(data){
	sMaxIDType = data["IDTYPE"]
	if(sMaxIDType != ""){
		Efs.getExt("cmdEdit").enable();
    Efs.getExt("cmdDel").enable();
    Efs.getExt("cmdMaxID").enable();
	}
}

function doMaxType()
{
  if(Efs.getExt("frmData").isValid()){
    var strXml = Efs.Common.getOpXml(Efs.getExt("frmData"))
    with(document.frmPost)
    {
      url = "<%=rootPath%>/ajax?method=maxidTypeDeal";
      txtOpXml.value = strXml;
    }
    opObj = "";
    Efs.getExt("frmPost").submit();
  }         
  
}

// 获取异步提交的返回监听函数
function frmPostSubBack(bln,from,action)
{
  if(bln)
  {
    if(opObj != "maxid") {
      Efs.getExt("MaxTypeWin").hide();
      Efs.getExt("maxgrid").store.load();
    }
    else {
      Efs.getExt("maxidGrid").store.load();
    }
  }
  else
  {
    var xml_http = action.response;
    if(xml_http != null)
    {
      var objXML = xml_http.reponseXML;
      
      alert("加载失败：" + objXML.selectSingleNode("//FUNCERROR").text);
      objXML = null;
    }
    xml_http = null;
  }
}

function onMaxID()
{
  Efs.getExt("MaxIDWin").show();  
  Efs.getDom("maxidList").txtXML = sMaxIDType;
  Efs.getExt("maxidGrid").store.load();
}


var opObj = "";
// 删除已经分配的编码
function onMaxIDDel()
{
  if(!confirm("确实要删除吗？"))
  {
    return false;
  }
  opObj = "maxid";
  
  var objXML = Efs.getExt("maxidGrid").getSelectedXml(true);
  if(objXML.selectSingleNode("//DATAINFO/MAXID")) {
    for(var i=0;i<objXML.selectNodes("//DATAINFO/MAXID").length;i++)
    {
      objXML.selectNodes("//DATAINFO/MAXID").item(i).setAttribute("operation","2");
      objXML.selectNodes("//DATAINFO/MAXID/IDTYPE").item(i).setAttribute("state","5");
      objXML.selectNodes("//DATAINFO/MAXID/IDTYPE").item(i).setAttribute("datatype","0");
      objXML.selectNodes("//DATAINFO/MAXID/ID1").item(i).setAttribute("state","5");
      objXML.selectNodes("//DATAINFO/MAXID/ID1").item(i).setAttribute("datatype","0");
      objXML.selectNodes("//DATAINFO/MAXID/MAXID").item(i).setAttribute("state","5");
      objXML.selectNodes("//DATAINFO/MAXID/MAXID").item(i).setAttribute("datatype","0");
    }
    var sXmlTmp = Efs.Common.addRootXml(objXML.xml);
    objXML = null;
  
    with(document.frmPost)
    {
      url = "<%=rootPath%>/ajax?method=maxidTypeDeal";
      txtOpXml.value = sXmlTmp;
    }
  
    Efs.getExt("frmPost").submit();
  }
  else {
    alert("没有选择已分配的编码");
  }
  
}
</SCRIPT>
</HEAD>
<BODY>

<div iconCls="icon-panel" id="maxgrid" region="center" xtype="grid" title="编码分配管理" pagingBar="true" pageSize="20" onEfsRowClick="doGridClick()" onEfsRowDblClick="onEditEx()" buttonAlign="center">
  <div xtype="tbar">
    <span style="font-size:9pt;font-weight:bold;color:#15428B;">编码列表</span>
    <div text="->"></div>
    <div iconCls="icon-add" text="增加编码#A" onEfsClick="onAddEx()"></div>
    <div text="-"></div>
    <div iconCls="icon-deal" text="编码处理">
      <div iconCls="icon-edit" id="cmdEdit" text="修改编码#E" onEfsClick="onEditEx()" disabled></div>
      <div text="-"></div>
      <div iconCls="icon-del" id="cmdDel" text="删除编码#D" onEfsClick="onDelEx()" disabled></div>
      <div text="-"></div>
      <div iconCls="icon-doc" id="cmdMaxID" text="已分配编码管理" onEfsClick="onMaxID()" disabled></div>
    </div>
    <div text="-"></div>
    <div iconCls="icon-back" text="返 回" onEfsClick="top.showTask()"></div>      
  </div>
	<div id="maxList" xtype="store" url="<%=rootPath%>/ajax?method=getQryMaxTypeList" baseParams="{txtXML:g_XML}" autoLoad="true">
		<div xtype="xmlreader" fieldid="IDTYPE" tabName="MAXIDTYPE" record="ROW" totalRecords="QUERYINFO@records">
			<div name="IDTYPE" mapping="IDTYPE"></div>
			<div name="IDNAME" mapping="IDNAME"></div>
			<div name="IDSIZE"></div>
			<div name="IDPARA"></div>
			<div name="IDLOOP"></div>
			<div name="IDMIN"></div>
			<div name="IDMAX"></div>
		</div>
	</div>
	<div xtype="colmodel">
    <div type="radio"></div>
		<div header="编码编号" width="80" sortable="true" dataIndex="IDTYPE" align="center"></div>
		<div header="编码名称" width="120" sortable="true" dataIndex="IDNAME" align="left"></div>
		<div header="编码长度" width="60" sortable="true" dataIndex="IDSIZE" align="center"></div>
		<div header="编码规则" width="80" sortable="true" dataIndex="IDPARA" align="center"></div>
		<div header="是否循环" width="60" sortable="true" dataIndex="IDLOOP" align="center"></div>
		<div header="最小值" width="80" sortable="true" dataIndex="IDMIN" align="center"></div>
		<div header="最大值" width="100" sortable="true" dataIndex="IDMAX" align="left"></div>
	</div>
</div>

<div iconCls="icon-panel" id="MaxIDWin" xtype="window" width="280" height="400" title="已分配编码列表" resizable="true" modal="true">
  <div id="maxidGrid" region="center" xtype="grid" title="">
    <div xtype="tbar">
      <div text="->"></div>
      <div iconCls="icon-del" id="cmdMaxIDDel" text="删除已分配编码#D" onEfsClick="onMaxIDDel()"></div>
    </div>
    <div id="maxidList" xtype="store" url="<%=rootPath%>/getQryMaxList.action" txtXML="" autoLoad="false">
      <div xtype="xmlreader" fieldid="ID1" tabName="MAXID" record="ROW">
        <div name="IDTYPE"></div>
        <div name="ID1"></div>
        <div name="MAXID"></div>
      </div>
    </div>
    <div xtype="colmodel">
      <div type="checkbox"></div>
      <div header="编码编号" width="60" sortable="true" dataIndex="IDTYPE" align="center"></div>
      <div header="种子" width="60" sortable="true" dataIndex="ID1" align="center"></div>
      <div header="当前值" width="80" sortable="true" dataIndex="MAXID" align="center"></div>
    </div>
  </div>
</div>

<!-- window开始 -->
<div iconCls="icon-panel" id="MaxTypeWin" xtype="window" width="500" height="190" title="添加编码规则" resizable="true" modal="true">
  <div region="center" xtype="panel" title="" border="false" autoScroll="true">
    <div xtype="tbar">
      <div text="->"></div>
      <div iconCls="icon-add" id="cmdUser" text="确  定" onEfsClick="doMaxType()"></div>
    </div>
    <form id="frmData" class="efs-box" method="post">
    <TABLE>
      <tr>
        <td class="label">编码编号</td>
        <td><input type="text" class="Edit" name="IDType" id="IDType" maxlength="6" kind="text" fieldname="MAXIDTYPE/IDTYPE" must="true" operation="0" writeevent="0" state="0" datatype="0"></td>
        <td>&nbsp;</td>
        <td class="label">编码名称</td>
        <td><input type="text" class="Edit" kind="text" fieldname="MAXIDTYPE/IDNAME" state="0" datatype="0" must="true"></td>
      </tr>
      <tr>
        <td class="label">编码长度</td>
        <td><input type="text" class="Edit" kind="int" fieldname="MAXIDTYPE/IDSIZE" state="0" datatype="1" must="true"></td>
        <td>&nbsp;</td>
        <td class="label">编码规则</td>
        <td><input type="text" class="Edit" kind="dic" src="DIC_IDPARA" fieldname="MAXIDTYPE/IDPARA" state="0" datatype="0" must="true"></td>
      </tr>
      <tr>
        <td class="label">是否循环</td>
        <td><input type="text" class="Edit" kind="dic" src="DIC_TRUEFALSE" fieldname="MAXIDTYPE/IDLOOP" state="0" datatype="0" must="true"></td>
        <td>&nbsp;</td>
        <td class="label">最小值</td>
        <td><input type="text" class="Edit" kind="int" fieldname="MAXIDTYPE/IDMIN" state="0" datatype="1" must="true"></td>
      </tr>
      <tr>
        <td class="label">最大值</td>
        <td><input type="text" class="Edit" kind="int" fieldname="MAXIDTYPE/IDMAX" state="0" datatype="1" must="true"></td>
      </tr>
    </TABLE>
    </form>
  </div>
</div>
<!-- window结束 -->

<FORM id="frmPost" name="frmPost" url="" method="post" style="display:none;" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
  <INPUT type="hidden" name="txtOpXml">
</FORM>
  
</BODY>
</HTML>

