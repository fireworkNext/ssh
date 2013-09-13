<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="inc/head.inc.jsp" %>
<HTML>
<HEAD>
<TITLE></TITLE>
<base href="<%=webRoot%>">
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/efs-all.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var g_XML = Efs.Common.getQryXml();
var sSalId = "";
var sRewId = "";

//grid单击响应事件
function doSalGridClick(data){
	sSalId = data["SALID"]
}

//grid单击响应事件
function doRewGridClick(data){
	sRewId = data["REWID"]
}

//弹出绩效工资明细窗口
function onSalDetail()
{
 if(sSalId == "")
  {
    alert("没有选择明细列表,请选择!");
    return false;
  }
  //alert(sSalId);
  Efs.getExt("frmDataSal").reset();
  var xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
  xmlhttp.Open("POST","<%=rootPath%>/gzcx_getSalaryDetail.action?txtSalId=" + sSalId,false);
  xmlhttp.Send();
  var xmlReturnDoc = new ActiveXObject("MSXML2.DOMDocument");
  xmlReturnDoc = xmlhttp.responseXML;
  //alert(xmlReturnDoc.xml);
  Efs.Common.setEditValue(xmlReturnDoc.xml,Efs.getExt("frmDataSal"), "QUERYINFO");
  xmlReturnDoc = null;
  xmlhttp = null;
  
  Efs.getExt("salWin").show();
}

//弹出业务发展奖励明细窗口
function onRewDetail()
{
 if(sRewId == "")
  {
    alert("没有选择明细列表,请选择!");s
    return false;
  }
  //alert(sSalId);
  Efs.getExt("frmDataRew").reset();
  var xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
  xmlhttp.Open("POST","<%=rootPath%>/gzcx_getRewardsDetail.action?txtRewId=" + sRewId,false);
  xmlhttp.Send();
  var xmlReturnDoc = new ActiveXObject("MSXML2.DOMDocument");
  xmlReturnDoc = xmlhttp.responseXML;
  //alert(xmlReturnDoc.xml);
  Efs.Common.setEditValue(xmlReturnDoc.xml,Efs.getExt("frmDataRew"), "QUERYINFO");
  xmlReturnDoc = null;
  xmlhttp = null;
  
  Efs.getExt("rewWin").show();
}
</SCRIPT>
<style>
<!--
td,div {
  font-size:9pt;
  line-height:160%;
}

@media print{ 
body {display:none} 
}
-->
</style>
</HEAD>

<BODY oncontextmenu="self.event.returnValue=false" onselectstart="return false">
<div title="绩效工资" region="center" xtype="grid" pagingBar="true" pageSize="10" buttonAlign="center" onEfsRowClick="doSalGridClick()" onEfsRowDblClick="onSalDetail()">
	<div id="list1" xtype="store" url="<%=rootPath%>/gzcx_getSalaryList.action" baseParams="{txtXML:g_XML}" autoLoad="true">
		<div xtype="xmlreader" fieldid="SALID" record="ROW" totalRecords="QUERYINFO@records">
			<div name="SALID" mapping="SALID"></div>
			<div name="YEAR"></div>
			<div name="MONTH"></div>
			<div name="SFZHM"></div>
			<div name="BXDM"></div>
			<div name="DW"></div>
			<div name="XM"></div>
			<div name="ZJ"></div>
			<div name="ZDW"></div>
			<div name="GW"></div>
			<div name="SAL1"></div>
			<div name="SAL2"></div>
			<div name="SAL3"></div>
			<div name="SAL4"></div>
			<div name="SAL5"></div>
			<div name="SAL6"></div>
			<div name="SAL7"></div>
			<div name="SAL8"></div>
			<div name="SAL9"></div>
			<div name="SAL10"></div>
			<div name="SAL11"></div>
			<div name="SAL12"></div>
			<div name="SAL13"></div>
			<div name="SAL14"></div>
			<div name="SAL15"></div>
			<div name="DETAIL"></div>
			<div name="VALID"></div>
		</div>
	</div>
	<div xtype="colmodel">
		<div header="年" width="80" dataIndex="YEAR" align="center"></div>
		<div header="月" width="80" dataIndex="MONTH" align="center"></div>
		<div header="应发工资(含交通费等)" width="80" dataIndex="SAL1" align="center"></div>
		<div header="公积金等个人扣款" width="80" dataIndex="SAL2" align="center"></div>
		<div header="实发工资" width="80" dataIndex="SAL3" align="center"></div>
		<div header="当月奖金" width="80" dataIndex="SAL4" align="center"></div>
		<div header="个人所得税" width="80" dataIndex="SAL5" align="center"></div>
		<div header="水电费等扣款" width="80" dataIndex="SAL6" align="center"></div>
		<div header="本月实发薪酬" width="80" dataIndex="SAL7" align="center"></div>
	</div>
</div>

<!-- 绩效工资明细window开始 -->
<div iconCls="icon-panel" id="salWin" xtype="window" width="603" height="350" title="绩效工资明细" resizable="false" modal="true">
  <div region="center" xtype="panel" title="" border="false" autoScroll="true">
    <form id="frmDataSal" class="efs-box" method="post" url="<%=rootPath%>/gzcx_getSalaryDetail.action" onEfsSuccess="frmPostSubBack(true)"  onEfsFailure="frmPostSubBack(false)">
		<TABLE class="formArea">
					<tr>
						<td class="label">姓名：</td>
						<td><input type="text" kind="text" fieldname="SALARY/XM" state="0" datatype="0" value="" readonly="readonly"></td>
						<td class="label">职级：</td>
						<td><input type="text" kind="text" fieldname="SALARY/ZJ" state="0" datatype="0" value=""></td>
					</tr>
					<tr>
						<td class="label">单位：</td>
						<td><input type="text"  kind="text" fieldname="SALARY/DW" state="0" datatype="0"></td>
						<td class="label">子单位：</td>
						<td><input type="text" kind="text" fieldname="SALARY/ZDW" state="0" datatype="0" value=""></td>	
					</tr>
					
					<tr>
						<td class="label">保险代码：</td>
						<td><input kind="int" fieldname="SALARY/BXDM" state="0" datatype="0"></input></td>				
						<td class="label">身份证号码：</td>
						<td><input type="text" kind="text" fieldname="SALARY/SFZHM" state="0" datatype="0" value=""></td>
					</tr>
					<tr>
						<td class="label">应发工资(含交通费等)：</td>
						<td><input type="text" kind="float" fieldname="SALARY/SAL1" state="0" datatype="1"></td>
						<td class="label">公积金等个人扣款：</td>
						<td><input type="text" kind="float" fieldname="SALARY/SAL2" state="0" datatype="1"></td>
					</tr>
					<tr>
						<td class="label">实发工资：</td>
						<td><input kind="float" fieldname="SALARY/SAL3" state="0" datatype="1"></td>
						<td class="label">当月奖金：</td>
						<td><input kind="float" fieldname="SALARY/SAL4" state="0" datatype="1"></td>
					</tr>
					<tr>
						<td class="label">个人所得税：</td>
						<td><input kind="float" fieldname="SALARY/SAL5" state="0" datatype="1"></td>
						<td class="label">水电费等扣款：</td>
						<td><input kind="float" fieldname="SALARY/SAL6" state="0" datatype="1"></td>
					</tr>
					<tr>
						<td class="label">本月实发薪酬：</td>
						<td><input kind="float" fieldname="SALARY/SAL7" state="0" datatype="1"></td>
					</tr>
					<!--
					<tr>
						<td class="label">明细：</td>
						<td colspan="3"><TEXTAREA class="Edit" fieldname="SALARY/DETAIL" style="height:125px;width:465px" kind="text" state="0" datatype="0"></TEXTAREA></td>
					</tr>
					-->
		</TABLE>
		<INPUT id="salid" type="hidden" kind="int" fieldname="SALARY/SALID" datatype="0" state="5" operation="1" writeevent="0"></INPUT>  
    </form>            
  </div>
</div>
<!-- window结束 -->
</BODY>
</HTML>
