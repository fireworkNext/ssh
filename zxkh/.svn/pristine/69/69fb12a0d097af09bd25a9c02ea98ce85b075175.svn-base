<%@ page language="java" import="org.ptbank.cache.*,org.ptbank.func.*" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   userlist.jsp
'** 实现功能：   用户维护
'** 设计人员：   gwd
'** 设计日期：   2012-12-21
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/sysadmin";
UserLogonInfo userSession = (UserLogonInfo)session.getAttribute("user");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ELEMENT>
<head>
<base href="<%=webRoot%>">
<title>用户维护</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<script type="text/javascript" src="js/common.js"></script>

<SCRIPT language="JavaScript">
var sTreeUnitId = "";
var sTreeUnitName = "";
var sFlag = "";
var sUserID = "";

// 进入查询
function doQry()
{
	//判断sTreeUnitId是否为空
	if(sTreeUnitId=="")
		sTreeUnitId="<%=userSession.getUnitID()%>";
	var sValue="(select munitid from manageunit start with munitid='"+sTreeUnitId+"' connect by prior munitid=msunitid)";
	Efs.getDom("munitid").setAttribute("value",sValue);
  	var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry"));
  	Efs.getDom("dataList").setAttribute("txtXML",strXml);
  	Efs.getExt("gridList").store.load();
}

var sUserID = "";
var sUserName = "";
var opType = "";
function doGridClick(data)
{
	sUserID = data["USERID"];
	sUserName = data["USERNAME"];
	Efs.getExt("cmdEdit").enable();
	Efs.getExt("cmdDel").enable();
	Efs.getExt("cmdPsw").enable();
	Efs.getExt("cmdPrint").enable();
	Efs.getExt("cmdCancelPrint").enable();
}

function onEditEx()
{
	if(sUserID == "")
	{
		alert("没有选择用户");
		return false;
	}
	Efs.getExt("unitid1").enable();
	Efs.getExt("frmData").reset();
	Efs.Common.ajax("<%=rootPath%>/getUserDetail.action?txtUserID=" + sUserID,sUserID,function(succ,response,options){
    if(succ)    // 是否成功
    {
     	var returnXML = response.responseText;
     	Efs.Common.setEditValue(returnXML,Efs.getExt("frmData"), "QUERYINFO");
     	Efs.getDom("UserID").setAttribute("operation","1");
		Efs.getDom("UserID").setAttribute("state","5");
		with(Efs.getExt("UserMWin"))
	    {
	      setTitle("修改用户");
	      show();
	    }
	}
    else
    {
    	alert("返回数据失败!");
    	return false;
    }
  });
}

function onAddEx()
{
	if(sTreeUnitId == "")
	{
		alert("请点击左边单位树");
		return false;
	}
	Efs.getDom("UserID").setAttribute("operation","0");
	Efs.getDom("UserID").setAttribute("state","0");
	
	Efs.getExt("frmData").reset();
	Efs.getExt("unitid1").setValue(sTreeUnitName);
	Efs.getDom("unitid1").setAttribute("code",sTreeUnitId);
	Efs.getExt("unitid1").disable();
	with(Efs.getExt("UserMWin"))
	{
		setTitle("添加用户");
		show();
	}
}

function onDelEx()
{
	if(sUserID == "")
	{
		alert("没有选择用户");
		return false;
	}
	
	if((sUserID == "00000001"))
	{
		alert("权限不足");
		return false;
	}
	if(!confirm("确定要删除吗？"))
		return false;
	
	with(document.frmPost)
	{
		Efs.getDom("frmPost").setAttribute("url","<%=rootPath%>/userDrop.action");
		//var sTmpXml = "<DATAINFO><USERLIST writeevent='0' operation='2'><USERID datatype='0' state='5'>" + sUserID + "</USERID></USERLIST></DATAINFO>";
		var sTmpXml = Efs.getExt("gridList").getDelXml();
		//alert(sTmpXml);
		txtOpXml.setAttribute("value",sTmpXml);
	}
	Efs.getExt("frmPost").submit();
}

function onPrintEx()
{
	if(sUserID == "")
	{
		alert("没有选择用户");
		return false;
	}
	
	if((sUserID == "00000001"))
	{
		alert("权限不足");
		return false;
	}
	with(document.frmPost)
	{
		Efs.getDom("frmPost").setAttribute("url","<%=rootPath%>/userSetPrintFlag.action");
		//var sTmpXml = "<DATAINFO><USERLIST writeevent='0' operation='2'><USERID datatype='0' state='5'>" + sUserID + "</USERID></USERLIST></DATAINFO>";
		var sTmpXml = Efs.getExt("gridList").getDelXml();
		txtOpXml.setAttribute("value",sTmpXml);
	}
	Efs.getExt("frmPost").submit();
}

function onCancelPrintEx()
{
	if(sUserID == "")
	{
		alert("没有选择用户");
		return false;
	}
	
	if((sUserID == "00000001"))
	{
		alert("权限不足");
		return false;
	}
	with(document.frmPost)
	{
		Efs.getDom("frmPost").setAttribute("url","<%=rootPath%>/userCancelPrintFlag.action");
		//var sTmpXml = "<DATAINFO><USERLIST writeevent='0' operation='2'><USERID datatype='0' state='5'>" + sUserID + "</USERID></USERLIST></DATAINFO>";
		var sTmpXml = Efs.getExt("gridList").getDelXml();
		txtOpXml.setAttribute("value",sTmpXml);
	}
	Efs.getExt("frmPost").submit();
}

function onPswEx()
{
	if(sUserID==""){
		alert("请先选中用户!");
		return false;
	}
	with(document.frmPost)
	{
	var sPwd = "<%=Encrypt.e("888888") %>";
	Efs.getDom("frmPost").setAttribute("url","<%=rootPath%>/userSetPassword.action");
	  var sTmpXml = "<DATAINFO><USERLIST writeevent='0' operation='1'><USERID datatype='0' state='5'>" + sUserID + "</USERID><USERPASSWORD datatype='0' state='0'>"+sPwd+"</USERPASSWORD></USERLIST></DATAINFO>";
	  txtOpXml.setAttribute("value",sTmpXml);
	}
	Efs.getExt("frmPost").submit();
}

function onDicEx()
{
	location.href = "<%=rootPath%>/toCreateDicFile.action?txtXML=USERLIST&txtNextUrl=<%=strSelfPath%>/userlist.jsp";
}

function doDealUser()
{
	with(Efs.getDom("frmData"))
	{
		if(Efs.getDom("UserID").getAttribute("operation") == "0")
			Efs.getDom("frmData").setAttribute("url","<%=rootPath%>/userAdd.action");
		else if(Efs.getDom("UserID").getAttribute("operation") == "1")
			Efs.getDom("frmData").setAttribute("url","<%=rootPath%>/userEdit.action");
	}
	
	Efs.getExt("frmData").submit();
}

// 获取异步提交的返回监听函数
function frmPostSubBack(bln,from,action)
{
	if(bln)
	{
		Efs.getExt("UserMWin").hide();
		doQry();
	}
	else
	{
		var xml_http = action.response;
	   
		if(xml_http != null)
		{
		  var objXML = xml_http.responseXML;
		  alert("交易失败：" + Efs.Common.getNodeValue(objXML,"//FUNCERROR",0));
		  objXML = null;
		}
		xml_http = null;
	}
}

function doUnitTreeClick(node){
	sTreeUnitId=node.attributes.id;
	sTreeUnitName=node.attributes.text;
	sFlag = node.attributes.flag;
	//根据sTreeUnitId执行本单位用户查询
	var sValue="(select munitid from manageunit start with munitid='"+sTreeUnitId+"' connect by prior munitid=msunitid)";
	Efs.getDom("munitid").setAttribute("value",sValue);
	Efs.getDom("dataList").setAttribute("txtXML",Efs.Common.getQryXml(Efs.getExt("frmQry")));
  	Efs.getExt("gridList").store.load();
}

function checkUserTitle()
{
	var sUserTitle = Efs.getExt("usertitle").getValue();
	if(sUserTitle == "")
	{
	  return false;
	}
	
	Efs.Common.ajax("<%=rootPath%>/checkUserTitle.action?",sUserTitle,function(succ,response,options){
		if(succ)    // 是否成功
		{
	    	var returnXML = response.responseText;
	    	if(returnXML==1) {
	    		alert("该用户名称已存在,请重新输入");
	    		Efs.getExt("usertitle").focus(true,true);
	    		return false;
	    	}
		}
	    else
	    {
	   		alert("返回数据失败!");
	   		return false;
	   	}
	 });
}

function checkUserIdcard()
{
	var sUserIdcard = Efs.getExt("idcard").getValue();
	if(sUserIdcard == "")
	{
	  return false;
	}
	
	Efs.Common.ajax("<%=rootPath%>/checkUserIdcard.action?",sUserIdcard,function(succ,response,options){
		if(succ)    // 是否成功
		{
	    	var returnXML = response.responseText;
	    	if(returnXML==1) {
	    		alert("该身份证号已存在,请重新输入");
	    		Efs.getExt("idcard").focus(true,true);
	    		return false;
	    	}
		}
	    else
	    {
	   		alert("返回数据失败!");
	   		return false;
	   	}
	 });
}
</SCRIPT>
</HEAD>
<BODY>
<div region="west" width="250" title="单位树" autoScroll="true" collapsible="true">
	<div id="unittreepanel" xtype="treepanel" height="100%" autoScroll="true" onEfsClick="doUnitTreeClick()" border="false">
    	<div xtype="loader" id="unittreeloader" url="<%=rootPath%>/getUnitJsonTree.action" txtXML="" parentPath="QUERYINFO"></div>
	</div>
</div>
<div region="center">
	<div iconCls="icon-user" region="north" height="60" title="用户查询" border="false">
	 <form id="frmQry"  method="post">
	  <TABLE class="formAreaTop">
	      <tr>
	        <td>身份证号</td>
	        <td><input type="text" class="Edit" kind="text" fieldname="IDCARD" maxlength="18"></td>
	        <td>用户姓名</td>
	        <td><input type="text" class="Edit" kind="text" fieldname="USERNAME" operation="like" maxlength="30" hint="模糊查询"></td>
	        <td>性别</td>
	        <td><input type="text" class="Edit" kind="dic" src="DIC_GENDER" fieldname="SEX"></td>
	        <td>用户类型</td>
	        <td><input type="text" class="Edit" kind="dic" src="DIC_USERTYPE" fieldname="USERTYPE"></td>
	        <td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry()"></td>
	        <td>&nbsp;</td>
	      </tr>
	    </TABLE>
	    <input type="hidden" id="munitid" name="munitid" class="Edit" kind="text" fieldname="MUNITID" operation="in">
	  </form>
	</div>
	
	<div id="gridList" region="center" xtype="grid" border="false" pagingBar="true" pageSize="25" onEfsRowClick="doGridClick()" onEfsRowDblClick="onEditEx()" buttonAlign="center">
	  <div xtype="tbar">
	    <span style="font-size:9pt;font-weight:bold;color:#15428B;">用户列表</span>
	    <div text="->"></div>
	    <div iconCls="icon-add" text="增加#A" onEfsClick="onAddEx()"></div>
	    <div text="-"></div>
	    <div iconCls="icon-edit" id="cmdEdit" text="编辑#E" onEfsClick="onEditEx()" disabled="disabled"></div>
	    <div text="-"></div>
	    <div iconCls="icon-del" id="cmdDel" text="删除#D" onEfsClick="onDelEx()" disabled="disabled"></div>
	    <div text="-"></div>
	    <div id="cmdPsw" text="初始化口令#P" onEfsClick="onPswEx()" disabled="disabled"></div>
	    <div text="-"></div>
	    <div id="cmdPrint" text="设置打印工资单#T" onEfsClick="onPrintEx()" disabled="disabled"></div>
	    <div text="-"></div>
	    <div id="cmdCancelPrint" text="取消打印工资单#T" onEfsClick="onCancelPrintEx()" disabled="disabled"></div>
	  </div>
		<div id="dataList" xtype="store" url="<%=rootPath%>/getUserList.action" txtXML='' autoLoad="false">
			<div xtype="xmlreader" fieldid="USERID" record="ROW" tabName="USERLIST" totalRecords="QUERYINFO@records">
				<div name="USERID" mapping="USERID"></div>
				<div name="USERTITLE" mapping="USERTITLE"></div>
				<div name="USERNAME"></div>
				<div name="UNITNAME"></div>
				<div name="SEX"></div>
	      		<div name="DISABLED"></div>
				<div name="CANEDITPASSWORD"></div>
				<div name="USERTYPE"></div>
				<div name="IDCARD"></div>
				<div name="BXDM"></div>
				<div name="PRINTFLAG"></div>
			</div>
		</div>
	
		<div xtype="colmodel">
			<div type="checkbox"></div>
			<div header="登录用户名" width="140" sortable="true" dataIndex="USERTITLE" align="center"></div>
			<div header="用户姓名" width="120" sortable="true" dataIndex="USERNAME" align="center"></div>
			<div header="单位" width="140" sortable="true" dataIndex="UNITNAME"></div>
			<div header="性别" width="40" sortable="true" dataIndex="SEX" align="center"></div>
			<div header="是否打印工资单" width="100" sortable="true" dataIndex="PRINTFLAG" align="center"></div>
	    	<div header="是否禁用用户" width="100" sortable="true" dataIndex="DISABLED" align="center"></div>
			<div header="能否修改口令" width="100" sortable="true" dataIndex="CANEDITPASSWORD" align="center"></div>
			<div header="用户类型" width="80" sortable="true" dataIndex="USERTYPE" align="center"></div>
			<div header="身份证号" width="140" sortable="true" dataIndex="IDCARD" align="center"></div>
		</div>
	</div>
</div>

    <!-- window开始 -->
    <div iconCls="icon-panel" id="UserMWin" xtype="window" width="760" height="420" title="添加用户" resizable="true" modal="true">
      <div region="center" xtype="panel" title="" border="false" autoScroll="true">
        <div xtype="tbar">
          <div text="->"></div>
          <div iconCls="icon-add" id="cmdUser" text="确  定" onEfsClick="doDealUser()"></div>
        </div>
        <form id="frmData" class="efs-box" method="post" url="" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
          <TABLE class="formArea">
          <tr style="display:none">
            <td>用户编号</td>
            <td colspan="4"><input type="hidden" kind="text" fieldname="USERLIST/USERID" name="UserID" id="UserID" operation="0" writeevent="0" state="0" datatype="0"></td>
          </tr>
          <tr>
            <td>单位</td>
            <td><input type="text" id="unitid1" name="unitid1" kind="dic" src="MANAGEUNIT" state="0" datatype="0" fieldname="USERLIST/MUNITID" must="true" disabled="disabled"></td>
            <td width="20">&nbsp;</td>
            <td>保险代码</td>
            <td><input type="text" kind="text" fieldname="USERLIST/BXDM" state="0" datatype="0"></td>
          </tr>
          <tr>
            <td width="100">登录用户名</td>
            <td width="160"><input type="text" id="usertitle" name="usertitle" kind="text" fieldname="USERLIST/USERTITLE" state="0" datatype="0" maxlength="30" value="" must="true" ></td>
            <td width="20">&nbsp;</td>
            <td width="80">用户姓名</td>
            <td width="160"><input type="text" kind="zhunicode" fieldname="USERLIST/USERNAME" state="0" datatype="0"  maxlength="30" must="true"></td>
          </tr>
          <tr>
            <td>身份证号</td>
            <td><input type="text" kind="text" id="idcard" name="idcard" fieldname="USERLIST/IDCARD" state="0" datatype="0" sex="sex" birthday="birthday" must="true" ></td>
            <td width="20">&nbsp;</td>
            <td>性别</td>
            <td><input type="text" kind="dic" id="sex" src="DIC_GENDER" must="true" fieldname="USERLIST/SEX" state="0" datatype="1"></td>
          </tr>
          <tr>
            <td>出生日期</td>
            <td><input type="text" kind="date" id="birthday" fieldname="USERLIST/BIRTHDAY" state="0" datatype="3"></td>
            <td width="20">&nbsp;</td>
            <td>民族</td>
            <td><input type="text" kind="dic" src="DIC_NATIVE" fieldname="USERLIST/NATION" state="0" datatype="0"></td>
          </tr>
          <tr>
            <td>籍贯</td>
            <td><input type="text" kind="dic" src="DIC_CODE" fieldname="USERLIST/NATIVEPLACE" state="0" datatype="0"></td>
            <td width="20">&nbsp;</td>
            <td>文化程度</td>
            <td><input type="text" kind="dic" src="DIC_EDUCATION" fieldname="USERLIST/EDUCATION" state="0" datatype="0"></td>
          </tr>
          <tr>
            <td>家庭住址</td>
            <td colspan="4"><input type="text" style="width:420px" kind="text" fieldname="USERLIST/ADDRESS" state="0" datatype="0" maxlength="100"></td>
          </tr>
          <tr>
            <td>暂住地址</td>
            <td colspan="4"><input type="text" style="width:420px" kind="text" fieldname="USERLIST/TEMPADDRESS" state="0" datatype="0" maxlength="100"></td>
          </tr>
          <tr>
            <td>联系方式</td>
            <td><input type="text" kind="text" fieldname="USERLIST/CONTACT" maxlength="50" state="0" datatype="0"></td>
          	<td width="20">&nbsp;</td>
            <td>职务</td>
            <td><input type="text" kind="dic" src="DIC_DUTY" state="0" datatype="0" fieldname="USERLIST/DUTY"></td>
          </tr>
          <tr>
            <td>手机号码</td>
            <td><input type="text" kind="text" fieldname="USERLIST/SMSTEL" maxlength="15" state="0" datatype="0"></td>
            <td width="20">&nbsp;</td>
            <td>是否禁用</td>
            <td><input type="text" kind="dic" src="DIC_TRUEFALSE" code="0" value="否" fieldname="USERLIST/DISABLED" state="0" datatype="1"></td>
          </tr>
          <tr>
            <td>能否修改口令</td>
            <td><input type="text" kind="dic" src="DIC_ABLE" code="1" value="能" fieldname="USERLIST/CANEDITPASSWORD" state="0" datatype="1"></td>
            <td width="20">&nbsp;</td>
            <td>用户类型</td>
            <td><input type="text" kind="dic" src="DIC_USERTYPE" code="3" value="普通管理员" fieldname="USERLIST/USERTYPE" state="0" datatype="1"></td>
          </tr>
          <tr>
            <td>是否打印工资单</td>
            <td><input type="text" kind="dic" src="DIC_TRUEFALSE" code="0" value="否" fieldname="USERLIST/PRINTFLAG" state="0" datatype="1"></td>
          </tr>
          <tr>
            <td>用户描述</td>
            <td colspan="4"><TEXTAREA kind="text" style="height:40px;width:420px" fieldname="USERLIST/USERDES" state="0" datatype="0"></TEXTAREA>
            </td>
          </tr>
          <tr style="display:none">
            <td>用户口令<br></td>
            <td colspan="4">|<input type="hidden" kind="text" fieldname="USERLIST/USERPASSWORD" state="0" datatype="0" value="<%=Encrypt.e("888888") %>"><br></td>
          </tr>
        </TABLE>
        </form>
      </div>
    </div>
    <!-- window结束 -->

    <!-- window结束AddBM -->
  <FORM id="frmPost" name="frmPost" url="" method="post" style="display:none;" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
    <INPUT type="hidden" name="txtOpXml">
  </FORM>
</BODY>
</HTML>