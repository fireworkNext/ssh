<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：  wagedetail.jsp
'** 实现功能：   工资汇总信息
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
  ArrayList al4 = GzcxBO.getCxndyf("wagedetailtpl",userSession);
  ArrayList al1 = GzcxBO.getCurDbfld("wagedetailtpl",userSession);
  ArrayList al2 = GzcxBO.getCurFldname("wagedetailtpl",userSession);
  ArrayList al3 = GzcxBO.getCurFldwidth("wagedetailtpl",userSession);
  ArrayList al5 = GzcxBO.getNoShowDbfld("wagedetailtpl", userSession);
  
  String sNodeAry = JSON.toJSONString(al1);
  String sHeaderAry = JSON.toJSONString(al2);
  String sColmWidAry = JSON.toJSONString(al3);
  String sNoShowAry = JSON.toJSONString(al5);
%>
<html>
<head>
<base href="<%=basePath%>">
<title>工资发放明细</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<script type="text/javascript">
var g_XML = Efs.Common.getQryXml();
var sWebRoot = '<%=rootPath%>';
var sSfzhm = "";
var noShowAry = <%=sNoShowAry%>;
var zeroAry = [];

Efs.onReady(
	function(){
		Ext.Ajax.timeout = 90000;
		Ext.data.Connection.prototype.timeout='9000';
		//按当前模版信息初始化grid
		var nodeAry=<%=sNodeAry%>;
		var headerAry=<%=sHeaderAry%>;
		var colmWidAry=<%=sColmWidAry%>;
		createGrid(nodeAry,headerAry,colmWidAry,zeroAry);
	}
);

function initGrid(griddata)
{
	//按当前模版信息初始化grid
	var nodeAry=griddata.nodeAry;
	var headerAry=griddata.headerAry;
	var colmWidAry=griddata.colmWidAry;
	var zeroAry=griddata.zeroAry;
	createGrid(nodeAry,headerAry,colmWidAry,zeroAry);
}

// nodeAry 对应节点数组
// headerAry 对应列表头数组
// colmWidAry 对应没列宽数组
// zeroAry 对应明细为0的数组
function createGrid(nodeAry,headerAry,colmWidAry,zeroAry)
{
    // 设置XmlReader读取模式
    var m_reader = new Ext.data.XmlReader(
                       { record: 'ROW' },
                         nodeAry);
    Efs.getExt("grid1").getStore().reader = m_reader;
    
    // 获得grid的列模式
    var colModel = Efs.getExt("grid1").getColumnModel();
    
    // 先隐藏所有
    for(var i=0,l=colModel.getColumnCount()-1;i<l;i++)
    {
      colModel.setHidden(i+1,true);
    }

    /*for(var i=0;i<headerAry.length;i++)
    {
      colModel.setColumnHeader(i+1,headerAry[i]);
      colModel.setDataIndex(i+1,nodeAry[i]);
      colModel.setColumnWidth(i+1,colmWidAry[i]);
      colModel.setHidden(i+1,false);
    }*/
    
    // 以下写法是可行的，但是不是很直观，需要比较清楚extjs的列模式配置
    var strColum_Cfg = [];
    var j = 0;
    var sNoShowString=noShowAry.join();
    sNoShowString=","+sNoShowString+",";
    var sZeroString=zeroAry.join();
    sZeroString=","+sZeroString+",";
    for(var i=0,l=headerAry.length;i<l;i++)
    {
    	//if(!isExists(noShowAry,nodeAry[i])) {
    	if(sNoShowString.indexOf(","+nodeAry[i]+",")==-1) {
    		if(Efs.getDom("zeroflag").getAttribute("code")=="1"){
    			if(sZeroString.indexOf(","+nodeAry[i]+",")==-1){
      				strColum_Cfg[j] = {id: nodeAry[i], header: headerAry[i], width: colmWidAry[i], dataIndex: nodeAry[i], sortable: true};
      				j++;
    			}
    		}else{
    			strColum_Cfg[j] = {id: nodeAry[i], header: headerAry[i], width: colmWidAry[i], dataIndex: nodeAry[i], sortable: true};
  				j++;
    		}
    	}
    }
    colModel.setConfig(strColum_Cfg);
}

function isExists(arr,obj) 
{
	for(var i=0,l=arr.length;i<l;i++){
		if(arr[i]==obj)
			return true;
	}
	return false;
}

function wageDetail()
{
	var sCxnd = Efs.getExt("cxnd").getValue();
	if(sCxnd =="" || typeof sCxnd==undefined){
		return false;
	}
	var sYear = sCxnd.substr(0,4);
	var sMonth = sCxnd.substr(4,2);
	Efs.getDom("year").setAttribute("value",sYear);
	Efs.getDom("month").setAttribute("value",sMonth);
	var sZeroFlag = Efs.getDom("zeroflag").getAttribute("code");
	
	//通过ajax调用动态返回创建grid所需的信息
	Efs.Common.ajax("<%=rootPath%>/gzcx_getCreateGridJson.action?tpl=wagedetailtpl"+"&cxnd="+sCxnd+"&zeroflag="+sZeroFlag,"",function(succ,response,options){
    if(succ)    // 是否成功
    {
     	var returnJson = eval("(" + response.responseText + ")");
     	initGrid(returnJson);
     	var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry"));
    	Efs.getDom("list1").setAttribute("url","<%=rootPath%>/gzcx_getSalaryList.action");
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
</script>
</head>

<body>
<div region="north" height="60" title="工资发放明细" collapsible="false">
<form id="frmQry"  method="post" action="wagedetail.jsp">
<table class="formAreaTop">
<tr>
	<td>年月:
	</td>
	<td>
		<select id="cxnd" name="cxnd" onEfsChange="">
        	<%
        		for (i=0;i<al4.size();i++)
        			out.println("<option value='"+al4.get(i).toString().substring(0,4)+al4.get(i).toString().substring(5,al4.get(i).toString().length()-1)+"'>"+al4.get(i)+"</option>");
        	%>
      	</select>
	</td>
	<td>是否过滤明细为0的字段:
	</td>
	<td>
		<input type="text" kind="dic" src="DIC_FLAG2" id="zeroflag" name="zeroflag" code="1" value="是"/>
	</td>
	<td>
		<input type="button" value="查 询" onClick="wageDetail();" iconCls="icon-qry">
	</td>
</tr>
</table>
	<input type="hidden" id="tpl" name="tpl" fieldname="TPL" value="wagedetailtpl"/>
	<input type="hidden" id="sfzhm" name="sfzhm" fieldname="SFZHM" value="<%=userSession.getIDCard()%>"/>
	<input type="hidden" id="year" name="year" fieldname="YEAR" />
	<input type="hidden" id="month" name="month" fieldname="MONTH" />
</form>
</div>
<div id="grid1" region="center" xtype="grid" pagingBar="true" pageSize="25" buttonAlign="center">
	<div id="list1" xtype="store" url="<%=rootPath%>/gzcx_getDetail.action" baseParams="{txtXML:g_XML}" autoLoad="false">
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
</body>
<div style="display:none">
<xml id="gridData">
</xml>
</div>
</html>
