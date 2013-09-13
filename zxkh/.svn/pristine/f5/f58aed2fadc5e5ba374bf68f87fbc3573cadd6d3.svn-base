<%@ page language="java" import="org.ptbank.cache.*,org.ptbank.bo.*,org.ptbank.func.*,org.ptbank.baseManage.*,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ include file="inc/head.inc.jsp" %>
<%!
/**
'*******************************
'** 程序名称：  portal.jsp
'** 实现功能：   首页portal
'** 设计人员：   gwd
'** 设计日期：   2012-12-15
'*******************************
*/
%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

UserLogonInfo userSession = (UserLogonInfo)request.getSession().getAttribute("user");
SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
String sBgnDate = General.curYear4()+"-01-01";
String sEndDate = sf.format(DateTimeUtil.addDays(-1));
%>
<HTML>
<HEAD>
<base href="<%=basePath%>">
<title>首页portal</title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/efs-all.css" />
<script type="text/javascript" src="js/loadmask.js"></script>
<script type="text/javascript" src="js/efs-all.js"></script>
<script type="text/javascript" src="js/Portal.js"></script>
<script type="text/javascript" src="js/PortalColumn.js"></script>
<script type="text/javascript" src="js/Portlet.js"></script>
<style>
<!--
.efs-box td{
  padding :5;
  font:normal normal normal 9pt Arial;
}
.title{
  font:18pt 黑体;
  color:#ffffff;
}

td{
  font-size:9pt;
}

a  { font:normal 12px ; color:#FFFFFF; text-decoration:none; }
a:hover  { color:#FFFFFF;text-decoration: underline; }

@media print{ 
body {display:none} 
}
-->
</style>

<script type="text/javascript">
Ext.onReady(function(){
    // NOTE: This is an example showing simple state management. During development,
    // it is generally best to disable state management as dynamically-generated ids
    // can change across page loads, leading to unpredictable results.  The developer
    // should ensure that stable state ids are set for stateful components in real apps.
    Ext.state.Manager.setProvider(new Ext.state.CookieProvider());

    // create some portlet tools using built in Ext tool ids
    var tools = [{
        id:'gear',
        handler: function(){
            Ext.Msg.alert('Message', 'The Settings tool was clicked.');
        }
    },{
        id:'close',
        handler: function(e, target, panel){
            panel.ownerCt.remove(panel, true);
        }
    }];

    var viewport = new Ext.Viewport({
        layout:'border',
        items:[{
            xtype:'portal',
            region:'center',
            //margins:'0 0 0 0',
            items:[{
                columnWidth:.33,
                style:'padding:5px 0 5px 5px',
                items:[{
                    title: '',
                    layout:'fit',
                    tools: tools,
                    height:document.body.scrollHeight-30,
                    html: '<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="'+'<%=rootPath%>/gzcx/salarytot.jsp'+'"></iframe>'
                }]
            },{
                columnWidth:.33,
                style:'padding:5px 0 5px 5px',
                items:[{
                    tools: tools,
                    height:(document.body.scrollHeight-40)/2,
                    html: '<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="'+'<%=rootPath%>/gzcx/wagetot.jsp'+'"></iframe>'
                },{
                    title: '',
                    tools: tools,
                    height:(document.body.scrollHeight-40)/2,
                    html: '<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="'+'<%=rootPath%>/gzcx/prizetot.jsp'+'"></iframe>'
                }]
            },{
                columnWidth:.33,
                style:'padding:5px',
                items:[{
                    title: '',
                    tools: tools,
                    height:(document.body.scrollHeight-40)/2,
                    html: '<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="'+'<%=rootPath%>/gzcx/yeartot.jsp'+'"></iframe>'
                },{
                    title: '',
                    tools: tools,
                    height:(document.body.scrollHeight-40)/2,
                    html: '<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="'+'<%=rootPath%>/gzcx/othertot.jsp'+'"></iframe>'
                }]
            }]
            
            /*
             * Uncomment this block to test handling of the drop event. You could use this
             * to save portlet position state for example. The event arg e is the custom 
             * event defined in Ext.ux.Portal.DropZone.
             */
//            ,listeners: {
//                'drop': function(e){
//                    Ext.Msg.alert('Portlet Dropped', e.panel.title + '<br />Column: ' + 
//                        e.columnIndex + '<br />Position: ' + e.position);
//                }
//            }
        }]
    });
});
</script>

</HEAD>
<BODY>
</BODY>
</HTML>