<%@ page language="java" import="org.ptbank.cache.*" pageEncoding="UTF-8"%>
<%@ include file="../../inc/head.inc.jsp"%>
<%!
/**
	 '*******************************
	 '** 程序名称：   extraMod.jsp
	 '** 实现功能：   高端客户附加信息维护
	 '** 设计人员：   蔡剑成
	 '** 设计日期：   2013-08-26
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
<title>高端客户附加信息维护</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>

<SCRIPT language="JavaScript">
var skhid = ""; //定义一个全局变量
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
	  Efs.getExt("jtqkMan").enable();
	  Efs.getExt("zcjgMan").enable();
	  Efs.getExt("cjjlMan").enable();

}
//跳出家庭情况维护窗口
function onJt(){
	//alert("test!!!");
	Efs.getDom("xsStore1").setAttribute("txtXML",skhid);
	Efs.getExt("xsGrid1").store.reload();
	Efs.getExt("win1").show();
}
//家庭情况窗口grid单击事件
function doJtGridClick(data){
	var jtOid = data["OID"];
	alert (jtOid);
	if(jtOid != "")
	  {
		 Efs.getExt("frmData1").reset(); 
	     Efs.Common.ajax("<%=rootPath%>/zxkh_frmJtqkModQry.action",jtOid,function(succ,response,options){
	       if(succ)    // 是否成功
	       { 
	         var xmlReturnDoc = response.responseXML;
	         alert(xmlReturnDoc.xml);
		     Efs.Common.setEditValue(xmlReturnDoc.xml,Efs.getExt("frmData1"), "QUERYINFO");
	         Efs.getExt("win11").show();
	        }
	       else
	       {
	        alert("加载数据失败!");
	       }
	      });
	   } 
}
//家庭情况新增确定按钮事件
function doJtqkOk(){
	//Efs.getDom("pid").setAttribute("value",skhid);
	Efs.getDom("pid1").value = skhid;
	var opObj = Efs.Common.getOpXml(Efs.getExt("frmData1"),true);
    Efs.getExt("frmData1").submit(opObj);
	
}
//家庭情况返回监听
function jtqkFrmPostSubBack(bln,from,action)
{
  if(bln)
  {
	  alert("新增客户家庭情况成功！");
	  Efs.getExt("frmData1").reset();
	  Efs.getExt("xsGrid1").store.reload();
	  //Efs.getExt("win1").hide();
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


//跳出资产结构新增窗口
function onAddZc(){
	Efs.getDom("xsStore2").setAttribute("txtXML",skhid);
	Efs.getExt("xsGrid2").store.reload();
	Efs.getExt("win2").show();
}
//资产结构新增确定按钮事件
function doZcjgOk(){
	Efs.getDom("pid2").value = skhid;
	var opObj = Efs.Common.getOpXml(Efs.getExt("frmData2"),true);
    Efs.getExt("frmData2").submit(opObj);
}
//资产结构返回监听
function frmPostSubBack2(bln,from,action)
{
  if(bln)
  {
	  alert("新增客户资产结构成功！");
	  Efs.getExt("frmData2").reset();
	  Efs.getExt("xsGrid2").store.reload();
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



//跳出历史成交记录新增窗口
function onAddLscj(){
	Efs.getDom("xsStore3").setAttribute("txtXML",skhid);
	Efs.getExt("xsGrid3").store.reload();
	Efs.getExt("win3").show();
}
//历史成交记录新增确定按钮事件
function doLscjjlAdd(){
	Efs.getDom("pid3").value = skhid;
	var opObj = Efs.Common.getOpXml(Efs.getExt("frmData3"));
	//var opObj = Efs.Common.getOpXml(Efs.getExt("frmData3"),true);
	//alert(Efs.getDom("pid3").value);
    Efs.getExt("frmData3").submit(opObj);
}
//历史成交记录返回监听
function frmPostSubBack3(bln)
{
  if(bln)
  {
	  alert("新增客户历史成交记录成功！");
	  Efs.getExt("frmData3").reset();
	  Efs.getExt("xsGrid3").store.reload();
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
	
	<div id="xsGrid" region="center" border="flase" xtype="grid" iconCls="icon-panel" onEfsRowClick="doGridClick() " pagingBar="true" pageSize="20">
	   <div xtype="tbar">
		  <span class="Title">高端客户资料列表</span>
		  <div text="->"></div>
		  <div iconCls="icon-add" id="jtqkMan" text="家庭情况维护#A" onEfsClick="onJt()" disabled="disabled"></div>
		  <div iconCls="icon-add" id="zcjgMan" text="资产结构维护#A" onEfsClick="onZc()" disabled="disabled"></div>
		  <div iconCls="icon-add" id="cjjlMan" text="成交记录维护#A" onEfsClick="onLscj()" disabled="disabled"></div>
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
	
	<!-- 家庭情况信息window开始 -->
	<div iconCls="icon-panel" id="win1" xtype="window" width="800" height="400" title="高端客户家庭情况信息" resizable="true" modal="true">
	  <div region="north" xtype="panel" title="" border="false"  autoScroll="true">
	    <div xtype="tbar">
	      <div text="->"></div>
	      <div iconCls="icon-add" id="cmdUser" text="修改记录" onEfsClick="doJtqkMod()"></div>
	       <div text="->"></div>
	      <div iconCls="icon-del" id="cmdUser" text="删除记录" onEfsClick="doJtqkDel()"></div>
	    </div>
	  </div>
	  <!-- 家庭情况Grid -->
	  <div id="xsGrid1"  region="center" border="flase" xtype="grid" iconCls="icon-panel" >
	   <div id="xsStore1" xtype="store" url="<%=rootPath%>/zxkh_getJtqkList.action" txtXML="" onEfsRowClick="doJtGridClick()" autoLoad="false">
			<div xtype="xmlreader" fieldid="OID" record="ROW" tabName="T_JTQK">
					<div name="OID"></div>
					<div name="GX"></div>
					<div name="XM"></div>
					<div name="MS"></div>
					<div name="AH"></div>
					<div name="BZ"></div>
			</div>
		</div>
		<div xtype="colmodel">
			<div header="关系" width="110" sortable="true"  align="center" dataIndex="GX"></div>
			<div header="姓名" width="160" sortable="true"  align="center" dataIndex="XM"  align="center"></div>
			<div header="描述" width="160" sortable="true" align="center" dataIndex="MS"></div>
			<div header="爱好" width="160" sortable="true" align="center" dataIndex="AH"></div>
			<div header="备注" width="160" sortable="true"  align="center" dataIndex="BZ"></div>
		</div>
	</div>
	</div>
<!-- 家庭情况信息window结束 -->
<!-- 家庭情况修改窗口 开始-->
<div iconCls="icon-panel" id="win11" xtype="window" width="800" height="200" title="家庭情况编辑窗口" resizable="true" modal="true">
	<form id="frmData1" class="efs-box" method="post" url="<%=rootPath%>/zxkh_jtqkAdd.action" onEfsSuccess="jtqkFrmPostSubBack(true)" onEfsFailure="jtqkFrmPostSubBack(false)">
		    <TABLE>
		      <tr>
		      	<td class="label">关系</td>
		        <td><input type="text"  class="Edit" kind="text" fieldname="T_JTQK/GX" must="true" state="0" datatype="0" ></td>
		        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		        <td class="label">姓名</td>
		        <td><input type="text" class="Edit" kind="text" fieldname="T_JTQK/XM" must="true" state="0" datatype="0"></td>
		         <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		        <td class="label">描述</td>
		         <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		        <td><input type="text" class="Edit" fieldname="T_JTQK/MS" must="true" state="0" datatype="0"></td>
		        <td class="label">爱好</td>
		         <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		        <td><input type="text"  class="Edit" kind="text" fieldname="T_JTQK/AH"  state="0" datatype="0"></td>
		      </tr>
		      <tr>
		      	<td class="label">备注</td>
		        <td><input type="text"  class="Edit" kind="text" fieldname="T_JTQK/BZ" must="true" state="0" datatype="0"></td>
		      </tr>
		    </TABLE>
   		    <input type="hidden"  kind="text" fieldname="T_JTQK/OID" operation="0" writeevent="0" state="0" datatype="0">
   		    <input type="button" name="确定">
	 </form>
</div>
<!-- 家庭情况修改窗口结束 -->

<!-- 资产结构window开始 -->
	<div iconCls="icon-panel" id="win2" xtype="window" width="673" height="400" title="资产结构编辑窗口" resizable="true" modal="true">
	  <div region="north" xtype="panel" title="" border="false" width="673" height="78" autoScroll="true">
		    <div xtype="tbar">
		       <div text="->"></div>
		       <div iconCls="icon-add" id="cmdUser" text="确定新增" onEfsClick="doZcjgOk()"></div>
		    </div>
		    <form id="frmData2" class="efs-box" method="post" url="<%=rootPath%>/zxkh_zcjgAdd.action" onEfsSuccess="frmPostSubBack2(true)" onEfsFailure="frmPostSubBack2(false)">
			    <TABLE>
			      <tr>
			      	<td class="label">资产类别</td>
			        <td><input type="text" id="dbfld" name="dbfld" class="Edit" kind="text" fieldname="T_ZCJG/ZCLB" must="true" state="0" datatype="0" onEfsBlur="toUpper();"></td>
			        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			        <td class="label">实际占比</td>
			        <td><input type="text" id="fldname" name="fldname" class="Edit" kind="text" fieldname="T_ZCJG/SJZB" must="true" state="0" datatype="0"></td>
			         <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			        <td class="label">建议占比</td>
			         <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			        <td><input type="text" class="Edit" fieldname="T_ZCJG/JYZB" must="true" state="0" datatype="0"></td>
			      </tr>
			    </TABLE>
			     <input type="hidden"  kind="text" fieldname="T_ZCJG/OID" operation="0" writeevent="0" state="0" datatype="0">
	   		 	 <input type="hidden"  id="pid2" kind="text" fieldname="T_ZCJG/KHID" operation="0" writeevent="0" state="0" datatype="0">
		    </form>
	  </div>
	  <!--资产结构Grid -->
	  <div id="xsGrid2"  region="center" border="flase" xtype="grid" iconCls="icon-panel"  pagingBar="false">
	   <div id="xsStore2" xtype="store" url="<%=rootPath%>/zxkh_getZcjgList.action" txtXML="" autoLoad="false">
			<div xtype="xmlreader" fieldid="OID" record="ROW" tabName="T_ZCJG">
					<div name="OID"></div>
					<div name="ZCLB"></div>
					<div name="SJZB"></div>
					<div name="JYZB"></div>
			</div>
		</div>
		<div xtype="colmodel">
			<div header="资产类别" width="200" sortable="true"  align="center" dataIndex="ZCLB"></div>
			<div header="实际占比" width="200" sortable="true"  align="center" dataIndex="SJZB"  align="center"></div>
			<div header="建议占比" width="200" sortable="true" align="center" dataIndex="JYZB"></div>
		</div>
	</div>
	</div>
<!-- 资产结构window结束 -->

<!-- 历史成交记录window开始 -->
	<div iconCls="icon-panel" id="win3" xtype="window" width="850" height="500" title="历史成交记录新增窗口" resizable="true" modal="true">
	  <div region="north" xtype="panel" title="" border="false" height="104" autoScroll="true">
		    <div xtype="tbar">
		       <div text="->"></div>
		       <div iconCls="icon-add" id="cmdUser" text="确定新增" onEfsClick="doLscjjlAdd()"></div>
		    </div>
		    <form id="frmData3" class="efs-box" method="post" url="<%=rootPath%>/zxkh_lscjjlAdd.action" onEfsSuccess="frmPostSubBack3(true)" onEfsFailure="frmPostSubBack3(false)">
			    <TABLE>
			      <tr>
			      	<td class="label">购买日期</td>
			        <td><input type="text" class="Edit" kind="date" must="true"  fieldname="T_LSCJJL/GMRQ"></td>
			        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			        <td class="label">产品</td>
			        <td><input type="text"  name="cp"  kind="text" fieldname="T_LSCJJL/CP" must="true" ></td>
			         <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			        <td class="label">积分</td>
			         <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			        <td><input type="text" class="Edit" fieldname="T_LSCJJL/JF" must="true" ></td>
			         <td class="label">到期日期</td>
			         <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			        <td><input type="text" class="Edit" kind="date" must="true"  fieldname="T_LSCJJL/DQRQ"></td>
			        </tr>
			        <tr>
			         <td class="label">备注说明</td>
			       	 <td ><input colspan=5 type="text" class="Edit" fieldname="T_LSCJJL/BZSM" must="true" state="0" datatype="0"></td>
			        </tr>
			    </TABLE>
			    <input type="hidden"  kind="text" fieldname="T_LSCJJL/OID" operation="0" writeevent="0" state="0" datatype="0">
	   		 	<input type="hidden"  id="pid3" kind="text" fieldname="T_LSCJJL/KHID" operation="0" writeevent="0" state="0" datatype="0">
		    </form>
	  </div>
	  <!--成交记录Grid -->
	  <div id="xsGrid3"  region="center" border="flase" xtype="grid" iconCls="icon-panel" >
		   <div id="xsStore3" xtype="store" txtXML=""  url="<%=rootPath%>/zxkh_getLscjjlList.action" autoLoad="false">
				<div xtype="xmlreader" fieldid="OID" record="ROW" tabName="T_LSCJJL">
						<div name="OID"></div>
						<div name="GMRQ"></div>
						<div name="CP"></div>
						<div name="JF"></div>
						<div name="DQRQ"></div>
						<div name="BZSM"></div>
				</div>
			</div>
			<div xtype="colmodel">
				<div header="购买日期" width="120" sortable="true"  align="center" dataIndex="GMRQ"></div>
				<div header="产品" width="120" sortable="true"  align="center" dataIndex="CP"  align="center"></div>
				<div header="积分" width="120" sortable="true" align="center" dataIndex="JF"></div>
				<div header="到期日期" width="120" sortable="true" align="center" dataIndex="DQRQ"></div>
				<div header="备注说明" width="330" sortable="true" align="center" dataIndex="BZSM"></div>
			</div>
	  </div>
	</div>
<!--历史成交记录window结束 -->
</body>
</html>

