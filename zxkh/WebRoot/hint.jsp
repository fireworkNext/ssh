<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%
      String url = request.getParameter("url");
      String msg = request.getParameter("msg");

      if (url == null) {
        url = (String) request.getAttribute("url");
      }
      if (msg == null) {
        msg = (String) request.getAttribute("msg");
      }
      String path = request.getContextPath();
      String basePath = request.getScheme() + "://" + request.getServerName()
          + ":" + request.getServerPort() + path + "/";
%>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>信息提示页</title>
    <style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 50px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style1 {
	font-size: x-large;
	font-weight: bold;
}
.button {
  behavior: url("<%=path%>/js/xButton.htc");
  }
a {
    font-size:          9pt;
    color:              navy;
    text-decoration:    none;
}

a:hover {
    font-size:          9pt;
    color:              darkorange;
    text-decoration:    underline;
}

-->
</style>
  </head>
  <SCRIPT LANGUAGE="JavaScript">
function go(strUrl)
{
  var sUrl = "<%=url%>";
  if(sUrl == "back")
  {
    setInterval("history.go(-2);",3000);
  }
  else
  {
    setInterval("document.location='" + strUrl + "'",3000);
  }
}
function doOk(strUrl)
{
  var sUrl = "<%=url%>";
  if(sUrl == "back")
  {
    history.go(-2);
  }
  else
  {
    document.location=strUrl;
  }
}
</SCRIPT>

  <body onload="go('<%=url%>')">
    <table width="600" border="0" align="center" cellpadding="0"
      cellspacing="0">
      <tr valign="top">
        <td width="116">
          <img src="images/common/i_hint.gif">
        </td>
        <td width="484">
          <table width="460" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td>
                <span class="style3">信息提示：</span>
              </td>
            </tr>
          </table>
          <table width="460" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="36" background="images/common/line.gif">
                &nbsp;
              </td>
            </tr>
          </table>
          <table width="460" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="25">
                &nbsp;·
                <%=msg%>
              </td>
            </tr>
            <tr>
              <td height="25">
                &nbsp;
              </td>
            </tr>
            <tr>
              <td height="25" style="font-size:9pt">
                &nbsp;·如果不想等待跳转，请点击
                <a href="#" onclick="doOk('<%=url%>')">直接跳转</a>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>
