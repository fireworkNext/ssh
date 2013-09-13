<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   wageuser.jsp
'** 实现功能：   工资用户管理
'** 设计人员：   gwd
'** 设计日期：   2011-06-03
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/gzcx";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<head>
<base href="<%=webRoot%>">
<title>工资用户管理</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>

<SCRIPT language="JavaScript">
var g_XML = Efs.Common.getQryXml();
var sSfzhm = "";

function doQry1()
{
	var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry1"));
	//alert(strXml);
	Efs.getDom("list1").txtXML = strXml;
	Efs.getExt("grid1").store.reload();
}

function onEditEx1()
{
	Efs.getDom("mesg1").setAttribute("value",sMesg);
	Efs.getDom("type1").setAttribute("value","1");
	Efs.getDom("sfzhm1").setAttribute("value",sSfzhm);
	Efs.getDom("year1").setAttribute("value",sYear);
	Efs.getDom("month1").setAttribute("value",sMonth);
	Efs.getDom("wage1").setAttribute("value","1");
	with(Efs.getExt("win1"))
	{
		setTitle("修改相关费用说明");
		show();
	}
}


function doGridClick1(data){
	sSfzhm = data["SFZHM"]
	          	            
	if(sSfzhm != ""){
		Efs.getExt("cmdEdit1").enable();
	}
}

function onPasswdEx()
{
	Efs.getDom("frmPost").setAttribute("action","<%=rootPath%>/gzcx_initPasswd.action");
	var sTmpXml = "<DATAINFO><T_WAGE_USER writeevent='0' operation='1'><SFZHM datatype='0' state='5'>" + sSfzhm + "</SFZHM><PASSWD datatype='0' state='0'>88888888</PASSWD></T_WAGE_USER></DATAINFO>";
	Efs.getDom("txtOpXml").setAttribute("value",sTmpXml);
	Efs.getExt("frmPost").submit();
}

// 获取异步提交的返回监听函数
function frmPostSubBack1(bln,from,action)
{
  if(bln)
  {
      alert("密码初始化成功,请通知用户重新登录！");
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

function cb(succ,response,options){
	alert(response.responseText);
}
</SCRIPT>
</HEAD>
<BODY>

<div region="center" buttonAlign="center" xtype="panel" region="center" border="false" title="用户管理">
	<div xtype="panel" region="north" height="80" iconCls="icon-add" title="查询条件" border="false" buttonAlign="center" autoScroll="true">
	  <form id="frmQry1" method="post" >
	      <TABLE class="formAreaTop">
	        <tr>
	          <td labelFor="forsfzhm1">身份证号</td>
	          <td><input type="text" kind="text" fieldname="SFZHM" id="forsfzhm1"></td>
	          <td labelFor="forname1">姓名</td>
	          <td><input type="text" kind="text" fieldname="NAME" id="forname1" operation="like" hint="模糊查询"></td>
	          <td>&nbsp;</td>
	        </tr>
	        <tr>
	          <td labelFor="fordwmc1">单位</td>
	          <td><input type="text" kind="text" fieldname="DWMC" operation="like" hint="模糊查询" id="fordwmc1"></td>
	          <td labelFor="forbmmc1">部门</td>
	          <td><input type="text" kind="text" fieldname="BMMC" operation="like" hint="模糊查询" id="forbmmc1"></td>
        	  <td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry1()"></td>
	        </tr>
	      </TABLE>
	  </form>
	</div>
	<div iconCls="icon-panel" id="grid1" region="center" xtype="grid" title="" pagingBar="true" pageSize="20" onEfsRowClick="doGridClick1()" onEfsRowDblClick="" buttonAlign="center">
	  <div xtype="tbar">
	    <span style="font-size:9pt;font-weight:bold;color:#15428B;">用户列表</span>
	    <div text="->"></div>
	    <div iconCls="icon-edit" id="cmdEdit1" text="初始化密码#E" onEfsClick="onPasswdEx()" disabled="disabled"></div>
	  </div>
		<div id="list1" xtype="store" url="<%=rootPath%>/gzcx_getWageUserList.action" baseParams="{txtXML:g_XML}" autoLoad="false">
			<div xtype="xmlreader" fieldid="SFZHM" tabName="T_WAGE_USER" record="ROW" totalRecords="QUERYINFO@records">
				<div name="DWMC"></div>
				<div name="BMMC"></div>
				<div name="SFZHM"></div>
				<div name="NAME"></div>
				<div name="MESG"></div>
				<div name="LST_LOG_DT"></div>
				<div name="LST_LOG_TM"></div>
			</div>
		</div>
		<div xtype="colmodel">
			<div header="单位名称" width="100" sortable="true" dataIndex="DWMC" align="center"></div>
			<div header="部门名称" width="100" sortable="true" dataIndex="BMMC" align="center"></div>
			<div header="身份证号码" width="120" sortable="true" dataIndex="SFZHM" align="center"></div>
			<div header="姓名" width="100" sortable="true" dataIndex="NAME" align="center"></div>
			<div header="上次登录日期" width="100" sortable="true" dataIndex="LST_LOG_DT" align="center"></div>
			<div header="上次登录时间" width="100" sortable="true" dataIndex="LST_LOG_TM" align="center"></div>
		</div>
	</div>
</div>
<div style="display:none;">
	<FORM id="frmPost" name="frmPost" url="" action="" method="post" onEfsSuccess="frmPostSubBack1(true)" onEfsFailure="frmPostSubBack1(false)">
		<INPUT type="hidden" id="txtOpXml" name="txtOpXml">
	</FORM>
</div>
</BODY>
</HTML>

