<%@ page language="java" import="org.ptbank.cache.*" pageEncoding="UTF-8"%>
<%@ include file="../../inc/head.inc.jsp"%>
<%!
/**
	 '*******************************
	 '** 程序名称：  basicAdd.jsp
	 '** 实现功能：   高端客户基本资料新增
	 '** 设计人员：   蔡剑成
	 '** 设计日期：   2013-08-12
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
<style>
body{font-size:14px;}
</style>
<head>
	<base href="<%=webRoot%>">
	<title>高端客户资料新增</title>
	<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
	<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
	<script type="text/javascript" src="js/loadmask.js"></script>
	<script type="text/javascript" src="js/efs-all.js"></script>
	<script language="JavaScript">
		//增加按钮响应函数
		var s = "";
		function onAddEx(){
			if(!Efs.getExt("frmGdkhAdd").isValid())
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
			//var t = Efs.Common.getOpXml(Efs.getExt("frmGdkhAdd"),true);
			Efs.getExt("frmGdkhAdd").submit();//基本信息提交
			}
		//返回监听
		function frmPostSubBack(bln,from,action)
		{
		  if(bln)
		  {
			  alert("新增高端客户信息成功!");
			  Efs.getExt("frmGdkhAdd").reset();
			 // Efs.getExt("frm2").reset();
			 //清除"理财优化建议"的值
			  document.getElementById("yhjy").value ="";
			//清除"checkbox"的值
			  var o = document.getElementsByName("checkbox");
			  for (var j=0;j<o.length;j++){
					if (o[j].checked)
						o[j].checked = false;
					}
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
	</script>
</head>
<body>
	<div iconCls="icon-panel" region="north" height="200" title="高端客户资料新增" border="false" buttonAlign="center" autoScroll="true">
		<div xtype="tbar">
	    	<span class="Title">客户基本信息</span>
	  		<div text="->"></div>
	 		<div iconCls="icon-add" id="cmdAdd" text="增加#A" onEfsClick="onAddEx()"></div>
		</div>
		<form id="frmGdkhAdd" method="post" url="<%=rootPath%>/zxkh_gdkhAdd.action" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
			<TABLE class="formAreaTop"  align="left" cellspacing="18" >
				<tr>
					<TD>客户姓名</TD>
					<TD align="left"><INPUT type="text" class="Edit"  must="true"  fieldname="T_GDKHXXB/XM"></TD>
					<TD>性  别</TD>
					<TD align="left"><INPUT type="text" class="Edit"  must="true"  fieldname="T_GDKHXXB/XB"></TD>
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
					<TD>个人偏好</TD>
					<TD align="left"><INPUT type="text" maxlength="60"  class="Edit"  fieldname="T_GDKHXXB/GRPH"></TD>
				 </tr>
				 <tr>
					<TD>现居住地</TD>
					<TD colspan="9" align="left"><INPUT style="width:300px" type="text" maxlength="60"  class="Edit"  fieldname="T_GDKHXXB/XJZD"></TD>
				 </tr>
				 <input type="hidden" kind="text" fieldname="T_GDKHXXB/GZR" operation="0">
				 <input type="hidden" kind="text" fieldname="T_GDKHXXB/GZRNAME" operation="0">
				 <input type="hidden" kind="text" fieldname="T_GDKHXXB/UNITID" operation="0">
				 <input type="hidden" kind="text" fieldname="T_GDKHXXB/UNITNAME" operation="0">
				 <input type="hidden" kind="text" fieldname="T_GDKHXXB/KHID" operation="0">
				 <input type="hidden" kind="date" fieldname="T_GDKHXXB/JDSJ" operation="0">
				 <input type="hidden" id="jrcpsyqk" kind="text" fieldname="T_GDKHXXB/JRCPSYQK" operation="0">
				 <input type="hidden" id="lcyhjy" kind="text" fieldname="T_GDKHXXB/LCYHJY" operation="0">
			</TABLE>
		</form>
	</div>
	<div region="center" >
			<div id="mypanel" xtype="panel"  title="理财优化建议" height="129">
				<textarea id="yhjy" rows="7" cols="284"></textarea>
			</div>
	 	    <div id="tab1" xtype="panel" title="产品覆盖(已购买产品打&#8730;)" height="121">
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
			<div id="mypanel" xtype="panel" title="使用其他银行情况(选择请打&#8730;)" height="100">
				<br>
				<input type="checkbox" name="checkbox" id="301"/>农信社/农商行
				<input type="checkbox" name="checkbox" id="302"/>中国农业银行
				<input type="checkbox" name="checkbox" id="303"/>中国工商银行
				<input type="checkbox" name="checkbox" id="304"/>中国建设银行
				<input type="checkbox" name="checkbox" id="305"/>中国银行
				<input type="checkbox" name="checkbox" id="306"/>交通银行
				<input type="checkbox" name="checkbox" id="307"/>其他
			</div>
			<div id="mypanel" xtype="panel"  title=" 其他理财产品(选择请打&#8730;)" height="100">
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
			</div>
	</div>	
</body>
</html>
