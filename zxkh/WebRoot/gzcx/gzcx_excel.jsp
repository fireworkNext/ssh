<%@ page contentType="application/vnd.ms-excel;charset=GBK" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URL"%>
<%@ page import = "java.util.Calendar" %>
<%@ page language="java" import = "java.sql.*" %>
<%@ page import = "java.io.*,java.text.*"%>
<%@ page import="java.util.ArrayList,org.ptbank.bo.*" %>
<%
	response.setHeader("Content-disposition","attachment;filename=test1.xls");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��Ա�嵥</title>

</head>
<%
	String year=request.getParameter("year");
	String month=request.getParameter("month");
	String sfzhm=request.getParameter("sfzhm");
	String name=request.getParameter("name");
	String issee=request.getParameter("issee");
	
%>
<body>
<table border="1">
  <tr>
        <td><table border="1">
        	<thead>
			<tr><td colspan="7" align="center">������Ա�嵥</td></tr>
			<tr><td colspan="7" align="center">ͳ�����ڣ�<%=year%>��<%=month%>��</td></tr>
            <tr>
            	<td align="center">���</td>
            	<td align="center">�·�</td>
            	<td align="center">��������</td>
            	<td align="center">���֤��</td>
            	<td align="center">����</td>
            	<td align="center">�鿴����</td>
            	<td align="center">�鿴ʱ��</td>
            </tr></thead>
			<%
				DecimalFormat df = new DecimalFormat("##.00");
					Rptgzcx rptgzcx = new Rptgzcx();
					ArrayList al=rptgzcx.getWageDetail(year,month,sfzhm,name,issee);
					//out.println("��¼��:"+al.size());
			      			for(int i=0;i<al.size();i++)
			      			{
			      				WageDetail wageDetail=(WageDetail)al.get(i);
			            		out.println("<tr>");
			            		out.println("<td align='center'>"+wageDetail.getYear()+"</td>");
			            		out.println("<td align='center'>"+wageDetail.getMonth()+"</td>");
			            		out.println("<td align='center'>"+wageDetail.getBmmc()+"</td>");
			            		out.println("<td align='center'>"+wageDetail.getSfzhm()+"&nbsp;</td>");
			            		out.println("<td align='center'>"+wageDetail.getName()+"</td>");
								out.println("<td align='center'>"+wageDetail.getSee_dt()+"</td>");
								out.println("<td align='center'>"+wageDetail.getSee_tm()+"</td>");
								out.println("</tr>");
			      			}
			%>
        </table></td>
  </tr>
</table>
</body>
</html>
