<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, Baekjunior.db.*, javax.naming.*, java.util.*" session="false"%>
<%
	request.setCharacterEncoding("utf-8");
	String userId = request.getParameter("userId");
	int problemId = Integer.parseInt(request.getParameter("problemId"));
	String problemIdStr = request.getParameter("problemId");
	String problemTitle = request.getParameter("title");
	String problemUrl = request.getParameter("problem_url");
	String problemSort = request.getParameter("problem_sort");
	String tier_name = request.getParameter("tier_name");
	int tier_num = Integer.parseInt(request.getParameter("tier_num"));
	int level = Integer.parseInt(request.getParameter("level"));
	String code = request.getParameter("cppCode");
	
	String isCheckedStr = request.getParameter("check_btn");
	int isChecked = 0; // 기본값을 0(체크되지 않음)으로 설정
	if (isCheckedStr != null) {
	    isChecked = 1; // 체크박스가 체크되었으면 1로 설정
	}
	
	String[] algorithms = request.getParameterValues("sorts");
	String openNote = request.getParameter("open_note");
	
	if(userId.equals("none")){
		response.sendRedirect("login.jsp");
	}
	else {
		ProblemInfo pi = new ProblemInfo();
		pi.setUser_id(userId);
		pi.setProblem_id(problemId);
		pi.setProblem_title(problemTitle);
		pi.setProblem_url(problemUrl);
		pi.setProblem_sort(problemSort);
		pi.setTier_name(tier_name);
		pi.setTier_num(tier_num);
		pi.setLevel(level);
		pi.setCode(code);
		pi.setIs_checked(isChecked);
		try {
			// 필기할 문제 등록
			ProblemInfoDB pdb = new ProblemInfoDB();
			pdb.insertProblem(pi);
			pdb.insertMemoTitle(pi.getProblem_idx(), problemTitle);
			pdb.close();
			
			// 해당 필기의 알고리즘 분류 저장
			AlgorithmSortDB asdb = new AlgorithmSortDB();
			asdb.insertAlgorithmSort(userId, pi.getProblem_idx(), algorithms);		
			asdb.close();
			
			// 내가 해결한 알고리즘 목록 저장하는 db (중복 x)
			AlgorithmMemoDB amdb = new AlgorithmMemoDB();
			for(String algo : algorithms) {
				// 존재하지 않는 알고리즘인 경우 필기할 수 있는 목록에 추가
				if(amdb.algorithmExistCheck(algo) == 0) {
					amdb.insertAlgorithmMemo(userId, algo);
				}
			}
			amdb.close();
			if(openNote.equals("true")){
				response.sendRedirect("note_detail_edit.jsp?problem_idx=" + pi.getProblem_idx());
			}
			else {
				response.sendRedirect("note_detail.jsp?problem_idx=" + pi.getProblem_idx());
			}
		} catch(SQLException e){
			out.print(e);
			return;
		} catch(NamingException e){
			out.print(e);
			return;
		}
	}
	%>