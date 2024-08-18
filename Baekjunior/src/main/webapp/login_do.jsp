<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, Baekjunior.db.*, javax.naming.*, java.util.*" session="false"%>
<%
request.setCharacterEncoding("utf-8");

HttpSession session = request.getSession(true);
String id = request.getParameter("id");
String pwd = request.getParameter("pw");

try {
	UserInfoDB userDB = new UserInfoDB();
	if(userDB.userExistCheck(id, pwd) == 1) {
		session.setAttribute("login.id", id);
		session.setAttribute("login.pwd", pwd);
		
		session.setAttribute("login.time", new Long(System.currentTimeMillis()));
		response.sendRedirect("0_Baekjunior.jsp");
	}
	else {
		out.print("<script>alert('아이디 (또는) 비밀번호가 일치하지 않습니다.');history.back();</script>");
	}
	userDB.close();
} catch(SQLException e){
	out.print(e);
	return;
} catch(NamingException e){
	out.print(e);
	return;
}

%>