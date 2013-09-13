<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%@ page import = "org.ptbank.db.*,org.ptbank.func.*,org.ptbank.cache.*" %>
<%!
/**
'*******************************
'** 程序名称：   costmaintain.jsp
'** 实现功能：  薪酬备注说明维护
'** 设计人员：   gwd
'** 设计日期：   2012-12-21
'*******************************
*/
%>
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
<title>备注说明维护</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/ComboBoxCheckTree.js"></script>
<script type="text/javascript" src="js/TreeCheckNodeUI.js"></script>

<SCRIPT language="JavaScript">
var g_XML = Efs.Common.getQryXml();
var sTpl = "";
var sSfzhm = "";
var sYear = "";
var sMonth = "";
var sMesg = "";
var sDwbm = "";
var sDwbmTree = "";
var unitTree1;

Efs.onReady(function(){
	doLoadDic("DIC_GZCX_TPL");
	unitTree1 = new Ext.ux.ComboBoxCheckTree({
		renderTo : 'unitTree1',
		width : 160,
		height : 300,
		tree : {
			xtype:'treepanel',
			height:100,
			checkModel: 'cascade',   //cascade selection
			onlyLeafCheckable: false,//all nodes with checkboxes
			animate: true,
			rootVisible: false,
			autoScroll:true,
			loader: new Ext.tree.TreeLoader({dataUrl:'getUnitJsonCheckTree.action',   
            baseAttrs: { uiProvider: Ext.ux.TreeCheckNodeUI } }),
       	 	root : new Ext.tree.AsyncTreeNode({id:'',text:''})
    	},
    	
    	// define which node's value will be submited
    	//all
    	//folder
		//leaf
		selectValueModel:'all'
		
	});
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

function doQry1()
{
	if(Efs.getExt("frmQry1").isValid()){
		if(unitTree1.getValue()!=""){
			sDwbmTree ="('";
			var sTmp = unitTree1.getValue();
			var arr=sTmp.split(",");
			for(var i=0;i<arr.length;i++){
				sDwbmTree=sDwbmTree+arr[i]+"','";
			}
			sDwbmTree=sDwbmTree.substr(0,sDwbmTree.length-2)+")";
			Efs.getDom("fordwbm1").setAttribute("value",sDwbmTree);
		}else{
			sDwbmTree = "('"+"<%=userSession.getUnitID()%>"+"')";
			Efs.getDom("fordwbm1").setAttribute("value",sDwbmTree);
		}
		var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry1"));
		Efs.getDom("list1").setAttribute("txtXML",strXml);
		Efs.getExt("grid1").store.reload();
		Efs.getExt("cmdEditAll1").enable();
	}
}

function onEditEx1()
{
	Efs.getDom("tpl1").setAttribute("value",sTpl);
	Efs.getDom("mesg1").setAttribute("value",sMesg);
	Efs.getDom("type1").setAttribute("value","1");
	Efs.getDom("sfzhm1").setAttribute("value",sSfzhm);
	Efs.getDom("year1").setAttribute("value",sYear);
	Efs.getDom("month1").setAttribute("value",sMonth);
	with(Efs.getExt("win1"))
	{
		setTitle("修改薪酬备注说明");
		show();
	}
}

function onEditAllEx1()
{
	if(unitTree1.getValue()!=""){
		sDwbm ="('";
		var sTmp = unitTree1.getValue();
		var arr=sTmp.split(",");
		for(var i=0;i<arr.length;i++){
			sDwbm=sDwbm+arr[i]+"','";
		}
		sDwbm=sDwbm.substr(0,sDwbm.length-2)+")";
		Efs.getDom("fordwbm1").setAttribute("value",sDwbm);
	}
	Efs.getDom("tpl1").setAttribute("value",sTpl);
	Efs.getDom("mesg1").setAttribute("value",sMesg);
	Efs.getDom("type1").setAttribute("value","2");
	Efs.getDom("sfzhm1").setAttribute("value",sSfzhm);
	Efs.getDom("year1").setAttribute("value",sYear);
	Efs.getDom("month1").setAttribute("value",sMonth);
	with(Efs.getExt("win1"))
	{
		setTitle("修改薪酬备注说明");
		show();
	}
}

function doGridClick1(data){
	sTpl = data["TPL"];
	sSfzhm = data["SFZHM"];
	sYear = data["YEAR"];
	sMonth = data["MONTH"];
	sMesg = data["REMARK"];
	sDwbm = data["DWBM"];
	          	            
	if(sSfzhm != ""){
		Efs.getExt("cmdEdit1").enable();
    	//Efs.getExt("cmdEditAll1").enable();
	}
}

function doOk1()
{
	if(Efs.getExt("frmData1").isValid()){
		var strXml = Efs.Common.getOpXml(Efs.getExt("frmData1"));
		//alert(strXml);
		Efs.getExt("frmData1").submit(strXml);
	}
}

function onQry(){
	Efs.getExt("win2").show();
}

// 获取异步提交的返回监听函数
function frmPostSubBack1(bln,from,action)
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
</SCRIPT>
</HEAD>
<BODY>

<div xtype="panel" region="north" height="80" iconCls="icon-add" title="薪酬备注说明维护" border="false" buttonAlign="center" autoScroll="true">
  <form id="frmQry1" method="post" >
      <TABLE class="formAreaTop" >
        <tr>
          <td labelFor="fordwmc1">单位</td>
          <td><div id="unitTree1"></td>
          <td labelFor="fortpl1">薪酬类型</td>
          <td><input type="text" kind="dic" src="#DIC_GZCX_TPL" fieldname="TPL" id="fortpl1"></td>
          <td labelFor="foryear1">年度</td>
          <td><input type="text" kind="text" fieldname="YEAR" must="true" id="foryear1"></td>
          <td labelFor="formonth1">月份</td>
          <td><input type="text" kind="text" fieldname="MONTH" must="true" id="formonth1"></td>
        </tr>
        <tr>
          <td labelFor="forsfzhm1">身份证号</td>
          <td><input type="text" kind="text" fieldname="SFZHM" id="forsfzhm1"></td>
          <td labelFor="forname1">姓名</td>
          <td><input type="text" kind="text" fieldname="NAME" operation="like" hint="模糊查询" id="forname1"></td>
          <td labelFor="formesg1">备注说明</td>
          <td><input type="text" kind="text" fieldname="REMARK" operation="like" hint="模糊查询" id="formesg1"></td>
       	  <td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry1()"></td>
        </tr>
      </TABLE>
      <input type="hidden" kind="text" fieldname="DWBM" must="true" operation="in" id="fordwbm1">
  </form>
</div>

<div iconCls="icon-panel" id="grid1" region="center" xtype="grid" title="" pagingBar="true" pageSize="20" onEfsRowClick="doGridClick1()" onEfsRowDblClick="onEditEx1()" buttonAlign="center">
  <div xtype="tbar">
    <span style="font-size:9pt;font-weight:bold;color:#15428B;">薪酬信息列表</span>
    <div text="->"></div>
    <div iconCls="icon-edit" id="cmdEdit1" text="修改单个#E" onEfsClick="onEditEx1()" disabled="disabled"></div>
    <div iconCls="icon-del" id="cmdEditAll1" text="修改全部#D" onEfsClick="onEditAllEx1()" disabled="disabled"></div>  
  </div>
	<div id="list1" xtype="store" url="<%=rootPath%>/gzcx_getSalaryList.action" baseParams="{txtXML:g_XML}" autoLoad="false">
		<div xtype="xmlreader" fieldid="" tabName="T_SALARY_DETAIL" record="ROW" totalRecords="QUERYINFO@records">
			<div name="DWBM"></div>
			<div name="DWMC"></div>
			<div name="TPL"></div>
			<div name="YEAR"></div>
			<div name="MONTH"></div>
			<div name="BMMC"></div>
			<div name="SFZHM"></div>
			<div name="NAME"></div>
			<div name="REMARK"></div>
			<div name="SEE_DT"></div>
			<div name="SEE_TM"></div>
		</div>
	</div>
	<div xtype="colmodel">
		<div header="单位编码" width="100" sortable="true" dataIndex="DWBM" align="center"></div>
		<div header="单位名称" width="120" sortable="true" dataIndex="DWMC" align="center"></div>
		<div header="薪酬类型" width="100" kind="dic" src="DIC_WAGE_TYPE" sortable="true" dataIndex="TPL" align="center"></div>
		<div header="年度" width="80" sortable="true" dataIndex="YEAR" align="center"></div>
		<div header="月份" width="80" sortable="true" dataIndex="MONTH" align="center"></div>
		<div header="部门名称" width="120" sortable="true" dataIndex="BMMC" align="center"></div>
		<div header="身份证号码" width="140" sortable="true" dataIndex="SFZHM" align="center"></div>
		<div header="姓名" width="120" sortable="true" dataIndex="NAME" align="center"></div>
		<div header="备注说明" width="200" sortable="true" dataIndex="REMARK" align="center"></div>
		<div header="查看日期" width="80" sortable="true" dataIndex="SEE_DT" align="center"></div>
		<div header="查看时间" width="80" sortable="true" dataIndex="SEE_TM" align="center"></div>
	</div>
</div>

<!-- window开始 -->
<div iconCls="icon-panel" id="win1" xtype="window" width="650" height="200" title="修改" resizable="true" modal="true">
  <div region="center" xtype="panel" title="" border="false" autoScroll="true">
    <div xtype="tbar">
      <div text="->"></div>
      <div iconCls="icon-add" id="cmdOk1" text="确  定" onEfsClick="doOk1()"></div>
    </div>
    <form id="frmData1" class="efs-box" method="post" url="<%=rootPath%>/gzcx_updCostMaintain.action" onEfsSuccess="frmPostSubBack1(true)" onEfsFailure="frmPostSubBack1(false)">
    <TABLE>
      <tr>
        <td class="label">备注说明：</td>
        <td><textarea id="mesg1" name="mesg1" class="Edit" style="width:500px;height:80px;" kind="text" maxlength="2000" fieldname="T_WAGE_DETAIL/REMARK" name="mesg" id="mesg"  must="true" operation="1" writeevent="0" state="0" datatype="0"></textarea></td>      
      </tr>
    </TABLE>
    <input type="hidden" id="type1" name="type1" fieldname="T_SALARY_DETAIL/TYPE"/>
    <input type="hidden" id="sfzhm1" name="sfzhm1" fieldname="T_SALARY_DETAIL/SFZHM"/>
    <input type="hidden" id="year1" name="year1" fieldname="T_SALARY_DETAIL/YEAR"/>
    <input type="hidden" id="month1" name="month1" fieldname="T_SALARY_DETAIL/MONTH"/>
    <input type="hidden" id="tpl1" name="tpl1" fieldname="T_SALARY_DETAIL/TPL"/>
    <input type="hidden" id="dwbm1" name="dwbm1" fieldname="T_SALARY_DETAIL/DWBM"/>
    </form>
  </div>
</div>
<div style="display:none">
<xml id="DIC_GZCX_TPL">
</xml>
<xml id="DIC_DBFLD">
</xml>
</div>
</BODY>
</HTML>

