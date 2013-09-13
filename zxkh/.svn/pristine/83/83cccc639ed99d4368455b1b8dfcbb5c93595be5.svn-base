<%@ page language="java" import="org.ptbank.cache.*" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp"%>
<%!
/**
	 '*******************************
	 '** 程序名称：   JyxAdd.jsp
	 '** 实现功能：   简易险销售新增
	 '** 设计人员：   杨一心
	 '** 设计日期：   2013-04-18
	 '*******************************
*/
%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.DecimalFormat" %>
<%@ page import = "java.net.URL"%>
<%@ page language="java" import = "java.sql.*" %>
<%@ page import = "java.io.*"%>
<%@ page import = "org.ptbank.db.*,org.ptbank.func.*,org.ptbank.bo.*,org.ptbank.cache.*,com.alibaba.fastjson.JSON"%>
<%
UserLogonInfo userSession = (UserLogonInfo)request.getSession().getAttribute("user");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<head>
<base href="<%=webRoot%>">
<title>简易险销售新增</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>

<SCRIPT language="JavaScript">
var sXsid = "" ;
var sName = "" ;
Efs.onReady(
  function(){	
      doQry();  
  }
);

function doQry()
{
    Efs.getDom("xsStore").txtXML =Efs.Common.getQryXml(Efs.getExt("xsGrid"));
    //alert(Efs.getDom("xsStore").txtXML);
    Efs.getExt("xsGrid").store.load();
}

//单击
function doGridClick(data)
{
  sXsid = data["XSID"];
  sName	= data["NAME"];
  Efs.getExt("cmdEdit").enable();
  Efs.getExt("cmdDel").enable();
}

//跳出一个窗口查看XML的函数
function seeXML(sXML)
{
  var w = window.open("");
  w.document.write("<xmp>" + sXML + "</xmp>");
}

//销售新增
function doadd()
{
  if(!Efs.getExt("frmjyxadd").isValid())
    return false;
  
  var opObj = Efs.Common.getOpXml(Efs.getExt("frmjyxadd"),true);
  //seeXML(opObj.xml);
  Efs.getExt("frmjyxadd").submit(opObj.xml);
}


//返回监听
function frmPostSubBack(bln,from,action)
{
  if(bln)
  {
  Efs.getExt("frmjyxadd").reset();
  Efs.getExt("xsGrid").store.reload(); 
  //alert("成功"); 
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

//返回监听1
function frmPostSubBack1(bln,from,action)
{
  if(bln)
  {
  Efs.getExt("frmjyxmx").reset();
  Efs.getExt("jyxmxWin").hide();
  Efs.getExt("xsGrid").store.reload(); 
  //alert("修改成功"); 
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
//查询出销售记录，待修改
function seejyx()
{
  if(sXsid != "")
  {
	 Efs.getExt("jyxmxWin").show();
	 Efs.getExt("frmjyxmx").reset();
     Efs.Common.ajax("<%=rootPath%>/jyx_seeJyx.action",sXsid,function(succ,response,options){
       if(succ)    // 是否成功
       { 
         var xmlReturnDoc = response.responseXML;
        
         Efs.Common.setEditValue(xmlReturnDoc.xml,Efs.getExt("frmjyxmx"), "QUERYINFO");
        }
       else
       {
        alert("加载数据失败!");
       }
      });
   }
 else
  {
    alert("请选择一条销售记录");
  }
}

//销售记录修改
function editjyx()
{
      if(!Efs.getExt("frmjyxmx").isValid())
	    return false;
	  var opObj = Efs.Common.getOpXml(Efs.getExt("frmjyxmx"),true);
	  //seeXML(opObj.xml);
	  Efs.getDom("frmjyxmx").url = "<%=rootPath%>/jyx_editJyx.action";
	  Efs.getExt("frmjyxmx").submit(opObj.xml);
	
}

//销售删除
function del()
{
	  Ext.Msg.confirm('提示',"是否删除客户为： "+sName+" ，销售ID为："+sXsid+" 的记录",function(btn,text){
	  	if (btn == 'yes')
	  	{
		  Efs.getDom("frmjyxadd").url = "<%=rootPath%>/jyx_delJyx.action";
		  Efs.getExt("frmjyxadd").submit(sXsid);
		}
		});
}




</SCRIPT>
</head>
<body>
	<div iconCls="icon-panel" region="north" height="200" title="简易险销售新增" border="false" buttonAlign="center" autoScroll="true">
	<form id="frmjyxadd" method="post" url="<%=rootPath%>/jyx_JyxAdd.action" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
		<TABLE class="formAreaTop" width="100%" height="100%" cellpadding="10" cellspacing="10">
			<tr>
				<TD colspan="8" align="center"  style="font-size: 14px; background-color: #00DF55; font-family: '黑体'; color: #FFFFFF;">简易险销售详情</TD>
			</tr>
			<tr>
				<TD>险  种</TD>
				<TD align="left"><INPUT type="text" class="Edit" kind="dic" src="DIC_XZ" must="true" fieldname="T_JYX/XZ"></TD>
				<TD>份  数</TD>
	            <TD align="left"><INPUT type="text" kind="int" maxlength="1" id="fsid" class="Edit"  must="true"  fieldname="T_JYX/FS"></TD>
	            <TD>金  额</TD>
	            <TD align="left"><INPUT type="text" kind="int"  id="jeid" class="Edit"  must="true"  fieldname="T_JYX/JE"></TD>
			</tr>
			<tr>
	            <TD>客户姓名</TD>
	            <TD align="left"><INPUT type="text" class="Edit"  must="true"  fieldname="T_JYX/NAME"></TD>
	            <TD>电  话</TD>
	            <TD align="left"><INPUT type="text" kind="int" class="Edit" maxlength="20" must="true"  fieldname="T_JYX/DH"></TD>
	           	<TD>身份证</TD>
	            <TD align="left"><INPUT type="text" class="Edit" must="true"  maxlength="18" fieldname="T_JYX/SFZ"></TD>
	         </tr>
			 <tr>
			 	<TD>家庭住址</TD>
	            <TD colspan="6" align="left"><INPUT type="text" maxlength="60" style="width:500" class="Edit"  must="true"  fieldname="T_JYX/JTZZ"></TD>
	         </tr>
			 <tr>
				<TD>备  注</TD>
	            <TD colspan="4" align="left"><INPUT type="text" maxlength="60" style="width:500" class="Edit"  fieldname="T_JYX/BZ"></TD>
			 	<TD><INPUT iconCls="icon-add" type="button" value="销售新增" onEfsClick="doadd()"></TD>
			 </tr>
			 <input type="hidden" kind="text" fieldname="T_JYX/GZRNAME" operation="0">
			 <input type="hidden" kind="text" fieldname="T_JYX/GZR" operation="0">
			 <input type="hidden" kind="text" fieldname="T_JYX/UNITID" operation="0">
			 <input type="hidden" kind="text" fieldname="T_JYX/UNITNAME" operation="0">
			 <input type="hidden" kind="text" fieldname="T_JYX/TBSJ" datatype="3" operation="0">
			 <input type="hidden" kind="text" fieldname="T_JYX/XSID" operation="0">
		</TABLE>
	</form>
	</div>
	
	<div id="xsGrid" region="center" border="flase" xtype="grid" iconCls="icon-panel"  pagingBar="true" pageSize="20" onEfsRowClick="doGridClick()" onEfsRowDblClick="seejyx()">
	   	<div xtype="tbar">
	   		<span style="font-size: 9pt; font-weight: bold; color: #15428B;">一周内已销售明细</span>
		  	<div text="->"></div>
		    <div iconCls="icon-edit" id="cmdEdit" text="销售记录修改" disabled onEfsClick="seejyx()"></div>
	  		<div iconCls="icon-del" id="cmdDel" text="销售记录删除" disabled onEfsClick="del()"></div>
	    </div>
	   <div id="xsStore" xtype="store" url="<%=rootPath%>/jyx_getJyxList.action" txtXML="" autoLoad="false">
			<div xtype="xmlreader" fieldid="XSID" record="ROW" tabName="T_JYX">
				<div name="GZR"></div>
				<div name="XSID"></div>
				<div name="XZ"></div>
				<div name="FS"></div>
				<div name="JE"></div>
				<div name="NAME"></div>
				<div name="DH"></div>
				<div name="SFZ"></div>
				<div name="GZRNAME"></div>
				<div name="UNITNAME"></div>
				<div name="TBSJ"></div>
				<div name="JTZZ"></div>
				<div name="BZ"></div>
			</div>
		</div>
		<div xtype="colmodel">
			<!-- <div type="radio"></div> -->
			<div header="销售ID" width="80" sortable="true"  align="center" dataIndex="XSID"></div>
			<div header="险  种" width="120" sortable="true"  align="center" dataIndex="XZ" kind="dic" src="DIC_XZ" align="center"></div>
			<div header="份  数" width="120" sortable="true" align="center" dataIndex="FS"></div>
			<div header="金  额" width="120" sortable="true" align="center" dataIndex="JE"></div>
			<div header="客户姓名" width="120" sortable="true"  align="center" dataIndex="NAME"></div>
			<div header="电    话" width="120" sortable="true" align="center" dataIndex="DH"></div>
			<div header="身份证" width="120" sortable="true" align="center" dataIndex="SFZ"></div>
			<div header="销售人" width="120" sortable="true" align="center" dataIndex="GZRNAME"></div>
			<div header="单  位" width="120" sortable="true" align="center" dataIndex="UNITNAME"></div>
			<div header="时  间" width="120" sortable="true" align="center"	dataIndex="TBSJ"></div>
			<div header="客户地址" width="120" sortable="true" align="center" dataIndex="JTZZ"></div>
			<div header="备  注" width="120" sortable="true" align="center" dataIndex="BZ"></div>
		</div>
	</div>

<!-- window1开始 -->
	<div iconCls="icon-panel" id="jyxmxWin" xtype="window" width="820" height="200" title="简易险销售修改" resizable="false" modal="true">
	   <form id="frmjyxmx" class="efs-box" method="post" url="" onEfsSuccess="frmPostSubBack1(true)" onEfsFailure="frmPostSubBack(false)">
		<TABLE class="formArea" align="center">
			<tr>
				<TD colspan="8" align="center"  style="font-size: 14px; background-color: #00DF55; font-family: '黑体'; color: #FFFFFF;">简易险销售详情</TD>
			</tr>
			<tr>
				<TD>险  种</TD>
				<TD align="left"><INPUT type="text" class="Edit" kind="dic" src="DIC_XZ" must="true" fieldname="T_JYX/XZ"></TD>
				<TD>份  数</TD>
	            <TD align="left"><INPUT type="text" kind="int" maxlength="1" class="Edit"  must="true"  fieldname="T_JYX/FS"></TD>
	            <TD>金  额</TD>
	            <TD align="left"><INPUT type="text" kind="int" class="Edit"  must="true"  fieldname="T_JYX/JE"></TD>
			</tr>
			<tr>
	            <TD>客户姓名</TD>
	            <TD align="left"><INPUT type="text" class="Edit"  must="true"  fieldname="T_JYX/NAME"></TD>
	            <TD>电  话</TD>
	            <TD align="left"><INPUT type="text" kind="int" class="Edit" maxlength="20" must="true"  fieldname="T_JYX/DH"></TD>
	           	<TD>身份证</TD>
	            <TD align="left"><INPUT type="text" class="Edit" must="true"  maxlength="18" fieldname="T_JYX/SFZ"></TD>
	         </tr>
			 <tr>
			 	<TD>家庭住址</TD>
	            <TD colspan="6" align="left"><INPUT type="text" maxlength="60" style="width:500" class="Edit"  must="true"  fieldname="T_JYX/JTZZ"></TD>
	         </tr>
			 <tr>
				<TD>备  注</TD>
	            <TD colspan="4" align="left"><INPUT type="text" maxlength="60" style="width:500" class="Edit"  fieldname="T_JYX/BZ"></TD>
			 	<TD><INPUT iconCls="icon-edit" type="button" value="确认修改" onEfsClick="editjyx()"></TD>
			 </tr>
			 <input type="hidden" kind="text" fieldname="T_JYX/XSID" datatype="0" state="5" operation="1" writeevent="0">
		</TABLE>
	</form>
 </div>
<!-- window1结束 -->

<!--动态组成字典列表例子  -->
<div style="display:none">
	<xml id="dynaDicXml1">
	</xml>
	<form id="frm" method="post" url="" >
		<input type="text" id="XSID1" fieldname="XSID"/>
	</form>
</div>
</body>
</html>
