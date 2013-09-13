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
<title>收入汇总清单</title>

</head>
<%
	String year=request.getParameter("year");
	
%>
<body>
<table border="1">
  <tr>
        <td><table border="1">
        	<thead>
			<tr><td colspan="45" align="center">工资人员清单</td></tr>
			<tr><td colspan="45" align="center">统计日期：<%=year%>年</td></tr>
            <tr>
            	<td rowspan="2" align="center">部门名称</td>
            	<td rowspan="2" align="center">姓名</td>
            	<td rowspan="2" align="center">身份证号</td>
            	<td colspan="3" align="center">1月份</td>
            	<td colspan="3" align="center">2月份</td>
            	<td colspan="3" align="center">3月份</td>
            	<td colspan="3" align="center">4月份</td>
            	<td colspan="3" align="center">5月份</td>
            	<td colspan="3" align="center">6月份</td>
            	<td colspan="3" align="center">7月份</td>
            	<td colspan="3" align="center">8月份</td>
            	<td colspan="3" align="center">9月份</td>
            	<td colspan="3" align="center">10月份</td>
            	<td colspan="3" align="center">11月份</td>
            	<td colspan="3" align="center">12月份</td>
            	<td colspan="3" align="center">13月份</td>
            	<td colspan="3" align="center">合计</td>
            </tr>
            <tr>
            	<td align="center">工资应发</td>
            	<td align="center">绩效应发</td>
            	<td align="center">五险一金</td>
            	<td align="center">工资应发</td>
            	<td align="center">绩效应发</td>
            	<td align="center">五险一金</td>
            	<td align="center">工资应发</td>
            	<td align="center">绩效应发</td>
            	<td align="center">五险一金</td>
            	<td align="center">工资应发</td>
            	<td align="center">绩效应发</td>
            	<td align="center">五险一金</td>
            	<td align="center">工资应发</td>
            	<td align="center">绩效应发</td>
            	<td align="center">五险一金</td>
            	<td align="center">工资应发</td>
            	<td align="center">绩效应发</td>
            	<td align="center">五险一金</td>
            	<td align="center">工资应发</td>
            	<td align="center">绩效应发</td>
            	<td align="center">五险一金</td>
            	<td align="center">工资应发</td>
            	<td align="center">绩效应发</td>
            	<td align="center">五险一金</td>
            	<td align="center">工资应发</td>
            	<td align="center">绩效应发</td>
            	<td align="center">五险一金</td>
            	<td align="center">工资应发</td>
            	<td align="center">绩效应发</td>
            	<td align="center">五险一金</td>
            	<td align="center">工资应发</td>
            	<td align="center">绩效应发</td>
            	<td align="center">五险一金</td>
            	<td align="center">工资应发</td>
            	<td align="center">绩效应发</td>
            	<td align="center">五险一金</td>
            	<td align="center">工资应发</td>
            	<td align="center">绩效应发</td>
            	<td align="center">五险一金</td>
            	<td align="center">工资应发合计</td>
            	<td align="center">绩效应发合计</td>
            	<td align="center">五险一金合计</td>
            </tr></thead>
			<%
				DecimalFormat df = new DecimalFormat("##.00");
				ArrayList al=GzcxBO.getSrhjTot(year);
					//out.println("记录数:"+al.size());
			      			for(int i=0;i<al.size();i++)
			      			{
			      				Map map = (HashMap)al.get(i);
			      				ArrayList al1 = (ArrayList)map.get("arrlist");
			            		out.println("<tr>");
			            		out.println("<td align='center'>"+map.get("bmmc")+"</td>");
			            		out.println("<td align='center'>"+map.get("name")+"</td>");
			            		out.println("<td align='center'>"+map.get("sfzhm")+"&nbsp;</td>");
			            		for(int j=0;j<al1.size();j++){
			            			out.println("<td align='center'>"+al1.get(j)+"</td>");
			            		}
								out.println("</tr>");
			      			}
			%>
        </table></td>
  </tr>
</table>
</body>
</html>
