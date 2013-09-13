<%@ page contentType="text/html;charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
  + request.getServerName() + ":" + request.getServerPort()
  + path + "/";
String strUserIP = request.getRemoteAddr();
%>

<HTML>
<HEAD>
<TITLE>莆田邮政工资查询系统</TITLE>
<STYLE type="text/css">
<!--
BODY {
	BACKGROUND-POSITION: 50% bottom; FONT-SIZE: 12px; BACKGROUND-IMAGE: url(images/bg_login.png); MARGIN: 0px; BACKGROUND-REPEAT: repeat-x; BACKGROUND-COLOR: #a2d5f0
}
TD {
	FONT-SIZE: 12px
}
DIV {
	FONT-SIZE: 12px
}
#login {
	BACKGROUND-POSITION: 50% bottom; BACKGROUND-IMAGE: url(images/bg_login.png); COLOR: white; BACKGROUND-REPEAT: repeat-x; BACKGROUND-COLOR: #a2d5f0
}
#login #main {
	BACKGROUND-IMAGE: url(images/login_main.jpg)
}
#login  TD {
	COLOR: white
}
#login A {
	COLOR: white; TEXT-DECORATION: none
}
#login .textbox {
	WIDTH: 180px;
	color:              #333333;
    font-size:          12px;
    background-color:   #ffffff;
    border:             1px solid #0080FF;
}
-->
</STYLE>
<script language="javascript">
function doKeyDown() {
    var keyCode = event.keyCode;
    var src = event.srcElement;
    var edt1 = document.getElementById("txtUserSfzhm");
    var edt2 = document.getElementById("txtUserName");
    var edt3 = document.getElementById("txtUserPWD");
    var btn = document.getElementById("btnLogin");

    switch (keyCode) {
        case 27:    // ESC
            edt1.value = "";
            edt2.value = "";
            edt3.value = "";
            return false;
            break;

        case 38:    // UP
            if (src == edt1) {
                btn.focus();
            }
            else if (src == edt2) {
                edt1.focus();
            }
            else if (src == edt3) {
                edt2.focus();
            }
            else if (src == btn) {
                edt3.focus();
            }
            break;

        case 13:    // Enter
        case 40:    // Down
        case 108:   // Enter(小键盘上)
            if (src == edt1) {
                edt2.focus();
            }
            else if (src == edt2) {
                edt3.focus();
            }
            else if (src == edt3) {
                btn.focus();
                if (keyCode != 40) {
                    if (doSubmit()) {
                        frmMain.submit();
                    }
                }
            }
            else if (src == btn) {
                edt1.focus();
            }
            return false;
    }
    return true;
}

function doSubmit()
{
    with(document.getElementById("frmMain"))
    {
    	strSfzhm = txtUserSfzhm.value;
    	strUserName = txtUserName.value;
    	strUserPWD = txtUserPWD.value;
    }
    strXml = '<?xml version="1.0"?> <EFSFRAME efsframe="urn=www-efsframe-cn" version="1.0"><DATAINFO><LOGININFO><USERSFZHM>' + document.getElementById("frmMain").txtUserSfzhm.value + '</USERSFZHM><USERNAME>' + document.getElementById("frmMain").txtUserName.value + '</USERNAME><USERPASSWD>' + document.getElementById("frmMain").txtUserPWD.value + '</USERPASSWD></LOGININFO></DATAINFO></EFSFRAME>';
    with(document.getElementById("frmMain"))
    {
    	txtXML.value = strXml;
    	action = "<%=path%>/login.action";
    	submit();
  	}
}

window.onload = function() 
{
  document.getElementById("txtMac").value = "";
  document.getElementById("txtUserSfzhm").focus();
}

</SCRIPT>
</HEAD>
<BODY>
<FORM name="frmMain" id="frmMain" action="" method="post" onSubmit="return doSubmit()">
<DIV id="div1">
  <TABLE id="login" height="100%" cellSpacing="0" cellPadding="0" width="800" align="center">
    <TBODY>
      <TR id="main">
        <TD>
          <TABLE height="100%" cellSpacing="0" cellPadding="0" width="100%">
            <TBODY>
              <TR>
                <TD colSpan="4">&nbsp;</TD>
              </TR>
              <TR height="20">
                <TD width="380">&nbsp;</TD>
                <TD>&nbsp;</TD>
                <TD>&nbsp;</TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR height="20">
                <TD rowSpan="4">&nbsp;</TD>
                <TD></TD>
                <TD><b><font color="#000000">身份证号：</font></b></TD>
                <TD>
                  <INPUT class="textbox" id="txtUserSfzhm" name="txtUserSfzhm" onFocus="this.select()">
                </TD>
                <TD width="120"><INPUT type="hidden" name="txtMac" id="txtMac" value=""><INPUT type="hidden" name="txtXML"></TD>
              </TR>
              <TR height="20">
                <TD rowSpan="4">&nbsp;</TD>
                <TD><b><font color="#000000">姓　　名：</font></b></TD>
                <TD>
                  <INPUT class="textbox" id="txtUserName" name="txtUserName" onFocus="this.select()">
                </TD>
                <TD width="120">&nbsp;</TD>
              </TR>
              <TR height="20">
                <TD><b><font color="#000000">密　　码：</font></b></TD>
                <TD>
                  <INPUT class="textbox" id="txtUserPWD" type="password" name="txtUserPWD" onFocus="this.select()">
                </TD>
                <TD width="120">&nbsp;</TD>
              </TR>
              <TR height="40">
                <TD></TD>
                <TD align="right">
                  <INPUT id="btnLogin" type="submit" value="登 录 " name="btnLogin" accesskey="E" onKeyDown="doKeyDown()">
                </TD>
                <TD width="120">&nbsp;</TD>
              </TR>
              <TR height="130">
                <TD colSpan="4">&nbsp;</TD>
              </TR>
            </TBODY>
          </TABLE>
        </TD>
      </TR>
      <TR height="104">
        <TD align="center"><span style="color:#000000">
          版权所有： 莆田市邮政局 &nbsp;&nbsp; <B>版本：V 1.0</B></span>
          <span style="color:#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业务咨询电话：0594-2380601&nbsp;&nbsp;技术支持电话：0594-2285583&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></TD>
      </TR>
    </TBODY>
  </TABLE>
</DIV>
</FORM>
</BODY>
</HTML>