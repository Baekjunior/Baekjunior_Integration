<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, java.util.*, java.io.*, javax.naming.*, Baekjunior.db.*, Baekjunior.multipart.*" session="false"%>
<%
request.setCharacterEncoding("utf-8");

String userId = request.getParameter("user_id");
String introText = request.getParameter("intro");
String originalFileName = "";
String savedFileName = "";

UserInfoDB uidb = new UserInfoDB();
ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");

Collection<Part> parts = request.getParts();
MyMultiPart multiPart = new MyMultiPart(parts, realFolder);

if(multiPart.getMyPart("fileName") != null) {	
	String imageStr = uidb.imageExistCheck(userId);
	// 이미 프로필 사진이 존재하는 경우
	if(imageStr != "") {
		String oldFileName = imageStr;
		File oldFile = new File(realFolder + File.separator + oldFileName);
		oldFile.delete();
	}
	uidb.updateProfileImage(userId, multiPart.getOriginalFileName("fileName"), multiPart.getSavedFileName("fileName"));
}

uidb.updateIntro(userId, introText);
uidb.close();

response.sendRedirect("editProfile.jsp");
%>