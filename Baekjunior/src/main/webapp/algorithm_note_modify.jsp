<%@ page language="java" contentType="text/html; charset=UTF-8"
   import="java.sql.*, javax.naming.*, Baekjunior.db.*" session="false"%>
<%
request.setCharacterEncoding("utf-8");

String userId = request.getParameter("user_id");
String algorithmName = request.getParameter("algorithm_name");
String algorithmMemo = request.getParameter("algorithm_memo");

AlgorithmMemo am = new AlgorithmMemo();
am.setUser_id(userId);
am.setAlgorithm_name(algorithmName);
am.setAlgorithm_memo(algorithmMemo);
try {
	AlgorithmMemoDB amdb = new AlgorithmMemoDB();
	amdb.updateAlgorithmMemo(am);
	amdb.close();
	response.sendRedirect("algorithm_note.jsp");
} catch(SQLException e) {
	out.print(e);
	return;
}
%>