<%@ page language="java" import="org.ptbank.cache.*" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   qryProList.jsp
'** 实现功能：   查询订单列表
'** 设计人员：   Enjsky
'** 设计日期：   2010-03-17
'*******************************
*/
%>
<%
UserLogonInfo userSession = (UserLogonInfo)request.getSession().getAttribute("user");
%>
<HTML>
<head>
<title>查询订单列表</title>
<link rel="stylesheet" type="text/css" href="../css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="../css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="../js/efs-all.js"></script>

<SCRIPT language="JavaScript">
Efs.onReady(
  function(){	
      doQry();  
  }
);

function doQry()
{
	Efs.getDom("mgStore").txtXML = Efs.Common.getQryXml(Efs.getExt("frmQry"));
  Efs.getExt("mgGrid").store.load();
}

var sOrderID = "";
function doGridClick(data)
{
  sOrderID = data["ORDERID"];
  Efs.getExt("cmdEdit").enable();
  Efs.getExt("cmdDel").enable();
  
}

function doEdit()
{
  if(sOrderID != "")
  {
    Efs.getExt("OrdWin").show();

    //参数1：请求地址,参数2：sClassesID将会放在txtXML参数提交 ，参数3：回调函数
    Efs.Common.ajax("<%=rootPath%>/ajax?method=getOrdDetail",sOrderID,function(succ,response,options){
       if(succ){ // 是否成功
         var xmlReturnDoc = response.responseXML;
        
         Efs.Common.setEditValue(xmlReturnDoc.xml,Efs.getExt("frmData"), "QUERYINFO");
         Efs.getExt("OrdWin").setTitle("修改订单");
        
         Efs.getDom("pStore").txtXML = Efs.Common.getQryXml();
         Efs.getExt("pGrid").store.load();
        
       }
       else{
        alert("加载数据失败!");
       }
    });
    
  }
  else
  {
    alert("请选择一个要修改的订单");
  }
}

function onProReady()
{
  Efs.Common.ajax("<%=rootPath%>/ajax?method=getOrdProList",sOrderID,function(succ,response,options){
     if(succ){ // 是否成功
        var xmlReturnDoc = response.responseXML;
        
        var seG = Efs.getExt("pGrid").getSelectionModel();
        seG.clearSelections();
        
        for(var i=0;i<Efs.getExt("pGrid").getStore().getCount();i++)
        {
          var sPid = Efs.getExt("pGrid").getStore().getAt(i).data["PID"];
          
          if(hasPid(xmlReturnDoc,sPid))
          {
            seG.selectRow(i,true);
          }
        }
     }
     else{
      alert("加载数据失败!");
     }
  });
}

function hasPid(objXML,pid)
{
  try
  {
    var node = objXML.selectSingleNode("//ROW[PID='" + pid + "']");    
    if(node != null)
      return true;
    else
      return false;
  }
  catch(e)
  {
    return false;
  }
}

function seeXML(sXML)
{
  var w = window.open("");
  w.document.write("<xmp>" + sXML + "</xmp>");
}


function doEditSub()
{
  if(!Efs.getExt("frmData").isValid())
    return false;
  
  Efs.getDom("frmData").url="<%=rootPath%>/ajax?method=ordEdit" ;

  var opObj = Efs.Common.getOpXml(Efs.getExt("frmData"),true);
  
  var oListXml = Efs.getExt("pGrid").getDelXml();
  
  var objXML = Efs.Common.createDocument(oListXml);
    
  objXML.documentElement.appendChild(opObj.selectSingleNode("//ORDERLIST"));
  // seeXML(objXML.xml);
  
  Efs.getExt("frmData").submit(objXML.xml);
}


// 获取异步提交的返回监听函数
function frmPostSubBack(bln,from,action)
{
  
  if(bln)
  {
    Efs.getExt("OrdWin").hide();
    Efs.getExt("mgGrid").store.reload();
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

function doDel()
{
  Efs.getDom("frmData").url="<%=rootPath%>/ajax?method=ordDel" ;
  Efs.getExt("frmData").submit(sOrderID);
}

</SCRIPT>
</HEAD>
<BODY>

<div iconCls="icon-panel" region="north" height="60" title="查询订单列表" border="false">
 <form id="frmQry"  method="post">
  <TABLE class="formAreaTop" width="100%" height="100%" cellpadding="0" cellspacing="0">
      <tr>
        <td>&nbsp;</td>
        <td width="60">起始时间</td>
        <td width="160"><input type="text" class="Edit" kind="date" fieldname="TO_CHAR(ORDERDATE,'YYYYMMDD')" operation="&gt;="></td>
        <td width="60">结束时间</td>
        <td width="160"><input type="text" class="Edit" kind="date" fieldname="TO_CHAR(ORDERDATE,'YYYYMMDD')" operation="&lt;="></td>
        <td width="40">下单人</td>
        <td width="160"><input type="text" class="Edit" kind="text" fieldname="ORDERPSN" operation="like"></td>
        <td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry()"></td>
        <td>&nbsp;</td>
      </tr>
    </TABLE>
  </form>
</div>

<div id="mgGrid" region="center" border="false" xtype="grid" iconCls="icon-panel" title="订单列表" pagingBar="true" pageSize="25" onEfsRowClick="doGridClick()" onEfsRowDblClick="doEdit()">
	<div xtype="tbar">
    <div text="->"></div>
<%
if(UserCache.getUserRightByEvent(userSession.getUserID(),"400205"))
{
%>    
    <div iconCls="icon-edit" id="cmdEdit" text="修改订单" disabled onEfsClick="doEdit()"></div>
    <div text="-"></div>
<%
}
else
{
%>
    <div iconCls="icon-edit" id="cmdEdit" text="修改订单" disabled onEfsClick="doEdit()" hidden="true"></div>
<%
}
if(UserCache.getUserRightByEvent(userSession.getUserID(),"400206"))
{
%>    
    <div iconCls="icon-del" id="cmdDel" text="删除订单" disabled onEfsClick="doDel()"></div>
<%
}
else
{
%>    
    <div iconCls="icon-del" id="cmdDel" text="删除订单" disabled onEfsClick="doDel()" hidden="true"></div>
<%
}
%>        
  </div>
  <div id="mgStore" xtype="store" url="<%=rootPath%>/ajax?method=getOrdList" txtXML="" autoLoad="false">
		<div xtype="xmlreader" fieldid="ORDERID" record="ROW" tabName="ORDERLIST">
			<div name="ORDERID"></div>
			<div name="ORDERPSN"></div>
			<div name="ORDERDATE"></div>
      <div name="ORDERTITLE"></div>
      <div name="CUSNAME"></div>
      <div name="CUSUNIT"></div>
		</div>
	</div>
	<div xtype="colmodel">
		<div type="radio"></div>
		<div header="下单人" width="120" sortable="true" dataIndex="ORDERPSN" align="center"></div>
		<div header="下单日期" width="100" sortable="true" dataIndex="ORDERDATE" align="center"></div>
    <div header="订单名称" width="100" sortable="true" dataIndex="ORDERTITLE" align="center"></div>
    <div header="客户名称" width="100" sortable="true" dataIndex="CUSNAME" align="center"></div>
    <div header="客户单位" width="100" sortable="true" dataIndex="CUSUNIT" align="center"></div>
	</div>
</div>

<!-- window开始 -->
<div iconCls="icon-panel" id="OrdWin" xtype="window" width="560" height="500" title="修改订单" resizable="true" modal="true">
  <div region="north" height="135">
    <div region="center" xtype="panel" title="" border="false" autoScroll="true">
      <div xtype="tbar">
        <div text="->"></div>
        <div iconCls="icon-ok2" id="cmdOK" text="确  定" onEfsClick="doEditSub()"></div>
      </div>
      <form id="frmData" class="efs-box" method="post" url="<%=rootPath%>/ajax?method=ordEdit" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
        <TABLE class="formArea">
          <tr>
            <td labelFor="orderpsn">下单人</td>
            <td><input type="text" kind="text" fieldname="ORDERLIST/ORDERPSN" id="orderpsn" must="true"></td>
            <td>&nbsp;</td>
            <td labelFor="orderdate">下单时间</td>
            <td><input type="text" kind="date" datatype="3" fieldname="ORDERLIST/ORDERDATE" id="orderdate" must="true"></td>
          </tr>
          <tr>
            <td labelFor="ordertitle">订单名称</td>
            <td colspan="4"><input type="text" style="width:360px;" kind="text" fieldname="ORDERLIST/ORDERTITLE" id="ordertitle" must="true"></td>
          </tr>
          <tr>
            <td>客户名称</td>
            <td><input type="text" kind="text" fieldname="ORDERLIST/CUSNAME"></td>
            <td>&nbsp;</td>
            <td>客户单位</td>
            <td><input type="text" kind="text" fieldname="ORDERLIST/CUSUNIT"></td>
          </tr>
        </TABLE>
        <input type="hidden" kind="text" fieldname="ORDERLIST/ORDERID" operation="1" state="5">
      </form>            
    </div>
  </div>
  
  <div id="pGrid" region="center" border="false" xtype="grid" iconCls="icon-panel" title="商品列表" pagingBar="true" pageSize="9999" buttonAlign="center">
    <div id="pStore" xtype="store" url="<%=rootPath%>/ajax?method=getProList" txtXML="" autoLoad="false" onEfsLoad="onProReady()">
      <div xtype="xmlreader" fieldid="PID" record="ROW" tabName="ORDPRO">
        <div name="PID"></div>
        <div name="PTYPE"></div>
        <div name="PNAME"></div>
        <div name="PRICE"></div>
        <div name="PNUM"></div>
      </div>
    </div>
    <div xtype="colmodel">
      <div type="checkbox"></div>
      <div header="商品编号" width="80" sortable="true" dataIndex="PID" align="center"></div>
      <div header="商品类型" width="120" sortable="true" kind="dic" src="DIC_PTYPE" dataIndex="PTYPE" align="center"></div>
      <div header="商品名称" width="100" sortable="true" dataIndex="PNAME" align="center"></div>
      <div header="商品价格" width="100" sortable="true" dataIndex="PRICE" align="center"></div>
      <div header="商品数量" width="100" sortable="true" dataIndex="PNUM" align="center"></div>
    </div>
  </div>
</div>
<!-- window结束 -->

</BODY>
</HTML>

