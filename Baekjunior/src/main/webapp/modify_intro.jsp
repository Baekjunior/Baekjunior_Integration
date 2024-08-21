<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, Baekjunior.db.*, javax.naming.*, java.util.*" session="false"%>
<%
request.setCharacterEncoding("utf-8");
String userId = request.getParameter("user_id");
String introText = request.getParameter("intro");
try {
	UserInfoDB uidb = new UserInfoDB();
	uidb.updateIntro(userId, introText);
	uidb.close();
	
	response.sendRedirect("editProfile.jsp");
} catch(SQLException e) {
	out.print(e);
	return;
}
%>