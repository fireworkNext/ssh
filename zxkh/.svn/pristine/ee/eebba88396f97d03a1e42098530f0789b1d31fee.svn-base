<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   impdata.jsp
'** 实现功能：   薪酬数据导入
'** 设计人员：   gwd
'** 设计日期：   2012-12-23
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
<title>薪酬数据导入</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<SCRIPT language="JavaScript">
<!--
Efs.onReady(function(){
	doLoadDic("DIC_WAGE_TYPE");
});

function doLoadDic(sDic){
	Efs.Common.ajax("<%=rootPath%>/getDic.action",sDic,function(succ,response,options){
	    if(succ)    // 是否成功
	    {
	     	var returnXML = response.responseText;
	     	Efs.getDom(sDic).loadXML(returnXML);
		}
	    else
	    {
	    	alert("动态获取字典"+sDic+"失败!");
	    	return false;
	    }
	   });
}
function doSubmit()
{
	if(Efs.getExt("frmPost").isValid && Efs.getExt("data").getValue()!="")
	{
		Efs.Msg.wait("系统正在处理中，请稍后...","信息窗口");
		Efs.getDom("tpl").setAttribute("value",Efs.getDom("tplname").getAttribute("code"));
		Efs.getExt("frmPost").submit(true);
	}
}

// 获取异步提交的返回监听函数
function frmPostSubBack(bln,from,action)
{
	alert(action.response.responseText);
}

function doRet()
{
  Efs.getDom("frmPost").reset();
}
//-->
</SCRIPT>
</HEAD>
<BODY>
<div xtype="panel" title="薪酬数据导入" autoHeight="true" border="false" buttonAlign="center">
  <form id="frmPost" class="efs-box" method="post" action="<%=rootPath%>/gzcx_upload.action" enctype="multipart/form-data" onEfsSuccess="frmPostSubBack(true)"  onEfsFailure="frmPostSubBack(false)">
      <TABLE class="formArea">
        <tr>
          <td class="label">数据类型：</td>
          <td><input type="text" id="tplname" name="tplname" class="Edit" kind="dic" src="#DIC_WAGE_TYPE" must="true" code=""></td>
        </tr>
        <!--  
        <tr>
          <td class="label">数据年月：</td>
          <td><input type="text" id="expdate" name="expdate" class="Edit" kind="text" maxlength="6" must="true" code="" hint="格式:4位年2位月,如201201"></td>
        </tr>
        -->
        <tr>
          <td class="label">数据文件：</td>
          <td><input type="file" id="data" name="data" must="true"></td>
        </tr>
		<tr>
		  <td colspan="2" align="left"><span style="color:red">注:薪酬文件为单独的excel或wps文件,系统默认读取第一个工作表.</span>
		  </td>
		</tr>
      </TABLE>
      <input type="hidden" id="tpl" name="tpl"/>
      </FORM>
	<div xtype="buttons">
     	<div text="确定" onEfsClick="doSubmit()"></div>
     	<div text="重置#R" onEfsClick="doRet()"></div>
     </div>
</div>
<div style="display:none">
<xml id="DIC_WAGE_TYPE">
</xml>
</div>
</BODY>
</HTML>
