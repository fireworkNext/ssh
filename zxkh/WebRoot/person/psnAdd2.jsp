<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   psnAdd.jsp
'** 实现功能：   添加学生基本信息
'** 设计人员：   Enjsky
'** 设计日期：   2009-10-14
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/person";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ELEMENT>
<head>
<base href="<%=webRoot%>">
<title>添加学生基本信息</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>

<SCRIPT language="JavaScript">
<!--
function doRet()
{
  location.href = "<%=strSelfPath%>/qryPsnList.jsp";
}

// 提交信息
function doSubmit()
{
  Efs.getExt("frmData").submit();
}

// 获取异步提交的返回监听函数
function frmPostSubBack(bln,from,action)
{
  if(bln){
    location.href = "<%=strSelfPath%>/qryPsnList.jsp";
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
//-->
</SCRIPT>
</HEAD>
<BODY>
<div xtype="panel" iconCls="icon-panel" title="添加学生基本信息" border="false" buttonAlign="center" autoScroll="true">
  <form id="frmData" class="efs-box" method="post" action="<%=rootPath%>/ajax?method=psnAdd" method="post" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
      <TABLE class="formArea">
        <TR>
          <TD width="100" labelFor="name">姓  名</TD>
          <TD><INPUT id="name" type="text" kind="zhunicode" must="true" maxlength="50" fieldname="PERSON/NAME" datatype="0" state="0"></TD>
          <TD width="20"></TD>
          <TD width="100">身份证号码</TD>
          <TD><INPUT type="text" kind="idcard" fieldname="PERSON/IDCARD" sex="sex" birthday="birthday" datatype="0" state="0"></TD>
        </TR>
        <TR>
          <TD width="100" labelFor="sex">性  别</TD>
          <TD><INPUT type="text" kind="dic" src="DIC_SEX" id="sex" fieldname="PERSON/SEX" must="true" datatype="0" state="0"></TD>
          <TD width="20"></TD>
          <TD width="100" labelFor="birthday">出生日期</TD>
          <TD><INPUT type="text" kind="date" id="birthday" fieldname="PERSON/BIRTHDAY" datatype="3" state="0" must="true"></TD>
        </TR>
        <TR>
          <TD width="100">籍  贯</TD>
          <TD><INPUT type="text" kind="dic" src="DIC_CODE" fieldname="PERSON/PLACECODE" datatype="0" state="0"></TD>
          <TD width="20"></TD>
          <TD width="100">年  龄</TD>
          <TD><INPUT type="text" kind="int" range=[0,119] fieldname="PERSON/YEAROLD" datatype="1" state="0"></TD>
        </TR>
        <TR>
          <TD width="100">邮  箱</TD>
          <TD><INPUT type="text" kind="email" fieldname="PERSON/EMAIL" datatype="0" state="0"></TD>
          <TD width="20"></TD>
          <TD width="100">电话号码</TD>
          <TD><INPUT type="text" kind="mask" mask="###-########" fieldname="PERSON/TEL" datatype="0" state="0"></TD>
        </TR>
        <tr>
          <td>备注</td>
          <td colspan="4"><TEXTAREA class="Edit" kind="text" style="height:60px;width:480px" fieldname="PERSON/BAK" state="0" datatype="0"></TEXTAREA>
          </td>
        </tr>
        <INPUT type="hidden" kind="text" fieldname="PERSON/PERSONID" datatype="0" state="0" operation="0" writeevent="0" ><!--operation="0"  定义为添加接口-->

      </TABLE>
	</form>
	 <div xtype="buttons">
     	<div text="确  定" onEfsClick="doSubmit()"></div>
     	<div text="返  回" onEfsClick="doRet()"></div>      
   </div>
</div>

</BODY>
</HTML>

