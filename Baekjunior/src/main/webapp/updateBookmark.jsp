<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, javax.naming.*, Baekjunior.db.*" session="false"%>
<%
    int problemIdx = Integer.parseInt(request.getParameter("problem_idx"));
    int isChecked = Integer.parseInt(request.getParameter("is_checked"));

    try {
       ProblemInfoDB pidb = new ProblemInfoDB();
       pidb.updateBookmark(problemIdx, isChecked);
       pidb.close();       
    } catch (SQLException e) {
        out.print(e);
        return;
    } 
%>
