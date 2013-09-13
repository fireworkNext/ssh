<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   report.jsp
'** 实现功能：   统计报表
'** 设计人员：   gwd
'** 设计日期：   2011-05-08
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
<title>统计报表</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>

<SCRIPT language="JavaScript">
var g_XML = Efs.Common.getQryXml();
var sSfzhm = "";
var sYear = "";
var sMonth = "";
var sMesg = "";

function doQry1()
{
	if(Efs.getExt("frmQry1").isValid()){
		if(Efs.getExt("forissee1").getValue()=="0"){
			Efs.getDom("see_dt1").setAttribute("ignore","true");
		}
		else if(Efs.getExt("forissee1").getValue()=="1")
		{
			Efs.getDom("see_dt1").setAttribute("ignore","false");
			Efs.getDom("see_dt1").setAttribute("operation","is not");
			Efs.getDom("see_dt1").setAttribute("value","null");
		}else {
			Efs.getDom("see_dt1").setAttribute("ignore","false");
			Efs.getDom("see_dt1").setAttribute("operation","is");
			Efs.getDom("see_dt1").setAttribute("value","null");
		}
		var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry1"));
		Efs.getDom("list1").txtXML = strXml;
		Efs.getExt("grid1").store.reload();
		Efs.getExt("cmdEditAll1").enable();
		Efs.getExt("cmdExportExcel1").enable();
	}
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

function onEditAllEx1()
{
	Efs.getDom("mesg1").setAttribute("value",sMesg);
	Efs.getDom("type1").setAttribute("value","2");
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
	sYear = data["YEAR"]
	sMonth = data["MONTH"]
	sMesg = data["MESG"];
	          	            
	if(sSfzhm != ""){
		Efs.getExt("cmdEdit1").enable();
    	//Efs.getExt("cmdEditAll1").enable();
	}
}

function doQry2()
{
	if(Efs.getExt("frmQry2").isValid()){
		if(Efs.getExt("forissee2").getValue()=="0"){
			Efs.getDom("see_dt2").setAttribute("ignore","true");
		}
		else if(Efs.getExt("forissee2").getValue()=="1")
		{	
			Efs.getDom("see_dt2").setAttribute("ignore","false");
			Efs.getDom("see_dt2").setAttribute("operation","is not");
			Efs.getDom("see_dt2").setAttribute("value","null");
		}else {
			Efs.getDom("see_dt2").setAttribute("ignore","false");
			Efs.getDom("see_dt2").setAttribute("operation","is");
			Efs.getDom("see_dt2").setAttribute("value","null");
		}
		var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry2"));
		Efs.getDom("list2").txtXML = strXml;
		Efs.getExt("grid2").store.reload();
		Efs.getExt("cmdEditAll2").enable();
	}
}

function onEditEx2()
{
	Efs.getDom("mesg1").setAttribute("value",sMesg);
	Efs.getDom("type1").setAttribute("value","1");
	Efs.getDom("sfzhm1").setAttribute("value",sSfzhm);
	Efs.getDom("year1").setAttribute("value",sYear);
	Efs.getDom("month1").setAttribute("value",sMonth);
	Efs.getDom("wage1").setAttribute("value","2");
	with(Efs.getExt("win1"))
	{
		setTitle("修改相关费用说明");
		show();
	}
}

function onEditAllEx2()
{
	Efs.getDom("mesg1").setAttribute("value",sMesg);
	Efs.getDom("type1").setAttribute("value","2");
	Efs.getDom("sfzhm1").setAttribute("value",sSfzhm);
	Efs.getDom("year1").setAttribute("value",sYear);
	Efs.getDom("month1").setAttribute("value",sMonth);
	Efs.getDom("wage1").setAttribute("value","2");
	with(Efs.getExt("win1"))
	{
		setTitle("修改相关费用说明");
		show();
	}
}

function onExportExcelEx1()
{
	var url="<%=rootPath%>/gzcx/gzcx_excel.jsp?year="+Efs.getDom("foryear1").value+"&month="+Efs.getDom("formonth1").value+"&sfzhm="+Efs.getDom("forsfzhm1").value+"&name="+Efs.getDom("forname1").value+"&issee="+Efs.getExt("forissee1").getValue();
	//alert(url);
	window.location.href=url;
}

function doGridClick2(data){
	sSfzhm = data["SFZHM"]
	sYear = data["YEAR"]
	sMonth = data["MONTH"]
	sMesg = data["MESG"];
	          	            
	if(sSfzhm != ""){
		Efs.getExt("cmdEdit2").enable();
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

// 获取异步提交的返回监听函数
function frmPostSubBack1(bln,from,action)
{
  if(bln)
  {
      Efs.getExt("win1").hide();
      if(Efs.getDom("wage1").getAttribute("value")=="1"){
      	Efs.getExt("grid1").store.load();
      }
      else {
        Efs.getExt("grid2").store.load();
      }
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

<div id="tab" region="center" buttonAlign="center" xtype="tabpanel" region="center" border="false" title="费用说明维护">
	<div id="tab1" title="工资统计">	
		<div xtype="panel" region="north" height="80" iconCls="icon-add" title="查询条件" border="false" buttonAlign="center" autoScroll="true">
		  <form id="frmQry1" method="post" >
		      <TABLE class="formAreaTop">
		        <tr>
		          <td labelFor="foryear1">年度</td>
		          <td><input type="text" kind="text" fieldname="YEAR" must="true" id="foryear1"></td>
		          <td labelFor="formonth1">月份</td>
		          <td><input type="text" kind="text" fieldname="MONTH" must="true" id="formonth1"></td>
		          <td labelFor="forsfzhm1">身份证号</td>
		          <td><input type="text" kind="text" fieldname="SFZHM" id="forsfzhm1"></td>
		        </tr>
		        <tr>
		          <td labelFor="forname1">姓名</td>
		          <td><input type="text" kind="text" fieldname="NAME" operation="like" hint="模糊查询" id="forname1"></td>
		          <td labelFor="forissee1">是否查看</td>
		          <td><select id="forissee1" name="forissee1" fieldname="ISSEE"><option value="0">全部</option><<option value="1">已查看</option><option value="2">未查看</option></select></td>
	        	  <td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry1()"></td>
	        	  <td>&nbsp;</td>
		        </tr>
		      </TABLE>
		      <input type="hidden" id="see_dt1" name="see_dt1" fieldname="SEE_DT" operation=""/>
		  </form>
		</div>
		<div iconCls="icon-panel" id="grid1" region="center" xtype="grid" title="" pagingBar="true" pageSize="20" onEfsRowClick="doGridClick1()" onEfsRowDblClick="onEditEx1()" buttonAlign="center">
		  <div xtype="tbar">
		    <span style="font-size:9pt;font-weight:bold;color:#15428B;">工资信息列表</span>
		    <div text="->"></div>
		    <div iconCls="icon-edit" id="cmdEdit1" text="修改单个#E" onEfsClick="onEditEx1()" disabled="disabled"></div>
		    <div iconCls="icon-del" id="cmdEditAll1" text="修改全部#D" onEfsClick="onEditAllEx1()" disabled="disabled"></div>
		    <div iconCls="icon-excel" id="cmdExportExcel1" text="导出到excel#P" onEfsClick="onExportExcelEx1()" disabled="disabled"></div>
		  </div>
			<div id="list1" xtype="store" url="<%=rootPath%>/gzcx_getWageList.action" baseParams="{txtXML:g_XML}" autoLoad="false">
				<div xtype="xmlreader" fieldid="" tabName="T_WAGE_DETAIL" record="ROW" totalRecords="QUERYINFO@records">
					<div name="YEAR"></div>
					<div name="MONTH"></div>
					<div name="DWMC"></div>
					<div name="BMMC"></div>
					<div name="SFZHM"></div>
					<div name="NAME"></div>
					<div name="MESG"></div>
					<div name="SEE_DT"></div>
					<div name="SEE_TM"></div>
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
					<div name="SAL16"></div>
					<div name="SAL17"></div>
					<div name="SAL18"></div>
					<div name="SAL19"></div>
					<div name="SAL20"></div>
					<div name="SAL21"></div>
					<div name="SAL22"></div>
					<div name="SAL23"></div>
					<div name="SAL24"></div>
					<div name="SAL25"></div>
					<div name="SAL26"></div>
					<div name="SAL27"></div>
					<div name="SAL28"></div>
					<div name="SAL29"></div>
					<div name="SAL30"></div>
					<div name="SAL31"></div>
					<div name="SAL32"></div>
					<div name="SAL33"></div>
					<div name="SAL34"></div>
					<div name="SAL35"></div>
					<div name="SAL36"></div>
					<div name="SAL37"></div>
					<div name="SAL38"></div>
					<div name="SAL39"></div>
					<div name="SAL40"></div>
				</div>
			</div>
			<div xtype="colmodel">
				<div header="年度" width="40" sortable="true" dataIndex="YEAR" align="center"></div>
				<div header="月份" width="40" sortable="true" dataIndex="MONTH" align="center"></div>
				<div header="部门名称" width="100" sortable="true" dataIndex="BMMC" align="center"></div>
				<div header="身份证号码" width="120" sortable="true" dataIndex="SFZHM" align="center"></div>
				<div header="姓名" width="100" sortable="true" dataIndex="NAME" align="center"></div>
				<div header="查看日期" width="60" sortable="true" dataIndex="SEE_DT" align="center"></div>
				<div header="查看时间" width="60" sortable="true" dataIndex="SEE_TM" align="center"></div>
				<div header="应发小计" width="60" sortable="true" dataIndex="SAL1" align="center"></div>
				<div header="应扣小计" width="60" sortable="true" dataIndex="SAL2" align="center"></div>
				<div header="实发小计" width="60" sortable="true" dataIndex="SAL3" align="center"></div>
				<div header="岗位工资" width="60" sortable="true" dataIndex="SAL4" align="center"></div>
				<div header="补发(扣)基本工资" width="60" sortable="true" dataIndex="SAL5" align="center"></div>
				<div header="专业技术职称津贴" width="60" sortable="true" dataIndex="SAL6" align="center"></div>
				<div header="职业资格等级津贴" width="60" sortable="true" dataIndex="SAL7" align="center"></div>
				<div header="综合补贴" width="60" sortable="true" dataIndex="SAL8" align="center"></div>
				<div header="班组长津贴" width="60" sortable="true" dataIndex="SAL9" align="center"></div>
				<div header="女工补贴(福利)" width="60" sortable="true" dataIndex="SAL10" align="center"></div>
				<div header="午餐补贴(单列)" width="60" sortable="true" dataIndex="SAL11" align="center"></div>
				<div header="交通补贴(单列)" width="60" sortable="true" dataIndex="SAL12" align="center"></div>
				<div header="其它工资" width="60" sortable="true" dataIndex="SAL13" align="center"></div>
				<div header="外勤津贴" width="60" sortable="true" dataIndex="SAL14" align="center"></div>
				<div header="其它1" width="60" sortable="true" dataIndex="SAL15" align="center"></div>
				<div header="其它2" width="60" sortable="true" dataIndex="SAL16" align="center"></div>
				<div header="代扣个税" width="60" sortable="true" dataIndex="SAL17" align="center"></div>
				<div header="五险一金" width="60" sortable="true" dataIndex="SAL18" align="center"></div>
				<div header="代扣水电" width="60" sortable="true" dataIndex="SAL19" align="center"></div>
				<div header="其它代扣款" width="60" sortable="true" dataIndex="SAL20" align="center"></div>
				<div header="内退生活费" width="60" sortable="true" dataIndex="SAL21" align="center"></div>
				<div header="费用说明" width="100" sortable="true" dataIndex="MESG" align="center"></div>
			</div>
		</div>
	</div>
	<div id="tab2" title="月奖统计">	
		<div xtype="panel" region="north" height="80" iconCls="icon-add" title="查询条件" border="false" buttonAlign="center" autoScroll="true">
		  <form id="frmQry2" method="post" >
		      <TABLE class="formAreaTop">
		        <tr>
		          <td labelFor="foryear2">年度</td>
		          <td><input type="text" kind="text" fieldname="YEAR" must="true" id="foryear2"></td>
		          <td labelFor="formonth2">月份</td>
		          <td><input type="text" kind="text" fieldname="MONTH" must="true" id="formonth2"></td>
		          <td labelFor="forsfzhm2">身份证号</td>
		          <td><input type="text" kind="text" fieldname="SFZHM" id="forsfzhm2"></td>
		        </tr>
		        <tr>
		          <td labelFor="forname2">姓名</td>
		          <td><input type="text" kind="text" fieldname="NAME" operation="like" hint="模糊查询" id="forname2"></td>
		          <td labelFor="forissee2">是否查看</td>
		          <td><select id="forissee2" name="forissee2" fieldname="ISSEE"><option value="0">全部</option><option value="1">已查看</option><option value="2">未查看</option></select></td>
	        	  <td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry2()"></td>
	        	  <td>&nbsp;</td>
		        </tr>
		      </TABLE>
		      <input type="hidden" id="see_dt2" name="see_dt2" fieldname="SEE_DT" operation=""/>
		  </form>
		</div>
		<div iconCls="icon-panel" id="grid2" region="center" xtype="grid" title="" pagingBar="true" pageSize="20" onEfsRowClick="doGridClick2()" onEfsRowDblClick="onEditEx2()" buttonAlign="center">
		  <div xtype="tbar">
		    <span style="font-size:9pt;font-weight:bold;color:#15428B;">月奖信息列表</span>
		    <div text="->"></div>
		    <div iconCls="icon-edit" id="cmdEdit2" text="修改单个#E" onEfsClick="onEditEx2()" disabled="disabled"></div>
		    <div iconCls="icon-del" id="cmdEditAll2" text="修改全部#D" onEfsClick="onEditAllEx2()" disabled="disabled"></div>  
		  </div>
			<div id="list2" xtype="store" url="<%=rootPath%>/gzcx_getPrizeList.action" baseParams="{txtXML:g_XML}" autoLoad="false">
				<div xtype="xmlreader" fieldid="" tabName="T_PRIZE_DETAIL" record="ROW" totalRecords="QUERYINFO@records">
					<div name="YEAR"></div>
					<div name="MONTH"></div>
					<div name="BMMC"></div>
					<div name="SFZHM"></div>
					<div name="NAME"></div>
					<div name="MESG"></div>
					<div name="SEE_DT"></div>
					<div name="SEE_TM"></div>
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
					<div name="SAL16"></div>
					<div name="SAL17"></div>
					<div name="SAL18"></div>
					<div name="SAL19"></div>
					<div name="SAL20"></div>
					<div name="SAL21"></div>
					<div name="SAL22"></div>
					<div name="SAL23"></div>
					<div name="SAL24"></div>
					<div name="SAL25"></div>
					<div name="SAL26"></div>
					<div name="SAL27"></div>
					<div name="SAL28"></div>
					<div name="SAL29"></div>
					<div name="SAL30"></div>
					<div name="SAL31"></div>
					<div name="SAL32"></div>
					<div name="SAL33"></div>
					<div name="SAL34"></div>
					<div name="SAL35"></div>
					<div name="SAL36"></div>
					<div name="SAL37"></div>
					<div name="SAL38"></div>
					<div name="SAL39"></div>
					<div name="SAL40"></div>
				</div>
			</div>
			<div xtype="colmodel">
				<div header="年度" width="40" sortable="true" dataIndex="YEAR" align="center"></div>
				<div header="月份" width="40" sortable="true" dataIndex="MONTH" align="center"></div>
				<div header="部门名称" width="100" sortable="true" dataIndex="BMMC" align="center"></div>
				<div header="身份证号码" width="120" sortable="true" dataIndex="SFZHM" align="center"></div>
				<div header="姓名" width="100" sortable="true" dataIndex="NAME" align="center"></div>
				<div header="查看日期" width="60" sortable="true" dataIndex="SEE_DT" align="center"></div>
				<div header="查看时间" width="60" sortable="true" dataIndex="SEE_TM" align="center"></div>
				<div header="应发小计" width="60" sortable="true" dataIndex="SAL1" align="center"></div>
				<div header="应扣小计" width="60" sortable="true" dataIndex="SAL2" align="center"></div>
				<div header="实发小计" width="60" sortable="true" dataIndex="SAL3" align="center"></div>
				<div header="月奖" width="60" sortable="true" dataIndex="SAL4" align="center"></div>
				<div header="补发(扣)月奖" width="60" sortable="true" dataIndex="SAL5" align="center"></div>
				<div header="加班工资" width="60" sortable="true" dataIndex="SAL6" align="center"></div>
				<div header="夜班津贴" width="60" sortable="true" dataIndex="SAL7" align="center"></div>
				<div header="金融竞赛奖" width="60" sortable="true" dataIndex="SAL8" align="center"></div>
				<div header="函件竞赛奖" width="60" sortable="true" dataIndex="SAL9" align="center"></div>
				<div header="电商竞赛奖" width="60" sortable="true" dataIndex="SAL10" align="center"></div>
				<div header="集邮竞赛奖" width="60" sortable="true" dataIndex="SAL11" align="center"></div>
				<div header="报刊发行竞赛奖" width="60" sortable="true" dataIndex="SAL12" align="center"></div>
				<div header="保险奖励" width="60" sortable="true" dataIndex="SAL13" align="center"></div>
				<div header="其它奖励" width="60" sortable="true" dataIndex="SAL14" align="center"></div>
				<div header="季度奖" width="60" sortable="true" dataIndex="SAL15" align="center"></div>
				<div header="其它1" width="60" sortable="true" dataIndex="SAL16" align="center"></div>
				<div header="其它2" width="60" sortable="true" dataIndex="SAL17" align="center"></div>
				<div header="其它3" width="60" sortable="true" dataIndex="SAL18" align="center"></div>
				<div header="代扣个税" width="60" sortable="true" dataIndex="SAL19" align="center"></div>
				<div header="其它代扣款" width="60" sortable="true" dataIndex="SAL20" align="center"></div>
				<div header="费用说明" width="100" sortable="true" dataIndex="MESG" align="center"></div>
			</div>
		</div>
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
        <td class="label">费用说明：</td>
        <td><textarea id="mesg1" name="mesg1" class="Edit" style="width:500px;height:80px;" kind="text" maxlength="2000" fieldname="T_WAGE_DETAIL/MESG" name="mesg" id="mesg"  must="true" operation="1" writeevent="0" state="0" datatype="0"></textarea></td>      
      </tr>
    </TABLE>
    <input type="hidden" id="type1" name="type1" fieldname="T_WAGE_DETAIL/TYPE"/>
    <input type="hidden" id="sfzhm1" name="sfzhm1" fieldname="T_WAGE_DETAIL/SFZHM"/>
    <input type="hidden" id="year1" name="year1" fieldname="T_WAGE_DETAIL/YEAR"/>
    <input type="hidden" id="month1" name="month1" fieldname="T_WAGE_DETAIL/MONTH"/>
    <input type="hidden" id="wage1" name="wage1" fieldname="T_WAGE_DETAIL/WAGE"/>
    </form>
  </div>
</div>
<!-- window结束 -->
</BODY>
</HTML>

