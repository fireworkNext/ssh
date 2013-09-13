<%@ page language="java" import="org.ptbank.cache.*" pageEncoding="UTF-8"%>
<%@ include file="../../inc/head.inc.jsp"%>
<%!
/**
	 '*******************************
	 '** 程序名称：   basicMod.jsp
	 '** 实现功能：   高端客户基本信息修改
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
<title>高端客户基本信息修改</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>

<SCRIPT language="JavaScript">
var skhid = ""; //定义一个全局变量
function onReady(){
}
//查询按钮响应事件
function doQry()
{
	if(!Efs.getExt("frmQry").isValid()){
		alert("请选择条件后再进行查询!");
    	return false;
	}
	Efs.getDom("xsStore").txtXML = Efs.Common.getQryXml(Efs.getExt("frmQry"));
	Efs.getDom("xsStore").url="<%=rootPath%>/zxkh_getGdkhList.action";
    Efs.getExt("xsGrid").store.reload();
}

function doGridClick(data){
	  skhid = data["KHID"];
	  Efs.getExt("jbxxMod").enable();
}

//客户基本信息按钮响应事件,弹出修改窗口
function onJbxxMod()
{
  if(skhid != "")
  {
	 Efs.getExt("frmGdkhMod").reset(); 
	 //清除"理财优化建议"的值
	  document.getElementById("yhjy").value ="";
	 //清除"checkbox"的值
	  var o = document.getElementsByName("checkbox");
		  for (var j=0;j<o.length;j++){
				if (o[j].checked)
					o[j].checked = false;
				}
     Efs.Common.ajax("<%=rootPath%>/zxkh_frmGdkhModQry.action",skhid,function(succ,response,options){
       if(succ)    // 是否成功
       { 
         var xmlReturnDoc = response.responseXML;
	     Efs.Common.setEditValue(xmlReturnDoc.xml,Efs.getExt("frmGdkhMod"), "QUERYINFO");
         var retStr = Efs.Common.getNodeValue(xmlReturnDoc, "//JRCPSYQK");
         var retStr1 = Efs.Common.getNodeValue(xmlReturnDoc,"//LCYHJY");
         document.getElementById("yhjy").value = retStr1;
       	 var jrcp =  retStr.split("|");	
       	 for(var i=0;i<jrcp.length;++i){
	       	 var t = jrcp[i];
	         if(t!="")
	       	 document.getElementById(t).checked = true;
       		 }
         Efs.getExt("win").show();
        }
       else
       {
        alert("加载数据失败!");
       }
      });
   } 
}

//客户基本信息窗口修改确认响应事件
function doGdkhMod(){
	var s = "";
	if(!Efs.getExt("frmGdkhMod").isValid())
		   return false;
		//遍历checkbox,拼接成字符串并赋值给隐藏字段,一起提交后台存储,分隔符号为"|"
		var x = document.getElementsByName("checkbox");
			for (var i=0;i<x.length;i++){
				if (x[i].checked)
					s = s + x[i].id + "|";
				}
		document.getElementById("jrcpsyqk").value = s; 
		//得到"理财优化建议"的值,并赋值给隐含字段提交!"
		var tt = document.getElementById("yhjy").value;
		document.getElementById("lcyhjy").value = tt;
		Efs.getExt("frmGdkhMod").submit();//基本信息提交
}
//返回监听
function frmPostSubBack(bln,from,action)
{
  if(bln)
  {
	  alert("修改高端客户信息成功!");
	  Efs.getExt("frmGdkhMod").reset();
	 //清除"理财优化建议"的值
	  document.getElementById("yhjy").value ="";
	//清除"checkbox"的值
	  var o = document.getElementsByName("checkbox");
	  for (var j=0;j<o.length;j++){
			if (o[j].checked)
				o[j].checked = false;
			}
	  Efs.getExt("win").hide();
	  Efs.getDom("xsStore").url="<%=rootPath%>/zxkh_getGdkhList.action";
	  Efs.getExt("xsGrid").store.reload();
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
	    	    <td><input iconCls="icon-qry" type="button" value="查  询" onEfsClick="doQry()"></td>
		      </tr>
			</TABLE>
		</form>
	</div>
	<div id="xsGrid" region="center" border="flase" xtype="grid" iconCls="icon-panel" onEfsRowClick="doGridClick() pagingBar="true" pageSize="20">
	   <div xtype="tbar">
		  <span class="Title">高端客户资料列表</span>
		  <div text="->"></div>
		  <div iconCls="icon-add" id="jbxxMod" text="客户基本信息修改#A" onEfsClick="onJbxxMod()" disabled="disabled"></div>
		  <!-- <div iconCls="icon-add" id="jtqkMod" text="客户家庭情况修改#A" onEfsClick="onJtqkMod" disabled="disabled"></div>
		  		<div iconCls="icon-add" id="zcjgMod" text="客户资产结构修改#A" onEfsClick="onZcjgMod()" disabled="disabled"></div>
		   -->
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
	<!-- 客户基本信息修改window -->
	<div iconCls="icon-panel" id="win" xtype="window" width="850" height="550" title="客户基本信息修改" resizable="true" modal="true">
	 <div region="north" xtype="panel" title="" border="false" height="140" autoScroll="true">
		    <div xtype="tbar">
		       <div text="->"></div>
		       <div iconCls="icon-add" id="cmdUser" text="确定修改" onEfsClick="doGdkhMod()"></div>
		    </div>
		<form id="frmGdkhMod" method="post" url="<%=rootPath%>/zxkh_frmGdkhMod.action" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
				<TABLE class="formAreaTop" align="left" cellspacing="10" >
					<tr>
						<TD>客户姓名</TD>
						<TD align="left"><INPUT type="text" class="Edit"  must="true"  fieldname="T_GDKHXXB/XM" disabled="disabled"></TD>
						<TD>出生年月</TD>
						<TD align="left"><INPUT type="text" kind="date" class="Edit" maxlength="20"  fieldname="T_GDKHXXB/CSNY"></TD>
						<TD>身份证号码</TD>
						<TD align="left"><INPUT type="text" class="Edit" must="true"  maxlength="18" fieldname="T_GDKHXXB/SFZHM"></TD>
						<TD>联系电话</TD>
						<TD align="left"><INPUT type="text" maxlength="60" class="Edit"  must="true"  fieldname="T_GDKHXXB/LXDH"></TD>
					</tr>
					<tr>
						<TD>职  业</TD>
						<TD align="left"><INPUT type="text" maxlength="60"  class="Edit"  fieldname="T_GDKHXXB/ZY"></TD>
						<TD>职 务</TD>
						<TD align="left"><INPUT type="text" maxlength="60"  class="Edit"  fieldname="T_GDKHXXB/ZW"></TD>
						<TD>月收入</TD>
						<TD align="left"><INPUT type="text" maxlength="60"  class="Edit"  fieldname="T_GDKHXXB/YSR"></TD>
						<TD>适销产品</TD>
						<TD align="left"><INPUT type="text" maxlength="60"  class="Edit"  fieldname="T_GDKHXXB/SXCP"></TD>
					</tr>
					<tr>
						<TD>个人偏好</TD>
						<TD align="left"><INPUT type="text" maxlength="60"  class="Edit"  fieldname="T_GDKHXXB/GRPH"></TD>
						<TD>现居住地</TD>
						<TD colspan="9" align="left"><INPUT  type="text" maxlength="60"  class="Edit"  fieldname="T_GDKHXXB/XJZD"></TD>
					 </tr>
					 <input type="hidden" kind="text" fieldname="T_GDKHXXB/KHID" operation="1" state="5">
					 <input type="hidden" id="jrcpsyqk" kind="text" fieldname="T_GDKHXXB/JRCPSYQK" operation="1">
					 <input type="hidden" id="lcyhjy" kind="text" fieldname="T_GDKHXXB/LCYHJY" operation="1">
				</TABLE>
		</form>
	</div>
	<div region="center" border="flase"  iconCls="icon-panel" >
			<div id="mypanel" xtype="panel"  title="理财优化建议:" height="100">
				<textarea id="yhjy" rows="9" cols="284"></textarea>
			</div>
	 	    <div id="mypanel" xtype="panel" fontsize="16px" title="产品覆盖(已购买产品打&#8730;)" height="110">
				<br>
				<input type="checkbox" name="checkbox" id="100">金卡
				<input type="checkbox" name="checkbox" id="101">定期存款
				<input type="checkbox" name="checkbox" id="102">生意通
				<input type="checkbox" name="checkbox" id="103">信用卡
				<input type="checkbox" name="checkbox" id="104">银信通
				<input type="checkbox" name="checkbox" id="105">理财产品
				<input type="checkbox" name="checkbox" id="106">保险产品
				<input type="checkbox" name="checkbox" id="107">基金产品
				<input type="checkbox" name="checkbox" id="108">国债业务
				<input type="checkbox" name="checkbox" id="109">商易通
				<br>
				<br>
				<input type="checkbox" name="checkbox" id="201">汇兑业务
				<input type="checkbox" name="checkbox" id="202">外汇业务
				<input type="checkbox" name="checkbox" id="203">代缴话费
				<input type="checkbox" name="checkbox" id="204">代发工资
				<input type="checkbox" name="checkbox" id="205">信贷业务
				<input type="checkbox" name="checkbox" id="206">公司业务
				<input type="checkbox" name="checkbox" id="207">代缴其他费
				<input type="checkbox" name="checkbox" id="208">其他业务
			</div>
			<div id="mypanel" xtype="panel" title="使用其他银行情况(选择请打&#8730;)" height="80">
				<br>
				<input type="checkbox" name="checkbox" id="301"/>农信社/农商行
				<input type="checkbox" name="checkbox" id="302"/>中国农业银行
				<input type="checkbox" name="checkbox" id="303"/>中国工商银行
				<input type="checkbox" name="checkbox" id="304"/>中国建设银行
				<input type="checkbox" name="checkbox" id="305"/>中国银行
				<input type="checkbox" name="checkbox" id="306"/>交通银行
				<input type="checkbox" name="checkbox" id="307"/>其他
				<br>
			</div>
			<div id="mypanel" xtype="panel"  title=" 其他理财产品(选择请打&#8730;)" height="86">
				<br>
				<input type="checkbox" name="checkbox" id="401"/>本外币理财
				<input type="checkbox" name="checkbox" id="401"/>国债
				<input type="checkbox" name="checkbox" id="403"/>其他债券
				<input type="checkbox" name="checkbox" id="404"/>保险
				<input type="checkbox" name="checkbox" id="405"/>基金
				<input type="checkbox" name="checkbox" id="406"/>证券
				<input type="checkbox" name="checkbox" id="407"/>信托
				<input type="checkbox" name="checkbox" id="408"/>期货
				<input type="checkbox" name="checkbox" id="409"/>贵金属
				<input type="checkbox" name="checkbox" id="410"/>房地产
				<input type="checkbox" name="checkbox" id="411"/>储蓄
				<input type="checkbox" name="checkbox" id="412"/>其他  
				<br>
				<br>
			</div>
	</div>
</div>
<!--客户基本信息修改window 结束-->	
</body>
</html>

