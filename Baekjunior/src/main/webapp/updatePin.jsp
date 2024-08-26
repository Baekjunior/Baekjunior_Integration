<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, javax.naming.*, Baekjunior.db.*" session="false"%>
<%
request.setCharacterEncoding("utf-8");
int problemIdx = Integer.parseInt(request.getParameter("problem_idx"));
int isFixed = Integer.parseInt(request.getParameter("is_fixed"));

try {
	ProblemInfoDB pidb = new ProblemInfoDB();
	pidb.updatePin(problemIdx, isFixed);
	pidb.close();
}
catch (SQLException e){
	out.print(e);
	return;
}
%>