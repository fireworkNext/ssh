<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../inc/head.inc.jsp" %>
<HTML>
<head>
<title>演示页面</title>
<link rel="stylesheet" type="text/css" href="../css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="../css/efs-all.css" />
<script type="text/javascript" src="../js/loadmask.js"></script>
<script type="text/javascript" src="../js/efs-all.js"></script>
<script language="JavaScript">

function doCodeDic(obj)
{
  var province = Efs.getDom("province");
  var city = Efs.getDom("city");
  var county = Efs.getDom("county");
  
  if(obj.id=="city")        /// 选择了市
  {
    if(province.code != "")
    {
      //alert(province.code);
      obj.src="DIC_CITY" + new String(province.code).substr(0,2);
      //alert(obj.src);
    }
    else
    {
      province.focus();
    }
  }
  else if(obj.id=="county")        /// 选择了区
  {
    if(typeof city.code == "undefined")
      city.focus();
    else if(city.code != "")
      obj.src="DIC_COUNTY" + new String(city.code).substr(0,4);
    else
      city.focus();
  }
}


</script>
</HEAD>
<BODY>
<div xtype="panel" iconCls="icon-dic" title="演示页面" border="false" autoScroll="true" buttonAlign="center">
  <form id="frmData" class="efs-box" url="" method="post"
  onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)"
  >
    <TABLE class="formArea">
        <TR>
          <TD width="100" labelFor="name">姓  名</TD>
          <TD><INPUT id="name" type="text" kind="text" must="true" maxlength="50" fieldname="PERSON/NAME" datatype="0" state="0"></TD>
          <TD width="20"></TD>
          <TD width="100">身份证号码</TD>
          <TD><INPUT type="text" kind="idcard" fieldname="PERSON/IDCARD" sex="sex" birthday="birthday" datatype="0" state="0"></TD>
        </TR>
        <TR>
          <TD width="100" labelFor="sex">性  别</TD>
          <TD><INPUT type="text" kind="dic" src="DIC_SEX" id="sex" fieldname="PERSON/SEX" must="true" state="0"></TD>
          <TD width="20"></TD>
          <TD width="100" labelFor="birthday">出生日期</TD>
          <TD><INPUT type="text" kind="date" id="birthday" fieldname="PERSON/BIRTHDAY" datatype="3" state="0" must="true"></TD>
        </TR>
        <tr>
          <td class="label">所属省</td>
          <td><input type="text" class="Edit" kind="dic" src="DIC_PROVINCE" fieldname="MANAGEUNIT/PROVINCE" must="true" state="0" datatype="0" id="province" ignore="true"></td>
          <td>&nbsp;</td>
          <td class="label">所属市</td>
          <td><input type="text" class="Edit" kind="dic" src="DIC_CITY" fieldname="MANAGEUNIT/CITY" state="0" datatype="0" must="true" id="city" onfocus="doCodeDic(this)" ignore="true"></td>
        </tr>
        <tr>
          <td class="label">所属区</td>
          <td colspan="4"><input type="text" class="Edit" kind="dic" src="DIC_CODE" fieldname="MANAGEUNIT/PLACECODE" must="true" id="county" onfocus="doCodeDic(this)"></td>
        </tr>
        
      </TABLE>
      
  </form>
  <div xtype="buttons">
      <div iconCls="icon-ok2" text="确  定" onEfsClick="doSubmit()"></div>
      <div iconCls="icon-back" text="返  回" onEfsClick="doRet()"></div>      
   </div>
</div>
</BODY>
</HTML>
