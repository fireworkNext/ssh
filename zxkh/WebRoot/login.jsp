<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" import="org.ptbank.func.*"%>
<%!
/**
'*******************************
'** 程序名称：  login.jsp
'** 实现功能：   登录界面
'** 设计人员：   gwd
'** 设计日期：   2012-12-15
'*******************************
*/
%>
<%
String rootPath = request.getContextPath();
String webRoot = request.getScheme() + "://"
                 + request.getServerName() + ":" + request.getServerPort()
                 + rootPath + "/";
String osName = SystemTool.getOSName();
String mac="";
if(osName.startsWith("windows")){
	mac=SystemTool.getWindowsMACAddress();
}else{
	mac=SystemTool.getUnixMACAddress();
}

%>
<html>
<head>
<base href="<%=webRoot%>">
<title>莆田邮政转型客户管理系统-系统登录</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<SCRIPT type="text/javascript">
Efs.onReady(function(){
	Efs.getExt("win1").show();
	Efs.getExt("txtUser").focus(true,true);
	Efs.getExt("txtPwd").el.on("keydown",function(event){
		if (event.keyCode == '13') {
			Efs.getExt("btnSubmit").setText("正在登录");
			//Efs.getExt("btnSubmit").focus(true,true);
			Efs.getExt("frmData").submit();
		}
	});
});

function doSubmit()
{
    Efs.getExt("frmData").submit();
}

</script>
</head>
<body>
<!-- 登录window开始 -->
<div iconCls="icon-person" id="win1" xtype="window" width="460" height="310" title="莆田邮政转型客户管理系统" resizable="true" closable="false" collapsible="true" modal="true">
  <div region="north" xtype="panel" height="70" title="" border="false" autoScroll="false">
  	<img border="0" width="450" height="70" src="images/login_banner.jpg" />
  </div>
  <div region="center" xtype="panel" title="身份验证" border="true" autoScroll="true">
    <form id="frmData" method="post" action="<%=rootPath%>/login.action">
    <TABLE>
      <tr>
      	<td>&nbsp;</td>
      </tr>
      <tr>
      	<td width="30">&nbsp;</td>
        <td class="label" style="font-weight:bold;">身份证号/用户名：</td>
        <td><input type="text" name="txtUser" id="txtUser" class="Edit" style="width:200px;" kind="text" fieldname="LOGININFO/USERTITLE"  must="true" state="0" datatype="0"></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td class="label" style="font-weight:bold;">密码：</td>
        <td><input type="password" name="txtPwd" id="txtPwd" class="Edit" style="width:200px;" kind="text" fieldname="LOGININFO/USERPASSWORD" state="0" datatype="0" must="true"></td>
      </tr>
      <tr>
      	<td>&nbsp;</td>
      </tr>
      <tr>
        <td width="30">&nbsp;</td>
      	<td colspan="2"><span style="font-size:12px;color:#15428b">身份证号指您的个人身份证号码。</span></td>
      </tr>
      <tr>
        <td width="30">&nbsp;</td>
        <td colspan="2"><span style="font-size:12px;color:#15428b">用户名指您在系统中设置的登录用户名。</span></td>
      </tr>
    </TABLE>
    <INPUT type="hidden" name="txtIp" id="txtIp" fieldname="LOGININFO/LOGINIP" value="<%=SystemTool.getIpAddr(request)%>">
    <INPUT type="hidden" name="txtMac" id="txtMac" fieldname="LOGININFO/MAC" value="<%=mac%>">
	</form>
    <div xtype="buttons">
     	<div text="登录系统#G" name="btnSubmit" id ="btnSubmit" iconCls="icon-ok" onEfsClick="doSubmit()"></div>
    </div>
  </div>
</div>
<!-- window结束 -->
</body>
</html>