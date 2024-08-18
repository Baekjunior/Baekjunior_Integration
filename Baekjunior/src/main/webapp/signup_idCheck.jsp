<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, Baekjunior.db.*, javax.naming.*"%>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");

try {
	UserInfoDB userDB = new UserInfoDB();
	
	// 아이디 중복 체크
	int is_exist = userDB.idCheck(id);
	
	if(is_exist == 1) {	
	%>
	<script>
		opener.document.signupf.idDuplication.value = "0";
		opener.showAlert("이미 존재하는 아이디입니다.");
		window.close();
	</script>
	<%
	} 
	else {
	%>
	<script>
		opener.document.signupf.idDuplication.value = "1";
		opener.showAlert("사용 가능한 아이디입니다.");
		window.close();
	</script>
	<%
	}
	userDB.close();
} catch(SQLException e) {
	out.print(e);
	return;
} catch(NamingException e) {
	out.print(e);
	return;
}
%>
