<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, java.util.*, java.io.*, javax.naming.*, Baekjunior.db.*, Baekjunior.multipart.*" session="false"%>
<%
request.setCharacterEncoding("utf-8");
String userId = request.getParameter("user_id");
try {
	UserInfoDB uidb = new UserInfoDB();
	
	ServletContext context = getServletContext();
	String realFolder = context.getRealPath("upload");
	
	String imageStr = uidb.imageExistCheck(userId);
	// 이미 프로필 사진이 존재하는 경우
	if(imageStr != "") {
		String oldFileName = imageStr;
		File oldFile = new File(realFolder + File.separator + oldFileName);
		oldFile.delete();
	}
	
	uidb.deleteUser(userId);
	uidb.close();
	
	response.sendRedirect("logout_do.jsp");
} catch (SQLException e) {
	out.print(e);
	return;
}
%>