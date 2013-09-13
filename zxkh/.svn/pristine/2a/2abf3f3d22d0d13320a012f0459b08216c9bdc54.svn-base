<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import = "org.ptbank.db.*,org.ptbank.func.*,org.ptbank.cache.*,org.ptbank.bo.*,com.alibaba.fastjson.JSON" %>
<%!
/**
'*******************************
'** 程序名称：  salarylist.jsp
'** 实现功能：  薪酬数据查询
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
String sNodeAry = GzcxBO.getDbfld("wagedetailtpl",userSession);
String sHeaderAry = GzcxBO.getFldname("wagedetailtpl",userSession);
String sColmWidAry = GzcxBO.getFldwidth("wagedetailtpl",userSession);
ArrayList al5 = GzcxBO.getNoShowDbfld("wagedetailtpl", userSession);

//String sNodeAry = JSON.toJSONString(al1);
//String sHeaderAry = JSON.toJSONString(al2);
//String sColmWidAry = JSON.toJSONString(al3);
String sNoShowAry = JSON.toJSONString(al5);
//System.out.println(sNodeAry);
//System.out.println(sHeaderAry);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<head>
<base href="<%=webRoot%>">
<title>薪酬数据查询</title>
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
var noShowAry = <%=sNoShowAry%>;

Efs.onReady(function(){
	doLoadDic("DIC_GZCX_TPL");
	//按当前模版信息初始化grid
	var nodeAry=<%=sNodeAry%>;
	var headerAry=<%=sHeaderAry%>;
	var colmWidAry=<%=sColmWidAry%>;
	createGrid(nodeAry,headerAry,colmWidAry);
	unitTree1 = new Ext.ux.ComboBoxCheckTree({
		renderTo : 'unitTree1',
		width : 160,
		height : 300,
		autoScroll:true,
		tree : {
			xtype:'treepanel',
			height:300,
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
      	strColum_Cfg[i+1] = {id: nodeAry[i], header: headerAry[i], width: colmWidAry[i], dataIndex: nodeAry[i], sortable: false};
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

function onExcelEx(){
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
		Efs.Common.ajax("<%=rootPath%>/gzcx_expSalaryData.action",Efs.Common.getQryXml(Efs.getExt("frmQry1")),function(succ,response,options){
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
}

function onExcelEx1(){
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
		Efs.Common.ajax("<%=rootPath%>/gzcx_expSalaryDataExcel.action",Efs.Common.getQryXml(Efs.getExt("frmQry1")),function(succ,response,options){
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
		//通过ajax调用动态返回创建grid所需的信息
		Efs.Common.ajax("<%=rootPath%>/gzcx_getCreateGridJsonAll.action?tpl="+Efs.getDom("fortpl1").getAttribute("code"),"",function(succ,response,options){
	    if(succ)    // 是否成功
	    {
	     	var returnJson = eval("(" + response.responseText + ")");
	     	initGrid(returnJson);
	     	var sTpl = Efs.getDom("fortpl1").getAttribute("code");
	     	if(sTpl.indexOf("tot")==-1){
	     		Efs.getDom("fortpldetail1").setAttribute("value","");
				Efs.getDom("list1").setAttribute("url","<%=rootPath%>/gzcx_getSalaryList.action");
	     	}else{
	     		if(sTpl=="salarytottpl"){
	     			Efs.getDom("fortpldetail1").setAttribute("value","wagedetailtpl");
	     		}else{
	     			Efs.getDom("fortpldetail1").setAttribute("value",sTpl.replace(/tot/g,"detail"));
	     		}
	     		Efs.getDom("list1").setAttribute("url","<%=rootPath%>/gzcx_getTotalAll.action");
	     	}
	     	var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry1"));
		   	Efs.getDom("list1").setAttribute("txtXML", strXml);
		   	Efs.getExt("grid1").getStore().reload();
		}
	    else
	    {
	    	alert("返回数据失败!");
	    	return false;
	    }
	    });
	}
}

function onDelEx(){
	if(!confirm("确定要删除吗？"))
		return false;
	if(Efs.getExt("frmQry1").isValid()){
		if(Efs.getDom("formonth1").getAttribute("value")=="" || Efs.getDom("formonth1").getAttribute("value")==undefined)
		{
			alert("月份不能为空！");
			Efs.getExt("formonth1").focus(true,true);
			return false;
		}
		if(unitTree1.getValue()!=""){
			sDwbmTree ="('";
			var sTmp = unitTree1.getValue();
			var arr=sTmp.split(",");
			for(var i=0;i<arr.length;i++){
				sDwbmTree=sDwbmTree+arr[i]+"','";
			}
			sDwbmTree=sDwbmTree.substr(0,sDwbmTree.length-2)+")";
			Efs.getDom("dwbm1").setAttribute("value",sDwbmTree);
		}else{
			sDwbmTree = "('"+"<%=userSession.getUnitID()%>"+"')";
			Efs.getDom("dwbm1").setAttribute("value",sDwbmTree);
		}
		Efs.getDom("tpl1").setAttribute("value",Efs.getDom("fortpl1").getAttribute("code"));
		Efs.getDom("year1").setAttribute("value",Efs.getExt("foryear1").getValue());
		Efs.getDom("month1").setAttribute("value",Efs.getExt("formonth1").getValue());
		Efs.getDom("frmPost").setAttribute("url", "<%=rootPath%>/gzcx_delImpData.action");
	   	Efs.getExt("frmPost").submit();
	}
}
	
// 获取异步提交的返回监听函数
function frmPostSubBack(bln,from,action)
{
	if(bln)
	{
		alert("数据删除成功！");
		doQry1();
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

<div xtype="panel" region="north" height="80" iconCls="icon-add" title="薪酬数据查询" border="false" buttonAlign="center" autoScroll="true">
  <form id="frmQry1" url="" method="post" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
      <TABLE class="formAreaTop" >
        <tr>
          <td labelFor="fordwmc1">单位</td>
          <td><div id="unitTree1"></div></td>
          <td labelFor="fortpl1">薪酬类型</td>
          <td><input type="text" kind="dic" src="#DIC_GZCX_TPL" fieldname="TPL" must="true" id="fortpl1"></td>
          <td labelFor="foryear1">年度</td>
          <td><input type="text" kind="int" fieldname="YEAR" must="true" id="foryear1"></td>
          <td labelFor="formonth1">月份</td>
          <td><input type="text" kind="int" range="[1,20]" fieldname="MONTH" id="formonth1"></td>
        </tr>
        <tr>
          <td labelFor="forsfzhm1">身份证号</td>
          <td><input type="text" kind="text" fieldname="SFZHM" id="forsfzhm1"></td>
          <td labelFor="forname1">姓名</td>
          <td><input type="text" kind="text" fieldname="NAME" operation="like" hint="模糊查询" id="forname1"></td>
       	  <td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry1()"></td>
       	  <td><input iconCls="icon-excel" type="button" value="导出数据wps" onEfsClick="onExcelEx()"></td>
       	  <td><input iconCls="icon-excel" type="button" value="导出数据excel" onEfsClick="onExcelEx1()"></td>
       	  <td><input iconCls="icon-del" type="button" value="按月删除导入数据" onEfsClick="onDelEx()"></td>
        </tr>
      </TABLE>
      <input type="hidden" kind="text" fieldname="DWBM" must="true" operation="in" id="fordwbm1">
      <input type="hidden" kind="text" fieldname="TPLDETAIL" must="true" id="fortpldetail1">
  </form>
</div>

<div id="grid1" region="center" xtype="grid" pagingBar="true" pageSize="20" buttonAlign="center">
	<div id="list1" xtype="store" url="<%=rootPath%>/gzcx_getSalaryList.action" baseParams="{txtXML:g_XML}" autoLoad="false">
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
</BODY>
<div style="display:none">
<xml id="gridData">
</xml>
<xml id="DIC_GZCX_TPL">
</xml>
<FORM id="frmPost" name="frmPost" url="" method="post" style="display:none;" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
    <input id="dwbm1" type="hidden" kind="text" fieldname="T_SALARY_DETAIL/DWBM"  operation="in" state="5" datatype="0">
    <input id="tpl1" type="hidden" kind="text" fieldname="T_SALARY_DETAIL/TPL" operation="2" writeevent="0"state="5" datatype="0">
    <input id="year1" type="hidden" kind="text" fieldname="T_SALARY_DETAIL/YEAR" state="5" datatype="0">
    <input id="month1" type="hidden" kind="text" fieldname="T_SALARY_DETAIL/MONTH" state="5" datatype="0">
</FORM>
</div>
</HTML>

