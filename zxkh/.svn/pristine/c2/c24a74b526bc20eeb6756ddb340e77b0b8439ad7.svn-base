<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   classesList.jsp
'** 实现功能：   查询班级列表
'** 设计人员：   Enjsky
'** 设计日期：   2009-10-14
'*******************************
*/
%>
<HTML>
<head>
<title>查询学生列表</title>
<link rel="stylesheet" type="text/css" href="../css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="../css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="../js/efs-all.js"></script>

<SCRIPT language="JavaScript">

var g_XML = Efs.Common.getQryXml();

var sClassesID = "";
function doGridClick(data){
	sClassesID = data["CID"]
	if(sClassesID != ""){
		Efs.getExt("cmdEdit").enable();
    Efs.getExt("cmdDel").enable();
	}
}

// 进入查询
function doQry()
{
  var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry"));
  Efs.getDom("csList").txtXML = strXml;
  Efs.getExt("csGrid").store.load();
}

// 修改人员档案
function onEditEx() {
  
  if(sClassesID == "")
  {
    alert("没有选择班级");
    return false;
  }
  Efs.getExt("frmData").reset();
  
  //参数1：请求地址,参数2：sClassesID将会放在txtXML参数提交 ，参数3：回调函数
  Efs.Common.ajax("<%=rootPath%>/classes.do?method=detail",sClassesID,function(succ,response,options){
  	 if(succ){ // 是否成功
  	 	var xmlReturnDoc = response.responseXML;
  	 	Efs.Common.setEditValue(xmlReturnDoc.xml,Efs.getExt("frmData"), "QUERYINFO");
  	 	Efs.getExt("CsWin").show();
  	 }else{
  	 	alert("加载数据失败!");
  	 }
  });
  
}

// 隐藏window窗体
function doHideWin(){
	Efs.getExt("CsWin").hide();
}

// 提交修改人员信息
function doSubmit() {
  Efs.getExt("frmData").submit();
}


// 获取异步提交的返回监听函数
function frmPostSubBack(bln,from,action)
{
  
  if(bln)
  {
    doHideWin();
    doQry();
  }
  else
  {
    var xml_http = action.response;
    if(xml_http != null)
    {
      var objXML = xml_http.responseXML;
      alert("处理失败：" + objXML.selectSingleNode("//FUNCERROR").text);
      objXML = null;
    }
    xml_http = null;
  }
}

// 删除人员信息
function onDelEx()
{
  Efs.getExt("frmData").submit(Efs.getExt("csGrid").getDelXml());
}

</SCRIPT>
</HEAD>
<BODY>
<div id="csGrid" region="center" border="false" xtype="grid" iconCls="icon-panel" title="班级列表" pagingBar="true" pageSize="25" onEfsRowClick="doGridClick()" onEfsRowDblClick="onEditEx()">
   <div xtype="tbar">
	   	<div iconCls="icon-edit" id="cmdEdit" text="编辑学生#E" onEfsClick="onEditEx()" disabled></div>
	    <div text="-"></div>
	   	<div iconCls="icon-Del" id="cmdDel" text="删除学生#D" onEfsClick="onDelEx()" disabled></div>
	    <div text="-"></div>
	   	<div iconCls="icon-back" text="返 回" onEfsClick="top.showTask()"></div>
	   	<div text="->"></div>
	    <table>
	    	<tr>
		    	<td>班级名称：</td>
		    	<td><form id="frmQry"  method="post"><input type="text" class="Edit" kind="text" fieldname="CNAME" operation="like" maxlength="30" hint="模糊查询"></form></td>
		    	<td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry()"></td>
	    	</tr>
	    </table>
   </div>
	<div id="csList" xtype="store" url="<%=rootPath%>/classes.do?method=list" baseParams="{txtXML:g_XML}" autoLoad="true">
		<div xtype="xmlreader" fieldid="CID" record="ROW" tabName="CLASSES">
			<div name="CID"></div>
			<div name="CNAME"></div>
			<div name="CMEMO"></div>
		</div>
	</div>
	<div xtype="colmodel">
		<div type="checkbox"></div>
    	<div header="班级编码" width="80" sortable="true" dataIndex="CID" align="center"></div>
		<div header="班级名称" width="120" sortable="true" dataIndex="CNAME" align="center"></div>
		<div header="备注" width="250" sortable="true" dataIndex="CMEMO" align="center"></div>
	</div>
</div>

<!-- window开始 -->
<div iconCls="icon-panel" id="CsWin" xtype="window" width="560" height="225" title="修改班级" resizable="true" modal="true">
  <div region="center" border="false" buttonAlign="center" autoScroll="true">
	  <form id="frmData" class="efs-box" method="post" url="<%=rootPath%>/base.do?method=dealWithXml" method="post" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
	      <TABLE class="formArea">
	        <tr>
	          <td width="100" labelFor="cname">班级名称</td>
	          <td colspan="4">
	          	<INPUT id="cname" type="text" kind="zhunicode" must="true" maxlength="30" fieldname="CLASSES/CNAME" datatype="0" state="0" must="true" />
	          </td>
	        <tr>
	          <td width="100" labelFor="cmemo">备注</td>
	          <td colspan="4">
	          	<TEXTAREA id="cmemo" class="Edit" kind="text" style="height:100px;width:430px" fieldname="CLASSES/CMEMO" state="0" datatype="0"></TEXTAREA>
	          </td>
	        <tr style="display:none;">
	        	<td colspan="4">
		        	<INPUT type="hidden" kind="text" fieldname="CLASSES/CID" datatype="0" state="5" operation="1" writeevent="0" >
	        	</td>
	        </tr>
	      </TABLE>
		</form>
		 <div xtype="buttons">
	     	<div text="保  存" onEfsClick="doSubmit()"></div>
	     	<div text="关  闭" onEfsClick="doHideWin()"></div>      
	   </div>
	</div>
</div>
<!-- window结束 -->

</BODY>
</HTML>

