<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   qryProList.jsp
'** 实现功能：   查询商品列表
'** 设计人员：   Enjsky
'** 设计日期：   2010-03-17
'*******************************
*/
%>
<HTML>
<head>
<title>查询商品列表</title>
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
var sPid = "";
function doGridClick(data)
{
  sPid = data["PID"];
  Efs.getExt("cmdEdit").enable();
  Efs.getExt("cmdDel").enable();
}

function doEdit()
{
  
}

function doEditSub()
{
  Efs.getExt("frmData").submit();
}


// 获取异步提交的返回监听函数
function frmPostSubBack(bln,from,action)
{
  
  if(bln)
  {
    Efs.getExt("ProWin").hide();
    doQry();
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
  Efs.getExt("frmData").submit(Efs.getExt("mgGrid").getDelXml());
}

var ProWin = false;
function doEdit2()
{
  if(!ProWin)
    Efs.Common.load("proField.jsp",loadOk);
  else
    loadOk();
}

function loadOk()
{
  ProWin = true;
  if(sPid != "")
  {
    Efs.getExt("ProWin").show();

    //参数1：请求地址,参数2：sClassesID将会放在txtXML参数提交 ，参数3：回调函数
    Efs.Common.ajax("<%=rootPath%>/ajax?method=getProDetail",sPid,function(succ,response,options){
       if(succ){ // 是否成功
        var xmlReturnDoc = response.responseXML;
        
        Efs.Common.setEditValue(xmlReturnDoc.xml,Efs.getExt("frmData"), "QUERYINFO");
        Efs.getExt("ProWin").setTitle("修改商品");
       }
       else{
        alert("加载数据失败!");
       }
    });
    
    Efs.getDom("frmData").url = "<%=rootPath%>/base.do?method=dealWithXml";
    
  }
  else
  {
    alert("请选择一个要修改的商品");
  }
}
</SCRIPT>
</HEAD>
<BODY>
<div xtype="panel" region="north" height="60" title="商品查询">
  <form id="frmQry"  method="post">
    <TABLE class="formAreaTop" width="100%" height="100%" cellpadding="0" cellspacing="0">
      <tr>
        <td>&nbsp;</td>
        <td width="60">商品名称</td>
        <td width="120"><input type="text" class="Edit" kind="text" fieldname="PNAME" operation="like" maxlength="30" hint="模糊查询"></td>
        <td width="60">商品类型</td>
        <td width="120"><input type="text" class="Edit" kind="dic" src="DIC_PTYPE" fieldname="PTYPE"></td>
        <td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry()"></td>
        <td>&nbsp;</td>
      </tr>
    </TABLE>
  </form>
</div>
<div id="mgGrid" region="center" border="false" xtype="grid" iconCls="icon-panel" title="商品列表" pagingBar="true" pageSize="25" onEfsRowClick="doGridClick()">
	<div xtype="tbar">
    <div text="->"></div>
    <div iconCls="icon-edit" id="cmdEdit" text="修改商品" disabled onEfsClick="doEdit2()"></div>
    <div text="-"></div>
    <div iconCls="icon-del" id="cmdDel" text="删除商品" disabled onEfsClick="doDel()"></div>
  </div>
  <div id="mgStore" xtype="store" url="<%=rootPath%>/ajax?method=getProList" txtXML="" autoLoad="false">
		<div xtype="xmlreader" fieldid="PID" record="ROW" tabName="PRODUCT">
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

</BODY>
</HTML>

