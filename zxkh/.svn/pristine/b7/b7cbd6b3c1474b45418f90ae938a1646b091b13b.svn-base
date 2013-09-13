<%@ page language="java" pageEncoding="UTF-8" import="org.ptbank.cache.*,org.ptbank.func.*,java.text.SimpleDateFormat"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   modpasswd.jsp
'** 实现功能：   修改密码
'** 设计人员：   gwd
'** 设计日期：   2013-01-11
'*******************************
*/
%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

UserLogonInfo userSession = (UserLogonInfo)request.getSession().getAttribute("user");
String sSfzhm = userSession.getIDCard();
SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
String sBgnDate = General.curYear4()+"-01-01";
String sEndDate = sf.format(DateTimeUtil.addDays(-1));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>

<head>
<base href="<%=basePath%>">
<title>密码修改</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/efs-all.js"></script>
<script language="JavaScript">
function validPwd(){
	if(Efs.getExt("oldpasswd").getValue()=="")
		return false;
	Efs.Common.ajax("<%=rootPath%>/gzcx_validPwd.action",Efs.getExt("oldpasswd").getValue(),function(succ,response,options){
	    if(succ)    // 是否成功
	    {
	     	var iCount = response.responseText;
	     	if(iCount>0){
	     		alert("旧口令输入错误,请检查");
	     		Efs.getExt("oldpasswd").focus(true,true);
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
  var oldpasswd = Efs.getExt("oldpasswd").getValue();
  var newpasswd = Efs.getExt("newpasswd");
  var newpasswd2 = Efs.getExt("newpasswd2");
  if (newpasswd.getValue()==oldpasswd) {
	  alert("不能与旧密码相同,请重新输入！");
	  newpasswd.focus();
	  return false;
  }
  if (newpasswd.getValue()=="888888") {
	  alert("不能修改为初始密码,请重新输入！");
	  newpasswd.focus();
	  return false;
  }
  if (newpasswd.getValue() != newpasswd2.getValue()) {
    newpasswd.setValue("");
    newpasswd2.setValue("");
    newpasswd.focus(true,true);
    alert("输入的两个口令不一致，请重新输入！");
    return false;
  }
  Efs.getExt("frmPost").submit();
}

function doRet()
{
  //location.href = "<%=rootPath%>/gzcx/wagetot.jsp";
  Efs.getExt("frmPost").reset();
}

function frmPostSubBack(bln,from,action)
{
  if(bln)
  {
    alert("修改成功,请重新登录！");
    top.famRMain.location="/login.jsp";
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
<div xtype="panel" title="密码修改" autoHeight="true" border="false" buttonAlign="center">
  <form id="frmPost" class="efs-box" method="post" action="<%=rootPath%>/modPasswd.action" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
      <table>
        <tr>
          <td class="label">旧的口令</td>
          <td><input type="password" id="oldpasswd" class="Edit" kind="text" fieldname="USERLIST/USERPASSWORD" must="true" maxlength="20" ignore="true" onEfsBlur="validPwd();"></td>
        </tr>
        <tr>
          <td class="label">新的口令</td>
          <td><input type="password" id="newpasswd" class="Edit" kind="text" operation="1" writeevent="0" state="0" datatype="0" fieldname="USERLIST/USERPASSWORD" must="true" maxlength="20"></td>
        </tr>
        <tr>
          <td class="label">再次确认新口令</td>
          <td><input type="password" id="newpasswd2" class="Edit" kind="text" fieldname="" must="true" maxlength="20" ignore="true"></td>
        </tr>
        <tr>
          <td></td>
          <td><input type="hidden" class="Edit" kind="text" fieldname="USERLIST/IDCARD" state="5" datatype="0" value="<%=sSfzhm%>"></td>
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

