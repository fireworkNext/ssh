<%@ page language="java" import="org.ptbank.baseManage.*" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   roleedit.jsp
'** 实现功能：   编辑角色
'** 设计人员：   gwd
'** 设计日期：   2012-12-21
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/sysadmin";
String strRoleID = request.getParameter("txtRoleID");

// 查询获得角色详细信息
String strXmlRet = IdentifyQueryBO.roleDetail(strRoleID);
strXmlRet = strXmlRet.replaceAll("\n","");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<head>
<base href="<%=webRoot%>">
<title>角色维护</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<SCRIPT language="JavaScript">
var xmlDetail = '<%=strXmlRet%>';
var sRoleId = "<%=strRoleID %>";
var sMunitId = "";
Efs.onReady(
  function(){
    Efs.Common.setEditValue(xmlDetail,Efs.getExt("frmData"), "QUERYINFO");
    doReadyRight();
    doReadyUser();
  }
);
// 构造角色下的权限列表
function doReadyRight()
{
  Efs.getDom("roleid").setAttribute("value",sRoleId);
  var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry"));
  Efs.getDom("eList").setAttribute("txtXML",strXml);
  Efs.getExt("eGrid").store.load();
}
// 构造角色下的用户列表
function doReadyUser()
{
	doQryRU();
}

function doQryRU(){
	Efs.getDom("roleidRU").setAttribute("value",sRoleId);
	var strXml = Efs.Common.getQryXml(Efs.getExt("frmQryRU"));
	Efs.getDom("uList").setAttribute("txtXML",strXml);
	Efs.getExt("uGrid").store.load();
}

function doRet()
{
  location.href = "<%=strSelfPath%>/rolelist.jsp";
}

// 提交信息
function doSubmit()
{
	Efs.getExt("frmData").submit();
}

function toAddEventTypeToRole()
{
  Efs.getExt("toAddEWin").show();
  Efs.getDom("roleid").setAttribute("value",sRoleId);
  var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry"));
  Efs.getDom("etrList").setAttribute("txtXML",strXml);
  Efs.getExt("etrGrid").store.load();
}

function toAddUserToRole()
{
  Efs.getExt("toAddUWin").show();
  //var sTmpXml = "<?xml version='1.0'?><EFSFRAME><QUERYCONDITION currentpagenum='1'><PREDICATE/><CONDITIONS><TYPE>and</TYPE><CONDITION alias='' datatype=''><FIELDNAME sv=''>USERID</FIELDNAME><OPERATION>NOT IN</OPERATION><VALUE>(SELECT USERID FROM ROLEUSER WHERE ROLEID = '<%=strRoleID %>')</VALUE></CONDITION></CONDITIONS></QUERYCONDITION></EFSFRAME>"
  //Efs.getDom("utrList").txtXML = sTmpXml;
  //Efs.getExt("utrGrid").store.load();
}

var opType = "";
// 将事件添加到角色中
function AddEventToRoleSure()
{
	opType = "event";
  
  // var xml = Efs.getExt("etrGrid").getSelectedXml();
  var objXML = Efs.getExt("etrGrid").getDelXml(true);
  var sXmlTmp = "";
  for(var i=0;i<Efs.Common.selectNodes(objXML,"//ROW").length;i++)
  {
    sXmlTmp = sXmlTmp + '<ROLEPOWER writeevent="0" operation="0"><ROLEID datatype="0" state="0"><%=strRoleID%></ROLEID><EVENTTYPEID datatype="0" state="0">' +
              Efs.Common.getNodeValue(objXML,"//EVENTTYPEID",i) + '</EVENTTYPEID></ROLEPOWER>';
  }
  sXmlTmp = Efs.Common.addRootXml('<DATAINFO>' + sXmlTmp + '</DATAINFO>');
  objXML = null;
  Efs.getDom("frmPost").setAttribute("url","<%=rootPath%>/backAddEventToRole.action");
  document.frmPost.txtOpXml.setAttribute("value",sXmlTmp);
  Efs.getExt("frmPost").submit();
}

// 将用户添加到角色中
function AddUserToRoleSure()
{
  opType = "user";
  var objXML = Efs.getExt("utrGrid").getDelXml(true);
  
  var sXmlTmp = "";
  for(var i=0;i<Efs.Common.selectNodes(objXML,"//ROW").length;i++)
  {
    sXmlTmp = sXmlTmp + '<ROLEUSER writeevent="0" operation="0"><ROLEID datatype="0" state="0"><%=strRoleID%></ROLEID><USERID datatype="0" state="0">' +
    		Efs.Common.getNodeValue(objXML,"//USERID",i) + '</USERID></ROLEUSER>';
  }
  sXmlTmp = Efs.Common.addRootXml('<DATAINFO>' + sXmlTmp + '</DATAINFO>');
  objXML = null;
  Efs.getDom("frmPost").setAttribute("url","<%=rootPath%>/backAddUserToRole.action");
  
  document.frmPost.txtOpXml.setAttribute("value",sXmlTmp);

  Efs.getExt("frmPost").submit();
}


// 删除角色包含的事件类型权限
function toDelEventType()
{
  opType = "delevent";
  var objXML = Efs.getExt("eGrid").getDelXml(true);
  
  var sXmlTmp = "";
  for(var i=0;i<Efs.Common.selectNodes(objXML,"//ROW").length;i++)
  {
    sXmlTmp = sXmlTmp + '<ROLEPOWER writeevent="0" operation="2"><ROLEID datatype="0" state="5"><%=strRoleID%></ROLEID><EVENTTYPEID datatype="0" state="5">' +
    		Efs.Common.getNodeValue(objXML,"//EVENTTYPEID",i) + '</EVENTTYPEID></ROLEPOWER>'
  }
  sXmlTmp = Efs.Common.addRootXml('<DATAINFO>' + sXmlTmp + '</DATAINFO>');
  objXML = null;
  Efs.getDom("frmPost").setAttribute("url","<%=rootPath%>/backDropEventfrmRole.action");
  
  document.frmPost.txtOpXml.setAttribute("value",sXmlTmp);

  Efs.getExt("frmPost").submit();
}

// 删除角色中包含的用户
function toDelUser()
{
  opType = "deluser";
  var objXML = Efs.getExt("uGrid").getDelXml(true);
  
  var sXmlTmp = "";
  for(var i=0;i<Efs.Common.selectNodes(objXML,"//ROW").length;i++)
  {
    sXmlTmp = sXmlTmp + '<ROLEUSER writeevent="0" operation="2"><ROLEID datatype="0" state="5"><%=strRoleID%></ROLEID><USERID datatype="0" state="5">' +
    		Efs.Common.getNodeValue(objXML,"//USERID",i) + '</USERID></ROLEUSER>';
  }
  sXmlTmp = Efs.Common.addRootXml('<DATAINFO>' + sXmlTmp + '</DATAINFO>');
  objXML = null;
  
  Efs.getDom("frmPost").setAttribute("url","<%=rootPath%>/backDropUserfrmRole.action");
  document.frmPost.txtOpXml.setAttribute("value",sXmlTmp);
  Efs.getExt("frmPost").submit();
}

// 获取异步提交的返回监听函数
function frmPostSubBack(bln,from,action)
{
  if(bln)
  {
    if(opType == "event")
    {
      Efs.getExt("toAddEWin").hide();
      doReadyRight();
    }
    else if(opType == "delevent")
      doReadyRight();
    else if(opType == "user")
    {
      Efs.getExt("toAddUWin").hide();
      doReadyUser();
    }
    else if(opType == "deluser")
      doReadyUser();
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

function doUnitTreeClick(node)
{
	//var strXml =  "<EFSFRAME><QUERYCONDITION><PREDICATE></PREDICATE><CONDITIONS><TYPE>and</TYPE><CONDITION alias='' datatype='0'><FIELDNAME sv=''>munitid</FIELDNAME><OPERATION>IN</OPERATION><VALUE>(SELECT MUNITID FROM MANAGEUNIT START WITH MUNITID='" + node.attributes.id + "' CONNECT BY PRIOR MUNITID=MSUNITID)</VALUE></CONDITION><CONDITION alias='' datatype=''><FIELDNAME sv=''>USERID</FIELDNAME><OPERATION>NOT IN</OPERATION><VALUE>(SELECT USERID FROM ROLEUSER WHERE ROLEID = '<%=strRoleID %>')</VALUE></CONDITION></CONDITIONS></QUERYCONDITION></EFSFRAME>";
	sMunitId=node.attributes.id;
	doQry();
}

function doQry(){
	if(sMunitId!="")
		Efs.getDom("munitidU").setAttribute("value","(SELECT MUNITID FROM MANAGEUNIT START WITH MUNITID='" + sMunitId + "' CONNECT BY PRIOR MUNITID=MSUNITID)");
	Efs.getDom("useridU").setAttribute("value","(SELECT USERID FROM ROLEUSER WHERE ROLEID = '<%=strRoleID %>')");
	var strXml = Efs.Common.getQryXml(Efs.getExt("frmQryU"));
	Efs.getDom("utrList").setAttribute("txtXML",strXml);
	Efs.getExt("utrGrid").store.load();
}
</SCRIPT>

</HEAD>

<BODY>
<div id="roleTab" region="center" buttonAlign="center" xtype="tabpanel" region="center" border="false" title="角色管理">
  <div id="tab1" title="角色属性">
    <form id="frmData" class="efs-box" method="post" action="<%=rootPath%>/roleEdit.action">
      <TABLE class="formArea">
        <tr>
          <td class="label">角色编号</td>
          <td><input type="text" class="Edit" readOnly kind="text" fieldname="ROLEBASIC/ROLEID" operation="1" writeevent="0" state="5" datatype="0"></td>
        </tr>
        <tr>
          <td class="label">角色名称</td>
          <td><input type="text" class="Edit" kind="text" fieldname="ROLEBASIC/ROLENAME" state="0" datatype="0" must="true"></td>
        </tr>
        <tr>
          <td class="label">角色描述</td>
          <td><TEXTAREA class="Edit" kind="text" style="height:60px;width:380px" fieldname="ROLEBASIC/ROLEDES" state="0" datatype="0"></TEXTAREA>
          </td>
        </tr>
      </TABLE>
      </form>
  </div>
  <div id="tab2" title="角色事件权限">
    <div id="eGrid" region="center" xtype="grid" title="" border="false" buttonAlign="center">
      <div xtype="tbar">
        <span style="font-size:9pt;font-weight:bold;color:#15428B;">角色事件权限列表</span>
        <div text="->"></div>
        <div iconCls="icon-add" id="cmdAddEvent" text="添加事件类型" onEfsClick="toAddEventTypeToRole()"></div>
        <div iconCls="icon-del" id="cmdDelEvent" text="删除事件类型" onEfsClick="toDelEventType()"></div>
      </div>
      <div id="eList" xtype="store" url="<%=rootPath%>/getRsQryRoleRightList.action" txtXML="" autoLoad="false">
        <div xtype="xmlreader" fieldid="EVENTTYPEID" record="ROW" totalRecords="QUERYINFO@records">
          <div name="EVENTTYPEID" mapping="EVENTTYPEID"></div>
          <div name="EVENTTYPENAME" mapping="EVENTTYPENAME"></div>
          <div name="DISABLED"></div>
          <div name="SHORTCUT"></div>
          <div name="VISIBLE"></div>
        </div>
      </div>
      <div xtype="colmodel">
	      <div type="checkbox"></div>
        <div header="事件类型编号" width="105" sortable="true" dataIndex="EVENTTYPEID" align="center"></div>
        <div header="事件类型名" width="200" sortable="true" dataIndex="EVENTTYPENAME" align="center"></div>
        <div header="是否禁用" width="60" sortable="true" dataIndex="DISABLED" align="center"></div>
        <div header="是否快捷键" width="80" sortable="true" dataIndex="SHORTCUT" align="center"></div>
        <div header="是否显示" width="60" sortable="true" dataIndex="VISIBLE" align="center"></div>
      </div>
    </div>

  </div>
  <div id="tab3" title="角色用户">
    <div iconCls="icon-user" region="north" height="60" title="用户查询" border="false">
		 <form id="frmQryRU"  method="post">
		  <TABLE class="formAreaTop">
		      <tr>
		        <td>身份证号</td>
		        <td><input type="text" class="Edit" kind="text" fieldname="IDCARD" maxlength="18"></td>
		        <td>用户姓名</td>
		        <td><input type="text" class="Edit" kind="text" fieldname="USERNAME" operation="like" maxlength="30" hint="模糊查询"></td>
		        <td>&nbsp;</td>
		        <td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQryRU()"></td>
		      </tr>
		    </TABLE>
		    <input type="hidden" id="roleidRU" name="roleidRU" class="Edit" kind="text" fieldname="ROLEID">
		  </form>
	</div>
    <div id="uGrid" region="center" pagingBar="true" pageSize="20" xtype="grid" title="" border="false" buttonAlign="center">
      <div xtype="tbar">
        <span style="font-size:9pt;font-weight:bold;color:#15428B;">角色用户列表</span>
        <div text="->"></div>
        <div iconCls="icon-add" id="cmdAddUser" text="添加用户" onEfsClick="toAddUserToRole()"></div>
        <div iconCls="icon-del" id="cmdDelUser" text="删除用户" onEfsClick="toDelUser()"></div>
      </div>
      <div id="uList" xtype="store" url="<%=rootPath%>/getRsQryRoleUserList.action" txtXML="" autoLoad="false">
        <div xtype="xmlreader" fieldid="USERID" record="ROW" totalRecords="QUERYINFO@records">
          <div name="USERID" mapping="USERID"></div>
          <div name="USERTITLE" mapping="USERTITLE"></div>
          <div name="USERNAME"></div>
          <div name="UNITNAME"></div>
          <div name="DISABLED"></div>
          <div name="USERTYPE"></div>
        </div>
      </div>
      <div xtype="colmodel">
        <div type="checkbox"></div>
        <div header="用户编号" width="140" sortable="true" dataIndex="USERID" align="center"></div>
        <div header="用户名称" width="140" sortable="true" dataIndex="USERTITLE" align="center"></div>
        <div header="用户姓名" width="100" sortable="true" dataIndex="USERNAME" align="center"></div>
        <div header="用户单位" width="200" sortable="true" dataIndex="UNITNAME" align="center"></div>
        <div header="是否禁用" width="60" sortable="true" dataIndex="DISABLED" align="center"></div>
        <div header="用户类型" width="80" sortable="true" dataIndex="USERTYPE" align="center"></div>
      </div>
    </div>
  </div>
  
  	<div xtype="buttons">
     	<div iconCls="icon-ok" text="确  定" onEfsClick="doSubmit()"></div>
     	<div iconCls="icon-back" text="返  回" onEfsClick="doRet()"></div>
     </div>
  
</div>

		<!-- window开始 -->
    <div id="toAddEWin" xtype="window" width="450" height="360" title="给角色添加事件类型权限" resizable="true" modal="true">
	    <div id="etrGrid" region="center" xtype="grid" title="" border="false">
	      <div xtype="tbar">
	        <div text="->"></div>
	        <div iconCls="icon-ok" id="cmdAddEventToRole" text="确  定" onEfsClick="AddEventToRoleSure()"></div>
	      </div>
	      <div id="etrList" xtype="store" url="<%=rootPath%>/getEventTypeList_AddToRole.action" txtXML='' autoLoad="false">
	        <div xtype="xmlreader" fieldid="EVENTTYPEID" record="ROW" totalRecords="QUERYINFO@records">
	          <div name="EVENTTYPEID" mapping="EVENTTYPEID"></div>
	          <div name="EVENTTYPENAME" mapping="EVENTTYPENAME"></div>
	          <div name="DISABLED"></div>
	          <div name="SHORTCUT"></div>
	          <div name="VISIBLE"></div>
	        </div>
	      </div>
	      <div xtype="colmodel">
					<div type="checkbox"></div>
	        <div header="事件类型编号" width="80" sortable="true" dataIndex="EVENTTYPEID" align="center"></div>
	        <div header="事件类型名" width="100" sortable="true" dataIndex="EVENTTYPENAME" align="center"></div>
	        <div header="是否禁用" width="60" sortable="true" dataIndex="DISABLED" align="center"></div>
	        <div header="是否快捷键" width="70" sortable="true" dataIndex="SHORTCUT" align="center"></div>
	        <div header="是否显示" width="60" sortable="true" dataIndex="VISIBLE" align="center"></div>
	      </div>
	    </div>
    </div>
    <!-- window结束 -->

    <!-- window开始 -->
    <div id="toAddUWin" xtype="window" width="760" height="400" title="给角色添加用户" resizable="true" modal="true">
      <!-- 单位树 -->
      <div region="west" width="150" title="选择单位" autoScroll="true">
      	<div id="unittreepanel" xtype="treepanel" height="100%" autoScroll="true" onEfsClick="doUnitTreeClick()" border="false" checkModel="cascade" onlyLeafCheckable="false">
    		<div xtype="loader" id="unittreeloader" url="<%=rootPath%>/getUnitJsonTree.action" txtXML="" parentPath="QUERYINFO" uiProviders="Ext.ux.TreeCheckNodeUI"></div>
      	</div>
      </div>
      <div region="center">
		<div iconCls="icon-user" region="north" height="76" title="用户查询" border="false">
		 <form id="frmQryU"  method="post">
		  <TABLE class="formAreaTop">
		      <tr>
		        <td>身份证号</td>
		        <td><input type="text" class="Edit" kind="text" fieldname="IDCARD" maxlength="18"></td>
		        <td>用户姓名</td>
		        <td><input type="text" class="Edit" kind="text" fieldname="USERNAME" operation="like" maxlength="30" hint="模糊查询"></td>
		      </tr>
		      <tr>
		        <td>用户类型</td>
		        <td><input type="text" class="Edit" kind="dic" src="DIC_USERTYPE" fieldname="USERTYPE"></td>
		        <td>&nbsp;</td>
		        <td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry()"></td>
		      </tr>
		    </TABLE>
		    <input type="hidden" id="munitidU" name="munitidU" class="Edit" kind="text" fieldname="MUNITID" operation="in">
		    <input type="hidden" id="useridU" name="useridU" class="Edit" kind="text" fieldname="USERID" operation="not in">
		  </form>
		</div>
      <div id="utrGrid" region="center" pagingBar="true" pageSize="20" xtype="grid" title="" border="false">
        <div xtype="tbar">
          <div text="->"></div>
          <div iconCls="icon-ok2" id="cmdAddUserToRole" text="确  定" onEfsClick="AddUserToRoleSure()"></div>
        </div>
        <div id="utrList" xtype="store" url="<%=rootPath%>/userList_AddToRole.action" txtXML='' autoLoad="false">
          <div xtype="xmlreader" fieldid="USERID" record="ROW" totalRecords="QUERYINFO@records">
            <div name="USERID" mapping="USERID"></div>
            <div name="USERTITLE" mapping="USERTITLE"></div>
            <div name="USERNAME"></div>
            <div name="UNITNAME"></div>
            <div name="USERTYPE"></div>
          </div>
        </div>
        <div xtype="colmodel">
          <div type="checkbox"></div>
          <div header="用户编号" width="100" sortable="true" dataIndex="USERID" align="center"></div>
          <div header="用户名称" width="100" sortable="true" dataIndex="USERTITLE" align="center"></div>
          <div header="用户姓名" width="100" sortable="true" dataIndex="USERNAME" align="center"></div>
          <div header="用户单位" width="140" sortable="true" dataIndex="UNITNAME" align="center"></div>
          <div header="用户类型" width="100" sortable="true" dataIndex="USERTYPE" align="center"></div>
        </div>
      </div>
    </div>
    </div>
    <!-- window结束 -->

  <FORM id="frmPost" name="frmPost" url="" method="post" style="display:none;" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
    <INPUT type="hidden" id="txtOpXml" name="txtOpXml">
  </FORM>
  
    <FORM id="frmQry" name="frmQry" url="" method="post" style="display:none;">
    <INPUT type="hidden" id="roleid" name="roleid" fieldname="ROLEID" >
  </FORM>
</BODY>
</HTML>

