<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, javax.naming.*, Baekjunior.db.*" session="false"%>
<%
request.setCharacterEncoding("utf-8");
int problemIdx = Integer.parseInt(request.getParameter("problem_idx"));
String code = request.getParameter("code_note");
String mainMemo = request.getParameter("main_memo");
String[] subMemos = request.getParameterValues("sub_memo");

ProblemInfo pi = new ProblemInfo();
pi.setProblem_idx(problemIdx);
pi.setCode(code);
pi.setMain_memo(mainMemo);
if(subMemos != null) {
	StringBuilder subMemosBuilder = new StringBuilder();
	for (String memo : subMemos) {
	    if (!memo.trim().isEmpty()) {
	        subMemosBuilder.append(memo.trim()).append("\n");
	    }
	}
	pi.setSub_memo(subMemosBuilder.toString());
}
else {
	pi.setSub_memo(null);
}
try {
	ProblemInfoDB pidb = new ProblemInfoDB();
	pidb.updateProblem(pi);
	pidb.close();
	
	response.sendRedirect("0_Baekjunior.jsp");
} catch (SQLException e){
	out.print(e);
	return;
}
%>