<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   proAdd.jsp
'** 实现功能：   添加商品
'** 设计人员：   Enjsky
'** 设计日期：   2006-03-10
'*******************************
*/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ELEMENT>
<head>
<title>添加商品</title>
<link rel="stylesheet" type="text/css" href="../css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="../css/efs-all.css" />
<script type="text/javascript" src="../js/loadmask.js"></script>
<script type="text/javascript" src="../js/efs-all.js"></script>
<SCRIPT language="JavaScript">
<!--
// 提交信息
function doSubmit()
{
  Efs.getExt("frmPost").submit();
}

function frmPostSubBack(bln,from,action)
{
  if(bln)
  {
    alert("提交成功");
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
<div xtype="panel" iconCls="icon-add" title="添加商品" border="false" buttonAlign="center" autoScroll="true">
  <form id="frmPost" class="efs-box" method="post" url="<%=rootPath%>/ajax?method=proAdd" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
      <TABLE class="formArea">
        <tr>
          <td labelFor="ptype">商品类型</td>
          <td><input type="text" kind="dic" src="DIC_PTYPE" fieldname="PRODUCT/PTYPE" id="ptype" must="true"></td>
        </tr>
        <tr>
          <td labelFor="pname">商品名称</td>
          <td><input type="text" kind="text" fieldname="PRODUCT/PNAME" id="pname" must="true"></td>
        </tr>
        <tr>
          <td>商品价格</td>
          <td><input type="text" kind="float" fieldname="PRODUCT/PRICE" datatype="1"></td>
        </tr>
        <tr>
          <td>商品数量</td>
          <td><input type="text" kind="int" fieldname="PRODUCT/PNUM" datatype="1"></td>
        </tr>
      </TABLE>
      <input type="hidden" kind="text" fieldname="PRODUCT/PID" operation="0">
  </form>
   <div xtype="buttons">
      <div text="确  定" onEfsClick="doSubmit()"></div>
      <div text="返  回" onEfsClick="doRet()"></div>      
   </div>
</div>
</BODY>
</HTML>