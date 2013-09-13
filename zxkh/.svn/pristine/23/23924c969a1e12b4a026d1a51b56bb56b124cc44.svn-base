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
<title>人员清单</title>

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
			<tr><td colspan="7" align="center">工资人员清单</td></tr>
			<tr><td colspan="7" align="center">统计日期：<%=year%>年<%=month%>月</td></tr>
            <tr>
            	<td align="center">年度</td>
            	<td align="center">月份</td>
            	<td align="center">部门名称</td>
            	<td align="center">身份证号</td>
            	<td align="center">姓名</td>
            	<td align="center">查看日期</td>
            	<td align="center">查看时间</td>
            </tr></thead>
			<%
				DecimalFormat df = new DecimalFormat("##.00");
					Rptgzcx rptgzcx = new Rptgzcx();
					ArrayList al=rptgzcx.getWageDetail(year,month,sfzhm,name,issee);
					//out.println("记录数:"+al.size());
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
