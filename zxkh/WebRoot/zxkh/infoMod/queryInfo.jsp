<%@ page language="java" import="org.ptbank.cache.*" pageEncoding="UTF-8"%>
<%@ include file="../../inc/head.inc.jsp"%>
<%!
/**
	 '*******************************
	 '** 程序名称：   queryInfo.jsp
	 '** 实现功能：   高端客户信息查询(带权限)
	 '** 设计人员：   蔡剑成
	 '** 设计日期：   2013-09-10
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
<title>高端客户信息查询</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>

<SCRIPT language="JavaScript">

//定义一个全局变量
var skhid = "";
Efs.onReady(
  		function(){
  			doLoadDynaDic();
  		});
  		
//根据用户名返回单位字典
function doLoadDynaDic() {
    var sUserTitle= "<%=userSession.getUserTitle()%>";
    Efs.Common.ajax("<%=rootPath%>/jyx_getUnit1.action",sUserTitle,function(succ,response,options){
       if(succ)    // 是否成功
       { 
           var xmlReturnDoc = response.responseXML;
           Efs.getDom("dynaDicXml").loadXML(xmlReturnDoc.xml);
       }
       else
       {
        alert("加载数据失败!");
       }
      }); 
}

function doQry()
{
	if(!Efs.getExt("frmQry").isValid()){
		alert("请选择条件后再进行查询!");
    	return false;
	}
	Efs.getDom("xsStore").txtXML = Efs.Common.getQryXml(Efs.getExt("frmQry"));
	Efs.getDom("xsStore").url="<%=rootPath%>/zxkh_roleGetGdkhList.action";
    Efs.getExt("xsGrid").store.reload();
}
//grid单击事件
function doGridClick(data){
	  skhid = data["KHID"];
	  Efs.getExt("ckJtqk").enable();
	  Efs.getExt("ckZcjg").enable();
	  Efs.getExt("ckCjjl").enable();
}
</SCRIPT>
</head>
<body>
	<div iconCls="icon-panel" region="north" height="103" title="高端客户查询" border="false" buttonAlign="center" autoScroll="true">
	<form id="frmQry" method="post" url="" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
		<TABLE class="formAreaTop" cellpadding="10" cellspacing="10">
	      <tr>
	        <td>起始时间</td>
	        <td><input type="text"  must=true class="Edit" kind="date" fieldname="TO_CHAR(JDSJ,'YYYYMMDD')" operation="&gt;="></td>
	        <td>结束时间</td>
	        <td><input type="text" must=true class="Edit" kind="date" fieldname="TO_CHAR(JDSJ,'YYYYMMDD')" operation="&lt;="></td>
	      </tr>
	      <tr>
	        <td>客户姓名</td>
	        <td><input type="text" kind="text" fieldname="XM" operation="like"></td>
	        <td>客户电话</td>
	        <td><input type="text" kind="text" fieldname="LXDH" operation="like"></td>
	        <td>身份证号码</td>
	        <td><input type="text" kind="text" fieldname="SFZHM" operation="like"></td>
	        <td>所属网点</td>
	        <TD><INPUT type="text" class="Edit" kind="dic" src="#dynaDicXml" fieldname="UNITID"></TD>
    	    <td><input iconCls="icon-qry" type="button" value="查  询" onEfsClick="doQry()"></td>
	      </tr>
		</TABLE>
	</form>
	</div>
	
	<div id="xsGrid" region="center" border="flase" xtype="grid" iconCls="icon-panel" onEfsRowClick="doGridClick() pagingBar="true" pageSize="20">
	   <div xtype="tbar">
		  <span class="Title">高端客户资料列表</span>
		  <div text="->"></div>
		  <div iconCls="icon-add" id="ckJbxx" text="查看客户基本信息#E" onEfsClick="onCkJbxx()" disabled="disabled"></div>
		  <div iconCls="icon-add" id="ckJtqk" text="查看客户家庭情况#E" onEfsClick="onCkJtqk()" disabled="disabled"></div>
		  <div iconCls="icon-add" id="ckZcjg" text="查看客户资产结构#E" onEfsClick="onCkZcjg()" disabled="disabled"></div>
		  <div iconCls="icon-add" id="ckCjjl" text="查看客户成交记录#E" onEfsClick="onCkCjjl()" disabled="disabled"></div>
	   </div>
	   <div id="xsStore" xtype="store" txtXML="" autoLoad="false">
			<div xtype="xmlreader" fieldid="KHID" record="ROW" tabName="T_GDKHXXB">
					<div name="KHID"></div>
					<div name="XM"></div>
					<div name="XB"></div>
					<div name="CSNY"></div>
					<div name="SFZHM"></div>
					<div name="LXDH"></div>
					<div name="ZY"></div>
					<div name="ZW"></div>
					<div name="YSR"></div>
					<div name="SXCP"></div>
					<div name="GRPH"></div>
					<div name="XJZD"></div>
			</div>
		</div>
		<div xtype="colmodel">
			<div header="客户姓名" width="80" sortable="true"  align="center" dataIndex="XM"></div>
			<div header="性 别" width="120" sortable="true"  align="center" dataIndex="XB"  align="center"></div>
			<div header="出生年月" width="120" sortable="true" align="center" dataIndex="CSNY"></div>
			<div header="身份证号码" width="120" sortable="true" align="center" dataIndex="SFZHM"></div>
			<div header="联系电话" width="120" sortable="true"  align="center" dataIndex="LXDH"></div>
			<div header="职业" width="120" sortable="true" align="center" dataIndex="ZY"></div>
			<div header="职务" width="120" sortable="true" align="center" dataIndex="ZW"></div>
			<div header="月收入" width="120" sortable="true" align="center" dataIndex="YSR"></div>
			<div header="适销产品" width="120" sortable="true" align="center" dataIndex="SXCP"></div>
			<div header="个人偏好" width="120" sortable="true" align="center"	dataIndex="GRPH"></div>
			<div header="现居住地" width="300" sortable="true" align="center" dataIndex="XJZD"></div>
		</div>
	</div>
</body>
</html>

