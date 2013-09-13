<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：  yeartot.jsp
'** 实现功能：   年终奖汇总信息
'** 设计人员：   gwd
'** 设计日期：   2012-12-15
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
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
  String sYear = request.getParameter("year");
  if(General.empty(sYear))
	  sYear=General.curYear4();
  UserLogonInfo userSession = (UserLogonInfo)session.getAttribute("user");
  int i=0;

  String sColor="#FFFFFF";//表格隔色显示颜色参数
  DecimalFormat df = new DecimalFormat("##.00");
  ArrayList al4 = GzcxBO.getCxnd("yeardetailtpl",userSession);
  ArrayList al6 = GzcxBO.getSum("yeardetailtpl",userSession);
  //获取字段名
  ArrayList al1 = GzcxBO.getCurDbfld("yeartottpl",userSession);
  //获取字段显示名称
  ArrayList al2 = GzcxBO.getCurFldname("yeartottpl",userSession);
  //获取字段显示宽度
  ArrayList al3 = GzcxBO.getCurFldwidth("yeartottpl",userSession);
  ArrayList al5 = GzcxBO.getNoShowDbfld("yeartottpl", userSession);

  String sNodeAry = JSON.toJSONString(al1);
  String sHeaderAry = JSON.toJSONString(al2);
  String sColmWidAry = JSON.toJSONString(al3);
  String sNoShowAry = JSON.toJSONString(al5);
%>
<html>
<head>
<base href="<%=basePath%>">
<title>年终奖汇总信息</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<script type="text/javascript" src="charts/FusionCharts.js"></script>
<script type="text/javascript">
var g_XML = Efs.Common.getQryXml();
var sWebRoot = '<%=rootPath%>';
var noShowAry = <%=sNoShowAry%>;

Efs.onReady(
  function(){	
	var nodeAry=<%=sNodeAry%>;
	var headerAry=<%=sHeaderAry%>;
	var colmWidAry=<%=sColmWidAry%>;
	
	createGrid(nodeAry,headerAry,colmWidAry);
	wageTot();
  }
);

function showCharts(){
	var chart = new FusionCharts("charts/FCF_Column3D.swf","chart1","500","360");
	Efs.getDom("sum").setAttribute("value",Efs.getExt("sum1").getValue());
	var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry1"));
	//通过ajax调用动态返回创建grid所需的信息
	Efs.Common.ajax("<%=rootPath%>/gzcx_getCharts.action?year="+Efs.getExt("cxnd").getValue(),strXml,function(succ,response,options){
    if(succ)    // 是否成功
    {
     	var returnJson = response.responseText;
     	chart.setDataXML(returnJson);
     	chart.render("chartId");
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
                       { record: 'ROW' },
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
    
  /// 以下写法是可行的，但是不是很直观，需要比较清楚extjs的列模式配置
    var strColum_Cfg = [];
    var j = 0;
    for(var i=0;i<headerAry.length;i++)
    {
    	if(!isExists(noShowAry,nodeAry[i])) {
      		strColum_Cfg[j] = {id: nodeAry[i], header: headerAry[i], width: colmWidAry[i], dataIndex: nodeAry[i], sortable: true};
      		j++;
    	}
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

function wageTot()
{
	if(Efs.getExt("cxnd").getValue()!=""){
		var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry"));
		Efs.getDom("list1").setAttribute("url","<%=rootPath%>/gzcx_getTotal.action?year="+Efs.getExt("cxnd").getValue());
		Efs.getDom("list1").setAttribute("txtXML",strXml);
		Efs.getExt("grid1").getStore().reload();	
	}
}

function onChart()
{
	showCharts();
	Efs.getExt("win1").show();
}

function doClose()
{
	Efs.getExt("win1").hide();
}

function doOk()
{
	showCharts();
}
</script>
</head>
<body>
<div region="north" height="60" title="年终奖汇总信息" collapsible="false">
<form id="frmQry"  method="post">
<table class="formAreaTop">
<tr>
	<td>年份:
	</td>
	<td>
		<select id="cxnd" name="cxnd" onEfsChange="" fieldname="YEAR">
        	<%
        		for (i=0;i<al4.size();i++)
        			out.println("<option value='"+al4.get(i).toString().substring(0,4)+"'>"+al4.get(i)+"</option>");
        	%>
      	</select>
	</td>
	<td>
		<input type="button" value="查 询" onClick="wageTot();" iconCls="icon-qry">
	</td>
	<td>
		<input type="button" value="图表展示" onClick="onChart();" iconCls="icon-excel">
	</td>
</tr>
</table>
	<input type="hidden" name="tpl" fieldname="TPL" value="yeartottpl"/>
	<input type="hidden" name="tpl" fieldname="TPLDETAIL" value="yeardetailtpl"/>
</form>
</div>
<div id="grid1" region="center" xtype="grid" pagingBar="true" pageSize="25" buttonAlign="center">
	<div id="list1" xtype="store" url="<%=rootPath%>/gzcx_getTotal.action" baseParams="{txtXML:g_XML}" autoLoad="false">
		<div xtype="xmlreader" record="ROW" totalRecords="QUERYINFO@records">
		</div>
	</div>
	<div xtype="colmodel">
		<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
    	<div header="1"sortable="true" menuDisabled="true" dataIndex="" hidden="true"></div>
	</div>
</div>
<!-- window开始 -->
<div iconCls="icon-panel" id="win1" xtype="window" width="720" height="440" title="图表展示窗口" resizable="true" modal="true">
  <div region="west" xtype="panel" title="" width="200" border="false" autoScroll="true">
	<form id="frmQry1"  method="post">
	<table class="formAreaTop">
	<tr>
		<td>项目:
		</td>
		<td>
			<select id="sum1" name="sum1" onEfsChange="">
	        	<%
	        		for (i=0;i<al6.size();i++){
	        			String strTmp = al6.get(i).toString();
	        			out.println("<option value='"+strTmp+"'>"+strTmp.substring(strTmp.indexOf('|')+1)+"</option>");
	        		}
	        	%>
	      	</select>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>
			<input type="button" value="确  定" onClick="doOk();" iconCls="icon-ok">
		</td>
	</tr>
	</table>
	<input type="hidden" name="tpl" fieldname="TPL" value="yeartottpl"/>
	<input type="hidden" name="tpl" fieldname="TPLDETAIL" value="yeardetailtpl"/>
	<input type="hidden" id="sum" name="sum" fieldname="SUM"/>
	</form>
  </div>
  <div region="center" xtype="panel" title="" border="false" autoScroll="true">
    	<div id="chartId" align="right"></div>
    </div>
</div>
<!-- window结束 -->
</body>
<div style="display:none">
<xml id="gridData">
</xml>
</div>
</html>
