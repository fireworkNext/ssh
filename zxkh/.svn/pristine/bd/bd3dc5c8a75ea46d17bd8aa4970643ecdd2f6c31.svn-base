<%@ page language="java" import="org.ptbank.cache.*" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   rolelist.jsp
'** 实现功能：   角色维护
'** 设计人员：   gwd
'** 设计日期：   2012-12-21
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/sysadmin";
UserLogonInfo userSession = (UserLogonInfo)request.getSession().getAttribute("user");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ELEMENT>

<head>
<base href="<%=webRoot%>">
<title>角色管理</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<SCRIPT language="JavaScript">
Efs.onReady(
  function(){	
    Efs.getDom("roleList").setAttribute("txtXML",Efs.Common.getQryXml());
    Efs.getExt("roleTab").setActiveTab(1);
    Efs.getExt("rolegrid").store.load();
  }
);
// 进入查询
function doQry()
{
	var strXml = Efs.util.Common.getQryXml(Efs.getExt("frmQry"));

	Efs.getDom("roleList").setAttribute("txtXML",strXml);
	Efs.getExt("roleTab").setActiveTab(1);
	Efs.getExt("rolegrid").store.load();
}

var UserType = '<%=userSession.getUserType()%>';

// 添加角色
function onAddEx()
{
  with(document.frmPost)
  {
    action = "<%=strSelfPath%>/roleadd.jsp";
    txtRoleID.getAttribute("value","");
    submit();
  }
}

var sRoleID = "";

function doGridClick(data,grid,rowId,e)
{
  sRoleID = data["ROLEID"];
  Efs.getExt("cmdEdit").enable();
  Efs.getExt("cmdDel").enable();
}

function onEditEx()
{
  if(sRoleID == "")
  {
    alert("没有选择角色");
    return false;
  }

  if(UserType!="0" && UserType!="1")
  {
    if((sRoleID == "000001") || (sRoleID == "000002"))
    {
      alert("权限不足");
      return false;
    }
  }
  
  with(document.frmPost)
  {
    action = "<%=strSelfPath%>/roleedit.jsp";
    txtXML.setAttribute("value","");
    txtRoleID.setAttribute("value",sRoleID);
    submit();
  }
}

function onDelEx()
{
  if(UserType!="0" && UserType!="1")
  {
    if((sRoleID == "000001"))
    {
      alert("权限不足");
      return false;
    }
  }

  with(document.frmPost)
  {
    var strXML = "<DATAINFO><ROLEBASIC writeevent='0' operation='2'><ROLEID datatype='0' state='5'>" + sRoleID + "</ROLEID></ROLEBASIC></DATAINFO>"
    action = "<%=rootPath%>/roleDrop.action";
    txtXML.setAttribute("value",strXML);
    txtRoleID.setAttribute("value","");
    submit();
  }
}
</SCRIPT>
</HEAD>
<BODY>
<div id="roleTab" region="center" buttonAlign="center" xtype="tabpanel" region="center" border="false" title="角色管理">
     <div id="tab1" title="角色查询">
     <form id="frmQry" class="efs-box" method="post">
      <TABLE>
	        <tr>
	          <td class="label">角色编号</td>
	          <td><input type="text" class="Edit" kind="text" fieldname="ROLEID"></td>
	        </tr>
	        <tr>
	          <td class="label">角色名称</td>
	          <td><input type="text" class="Edit" fieldname="ROLENAME" operation="like" hint="模糊查询"></td>
	        </tr>
	        <tr>
	          <td class="label">角色描述</td>
	          <td><input type="text" class="Edit" fieldname="ROLEDES" operation="like" hint="模糊查询"></td>
	        </tr>
        </TABLE>
      </form>
     </div>
     
     <div id="tab2" title="角色列表">
        <div id="rolegrid" region="center" xtype="grid" title="" border="false" pagingBar="true" pageSize="20" onEfsRowClick="doGridClick()" onEfsRowDblClick="onEditEx()" buttonAlign="center">
          <div xtype="tbar">
            <span style="font-size:9pt;font-weight:bold;color:#15428B;">角色列表</span>
            <div text="->"></div>
            <div iconCls="icon-edit" id="cmdEdit" text="编辑角色#E" onEfsClick="onEditEx()" disabled></div>
            <div text="-"></div>
            <div iconCls="icon-del" id="cmdDel" text="删除角色#D" onEfsClick="onDelEx()" disabled></div>
          </div>
          <div id="roleList" xtype="store" url="<%=rootPath%>/ajax?method=getRsQryRoleList" txtXML='' autoLoad="false">
            <div xtype="xmlreader" fieldid="ROLEID" record="ROW" totalRecords="QUERYINFO@records">
              <div name="ROLEID" mapping="ROLEID"></div>
              <div name="ROLENAME" mapping="ROLENAME"></div>
              <div name="ROLEDES"></div>
            </div>
          </div>
          <div xtype="colmodel">
            <div header="角色编号" width="105" sortable="true" dataIndex="ROLEID" align="center"></div>
            <div header="角色名" width="200" sortable="true" dataIndex="ROLENAME" align="center"></div>
            <div header="角色描述" width="200" sortable="true" dataIndex="ROLEDES" align="center"></div>
          </div>
        </div>
     </div>

    <div xtype="buttons">
      <div text="查  询" onEfsClick="doQry()"></div>
      <div text="增加角色#A" onEfsClick="onAddEx()"></div>
      <div text="返 回" onEfsClick="top.showTask()"></div>      
    </div>       

</div>

  <FORM name="frmPost" action="" method="post" style="display:none;">
    <INPUT type="hidden" name="txtXML">
    <INPUT type="hidden" name="txtRoleID">
  </FORM>
  
</BODY>
</HTML>

