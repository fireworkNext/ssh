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
// 班级空查询条件
var g_XML = Efs.Common.getQryXml();

// 当前选中的班级ID
var sClassesID = "";
// 班级数据是否加载标志
var isLoaded_CS = false;
// 学生数据是否加载标志
var isLoaded_PS = false;

// 班级查询
function doQry()
{
  var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry"));
  Efs.getDom("csList").txtXML = strXml;
  Efs.getExt("csGrid").store.load();
}

// 学生查询
function doQry2()
{
  if(!sClassesID){
  	return ;
  }
  Ext.getDom("qClassesID").value = sClassesID;
  var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry2"));
  Efs.getDom("psnList").txtXML = strXml;
  Efs.getExt("psnGrid").store.load();
}

// 班级数据加载事件监听
function onCSLoad(){
	var selmod = Efs.getExt("csGrid").getSelectionModel();
	if(!isLoaded_CS){
		selmod.on("rowselect",onCSRowselect);
	}
	selmod.selectFirstRow();
	isLoaded_CS = true;
}

// 班级列表选择事件监听，由onCSLoad方法注册
function onCSRowselect(selmod){
	var record = selmod.getSelected();
	if(record){
		sClassesID = record.data.CID;
		var xml =  "<EFSFRAME><QUERYCONDITION><PREDICATE></PREDICATE><CONDITIONS><TYPE>and</TYPE><CONDITION alias='' datatype='0'><FIELDNAME sv=''>r.CID</FIELDNAME><OPERATION>=</OPERATION><VALUE>" + sClassesID + "</VALUE></CONDITION></CONDITIONS></QUERYCONDITION></EFSFRAME>";
		Ext.getDom("psnList").txtXML= xml;
		Efs.getExt("psnGrid").store.load();
	}
}

// 学生数据加载事件监听
function onPsnLoad(store,records){
	var selmod = Efs.getExt("psnGrid").getSelectionModel();
	for(var i=0;i<records.length;i++){
		var cid = records[i].data.CID;
		if(cid && cid == sClassesID){
			selmod.selectRow(i,true);
		}
	}
	
	if(!isLoaded_PS){
		selmod.on("rowselect",onPsnRowselect);
		selmod.on("rowdeselect",onPsnRowdeselect);
	}
}

// 学生列表选择事件监听
function onPsnRowselect(selmod,rowIndex,record){
	if(!record.data.CID){
		var xml = "<DATAINFO><CLASSESREF operation='0' writeevent='0'><CID datatype='0' state='0'>" + sClassesID + "</CID><PERSONID datatype='0' state='0'>" + record.data.PERSONID + "</PERSONID></CLASSESREF></DATAINFO>"
		  //参数1：请求地址,参数2：sClassesID将会放在txtXML参数提交 ，参数3：回调函数
	  	Efs.Common.ajax("<%=rootPath%>/base.do?method=dealWithXml",xml);
	  	
	  	record.data.CID = sClassesID;
	}
}

// 学生列表取消选择事件监听
function onPsnRowdeselect(selmod,rowIndex,record){
	if(record.data.CID){
		var xml = "<DATAINFO><CLASSESREF operation='2' writeevent='0'><CID datatype='0' state='5'>" + record.data.CID + "</CID><PERSONID datatype='0' state='5'>" + record.data.PERSONID + "</PERSONID></CLASSESREF></DATAINFO>"
		  //参数1：请求地址,参数2：sClassesID将会放在txtXML参数提交 ，参数3：回调函数
	  	Efs.Common.ajax("<%=rootPath%>/base.do?method=dealWithXml",xml);
	  	
	  	record.data.CID = "";
	}
}


</SCRIPT>
</HEAD>
<BODY>
<div id="csGrid" region="west" width="400" border="false" xtype="grid" iconCls="icon-panel" title="班级列表" pagingBar="true" pageSize="25">
   <div xtype="tbar">
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
	<div id="csList" xtype="store" url="<%=rootPath%>/classes.do?method=list" baseParams="{txtXML:g_XML}" autoLoad="true" onEfsLoad="onCSLoad()">
		<div xtype="xmlreader" fieldid="CID" record="ROW" tabName="CLASSES">
			<div name="CID"></div>
			<div name="CNAME"></div>
			<div name="CMEMO"></div>
		</div>
	</div>
	<div xtype="colmodel">
    	<div header="班级编码" width="80" sortable="true" dataIndex="CID" align="center"></div>
		<div header="班级名称" width="120" sortable="true" dataIndex="CNAME" align="center"></div>
		<div header="备注" width="150" sortable="true" dataIndex="CMEMO" align="center"></div>
	</div>
</div>

<div region="center">
	<div iconCls="icon-panel" region="north" height="60" title="学生列表" border="false">
	 <form id="frmQry2"  method="post">
	  <TABLE class="formAreaTop" width="100%" height="100%" cellpadding="0" cellspacing="0">
	      <tr>
	        <td>&nbsp;</td>
	        <td width="60">姓名</td>
	        <td width="160"><input type="text" class="Edit" kind="text" fieldname="s.NAME" operation="like" maxlength="30" hint="模糊查询"></td>
	        <td width="40">性别</td>
	        <td width="160"><input type="text" class="Edit" kind="dic" src="DIC_SEX" fieldname="s.SEX"></td>
	        <td width="40">籍贯</td>
	        <td width="160"><input type="text" class="Edit" kind="dic" src="DIC_CODE" fieldname="s.PLACECODE"></td>
	        <td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry2()"></td>
	        <td><input id="qClassesID" type="hidden" class="Edit" kind="text" fieldname="r.cid"></td>
	      </tr>
	    </TABLE>
	  </form>
	</div>
	
	<div id="psnGrid" region="center" xtype="grid" pagingBar="true" pageSize="25">
		<div id="psnList" xtype="store" url="<%=rootPath%>/classes.do?method=personList" onEfsLoad="onPsnLoad()">
			<div xtype="xmlreader" fieldid="PERSONID" record="ROW" tabName="PERSON">
				<div name="PERSONID" mapping="PERSONID"></div>
				<div name="NAME" mapping="NAME"></div>
				<div name="IDCARD"></div>
				<div name="SEX"></div>
	      		<div name="PLACECODE"></div>
				<div name="BIRTHDAY"></div>
				<div name="TEL"></div>
				<div name="CID"></div>
			</div>
		</div>
		<div xtype="colmodel">
			<div type="checkbox"></div>
	    	<div header="学生编码" width="80" sortable="true" dataIndex="PERSONID"></div>
			<div header="学生姓名" width="80" sortable="true" dataIndex="NAME"></div>
			<div header="身份证号" width="120" sortable="true" dataIndex="IDCARD" align="center"></div>
			<div header="性别" width="40" sortable="true" dataIndex="SEX" kind="dic" src="DIC_SEX"></div>
	    	<div header="籍贯" width="120" sortable="true" dataIndex="PLACECODE" kind="dic" src="DIC_CODE" align="center"></div>
			<div header="出生日期" width="100" sortable="true" dataIndex="BIRTHDAY" align="center"></div>
			<div header="联系电话" width="100" sortable="true" dataIndex="TEL"></div>
		</div>
	</div>
</div>

</BODY>
</HTML>

