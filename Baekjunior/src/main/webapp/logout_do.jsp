<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, Baekjunior.db.*, javax.naming.*, java.util.*" session="false"%>
<%
	HttpSession session = request.getSession(false);
	if(session != null && session.getAttribute("login.id") != null) {
		session.invalidate();
		response.sendRedirect("information.jsp");
	}
%>