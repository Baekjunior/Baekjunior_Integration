<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, javax.naming.*, Baekjunior.db.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Baekjunior</title>
<link rel="stylesheet" href="Baekjunior_css.css">

<!-- 알고리즘 분류별로 모아보는 페이지 -->
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

//모아볼(선택한) 알고리즘 분류
String algorithmSort = request.getParameter("sort");

// 정렬 순서 정하기
String sortClause = "p.problem_idx DESC"; // 기본 최신순
if (request.getParameter("latest") != null) {
	sortClause = "p.problem_idx DESC";	// 최신순
} else if (request.getParameter("earliest") != null) {
	sortClause = "p.problem_idx";	// 오래된 순
} else if (request.getParameter("ascending") != null) {
	sortClause = "p.problem_id";	// 문제번호 오름차순
} else if (request.getParameter("descending") != null) {
	sortClause = "p.problem_id DESC";	// 문제번호 내림차순
}

String searchRange = request.getParameter("search_range");
String searchKeyword = request.getParameter("search_keyword");

// 기본 SQL 쿼리 (검색어가 없을 경우 전체 검색)
String problemQuery = "SELECT * FROM problems p JOIN algorithm_sort a ON p.problem_idx=a.problem_idx " 
					+ "WHERE a.user_id=? AND a.sort=?";

if (searchKeyword != null && !searchKeyword.isEmpty()) {
    searchKeyword = searchKeyword.replace(" ", ""); // 검색어에서 공백 제거

    if ("number".equals(searchRange)) {
        // 문제 번호로 검색
        problemQuery += " AND REPLACE(problem_id, ' ', '') LIKE ?";
    } else if ("title".equals(searchRange)) {
        // 제목으로 검색
        problemQuery += " AND REPLACE(memo_title, ' ', '') LIKE ?";
    } else if ("note".equals(searchRange)) {
        // 메모 내용으로 검색
        problemQuery += " AND REPLACE(main_memo, ' ', '') LIKE ?";
    }
}

problemQuery += " ORDER BY is_fixed DESC, " + sortClause;

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
	<header style="padding:0 100px;">
		<a href="0_Baekjunior.jsp" class="logo">Baekjunior</a>
		<div id="main_menu">
			<ul>
				<li class="main_menu_Storage"><a href="#">Storage</a>
					<ul>
						<li><a href="0_Baekjunior.jsp">ALL</a></li>
						<li><a href="1_Baekjunior.jsp">BOOKMARK</a></li>
						<li><a href="2_Baekjunior.jsp">CATEGORY</a></li>
						<li><a href="3_Baekjunior.jsp">LEVEL</a></li>
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
		<%
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			if(userId != "none") {
				String sql = "SELECT * FROM users WHERE user_id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, userId);
				rs = pstmt.executeQuery();
				rs.next();
			}

		%>
		<div>
			<ul onmouseover="opendiv()" onmouseout="closediv()" style="height:130px;">
				<li><img src="img/user.png" style="width:30px;"></li>
				<li><a href="#"><%=userId %></a></li>
			</ul>
			<div id="myprodiv" onmouseover="opendiv()" onmouseout="closediv()" style="display:none;position:fixed;top: 100px;background: white;padding: 17px;border: 3px solid black;margin-right: 20px;width: 200px;">
				<img src="./upload/<%=rs.getString("savedFileName") %>" alt="profileimg" style="border-radius:70%;width:70px;">
				<a href="MyPage.jsp" style="position:absolute;top:30px;margin-left:20px;text-decoration: none;color: black;"><%=userId %></a>
				<a href="logout_do.jsp" style="border: 1px solid;width: 90px;display:inline-block;text-align: center;height: 30px;position:absolute;top:60px;margin-left:8px;text-decoration: none;color: black;">로그아웃</a>
			</div>
		</div>
		<%
		pstmt.close();
		rs.close();
		} catch (SQLException e){
			out.print(e);
			return;
		}	
		%>
		<!-- 프로필, 로그아웃 div 띄우기 -->
		<script>
		function opendiv() {
			document.getElementById("myprodiv").style.display = "block";
		}
		function closediv() {
			document.getElementById("myprodiv").style.display = "none";
		}
		</script>
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
				<li><a href="0_Baekjunior.jsp">ALL</a></li>
				<li><a href="1_Baekjunior.jsp">BOOKMARK</a></li>
				<li><a href="#">LEVEL</a>
					<ul class="sub" style="font-size:17px;">
					<%
						String levelQuery = "SELECT DISTINCT tier_name, tier_num, level FROM problems WHERE user_id=? ORDER BY level";
						levelPstmt = con.prepareStatement(levelQuery);
						levelPstmt.setString(1, userId);
						levelRs = levelPstmt.executeQuery();
						while(levelRs.next()){
							String tierName = levelRs.getString("tier_name");
							int tierNum = levelRs.getInt("tier_num");
							int level = levelRs.getInt("level");
							if(tierName.equals("unrated")) {
						%>
							<li><a href="3_Baekjunior.jsp?level=<%=level%>&tier_name=<%=tierName%>&tier_num=<%=tierNum%>"><span><img src="img/star_<%=tierName.toLowerCase()%>.png"></span><span><%=tierName.toUpperCase()%></span></a></li>
						<%
								} else {
						%>
							<li><a href="3_Baekjunior.jsp?level=<%=level%>&tier_name=<%=tierName%>&tier_num=<%=tierNum%>"><span><img src="img/star_<%=tierName.toLowerCase()%>.png"></span><span><%=tierName.toUpperCase()%><%=tierNum %></span></a></li>
						<%
								}
							}
						%>
					</ul>
				</li>
				<li><a href="#"><b>CATEGORY</b></a>
					<ul class="sub" style="font-size:17px;">
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
			</ul>
			<br><br><br>
		</div>
	</nav>
	
	<div id="main">
		<div id="main_bar">
			<div style="margin-bottom:50px;display:flex;" >
				<a style="font-size:30px; font-weight:bold;"" onclick="location.href='algorithm_note.jsp?algorithm_sort=<%=algorithmSort%>'">
				CATEGORY : <%=algorithmSort %></a>
				<!-- 해당 알고리즘 노트 리스트는 오른쪽으로 밀리고 왼쪽에 알고리즘노트 나오는 버튼 -->
				<button class="memobutton" id="openmemo" onclick="openmemo()">memo</button>
				<button class="memobutton" id="closememo" onclick="closememo()" style="display:none;">close</button>
				<script>
				function openmemo() {
					document.getElementById("memo").style.display = "block";
					document.getElementById("openmemo").style.display = "none";
					document.getElementById("closememo").style.display = "block";
				}
				function closememo() {
					document.getElementById("memo").style.display = "none";
					document.getElementById("openmemo").style.display = "block";
					document.getElementById("closememo").style.display = "none";
				}
				</script>
			</div>
			
			<div id="sort"  class="content_set">
				<div id="sort_select" class="content_set_b">
					<button>SORT</button>
				</div>
				<ul style="top:205px;">
					<li><a href="2_Baekjunior.jsp?latest=true&sort=<%=algorithmSort%>&search_range=<%=searchRange%>&search_keyword=<%=searchKeyword%>">Latest</a></li>
					<li><a href="2_Baekjunior.jsp?earliest=true&sort=<%=algorithmSort%>&search_range=<%=searchRange%>&search_keyword=<%=searchKeyword%>">Earliest</a></li>
					<li><a href="2_Baekjunior.jsp?ascending=true&sort=<%=algorithmSort%>&search_range=<%=searchRange%>&search_keyword=<%=searchKeyword%>">Ascending number</a></li>
					<li><a href="2_Baekjunior.jsp?descending=true&sort=<%=algorithmSort%>&search_range=<%=searchRange%>&search_keyword=<%=searchKeyword%>">Descending number</a></li>
				</ul>
			</div>
			
			<div id="search">
				<div id="search_frame" style="float:right;">
					<input id="search_input" type="text" placeholder="Search...">
					<span><img src="img/search.png" style="width:15px;" onclick="searchNotes()"></span>
				</div>
				
				<div id="search_selection" style="float:right;">
					<input type="hidden" id="algo_search" value="<%=algorithmSort %>">
					<input type="radio" name="search_range" value="number" 
					<%
				    if (request.getParameter("search_range") == null || "number".equals(request.getParameter("search_range"))) {
				    %> 
				    	checked 
				    <%
				    }
				    %>></input><label>Number</label>
					<input type="radio" name="search_range" value="title"
					<%
				    if ("title".equals(request.getParameter("search_range"))) {
				    %> 
				    	checked 
				    <%
				    }
				    %>></input><label>Title</label>
					<input type="radio" name="search_range" value="note"
					<%
				    if ("note".equals(request.getParameter("search_range"))) {
				    %> 
				    	checked 
				    <%
				    }
				    %>></input><label>Note</label>
				</div>
			</div>
			<div id="btn_cretenote">
				<button onclick="location.href='create_note.jsp'">CREATE NOTE</button>
			</div>
		</div>
		
		<script>
		function searchNotes() {
			// 사용자가 입력한 검색어 받아옴. 불필요한 공백 제거
	        var searchKeyword = document.getElementById("search_input").value.trim().replace(/\s+/g, '');
	        // 라디오 버튼 중, checked 상태인 놈을 고름
	        var searchRange = document.querySelector('input[name="search_range"]:checked').value;
	        var algoSearch = document.getElementById("algo_search").value;
		
	        window.location.href = '2_Baekjunior.jsp?sort=' + algoSearch + '&search_range=' + searchRange + '&search_keyword=' + searchKeyword;
	    }
		</script>
		
		<br><br><br>
		
		
		<div style="display:flex;margin-left:55px;">
			 <div class="memo" id="memo" style="margin-top:20px;flex:4;animation-name:takent;animation-duration:2s;display:none;">
               <div class="memo_box" contenteditable="true" id="editablememo" style="min-height:600px;padding:30px;background:white;border-radius:10px;border:3px solid black;">
                  <%
                  	String memoSql = "SELECT * FROM algorithm_memo WHERE user_id=? AND algorithm_name=?";
	                PreparedStatement memoPstmt = null;
	                ResultSet memoRs = null;
                  	memoPstmt = con.prepareStatement(memoSql);
                  	memoPstmt.setString(1, userId);
                  	memoPstmt.setString(2, algorithmSort);
                  	
                  	memoRs = memoPstmt.executeQuery();
                  	if(memoRs.next()) {
                  %>
                  <%=Util.nullChk(memoRs.getString("algorithm_memo"), "not exist")%>
                  <% } %>
               </div>
               <!-- editablememo 내용 수정할때마다 받아오기 -->
               <script>
                  const editablememo = document.getElementById('editablememo');
                  
                  // 텍스트가 수정될 때마다 발생하는 이벤트 리스너 추가
                  editablememo.addEventListener('input', function() {
                     //변경된 텍스트 받아오기
                     const editedtext = this.innerText;
                     console.log('변경된 텍스트: ', editedtext);
                  })
                  editablememo.addEventListener('focusout', function() {
                      console.log('포커스를 잃었습니다.');
                      // 사용자가 메모box를 벗어나면 db에 저장
                      
	                  const xhr = new XMLHttpRequest();
	                  const userId = '<%= userId %>'; // 세션에서 가져온 사용자 ID
	                  const algorithmSort = '<%= algorithmSort %>'; // 문제의 알고리즘 분류
	                  const editedtext = editablememo.innerText	; // 현재 수정된 텍스트
	
	                  xhr.open("POST", "algorithm_note_modify.jsp", true);
	                  xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	                  xhr.onreadystatechange = function () {
	                      if (xhr.readyState === 4 && xhr.status === 200) {
	                          console.log("Response from server: ", xhr.responseText);
	                       }
	                  };
	
	                  // 파라미터로 userId, algorithmSort, 수정된 메모를 전송
	                  xhr.send("user_id=" + encodeURIComponent(userId) + "&algorithm_name=" + encodeURIComponent(algorithmSort) + "&algorithm_memo=" + encodeURIComponent(editedtext));
	                  });
                  
               </script>
            </div>
            
            <div id="list_group" style="flex:6;">
				<ul class="list" style="margin: 20px 0 0 0;">
		 		<%
 		if (!userId.equals("none")) {
 			try {
 				
 				problemPstmt = con.prepareStatement(problemQuery);
 				problemPstmt.setString(1, userId);
 				problemPstmt.setString(2, algorithmSort);
 				// 검색어가 있을 경우 쿼리에 파라미터 설정
	 			if (searchKeyword != null && !searchKeyword.isEmpty()) {
 				    problemPstmt.setString(3, "%" + searchKeyword + "%");
 				}
				
	 			problemRs = problemPstmt.executeQuery();
	 			
	 			int resultCount = 0;
 				while (problemRs.next()) {
 				    resultCount++;
 				}
 			
 				if (resultCount > 0) {
 					problemRs.beforeFirst();
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
 				} else {
 		%>
 				<div>
 					not exist
 				</div>
 		<%
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
					</li>
		 		</ul>
		 	</div>
		</div>
	
	<br><br><br>

	<footer></footer>

</body>
</html> 