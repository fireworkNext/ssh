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
<div title="绩效工资" region="north" height="220" xtype="grid" pagingBar="true" pageSize="5" buttonAlign="center" onEfsRowClick="doSalGridClick()" onEfsRowDblClick="onSalDetail()">
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
			<div name="SFGZ"></div>
			<div name="YJXGZ"></div>
			<div name="QT"></div>
			<div name="YFHJ"></div>
			<div name="SF"></div>
			<div name="SFHJ"></div>
			<div name="DETAIL"></div>
			<div name="VALID"></div>
		</div>
	</div>
	<div xtype="colmodel">
		<div header="年" width="80" dataIndex="YEAR" align="center"></div>
		<div header="月" width="80" dataIndex="MONTH" align="center"></div>
		<div header="实发工资" width="80" dataIndex="SFGZ" align="center"></div>
		<div header="月绩效工资" width="80" dataIndex="YJXGZ" align="center"></div>
		<div header="其它" width="80" dataIndex="QT" align="center"></div>
		<div header="应发合计" width="80" dataIndex="YFHJ" align="center"></div>
		<div header="税费" width="80" dataIndex="SF" align="center"></div>
		<div header="实发合计" width="80" dataIndex="SFHJ" align="center"></div>
	</div>
</div>
<div region="center" border="false">
<div title="业务发展奖励" height="220" xtype="grid" pagingBar="true" pageSize="5" buttonAlign="center" onEfsRowClick="doRewGridClick()" onEfsRowDblClick="onRewDetail()">
	<div id="list2" xtype="store" url="<%=rootPath%>/gzcx_getRewardsList.action" baseParams="{txtXML:g_XML}" autoLoad="true">
		<div xtype="xmlreader" fieldid="ID" record="ROW" totalRecords="QUERYINFO@records">
			<div name="REWID" mapping="REWID"></div>
			<div name="YEAR"></div>
			<div name="MONTH"></div>
			<div name="SFZHM"></div>
			<div name="BXDM"></div>
			<div name="DW"></div>
			<div name="XM"></div>
			<div name="ZJ"></div>
			<div name="ZDW"></div>
			<div name="GW"></div>
			<div name="YWZL"></div>
			<div name="YWSR"></div>
			<div name="JLBZ"></div>
			<div name="SF"></div>
			<div name="SFJL"></div>
			<div name="DETAIL"></div>
			<div name="VALID"></div>
		</div>
	</div>
	<div xtype="colmodel">
		<div header="年" width="80" dataIndex="YEAR" align="center"></div>
		<div header="月" width="80" dataIndex="MONTH" align="center"></div>
		<div header="业务种类" width="80" dataIndex="YWZL" align="center"></div>
		<div header="发展业务量/业务收入" width="160" dataIndex="YWSR" align="center"></div>
		<div header="奖励标准" width="80" dataIndex="JLBZ" align="center"></div>
		<div header="税费" width="80" dataIndex="SF" align="center"></div>
		<div header="实发奖励" width="80" dataIndex="SFJL" align="center"></div>
	</div>
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
						<td class="label">实发工资：</td>
						<td><input type="text" kind="float" fieldname="SALARY/SFGZ" state="0" datatype="1"></td>
						<td class="label">月绩效工资：</td>
						<td><input type="text" kind="float" fieldname="SALARY/YJXGZ" state="0" datatype="1"></td>
					</tr>
					<tr>
					<td class="label">其它：</td>
						<td><input kind="float" fieldname="SALARY/QT" state="0" datatype="1"></td>
						<td class="label">应发合计：</td>
						<td><input kind="float" fieldname="SALARY/YFHJ" state="0" datatype="1"></td>
					</tr>
					<tr>
					<td class="label">税费：</td>
						<td><input kind="float" fieldname="SALARY/SF" state="0" datatype="1"></td>
						<td class="label">实发合计：</td>
						<td><input kind="float" fieldname="SALARY/SFHJ" state="0" datatype="1"></td>
					</tr>
					<tr>
						<td class="label">明细：</td>
						<td colspan="3"><TEXTAREA class="Edit" fieldname="SALARY/DETAIL" style="height:125px;width:465px" kind="text" state="0" datatype="0"></TEXTAREA></td>
					</tr>
		</TABLE>
		<INPUT id="salid" type="hidden" kind="int" fieldname="SALARY/SALID" datatype="0" state="5" operation="1" writeevent="0"></INPUT>  
    </form>            
  </div>
</div>
<!-- window结束 -->

<!-- 业务发展奖励明细window开始 -->
<div iconCls="icon-panel" id="rewWin" xtype="window" width="603" height="350" title="业务发展奖励明细" resizable="false" modal="true">
  <div region="center" xtype="panel" title="" border="false" autoScroll="true">
    <form id="frmDataRew" class="efs-box" method="post" url="<%=rootPath%>/gzcx_getRewardsDetail.action" onEfsSuccess="frmPostSubBack(true)"  onEfsFailure="frmPostSubBack(false)">
		<TABLE class="formArea">
					<tr>
						<td class="label">姓名：</td>
						<td><input type="text" kind="text" fieldname="REWARDS/XM" state="0" datatype="0" value="" readonly="readonly"></td>
						<td class="label">职级：</td>
						<td><input type="text" kind="text" fieldname="REWARDS/ZJ" state="0" datatype="0" value=""></td>
					</tr>
					<tr>
						<td class="label">单位：</td>
						<td><input type="text"  kind="text" fieldname="REWARDS/DW" state="0" datatype="0"></td>
						<td class="label">子单位：</td>
						<td><input type="text" kind="text" fieldname="REWARDS/ZDW" state="0" datatype="0" value=""></td>	
					</tr>
					
					<tr>
						<td class="label">保险代码：</td>
						<td><input kind="int" fieldname="SALARY/BXDM" state="0" datatype="0"></input></td>				
						<td class="label">身份证号码：</td>
						<td><input type="text" kind="text" fieldname="SREWARDS/SFZHM" state="0" datatype="0" value=""></td>
					</tr>
					<tr>
						<td class="label">业务种类：</td>
						<td><input type="text" kind="text" fieldname="REWARDS/YWZL" state="0" datatype="0"></td>
						<td class="label">奖励标准：</td>
						<td><input kind="text" fieldname="REWARDS/JLBZ" state="0" datatype="0"></td>
					</tr>
					<tr>
						<td class="label">发展业务量/业务收入：</td>
						<td colspan="3"><input type="text" kind="text" fieldname="REWARDS/YWSR" state="0" datatype="0"></td>
					</tr>
					<tr>
					<td class="label">税费：</td>
						<td><input kind="float" fieldname="REWARDS/SF" state="0" datatype="1"></td>
						<td class="label">实发奖励：</td>
						<td><input kind="float" fieldname="REWARDS/SFJL" state="0" datatype="1"></td>
					</tr>
					<tr>
						<td class="label">明细：</td>
						<td colspan="3"><TEXTAREA class="Edit" fieldname="REWARDS/DETAIL" style="height:125px;width:465px" kind="text" state="0" datatype="0"></TEXTAREA></td>
					</tr>
		</TABLE>
		<INPUT id="rewid" type="hidden" kind="int" fieldname="REWARDS/REWID" datatype="0" state="5" operation="1" writeevent="0"></INPUT>  
    </form>            
  </div>
</div>
<!-- window结束 -->
</BODY>
</HTML>
