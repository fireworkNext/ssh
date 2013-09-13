<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   AffairtypeAdd.jsp
'** 实现功能：   增加事务类型
'** 设计人员：   gwd
'** 设计日期：   2012-12-21
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/developer";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ELEMENT>
<head>
<base href="<%=webRoot%>">
<title>事务类型列表</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>

<SCRIPT language="JavaScript">
<!--
function doRet()
{
  location.href = "<%=strSelfPath%>/affairtypelist.jsp";
}

function doBeforSubmit(){
  // alert(this.txtXML);
}
		
// 提交信息
function doSubmit()
{
	if(Efs.getDom("PARENTID").getAttribute("value")==""){
		Efs.getDom("PARENTID").setAttribute("code","0");
	}
	Efs.getExt("frmPost").submit();
}
//-->
</SCRIPT>
<style>
.edit {
  width:120px;
}
</style>
</HEAD>
<BODY>
<div xtype="panel" iconCls="titleIcon" title="新增事务类型" border="false" buttonAlign="center" autoScroll="true">
  <form id="frmPost" onEfsBeforeaction="doBeforSubmit()" class="efs-box" method="post" action="<%=rootPath%>/affairDeal.action">
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
          <td><input id="AFFAIRTYPEID" type="text" hint="请书写6位数字编号" kind="text" fieldname="AFFAIRTYPE/AFFAIRTYPEID" operation="0" writeevent="0" state="0" datatype="0" must="true" name="AffairTypeID" id="AffairTypeID" maxlength="6"></td>
        </tr>
        <tr>
          <td labelFor="AFFAIRTYPENAME">事务类型名称</td>
          <td><input id="AFFAIRTYPENAME" type="text" kind="text" fieldname="AFFAIRTYPE/AFFAIRTYPENAME" state="0" datatype="0" value="" must="true"></td>
        </tr>
        <tr>
          <td labelFor="AFFAIRTYPEMODE">事务类型模式</td>
          <td><input id="AFFAIRTYPEMODE" type="text" kind="dic" src="DIC_AFFAIRTYPEMODE" fieldname="AFFAIRTYPE/AFFAIRTYPEMODE" state="0" datatype="1" value="业务类" code="1" must="true"></td>
        </tr>
        <tr>
          <td>事务类型描述</td>
          <td><TEXTAREA kind="text" style="height:60px;width:380px" fieldname="AFFAIRTYPE/AFFAIRTYPEDES" state="0" datatype="0"></TEXTAREA>
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
