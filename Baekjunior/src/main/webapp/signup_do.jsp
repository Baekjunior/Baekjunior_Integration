<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, Baekjunior.db.*, javax.naming.*" session="false"%>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String pwd = request.getParameter("pw");
String email = request.getParameter("email");

UserInfo ui = new UserInfo();
ui.setUser_id(id);
ui.setPassword(pwd);
ui.setEmail(email);
try {
	UserInfoDB userDB = new UserInfoDB();
	userDB.insertUser(ui);
	userDB.close();
} catch(NamingException e){
	out.print(e);
	return;
} catch(SQLException e){
	out.print(e);
	return;
}
response.sendRedirect("login.jsp");
%>
