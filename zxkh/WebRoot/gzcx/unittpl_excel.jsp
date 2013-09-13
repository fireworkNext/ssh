<%@ page contentType="application/vnd.ms-excel;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.io.*,java.text.*"%>
<%@ page import="java.util.ArrayList,org.ptbank.bo.*"%>
<%
	String sTpl = request.getParameter("tpl");
	String sDwbm = request.getParameter("dwbm");
%>
<%
	response.setHeader("Content-disposition", "attachment;filename=" + sDwbm + sTpl + ".et");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>导出模版</title>
<!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name></x:Name><x:WorksheetOptions><x:Selected/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]-->
<style type="text/css">
.td {
	width: 84px;
}

.gdtjContainer .tb tr {
	text-align: center;
	vertical-align: middle;
}

.gdtjContainer .tb th {
	border-left: 0.5pt solid #000;
	border-bottom: 0.5pt solid #000;
	text-align: center;
	font-weight: normal;
	font-size: 10pt;
	middle: ;;
	height: 30px;
}

.gdtjContainer .header th {
	font-size: 12pt;
}

.gdtjContainer .tb tr th.noleftborder {
	border-left: none;
}

.gdtjContainer .tb tr th.rightborder {
	border-right: 0.5pt solid #000;
}
</style>
</head>

<body>
	<div class="gdtjContainer">
		<table class="tb" cellspacing="0" cellpadding="0" border="1">
			<%
				Rptgzcx rptgzcx = new Rptgzcx();
				ArrayList al = rptgzcx.getUnitTplList(sDwbm, sTpl);
				//out.println("记录数:"+al.size());
				/*out.println("<tr>");
				for(int i=0;i<al.size();i++)
				{
					Tpl tpl = (Tpl)al.get(i);
					out.println("<td align='center'>"+tpl.getDbfld()+"</td>");
				}
				out.println("</tr>");*/
				out.println("<tr>");
				for (int j = 0; j < al.size(); j++) {
					Tpl tpl = (Tpl) al.get(j);
					out.println("<td align='center'>" + tpl.getFldname() + "</td>");
				}
				out.println("</tr>");
			%>
		</table>
	</div>
</body>
</html>
