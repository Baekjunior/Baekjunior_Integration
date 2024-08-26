<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, javax.naming.*, Baekjunior.db.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Baekjunior</title>
<link rel="stylesheet" href="Baekjunior_css.css">
<!-- 난이도별로 모아보는 페이지 -->
</head>
<%
request.setCharacterEncoding("utf-8");
String userId = "none";
HttpSession session = request.getSession(false);
if(session != null && session.getAttribute("login.id") != null) {
	userId = (String) session.getAttribute("login.id");
}
else{
	response.sendRedirect("information.jsp");
    return;
}

int levelSort = Integer.parseInt(request.getParameter("level"));

// 정렬 순서 정하기
String sortClause = "problem_idx DESC"; // 기본 최신순
if (request.getParameter("latest") != null) {
	sortClause = "problem_idx DESC";	// 최신순
} else if (request.getParameter("earliest") != null) {
	sortClause = "problem_idx";	// 오래된 순
} else if (request.getParameter("ascending") != null) {
	sortClause = "problem_id";	// 문제번호 오름차순
} else if (request.getParameter("descending") != null) {
	sortClause = "problem_id DESC";	// 문제번호 내림차순
}
Connection con = DsCon.getConnection();
PreparedStatement problemPstmt = null;
ResultSet problemRs = null;
PreparedStatement problemCountPstmt = null;
ResultSet countRs = null;
PreparedStatement categoryPstmt = null;
ResultSet categoryRs = null;
PreparedStatement levelPstmt = null;
ResultSet levelRs = null;
%>

<script type="text/javascript">
    function confirmDeletion(problemIdx) {
        var result = confirm("정말 삭제하시겠습니까?");
        if (result) {
            window.location.href = "note_delete_do.jsp?problem_idx=" + problemIdx;
        } else {
            return false;
        }
    }
</script>

<script>
	// 고정 여부 업데이트하는 함수
	function updatePin(problemIdx) {
	    var pinIcon = document.getElementById('content_set_a_' + problemIdx);
	    let fix = 0;
	    
		if(pinIcon.offsetWidth > 0 && pinIcon.offsetHeight > 0) {
			pinIcon.style.display = 'none';
			fix = 0;
		} else {
			pinIcon.style.display = 'inline-block';
			fix = 1;
		}
	  
		const xhr = new XMLHttpRequest();
	    xhr.open("POST", "updatePin.jsp", true);
	    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	    xhr.onreadystatechange = function () {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	            console.log(xhr.responseText);  
	        }
	    };
	    xhr.send("problem_idx=" + problemIdx +"&is_fixed=" + fix);
	}
</script>

<body>	
	<header>
		<a href="0_Baekjunior.jsp" class="logo">Baekjunior</a>
		<div id="main_menu">
			<ul>
				<li class="main_menu_Storage"><a href="#">Storage</a>
					<ul>
						<li><a href="#">storage1</a></li>
						<li><a href="#">storage2</a></li>
						<li><a href="#">storage3</a></li>
						<li><a href="#">storage4</a></li>
						<li><a href="#">storage5</a></li>
					</ul>
				</li>				
				<li class="main_menu_Friend"><a href="#">Friend</a>
					<ul>
						<li><a href="#">friend1</a></li>
						<li><a href="#">friend2</a></li>
						<li><a href="#">friend3</a></li>
					</ul>
				</li>
				<li class="main_menu_Group"><a href="#">Group</a>
					<ul>
						<li><a href="#">group1</a></li>
						<li><a href="#">group2</a></li>
					</ul>
				</li>
				<li class="main_menu_MyPage"><a href="MyPage.jsp">MyPage</a>
					<ul>
						<li><a href="#">mypage1</a></li>
						<li><a href="#">mypage2</a></li>
						<li><a href="#">mypage3</a></li>
						<li><a href="#">mypage4</a></li>
					</ul>
				</li>
				<li class="main_menu_Setting"><a href="#">Setting</a>
					<ul>
						<li><a href="#">setting1</a></li>
						<li><a href="#">setting2</a></li>
						<li><a href="#">setting3</a></li>
					</ul>
				</li>
			</ul>
		</div>
		<ul>
			<li><img src="img/user.png" style="width:30px;"></li>
			<li><a href="MyPage.jsp"><%=userId%></a></li>
		</ul>
	</header>
	
	<script type="text/javascript">
		window.addEventListener("scroll", function(){
			var header= document.querySelector("header");
			header.classList.toggle("sticky", window.scrollY > 0);
		});
	</script>
	
	<section class="banner">
		<a href="#" class="logo"></a>
	</section>
	
	
	
	<!-- menu -->
	<nav>
		<div>
			<ul>
				<li><a href="0_Baekjunior.jsp"><b>ALL</b></a></li>
				<li><a href="1_Baekjunior.jsp">BOOKMARK</a></li>
				<li><a href="#">CATEGORY</a>
					<ul class="sub">
					<%
						String categoryQuery = "SELECT * FROM algorithm_memo WHERE user_id=?";
						categoryPstmt = con.prepareStatement(categoryQuery);
						categoryPstmt.setString(1, userId);
						categoryRs = categoryPstmt.executeQuery();
						while(categoryRs.next()) {
					%>
						<li><a href="2_Baekjunior.jsp?sort=<%=categoryRs.getString("algorithm_name")%>"><img src="img/dot1.png">
								<%=categoryRs.getString("algorithm_name") %></a></li>
					<%
						}
					%>
					</ul>
				</li>
				<li><a href="#">LEVEL</a>
					<ul class="sub">
					<%
						String levelQuery = "SELECT DISTINCT tier_name, tier_num, level FROM problems WHERE user_id=? ORDER BY level";
						levelPstmt = con.prepareStatement(levelQuery);
						levelPstmt.setString(1, userId);
						levelRs = levelPstmt.executeQuery();
						while(levelRs.next()){
							String tierName = levelRs.getString("tier_name");
							int tierNum = levelRs.getInt("tier_num");
							int level = levelRs.getInt("level");
					%>
						<li><a href="3_Baekjunior.jsp?level=<%=level%>"><img src="img/star_<%=tierName.toLowerCase()%>.png">
								<%=tierName.toUpperCase()%><%=tierNum %></a></li>
					<%
						}
					%>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	
	<div id="main">
		<div id="main_bar">
			<div id="sort"  class="content_set">
				<div id="sort_select" class="content_set_b">
					<button>SORT</button>
				</div>
				<ul style="top:205px;">
					<li><a href="3_Baekjunior.jsp?latest=true&level=<%=levelSort%>">Latest</a></li>
					<li><a href="3_Baekjunior.jsp?earliest=true&level=<%=levelSort%>">Earliest</a></li>
					<li><a href="3_Baekjunior.jsp?ascending=true&level=<%=levelSort%>">Ascending number</a></li>
					<li><a href="3_Baekjunior.jsp?descending=true&level=<%=levelSort%>">Descending number</a></li>
				</ul>
			</div>
			
			<div id="search">
				<div id="search_frame" style="float:right;">
					<input id="search_input" type="text" placeholder="Search...">
				</div>
				
				<div id="search_selection" style="float:right;">
					<input type="radio" name="search_range" checked></input><label>Number</label>
					<input type="radio" name="search_range"></input><label>Title</label>
					<input type="radio" name="search_range"></input><label>Note</label>
				</div>
			</div>
			<div id="btn_cretenote">
				<button onclick="location.href='create_note.jsp'">CREATE NOTE</button>
			</div>
		</div>
		
		
		<br><br><br>
		
		
		<div id="list_group">
		<ul class="list">
 		<%
 		if (!userId.equals("none")) {
 			try {
 				
 				// 문제 선택
 				String problemQuery = "SELECT * FROM problems WHERE user_id=? and level=? ORDER BY is_fixed DESC, " + sortClause;
 				problemPstmt = con.prepareStatement(problemQuery);
 				problemPstmt.setString(1, userId);
 				problemPstmt.setInt(2, levelSort);
 				problemRs = problemPstmt.executeQuery();
				
 				// 등록된 문제 수 세기
				String problemCountQuery = "SELECT COUNT(*) FROM problems WHERE user_id=?";
				problemCountPstmt = con.prepareStatement(problemCountQuery);
				problemCountPstmt.setString(1, userId);
				countRs = problemCountPstmt.executeQuery();
 			
 				if (countRs.next() && countRs.getInt(1) <= 0) {
 					%>
 					<div>
 						not exist
 					</div>
 					<%
 				} else {
 					// 고정된 문제 먼저 출력
 					while (problemRs.next()) {
 		%>
 			<li class="item">
 				<div class="content_number"><a href="note_detail.jsp?problem_idx=<%=problemRs.getInt("problem_idx")%>"># <%=problemRs.getInt("problem_id") %></a></div>
 				<div class="content_set">
 				<% if(problemRs.getInt("is_fixed") == 1) { %>
	    			<img class="content_set_a" id="content_set_a_<%= problemRs.getInt("problem_idx") %>" src="img/pin.png">
	    		<% } else { %>
	    			<img class="content_set_a" id="content_set_a_<%= problemRs.getInt("problem_idx") %>" src="img/pin.png" style="display:none">
	    			<% } %>
	    		<button class="content_set_b"><img src="img/....png"></button>
	    		<ul>
	    			<li><a onclick="updatePin('<%=problemRs.getInt("problem_idx") %>')" href="#">Unpin / Pin to top</a></li>
	    			<li><a href="split_screen.jsp?problem_idx1=<%=problemRs.getInt("problem_idx")%>&problem_idx2=-1">Split screen</a></li>
	    			<li><a href="#">Setting</a></li>
	    			<li><a onclick="confirmDeletion('<%=problemRs.getInt("problem_idx") %>')" href="#">Delete</a></li>
	    		</ul>
	    	</div>
 				<div class="content_title"><a href="note_detail.jsp?problem_idx=<%=problemRs.getInt("problem_idx")%>"><%=problemRs.getString("memo_title") %></a></div>
 			</li>
 		<%
 					}			
 				}
 			} catch(SQLException e) {
 				out.print(e);
 			} finally {
 				if (con != null) con.close();
				if(problemPstmt != null) problemPstmt.close();
				if(problemRs != null) problemRs.close();
				if(problemCountPstmt != null) problemCountPstmt.close();
				if(countRs != null) countRs.close();
				if(levelPstmt != null) levelPstmt.close();
				if(levelRs != null) levelRs.close();
 			}
 		}
 		%>
		</ul>
		</div>
	</div>
	
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

	<footer></footer>

</body>
</html> 