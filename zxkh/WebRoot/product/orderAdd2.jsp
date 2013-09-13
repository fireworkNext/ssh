<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   orderAdd.jsp
'** 实现功能：   添加订单
'** 设计人员：   Enjsky
'** 设计日期：   2010-03-20
'*******************************
*/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ELEMENT>
<head>
<title>添加订单</title>
<link rel="stylesheet" type="text/css" href="../css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="../css/efs-all.css" />
<script type="text/javascript" src="../js/loadmask.js"></script>
<script type="text/javascript" src="../js/efs-all.js"></script>
<SCRIPT language="JavaScript">
<!--
Efs.onReady(
  function(){ 
    Efs.getDom("mgStore").txtXML = Efs.Common.getQryXml();
    Efs.getExt("mgGrid").store.load();
  }
);

// 提交信息
function doSubmit()
{
  if(!Efs.getExt("frmPost").isValid())
    return false;
  
  var opObj = Efs.Common.getOpXml(Efs.getExt("frmPost"),true);
  
  var oListXml = Efs.getExt("mgGrid").getDelXml();
  if(oListXml.length < 22)
  {
    alert("必须选择一个商品");
    return false;
  }
  
  var objXML = Efs.Common.createDocument(oListXml);
    
  objXML.documentElement.appendChild(opObj.selectSingleNode("//ORDERLIST"));
  // seeXML(objXML.xml);
  
  Efs.getExt("frmPost").submit(objXML.xml);
}

function seeXML(sXML)
{
  var w = window.open("");
  w.document.write("<xmp>" + sXML + "</xmp>");
}

function frmPostSubBack(bln,from,action)
{
  if(bln)
  {
    location.href="orderList.jsp";
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

function doRet()
{
  history.back();
}
//-->
</SCRIPT>
</HEAD>
<BODY>
<div xtype="panel" region="north" height="132" iconCls="icon-add" title="添加订单" border="false" buttonAlign="center" autoScroll="true">
  <form id="frmPost" class="efs-box" method="post" url="<%=rootPath%>/ajax?method=ordAdd2" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
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
      <input type="hidden" kind="text" fieldname="ORDERLIST/ORDERID" operation="0">
  </form>
</div>

<div id="mgGrid" region="center" border="false" xtype="grid" iconCls="icon-panel" title="商品列表" pagingBar="true" pageSize="9999" buttonAlign="center">
  <div id="mgStore" xtype="store" url="<%=rootPath%>/ajax?method=getProList" txtXML="" autoLoad="false">
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
   <div xtype="buttons">
      <div text="确  定" onEfsClick="doSubmit()"></div>
      <div text="返  回" onEfsClick="doRet()"></div>      
   </div>
</div>

</BODY>
</HTML>