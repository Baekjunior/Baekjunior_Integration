<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, javax.naming.*, Baekjunior.db.*" session="false"%>
<%
request.setCharacterEncoding("utf-8");
int problemIdx = Integer.parseInt(request.getParameter("problem_idx"));
try {
	ProblemInfoDB pidb = new ProblemInfoDB();
	pidb.deleteProblem(problemIdx);
	pidb.close();
	
	response.sendRedirect("0_Baekjunior.jsp");
} catch(SQLException e) {
	out.print(e);
	return;
}
%>