<%@ page language="java" import="org.ptbank.baseManage.*" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   AffairtypeAdd.jsp
'** 实现功能：   修改事务类型
'** 设计人员：   Enjsky
'** 设计日期：   2006-03-10
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/developer";
String strAffairTypeID = request.getParameter("txtAffairTypeID");

// 查询获得事务类型详细信息
String strXmlRet = IdentifyQueryBO.affairTypeDetail(strAffairTypeID);
strXmlRet = strXmlRet.replaceAll("\n","");
%>
<HTML>
<head>
<base href="<%=webRoot%>">
<title>修改事务类型</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>

<SCRIPT language="JavaScript">
<!--
var xmlDetail = '<%=strXmlRet%>';
Efs.onReady(function(){
	Efs.Common.setEditValue(xmlDetail,Efs.getExt("frmPost"), "QUERYINFO");
});
    
function doRet()
{
  location.href = "<%=strSelfPath%>/affairtypelist.jsp";
}

// 提交信息
function doSubmit()
{
	Efs.getExt("frmPost").submit();
}
//-->
</SCRIPT>
</HEAD>
<BODY>
<div xtype="panel" title="新增事务类型" autoHeight="true" border="false" buttonAlign="center">
  <form id="frmPost" class="efs-box" method="post" action="<%=rootPath%>/affairDeal.action">
      <TABLE class="formArea">
      	<tr>
          <td labelFor="SYSTEMID">所属应用系统</td>
          <td><input id="SYSTEMID" type="text" kind="dic" src="DIC_SYSTEM" fieldname="AFFAIRTYPE/SYSTEMID" state="0" datatype="0" must="true"></td>
        </tr>
        <tr>
          <td labelFor="PARENTID">上级事务类型</td>
          <td><input id="PARENTID" type="text" kind="dic" src="AFFAIRTYPE" fieldname="AFFAIRTYPE/PARENTID" state="0" datatype="0" must="true"></td>
        </tr>
        <tr>
          <td labelFor="AFFAIRTYPEID">事务类型编号</td>
          <td><input id="AFFAIRTYPEID" type="text" class="Edit" kind="text" fieldname="AFFAIRTYPE/AFFAIRTYPEID" operation="1" writeevent="0" state="5" datatype="0" must="true"  maxlength="6"></td>
        </tr>
        <tr>
          <td labelFor="AFFAIRTYPENAME">事务类型名称</td>
          <td><input id="AFFAIRTYPENAME" type="text" class="Edit" kind="text" fieldname="AFFAIRTYPE/AFFAIRTYPENAME" state="0" datatype="0" value="" must="true"></td>
        </tr>
        <tr>
          <td labelFor="AFFAIRTYPEMODE">事务类型模式</td>
          <td><input id="AFFAIRTYPEMODE" type="text" class="Edit" kind="dic" src="DIC_AFFAIRTYPEMODE" fieldname="AFFAIRTYPE/AFFAIRTYPEMODE" state="0" datatype="1" must="true"></td>
        </tr>
        <tr>
          <td>事务类型描述</td>
          <td><TEXTAREA class="Edit" kind="text" style="height:60px;width:380px" fieldname="AFFAIRTYPE/AFFAIRTYPEDES" state="0" datatype="0"></TEXTAREA>
          </td>
        </tr>
      </TABLE>
	</form>
	
	<div xtype="buttons">
     	<div text="确  定" onEfsClick="doSubmit()"></div>
     	<div text="返  回" onEfsClick="doRet()"></div>
     </div>
</div>


</BODY>
</HTML>

