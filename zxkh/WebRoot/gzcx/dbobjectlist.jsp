<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   dbobjectlist.jsp
'** 实现功能：   数据库对象管理（增删改查）
'** 设计人员：   gwd
'** 设计日期：   2013-4-5
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
<title>数据库对象管理</title>
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
	doLoadDic("DIC_SQL_TYPE");
	//doQry();
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

function initGrid(griddata)
{
	//按当前模版信息初始化grid
	var nodeAry=griddata.nodeAry;
	var headerAry=griddata.headerAry;
	var colmWidAry=griddata.colmWidAry;
	createGrid(nodeAry,headerAry,colmWidAry);
}

// nodeAry 对应节点数组
// headerAry 对应列表头数组
// colmWidAry 对应没列宽数组
function createGrid(nodeAry,headerAry,colmWidAry)
{
    // 设置XmlReader读取模式
    var m_reader = new Ext.data.XmlReader(
                       { record: 'ROW' ,totalRecords:'QUERYINFO@records'},
                         nodeAry);
    Efs.getExt("grid1").getStore().reader = m_reader;
    
    // 获得grid的列模式
    var colModel = Efs.getExt("grid1").getColumnModel();
    
    // 先隐藏所有
    var strColum_hidden = [];
    for(var i=0;i< colModel.getColumnCount()-1;i++)
    {
    	strColum_hidden[i] = {id:colModel.getColumnId(i),dataIndex:colModel.getColumnId(i),hidden:true};
    }
    colModel.setConfig(strColum_hidden);
    
    /*for(var i=0;i<headerAry.length;i++)
    {
      colModel.setColumnHeader(i+1,headerAry[i]);
      colModel.setDataIndex(i+1,nodeAry[i]);
      colModel.setColumnWidth(i+1,colmWidAry[i]);
      colModel.setHidden(i+1,false);
    }*/
    
    // 以下写法是可行的，但是不是很直观，需要比较清楚extjs的列模式配置
    var strColum_Cfg = [];
    strColum_Cfg[0]=new Ext.grid.PageRowNumberer();
    for(var i=0;i<headerAry.length;i++)
    {
      	strColum_Cfg[i+1] = {id: nodeAry[i], header: headerAry[i], width: 100, dataIndex: nodeAry[i], sortable: false};
    }
    colModel.setConfig(strColum_Cfg);
}

function isExists(arr,obj) 
{
	for(var i=0;i<arr.length;i++){
		if(arr[i]==obj)
			return true;
	}
	return false;
}

function doQry1()
{
	var sqltype = Efs.getExt("forsqltype1").getValue();
	if(sqltype!="" && sqltype=="查询"){
		if(Efs.getDom("forobjectname1").getAttribute("value")==""){
			alert("对象名称不能为空!");
			Efs.getExt("forobjectname1").focus(true,true);
			return false;
		}
	}else if(sqltype!="" && sqltype=="更新"){
		if(Efs.getDom("forsql1").getAttribute("value")==""){
			alert("SQL语句不能为空!");
			Efs.getExt("forsql1").focus(true,true);
			return false;	
		}
	}
	
	if(Efs.getExt("frmQry1").isValid()){
		var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry1"));
		//通过ajax调用动态返回创建grid所需的信息
		Efs.Common.ajax("<%=rootPath%>/gzcx_getObjectCreateGridJsonAll.action",strXml,function(succ,response,options){
	    if(succ)    // 是否成功
	    {
	    	var sqltype = Efs.getExt("forsqltype1").getValue();
	    	var returnJson = "";
	    	if(sqltype!="" && sqltype=="查询"){
	    		returnJson = eval("(" + response.responseText + ")");
	    		initGrid(returnJson);
		     	
			   	Efs.getDom("list1").setAttribute("txtXML", strXml);
			   	Efs.getExt("grid1").getStore().reload();
	    	}else if(sqltype!="" && sqltype=="更新"){
	    		alert(response.responseText);
	    	}
		}
	    else
	    {
	    	alert("返回数据失败!");
	    	return false;
	    }
	    });
	}
}

function doSqlChange(){
	/*var sqltype = Efs.getExt("forsqltype1").getValue();
	if(sqltype!="" && sqltype=="查询"){
		Efs.getExt("forsql1").setDisabled(true);
		Efs.getExt("forobjectname1").setDisabled(false);
		Efs.getExt("forwhere1").setDisabled(false);
		Efs.getExt("fororder1").setDisabled(false);
	}else if(sqltype!="" && sqltype=="更新"){
		Efs.getExt("forsql1").setDisabled(false);
		Efs.getExt("forobjectname1").setDisabled(true);
		Efs.getExt("forwhere1").setDisabled(true);
		Efs.getExt("fororder1").setDisabled(true);
	}*/
}

function doTreeClick(node){
	sText = node.attributes.text;
	Efs.getDom("forobjectname1").setAttribute("value",sText);
}

// 获取异步提交的返回监听函数
function frmPostSubBack(bln,from,action)
{
  if(bln)
  {
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

</SCRIPT>
</HEAD>
<BODY>
<div region="west" width="250" title="对象树" autoScroll="true" border="tue" collapsible="true" collapseMode="true">
	<div id="treepanel1" xtype="treepanel" height="100%" autoScroll="true" onEfsClick="doTreeClick()" border="false">
	    <div xtype="loader" id="loader1" url="<%=rootPath%>/getDbobjectJsonTree.action" txtXML="" parentPath="QUERYINFO"></div>
	</div>
</div>
<div region = "center" border="false">
	<div iconCls="icon-panel" region="north" height="210" title="查询条件" border="true" collapsible="true" collapseMode="true">
	 <form class="formAreaTop" id="frmQry1"  method="post">
	  <TABLE>
	      <tr>
	        <td labelFor="forsqltype1">SQL类型</td>
            <td><input type="text" kind="dic" src="DIC_SQL_TYPE" fieldname="SQLTYPE" must="true" id="forsqltype1" code="SELECT" value="查询"></td>
          </tr>
          <tr>
          	<td labelFor="forsql1">更新语句</td>
          	<td><textarea class="Edit" kind="text" style="height:50px;width:600px" fieldname="SQL" datatype="0" id="forsql1"></textarea></td>
          </tr>
          <tr>
	        <td labelFor="forobjectname1">对象名称</td>
            <td><input type="text" kind="text" fieldname="OBJECT_NAME" id="forobjectname1"></td>
	      </tr>
	      <tr>
	        <td labelFor="forwhere1">where条件</td>
          	<td><input type="text" class="Edit" kind="text" style="width:600px" fieldname="WHERE" datatype="0" id="forwhere1"></td>
	      </tr>
	      <tr>
	        <td labelFor="fororder1">order条件</td>
          	<td><input type="text" class="Edit" kind="text" style="width:600px" fieldname="ORDER" datatype="0" id="fororder1"></td>
	      </tr>
	      <tr>
	      	<td><input iconCls="icon-qry" type="button" value="执行" onEfsClick="doQry1()"></td>
	      </tr>
	    </TABLE>
	  </form>
	</div>
	
	<div id="grid1" region="center" xtype="grid" pagingBar="true" pageSize="20" buttonAlign="center">
	<div id="list1" xtype="store" url="<%=rootPath%>/gzcx_getDbobjectList.action" baseParams="{txtXML:g_XML}" autoLoad="false">
		<div xtype="xmlreader" record="ROW" totalRecords="QUERYINFO@records">
		</div>
	</div>
	<div xtype="colmodel">
		<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1" menuDisabled="true" dataIndex="" hidden="true"></div>
	</div>
	</div>
</div>
</BODY>
<div style="display:none">
<xml id="gridData">
</xml>
<xml id="DIC_SQL_TYPE">
</xml>
<FORM id="frmPost" name="frmPost" url="" method="post" style="display:none;" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
    <input id="dwbm1" type="hidden" kind="text" fieldname="T_SALARY_DETAIL/DWBM"  operation="in" state="5" datatype="0">
    <input id="tpl1" type="hidden" kind="text" fieldname="T_SALARY_DETAIL/TPL" operation="2" writeevent="0"state="5" datatype="0">
    <input id="year1" type="hidden" kind="text" fieldname="T_SALARY_DETAIL/YEAR" state="5" datatype="0">
    <input id="month1" type="hidden" kind="text" fieldname="T_SALARY_DETAIL/MONTH" state="5" datatype="0">
</FORM>
</div>
</HTML>

