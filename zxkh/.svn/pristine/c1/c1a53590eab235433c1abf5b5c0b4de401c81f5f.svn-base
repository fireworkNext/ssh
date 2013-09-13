<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：   deptlist.jsp
'** 实现功能：   部门管理
'** 设计人员：   gwd
'** 设计日期：   2010-04-03
'*******************************
*/
%>
<%
String strSelfPath = rootPath + "/sysadmin";
%>
<HTML>
<head>
<base href="<%=webRoot%>">
<title>部门维护</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/ext-all-min.js"></script>
<script type="text/javascript" src="js/efs-min.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>

<SCRIPT language="JavaScript">
var sTreeUnitId = "";
var sTreeUnitName = "";
var sTreeDeptId = "";
var sTreeDeptName = "";
var sFlag = "";
var sID = "";
Efs.onReady(function(){ 
	var unitTreeContextMenu = new Ext.menu.Menu({
			id:'unitTreeContextMenu',
			items:[{
				text:'新增部门',
				iconCls:'icon-add',
				handler:function(){
					Efs.getDom("deptId").operation = "0";
					Efs.getDom("deptId").state = "0";
					Efs.getExt("frmData").reset();
					Efs.getDom("munitid1").value=sTreeUnitName;
					Efs.getDom("munitid1").code=sTreeUnitId;
					with(Efs.getExt("oprWin"))
					{
						setTitle("添加部门");
				    	show();
				 	}
				}
			}]
		});
	Efs.getExt("unittreepanel").on("contextmenu",function(node,e){
		e.preventDefault();
		node.select();
		doUnitTreeClick(node);
		unitTreeContextMenu.showAt(e.getXY());
	});
	
	var deptTreeContextMenu = new Ext.menu.Menu({
		id:'deptTreeContextMenu',
		items:[{
			text:'删除',
			iconCls:'icon-del',
			handler:function(){
				if(!confirm("确定要删除吗？"))
			    	return false;
		    	
				var strXml = '<DATAINFO><DEPT operation="2" writeevent="0"><DEPTID datatype="0" state="5">'+sTreeDeptId+"</DEPTID></DEPT></DATAINFO>";
				Efs.getExt("frmDept").submit(strXml);
			}
		}]
	});
	Efs.getExt("depttreepanel").on("contextmenu",function(node,e){
		e.preventDefault();
		node.select();
		doDeptTreeClick(node);
		deptTreeContextMenu.showAt(e.getXY());
	});	
});
function doGridClick(data)
{
  sID = data["DEPTID"];
  Efs.getExt("cmdEdit").enable();
  Efs.getExt("cmdDel").enable();
}

// 进入查询
function doQry()
{
  var strXml = Efs.Common.getQryXml(Efs.getExt("frmQry"));
  Efs.getDom("dataList").txtXML = strXml;
  Efs.getExt("gridList").store.load();
}

function onAddEx()
{
  if(sTreeUnitId == "")
  {
    alert("请点击左边单位树");
    return false;
  }
  if(sTreeDeptId == "")
  {
    alert("请点击左边部门树");
    return false;
  }
  Efs.getDom("deptId").operation = "0";
  Efs.getDom("deptId").state = "0";

  Efs.getExt("frmData").reset();
  Efs.getDom("munitid1").value=sTreeUnitName;
  Efs.getDom("munitid1").code=sTreeUnitId;
  Efs.getDom("parentid1").value=sTreeDeptName;
  Efs.getDom("parentid1").code=sTreeDeptId;
  with(Efs.getExt("oprWin"))
  {
    setTitle("添加部门");
    show();
  }
}

function onEditEx()
{
  if(sID == "")
  {
    alert("没有选择部门");
    return false;
  }
  Efs.getExt("frmData").reset();
  var xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
  xmlhttp.Open("POST","<%=rootPath%>/getDeptDetail.action?txtID=" + sID,false);
  xmlhttp.Send();
  var xmlReturnDoc = new ActiveXObject("MSXML2.DOMDocument");
  xmlReturnDoc = xmlhttp.responseXML;
  Efs.Common.setEditValue(xmlReturnDoc.xml,Efs.getExt("frmData"), "QUERYINFO");
  xmlReturnDoc = null;
  xmlhttp = null;
  Efs.getDom("deptId").operation = "1";
  Efs.getDom("deptId").state = "5";
  
  with(Efs.getExt("oprWin"))
  {
    setTitle("修改部门");
    show();
  }
}

function doOk()
{
  Efs.getExt("frmData").submit();
}

function doSave()
{
  Efs.getExt("frmDept").submit();
}

// 获取异步提交的返回监听函数
function frmPostSubBack(bln,from,action)
{
  if(bln)
  {
    Efs.getExt("oprWin").hide();
    alert("保存成功!");
    doQry();
    //根据选择单位动态加载部门树结构
	var deptTreeLoader = Efs.getExt("depttreepanel").getLoader();
	Efs.getDom("depttreeloader").txtXML=sTreeUnitId;
	deptTreeLoader.load(Efs.getExt("depttreepanel").getRootNode());
  }
  else
  {
    var xml_http = action.response;
    if(xml_http != null)
    {
      var objXML = xml_http.responseXML;
      
      alert("加载失败：" + objXML.selectSingleNode("//FUNCERROR").text);
      objXML = null;
    }
    xml_http = null;
  }
}

function frmPostCallBack(bln,from,action)
{
  if(bln)
  {
	  alert("保存成功!");
	  //根据选择单位动态加载部门树结构
      var deptTreeLoader = Efs.getExt("depttreepanel").getLoader();
	  Efs.getDom("depttreeloader").txtXML=sTreeUnitId;
	  deptTreeLoader.load(Efs.getExt("depttreepanel").getRootNode());
  }
  else
  {
    var xml_http = action.response;
    if(xml_http != null)
    {
      var objXML = xml_http.reponseXML;
      
      alert("加载失败：" + objXML.selectSingleNode("//FUNCERROR").text);
      objXML = null;
    }
    xml_http = null;
  }
}

function onDelEx()
{
  if(sID == "")
  {
    alert("没有选择部门");
    return false;
  }
  
  if(!confirm("确定要删除吗？"))
    return false;
    
  var strXml = Efs.getExt("gridList").getDelXml();
  Efs.getExt("frmData").submit(strXml);
}

function onDicEx()
{
  location.href = "<%=rootPath%>/createDeptDicFile.action?txtXML=DEPT&txtNextUrl=<%=strSelfPath%>/deptlist.jsp";
}

function doUnitTreeClick(node){
	sTreeUnitId=node.attributes.id;
	sTreeUnitName=node.attributes.text;
	sFlag = node.attributes.flag;
	if(!node.attributes.right){
		Ext.Msg.alert("信息窗口","单位:"+node.attributes.text+",不在您的可管理单位范围");
		return false;
	}
	//根据选择单位动态加载部门树结构
	var deptTreeLoader = Efs.getExt("depttreepanel").getLoader();
	Efs.getDom("depttreeloader").txtXML=sTreeUnitId;
	deptTreeLoader.load(Efs.getExt("depttreepanel").getRootNode());
}

function doDeptTreeClick(node){
	sTreeDeptId=node.attributes.id;
	sTreeDeptName=node.attributes.text;
	sFlag=node.attributes.flag;
	if(!node.attributes.right){
		Ext.Msg.alert("信息窗口","部门:"+node.attributes.text+",不在您的可管理部门范围");
		return false;
	}
	//根据sTreeDeptId执行本机单位查询
	Efs.Common.ajax("<%=rootPath%>/getDeptDetail.action?txtID=" + sTreeDeptId,"",cb);
	//sTreeUnitId付给所属单位及sTreeDeptId付给查询表单的上级部门后，执行下级部门查询
	Efs.getDom("munitid").value=sTreeUnitId;
	Efs.getDom("parentid").value=sTreeDeptId;
	Efs.getDom("dataList").txtXML = Efs.Common.getQryXml(Efs.getExt("frmQry"));
  	Efs.getExt("gridList").store.load();
}

function cb(succ,response,options){
	Efs.getExt("frmDept").reset();
	var deptDoc = response.responseXML;
	Efs.Common.setEditValue(response.responseXML.xml,Efs.getExt("frmDept"), "QUERYINFO");
	//处理上级部门为空的情况
	/*if(deptDoc.selectSingleNode("//PARENTID").text==""){
		Efs.getDom("parentid2").value="";
		Efs.getDom("parentid2").code="";	
	}*/
}

</SCRIPT>
</HEAD>
<BODY>
<div region="west" width="300" title="单位部门树" collapsible="true">
	<div region="west" width="150" title="单位树" autoScroll="true">
		<div id="unittreepanel" xtype="treepanel" height="600" autoScroll="true" onEfsClick="doUnitTreeClick()" border="false">
	    	<div xtype="loader" id="unittreeloader" url="<%=rootPath%>/getUnitJsonTree.action" txtXML="" parentPath="QUERYINFO"></div>
		</div>
	</div>
	
	<div region="center" title="部门树" autoScroll="true">
      	<div region="center" id="depttreepanel" xtype="treepanel" height="600" autoScroll="true" onEfsClick="doDeptTreeClick()" border="false" autoLoad="false">
    		<div xtype="loader" id="depttreeloader" url="<%=rootPath%>/getDeptJsonTree.action" txtXML="" parentPath="QUERYINFO"></div>
      	</div>
    </div>
</div>

<div region="center" xtype="tabpanel">
	<div id="tab1" title="本级部门">
	  <div region="center" xtype="panel" title="" border="false" autoScroll="true">
        <div xtype="tbar">
          <div text="->"></div>
          <div iconCls="icon-ok2" id="cmdUser" text="保存" onEfsClick="doSave()"></div>
        </div>
        <form txtXML="" id="frmDept" class="efs-box" method="post" url="<%=rootPath%>/deptDeal.action" onEfsSuccess="frmPostCallBack(true)" onEfsFailure="frmPostCallBack(false)">
        <TABLE>
          <tr>
            <td class="label">所属单位</td>
            <td colspan="3"><input type="text" style="width:385px" class="Edit" kind="dic" src="MANAGEUNIT" fieldname="DEPT/MUNITID" state="0" datatype="0" must="true" disabled="disabled"></td>
          </tr>
          <tr>
            <td class="label">部门类型</td>
            <td><input type="text" class="Edit" kind="dic" src="DIC_DTYPE" fieldname="DEPT/DEPTTYPE" state="0" datatype="0" must="true"></td>
			<td class="label">上级部门</td>
            <td><input type="text" id="parentid2" name="parentid2" class="Edit" kind="dic" src="DEPT" state="0" datatype="0" fieldname="DEPT/PARENTID"></td>          
          </tr>
          <tr>
            <td class="label">部门名称</td>
            <td colspan="3"><input type="text" style="width:385px" class="Edit" kind="text" fieldname="DEPT/DEPTNAME" state="0" datatype="0" must="true"></td>
          </tr>
          <tr>
            <td class="label">是否有效</td>
            <td><input type="text" class="Edit" kind="dic" src="DIC_TRUEFALSE" fieldname="DEPT/VALID" state="0" datatype="1" code="1" value="是" must="true"></td>
            <td class="label">部门级别</td>
            <td><input type="text" class="Edit" kind="dic" src="DIC_DLEVEL" fieldname="DEPT/DEPTLEVEL" state="0" datatype="1" must="true"></td>
          </tr>
          <tr>
            <td class="label">机构编码</td>
            <td><input type="text" class="Edit" kind="int" fieldname="DEPT/JGBM" state="0" datatype="1"></td>
            <td class="label">联系电话</td>
            <td><input type="text" class="Edit" kind="text" fieldname="DEPT/LXDH" state="0" datatype="0"></td>
          </tr>
          <tr>
            <td class="label">部门描述</td>
            <td colspan="3"><TEXTAREA class="Edit" kind="text" style="height:60px;width:385px" fieldname="DEPT/DEPTDESC" state="0" datatype="0"></TEXTAREA></td>
          </tr>
        </TABLE>
        <input type="hidden" class="Edit" maxlength="16" kind="text" fieldname="DEPT/DEPTID" must="true" operation="1" writeevent="0" state="5" datatype="0">
        </form>
      </div>
	</div>
	<div id="tab2" title="下级部门">
		<div iconCls="icon-panel" region="north" height="80" title="部门查询" border="false" collapsible="true" collapseMode="mini">
		 <form id="frmQry"  method="post">
		  <TABLE class="formAreaTop" width="100%" height="100%" cellpadding="0" cellspacing="0">
		      <tr>
		        <TD>部门名称</TD>
		        <TD><INPUT fieldname="DEPTNAME" type="text" operation="like" hint="模糊查询"></TD>
		        <TD>部门类型</TD>
		        <TD><INPUT fieldname="DEPTTYPE" type="text" kind="dic" src="DIC_DTYPE"></TD>
		      </TR>
		      <TR>
		      	<TD>机构编码</TD>
		        <TD><INPUT fieldname="JGBM" type="text" kind="int"></TD>
		        <TD>联系电话</TD>
		        <TD><INPUT fieldname="LXDH" type="text" kind="text"></TD>
		        <td>&nbsp;</td>
		        <td align="center"><input iconCls="icon-qry" type="button" value="查 询" onEfsClick="doQry()"></td>
		      </TR>
		    </TABLE>
		    <INPUT id="munitid" name="munitid" type="hidden" fieldname="MUNITID" type="text" kind="dic" src="MANAGEUNIT">
		    <INPUT id="parentid" name="parentid" fieldname="PARENTID" type="text" kind="dic" src="DEPT">
		  </form>
		</div>
		
		<div id="gridList" region="center" xtype="grid" title="" border="false" pagingBar="true" pageSize="25" onEfsRowClick="doGridClick()" onEfsRowDblClick="onEditEx()" buttonAlign="center">
		  <div xtype="tbar">
		    <span style="font-size:9pt;font-weight:bold;color:#15428B;">部门列表</span>
		    <div text="->"></div>
		    <div iconCls="icon-add" text="增加部门#A" onEfsClick="onAddEx()"></div>
		    <div iconCls="icon-edit" id="cmdEdit" text="编辑部门#E" onEfsClick="onEditEx()" disabled="disabled"></div>
		    <div iconCls="icon-del" id="cmdDel" text="删除部门#D" onEfsClick="onDelEx()" disabled="disabled"></div>
		    <div iconCls="icon-dic" id="cmdDic" text="生成字典文件#T" onEfsClick="onDicEx()"></div>
		    <div iconCls="icon-back" text="返 回" onEfsClick="top.showTask()"></div>      
		  </div>
			<div id="dataList" xtype="store" url="<%=rootPath%>/getDeptList.action" txtXML='' autoLoad="false">
				<div xtype="xmlreader" fieldid="DEPTID" tabName="DEPT" record="ROW" totalRecords="QUERYINFO@records">
					<div name="DEPTID" mapping="DEPTID"></div>
					<div name="DEPTNAME" mapping="DEPTNAME"></div>
					<div name="MUNITID"></div>
					<div name="PARENTID"></div>
					<div name="DEPTTYPE"></div>
					<div name="DEPTLEVEL"></div>
					<div name="JGBM"></div>
					<div name="LXDH"></div>
		      		<div name="VALID"></div>
				</div>
			</div>
		
			<div xtype="colmodel">
				<div header="所属单位" width="120" sortable="true" dataIndex="MUNITID" align="center"></div>
				<div header="部门名称" width="120" sortable="true" dataIndex="DEPTNAME" align="center"></div>
				<div header="上级部门" width="120" sortable="true" dataIndex="PARENTID" align="center"></div>
				<div header="部门类型" width="80" sortable="true" dataIndex="DEPTTYPE"></div>
				<div header="部门级别" width="60" sortable="true" dataIndex="DEPTLEVEL" align="center"></div>
				<div header="机构编码" width="100" sortable="true" dataIndex="JGBM" align="center"></div>
				<div header="联系电话" width="100" sortable="true" dataIndex="LXDH" align="center"></div>
		    	<div header="是否有效" width="80" sortable="true" dataIndex="VALID" align="center"></div>
			</div>
		</div>
	</div>
</div>


    <!-- window开始 -->
    <div iconCls="icon-panel" id="oprWin" xtype="window" width="560" height="280" title="添加部门" resizable="true" modal="true">
      <div region="center" xtype="panel" title="" border="false" autoScroll="true">
        <div xtype="tbar">
          <div text="->"></div>
          <div iconCls="icon-ok2" id="cmdUser" text="保存" onEfsClick="doOk()"></div>
        </div>
        <form txtXML="" id="frmData" class="efs-box" method="post" url="<%=rootPath%>/deptDeal.action" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
        <TABLE>
          <tr>
            <td class="label">所属单位</td>
            <td colspan="3"><input type="text" id="munitid1" name="munitid1" style="width:385px" class="Edit" kind="dic" src="MANAGEUNIT" fieldname="DEPT/MUNITID" state="0" datatype="0" must="true" disabled="disabled"></td>
          </tr>
          <tr>
            <td class="label">部门类型</td>
            <td><input type="text" class="Edit" kind="dic" src="DIC_DTYPE" fieldname="DEPT/DEPTTYPE" state="0" datatype="0" must="true"></td>
			<td class="label">上级部门</td>
            <td><input type="text" id="parentid1" name="parentid1" class="Edit" kind="dic" src="DEPT" state="0" datatype="0" fieldname="DEPT/PARENTID" disabled="disabled"></td>          
          </tr>
          <tr>
            <td class="label">部门名称</td>
            <td colspan="3"><input type="text" style="width:385px" class="Edit" kind="text" fieldname="DEPT/DEPTNAME" state="0" datatype="0" must="true"></td>
          </tr>
          <tr>
            <td class="label">是否有效</td>
            <td><input type="text" class="Edit" kind="dic" src="DIC_TRUEFALSE" fieldname="DEPT/VALID" state="0" datatype="1" code="1" value="是" must="true"></td>
            <td class="label">部门级别</td>
            <td><input type="text" class="Edit" kind="dic" src="DIC_DLEVEL" fieldname="DEPT/DEPTLEVEL" state="0" datatype="1" must="true"></td>
          </tr>
          <tr>
            <td class="label">机构编码</td>
            <td><input type="text" class="Edit" kind="int" fieldname="DEPT/JGBM" state="0" datatype="1"></td>
            <td class="label">联系电话</td>
            <td><input type="text" class="Edit" kind="text" fieldname="DEPT/LXDH" state="0" datatype="0"></td>
          </tr>
          <tr>
            <td class="label">部门描述</td>
            <td colspan="3"><TEXTAREA class="Edit" kind="text" style="height:60px;width:385px" fieldname="DEPT/DEPTDESC" state="0" datatype="0"></TEXTAREA></td>
          </tr>
        </TABLE>
        <input type="hidden" class="Edit" name="deptId" id="deptId" maxlength="16" kind="text" fieldname="DEPT/DEPTID" must="true" operation="0" writeevent="0" state="0" datatype="0">
        </form>
      </div>
    </div>
    <!-- window结束 -->
    
</BODY>
</HTML>

