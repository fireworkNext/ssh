<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   manageunitlist.jsp
'** 实现功能：   单位管理
'** 设计人员：   gwd
'** 设计日期：   2012-12-21
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/sysadmin";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML XMLNS:ELEMENT>
<head>
<base href="<%=webRoot%>">
<title>单位维护</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<script type="text/javascript" src="js/common.js"></script>

<SCRIPT language="JavaScript">
var sTreeUnitId = "";
var sTreeUnitName = "";
function onDicEx()
{
  location.href = "<%=rootPath%>/toCreateDicFile.action?txtXML=MANAGEUNIT&txtNextUrl=<%=strSelfPath%>/manageunitlist.jsp";
}

var sUnitID = "";
function doGridClick(data)
{
  sUnitID = data["MUNITID"];
  Efs.getExt("cmdEdit").enable();
  Efs.getExt("cmdDel").enable();
}

// 进入查询
function doQry()
{
  var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry"));
  Efs.getDom("unitList").setAttribute("txtXML",strXml);
  Efs.getExt("unitgrid").store.load();
}

function onAddEx()
{
  if(sTreeUnitId == "")
  {
    alert("请点击左边单位树");
	return false;
  }
  Efs.getDom("MUnitID").setAttribute("operation", "0");
	Efs.getDom("MUnitID").setAttribute("state", "0");

  Efs.getExt("frmData").reset();
  //Efs.getExt("treePopWin").show();
  Efs.getExt("msunitid1").setValue(sTreeUnitName);
  //Efs.getDom("msunitid1").setAttribute("value",sTreeUnitName);
  Efs.getDom("msunitid1").setAttribute("code",sTreeUnitId);
  
  with(Efs.getExt("UnitMWin"))
  {
    setTitle("添加单位");
    show();
  }
}

function onEditEx()
{
  if(sUnitID == "")
  {
    alert("没有选择单位");
    return false;
  }
  Efs.getExt("frmData").reset();
  Efs.Common.ajax("<%=rootPath%>/getMunitDetail.action?txtUnitID=" + sUnitID, sUnitID, function(succ, response, options) {
	if (succ) // 是否成功
	{
		var returnXML = response.responseText;
		Efs.Common.setEditValue(returnXML, Efs.getExt("frmData"), "QUERYINFO");
		Efs.getDom("MUnitID").setAttribute("operation", "1");
		Efs.getDom("MUnitID").setAttribute("state", "5");
		with(Efs.getExt("UnitMWin"))
		  {
		    setTitle("修改单位");
		    show();
		  }
	} else {
		alert("返回数据失败!");
		return false;
	}
  });
}

function doMUnit()
{
  Efs.getExt("frmData").submit();
}


function doSave()
{
  Efs.getExt("frmUnit").submit();
}

//获取异步提交的返回监听函数
function frmPostCallBack(bln,from,action)
{
  if(bln)
  {
    alert("保存成功!");
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

// 获取异步提交的返回监听函数
function frmPostSubBack(bln,from,action)
{
  if(bln)
  {
    Efs.getExt("UnitMWin").hide();
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

function onDelEx()
{
  if(sUnitID == "")
  {
    alert("没有选择单位");
    return false;
  }
  
  if(!confirm("确定要删除吗？"))
    return false;
    
  var strXml = Efs.getExt("unitgrid").getDelXml();
  Efs.getExt("frmData").submit(strXml);
}

function onDicEx()
{
  location.href = "<%=rootPath%>/toCreateDicFile.action?txtXML=MANAGEUNIT&txtNextUrl=<%=strSelfPath%>/manageunitlist.jsp";
}

function doUnitTreeClick(node){
	sTreeUnitId=node.attributes.id;
	sTreeUnitName=node.attributes.text;
	//根据sTreeUnitId执行本机单位查询
	Efs.Common.ajax("<%=rootPath%>/getMunitDetail.action?txtUnitID=" + sTreeUnitId, "", cb);
		//将sTreeUnitId付给查询表单的上级单位后，执行下级单位查询
		Efs.getDom("msunitid").value = sTreeUnitId;
		Efs.getDom("unitList").setAttribute("txtXML",Efs.Common.getQryXml(Efs.getExt("frmQry")));
		Efs.getExt("unitgrid").store.load();
	}

	function cb(succ, response, options) {
		Efs.Common.setEditValue(response.responseText, Efs.getExt("frmUnit"), "QUERYINFO");
	}
</SCRIPT>
</HEAD>
<BODY>
<div region="west" width="250" title="单位树" autoScroll="true">
	<div id="unittreepanel" xtype="treepanel" height="100%" autoScroll="true" onEfsClick="doUnitTreeClick()" border="false">
    	<div xtype="loader" id="unittreeloader" url="<%=rootPath%>/getUnitJsonTree.action" txtXML="" parentPath="QUERYINFO"></div>
	</div>
</div>
<div region="center" xtype="tabpanel">
	<div id="tab1" title="本级单位">
		<div region="center" xtype="panel" title="" border="false" autoScroll="true">
	        <div xtype="tbar">
	          <div text="->"></div>
	          <div iconCls="icon-ok2" id="cmdUser" text="保存" onEfsClick="doSave()"></div>
	        </div>
	        <form txtXML="" id="frmUnit" class="efs-box" method="post" url="<%=rootPath%>/unitDeal.action" onEfsSuccess="frmPostCallBack(true)" onEfsFailure="frmPostCallBack(false)">
	        <TABLE>
	          <tr>
	            <td class="label">单位类型</td>
	            <td><input type="text" class="Edit" kind="dic" src="DIC_MTYPE" fieldname="MANAGEUNIT/MTYPE" state="0" datatype="0" must="true"></td>
				<td class="label">上级单位</td>
	            <td><input type="text" class="Edit" kind="dic" src="MANAGEUNIT" state="0" datatype="0" fieldname="MANAGEUNIT/MSUNITID" must="true" disabled="disabled"></td>          
	          </tr>
	          <tr>
	            <td class="label">单位编码</td>
	            <td><input type="text" class="Edit" kind="text" fieldname="MANAGEUNIT/MUNITID" state="0" datatype="0" must="true"></td>
	            <td class="label">单位名称</td>
	            <td><input type="text" class="Edit" kind="text" fieldname="MANAGEUNIT/MUNITNAME" state="0" datatype="0" must="true"></td>
	          </tr>
	          <tr>
	            <td class="label">是否有效</td>
	            <td><input type="text" class="Edit" kind="dic" src="DIC_TRUEFALSE" fieldname="MANAGEUNIT/VALID" state="0" datatype="1" code="1" value="是" must="true"></td>
	            <td class="label">单位级别</td>
	            <td><input type="text" class="Edit" kind="dic" src="DIC_MLEVEL" fieldname="MANAGEUNIT/MLEVEL" state="0" datatype="1" must="true"></td>
	          </tr>
	          <tr>
	            <td class="label">机构编码</td>
	            <td><input type="text" class="Edit" kind="int" fieldname="MANAGEUNIT/JGBM" state="0" datatype="1"></td>
	            <td class="label">联系电话</td>
	            <td><input type="text" class="Edit" kind="int" fieldname="MANAGEUNIT/LXDH" state="0" datatype="1"></td>
	          </tr>
	          <tr>
	            <td class="label">单位描述</td>
	            <td colspan="3"><TEXTAREA class="Edit" kind="text" style="height:60px;width:310px" fieldname="MANAGEUNIT/MDES" state="0" datatype="0"></TEXTAREA></td>
	          </tr>
	        </TABLE>
	        <input type="hidden" class="Edit" maxlength="16" kind="text" fieldname="MANAGEUNIT/MUNITID" must="true" operation="1" writeevent="0" state="5" datatype="0">
	        </form>
	      </div>
	</div>
	<div id="tab2" title="下级单位">
		<div iconCls="icon-panel" region="north" height="100" title="单位查询" border="false">
		 <form id="frmQry"  method="post">
		  <TABLE class="efs-box" >
		      <tr>
		        <TD class="label">单位名称</TD>
		        <TD><input type="text" kind="text" class="Edit" fieldname="MUNITNAME" operation="like" hint="模糊查询"></TD>
		        <TD class="label">单位级别</TD>
		        <TD><input type="text" kind="dic" src="DIC_MLEVEL" class="Edit" fieldname="MLEVEL" ></TD>
		        <TD class="label">单位类型</TD>
		        <TD ><input type="text" kind="dic" src="DIC_MTYPE" class="Edit" fieldname="MTYPE" ></TD>
		      </TR>
		      <TR>
		      	<TD class="label">机构编码</TD>
		        <TD ><input type="text" kind="int" class="Edit" fieldname="JGBM" id="jgbm"></TD>
		        <TD class="label">联系电话</TD>
		        <TD ><input type="text" kind="int" class="Edit" fieldname="LXDH" ></TD>
		        <td><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry()"></td>
		      </TR>
		    </TABLE>
		    <INPUT id="msunitid" name="msunitid" type="hidden" fieldname="MSUNITID" type="text" kind="dic" src="MANAGEUNIT">
		  </form>
		</div>
		
		<div id="unitgrid" region="center" xtype="grid" title="" border="false" pagingBar="true" pageSize="25" onEfsRowClick="doGridClick()" onEfsRowDblClick="onEditEx()" buttonAlign="center">
		  <div xtype="tbar">
		    <span style="font-size:9pt;font-weight:bold;color:#15428B;">单位列表</span>
		    <div text="->"></div>
		    <div iconCls="icon-add" text="增加单位#A" onEfsClick="onAddEx()"></div>
		    <div iconCls="icon-edit" id="cmdEdit" text="编辑单位#E" onEfsClick="onEditEx()" disabled="disabled"></div>
		    <div iconCls="icon-del" id="cmdDel" text="删除单位#D" onEfsClick="onDelEx()" disabled="disabled"></div>
		    <div iconCls="icon-dic" id="cmdDic" text="生成字典文件#T" onEfsClick="onDicEx()"></div>  
		  </div>
			<div id="unitList" xtype="store" url="<%=rootPath%>/getRsQryMunitList.action" txtXML='' autoLoad="false">
				<div xtype="xmlreader" fieldid="MUNITID" tabName="MANAGEUNIT" record="ROW" totalRecords="QUERYINFO@records">
					<div name="MUNITID" mapping="MUNITID"></div>
					<div name="MUNITNAME" mapping="MUNITNAME"></div>
					<div name="MSUNITID"></div>
					<div name="MTYPE"></div>
					<div name="MLEVEL"></div>
					<div name="JGBM"></div>
					<div name="LXDH"></div>
		      		<div name="VALID"></div>
				</div>
			</div>
		
			<div xtype="colmodel">
				<div header="单位编码" width="100" sortable="true" dataIndex="MUNITID" align="center"></div>
				<div header="单位名称" width="120" sortable="true" dataIndex="MUNITNAME" align="center"></div>
				<div header="上级单位" width="120" sortable="true" dataIndex="MSUNITID" align="center"></div>
				<div header="单位类型" width="80" sortable="true" dataIndex="MTYPE"></div>
				<div header="单位级别" width="200" sortable="true" dataIndex="MLEVEL" align="center"></div>
				<div header="机构编码" width="100" sortable="true" dataIndex="JGBM" align="center"></div>
				<div header="联系电话" width="100" sortable="true" dataIndex="LXDH" align="center"></div>
		    	<div header="是否有效" width="80" sortable="true" dataIndex="VALID" align="center"></div>
			</div>
		</div>
	</div>
</div>

    <!-- window开始 -->
    <div iconCls="icon-panel" id="UnitMWin" xtype="window" width="560" height="250" title="添加单位" resizable="true" modal="true">
      <div region="center" xtype="panel" title="" border="false" autoScroll="true">
        <div xtype="tbar">
          <div text="->"></div>
          <div iconCls="icon-ok2" id="cmdUser" text="保存" onEfsClick="doMUnit()"></div>
        </div>
        <form txtXML="" id="frmData" class="efs-box" method="post" url="<%=rootPath%>/unitDeal.action" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
        <TABLE>
          <tr>
            <td class="label">单位类型</td>
            <td><input type="text" class="Edit" kind="dic" src="DIC_MTYPE" fieldname="MANAGEUNIT/MTYPE" state="0" datatype="0" must="true"></td>
			<td class="label">上级单位</td>
            <td><input id="msunitid1" name="msunitid1" type="text" class="Edit" kind="dic" src="MANAGEUNIT" state="0" datatype="0" fieldname="MANAGEUNIT/MSUNITID" must="true" disabled="disabled"></td>          
          </tr>
          <tr>
            <td class="label">单位编码</td>
	            <td><input type="text" class="Edit" kind="text" fieldname="MANAGEUNIT/MUNITID" state="0" datatype="0" must="true"></td>
	            <td class="label">单位名称</td>
	            <td><input type="text" class="Edit" kind="text" fieldname="MANAGEUNIT/MUNITNAME" state="0" datatype="0" must="true"></td>
          </tr>
          <tr>
            <td class="label">是否有效</td>
            <td><input type="text" class="Edit" kind="dic" src="DIC_TRUEFALSE" fieldname="MANAGEUNIT/VALID" state="0" datatype="1" code="1" value="是" must="true"></td>
            <td class="label">单位级别</td>
            <td><input type="text" class="Edit" kind="dic" src="DIC_MLEVEL" fieldname="MANAGEUNIT/MLEVEL" state="0" datatype="1" must="true"></td>
          </tr>
          <tr>
            <td class="label">机构编码</td>
            <td><input type="text" class="Edit" kind="int" fieldname="MANAGEUNIT/JGBM" state="0" datatype="1"></td>
            <td class="label">联系电话</td>
            <td><input type="text" class="Edit" kind="int" fieldname="MANAGEUNIT/LXDH" state="0" datatype="1"></td>
          </tr>
          <tr>
            <td class="label">单位描述</td>
            <td colspan="3"><TEXTAREA class="Edit" kind="text" style="height:60px;width:310px" fieldname="MANAGEUNIT/MDES" state="0" datatype="0"></TEXTAREA></td>
          </tr>
        </TABLE>
        <input type="hidden" class="Edit" name="MUnitID" id="MUnitID" maxlength="16" kind="text" fieldname="MANAGEUNIT/MUNITID" must="true" operation="0" writeevent="0" state="0" datatype="0">
        </form>
      </div>
    </div>
    <!-- window结束 -->
</BODY>
</HTML>

