<%
String rootPath = request.getContextPath();
String webRoot = request.getScheme() + "://"
                 + request.getServerName() + ":" + request.getServerPort()
                 + rootPath + "/";

if(request.getSession().getAttribute("user") == null)
{
%>
<SCRIPT LANGUAGE=javascript>
try{
  top.logOff();
}
catch(e){}
</SCRIPT>
<%
  return;
}
%>
