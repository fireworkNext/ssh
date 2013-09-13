<%@ page language="java" pageEncoding="UTF-8" import="org.ptbank.cache.*,org.ptbank.func.*,java.text.SimpleDateFormat"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   usertitle.jsp
'** 实现功能：   用户名设置
'** 设计人员：   gwd
'** 设计日期：   2013-01-11
'*******************************
*/
%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

UserLogonInfo userSession = (UserLogonInfo)request.getSession().getAttribute("user");
String sUserId = userSession.getUserID();
SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
String sBgnDate = General.curYear4()+"-01-01";
String sEndDate = sf.format(DateTimeUtil.addDays(-1));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>

<head>
<base href="<%=basePath%>">
<title>用户名设置</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/efs-all.js"></script>
<script language="JavaScript">
function validUserTitle(){
	if(Efs.getExt("newusertitle").getValue()=="")
		return false;
	if(Efs.getExt("newusertitle").getValue().length<4){
		alert("用户名长度最小4位,请重新输入!");
		Efs.getExt("newusertitle").focus(true,true);
		return false;
	}
	Efs.Common.ajax("<%=rootPath%>/gzcx_validUserTitle.action",Efs.getExt("newusertitle").getValue(),function(succ,response,options){
	    if(succ)    // 是否成功
	    {
	     	var iCount = response.responseText;
	     	if(iCount>0){
	     		alert("该用户登录名已存在,请重新设置！");
	     		Efs.getExt("newusertitle").focus(true,true);
	     	}
		}
	    else
	    {
	    	alert("返回数据失败!");
	    	return false;
	    }
	  });
}
function doSubmit()
{
	if(Efs.getExt("frmPost").isValid()){
		Efs.getExt("frmPost").submit();
	}
}

function doRet()
{
  //location.href = "<%=rootPath%>/welcome.jsp";
  Efs.getExt("frmPost").reset();
}

function frmPostSubBack(bln,from,action)
{
  if(bln)
  {
    alert("修改成功！");
    top.famRMain.location="/welcome.jsp";
  }
  else
  {
    var xml_http = action.response;
    if(xml_http != null)
    {
      var objXML = xml_http.responseXML;
      alert("处理失败：" + Efs.Common.getNodeValue(objXML,"//FUNCERROR",0));
      objXML = null;
    }
    xml_http = null;
  }
}
</script>
</HEAD>
<BODY>
<div xtype="panel" title="用户名设置" autoHeight="true" border="false" buttonAlign="center">
  <form id="frmPost" class="efs-box" method="post" action="<%=rootPath%>/modUserTitle.action" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
      <table>
        <tr>
          <td class="label">用户名</td>
          <td><input type="text" id="oldusertitle" class="Edit" kind="text" must="true" disabled="disabled" value="<%=userSession.getUserTitle()%>"></td>
        </tr>
        <tr>
          <td class="label">新用户名</td>
          <td><input type="text" id="newusertitle" class="Edit" kind="text" operation="1" writeevent="0" state="0" datatype="0" fieldname="USERLIST/USERTITLE" must="true" onEfsBlur="validUserTitle();"></td>
        </tr>
        <tr>
          <td></td>
          <td><input type="hidden" class="Edit" kind="text" fieldname="USERLIST/USERID" state="5" datatype="0" value="<%=sUserId%>"></td>
        </tr>
        <tr>
          <td colspan="2"><span style="font-size:12px;">用户名可由4-20位字母、数字或下划线组成。</span></td>
        </tr>
      </table>
      </FORM>
	<div xtype="buttons">
     	<div text="确  定" onEfsClick="doSubmit()"></div>
     	<div text="重  置" onEfsClick="doRet()"></div>
     </div>
</div>    

</BODY>
</HTML>

