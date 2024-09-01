<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, javax.naming.*, Baekjunior.db.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Baekjunior</title>
<link rel="stylesheet" href="Baekjunior_css.css">

<style>
   @-webkit-keyframes takent {
      0% {
         flex: 0;
      }
      100% {
         flex: 3;
      }
   }
   @keyframes takent {
      0% {
         flex: 0;
      }
      100% {
         flex: 3;
      }
   }
   @-webkit-keyframes outnt {
      0% {
         flex: 3;
      }
      100% {
         flex: 0;
      }
   }
   @keyframes outnt {
      0% {
         flex: 3;
      }
      100% {
         flex: 0;
      }
   }
   .outnote {
      animation-name: outnt;
      animation-duration: 2s;
   }
</style>

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
				<a style="font-size:30px; font-weight:bold;"" onclick="location.href='algorithm_note.jsp'">CATEGORY : <%=algorithmSort %></a>
				<!-- 해당 알고리즘 노트 리스트는 오른쪽으로 밀리고 왼쪽에 알고리즘노트 나오는 버튼 -->
				<button class="memobutton">memo</button>
			</div>
			
			<div id="sort"  class="content_set">
				<div id="sort_select" class="content_set_b">
					<button>SORT</button>
				</div>
				<ul style="top:205px;">
					<li><a href="2_Baekjunior.jsp?latest=true&sort=<%=algorithmSort%>">Latest</a></li>
					<li><a href="2_Baekjunior.jsp?earliest=true&sort=<%=algorithmSort%>">Earliest</a></li>
					<li><a href="2_Baekjunior.jsp?ascending=true&sort=<%=algorithmSort%>">Ascending number</a></li>
					<li><a href="2_Baekjunior.jsp?descending=true&sort=<%=algorithmSort%>">Descending number</a></li>
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
		
		<div id="algonote" style="margin-top: 20px;flex:3;animation-name:takent;animation-duration:2s;">
         <div style="width: 80%; margin-left:auto;">
            <div class="algorithm_name" style="display: flex;align-items: center;justify-content: space-between;">
               <div>
                  <img src="img/dot1.png" style="width: 15px;height:15px;">
                  <h1 style="display: inline;font-size: 30px;margin-left: 10px;"><%=algorithmSort %></h1>
               </div>
               <i class="fa-solid fa-xmark fa-xl" id="x" onclick="closealgont()" style="margin-right:4"></i>
            </div>
            <script>
            function closealgont() {
               document.getElementById("algonote").classList.remove("outnote");
               document.getElementById("algonote").classList.add("outnote");
               location.href="note_detail.jsp?problem_idx=<%=rs.getInt("problem_idx")%>";
            }
            </script>
            <div class="memo" style="margin-top:20px;">
	               <div class="memo_box" contenteditable="true" id="editablememo" style="min-height:600px;padding:30px;background:white;border-radius:10px;border:3px solid black;">
	                  <%
	                  	PreparedStatement memoPstmt = null;
	                 	ResultSet memoRs = null;
	                  	String memoSql = "SELECT * FROM algorithm_memo WHERE user_id=? AND algorithm_name=?";
	                  	
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
	         </div>
  		 </div>   
		
		<div id="list_group">
		<ul class="list">
 		<%
 		if (!userId.equals("none")) {
 			try {
 				
 				// 고정된 문제 선택
 				String problemQuery = "SELECT * FROM problems p JOIN algorithm_sort a ON p.problem_idx=a.problem_idx " 
 										+ "WHERE a.user_id=? AND a.sort=? ORDER BY p.is_fixed DESC, " + sortClause;
 				problemPstmt = con.prepareStatement(problemQuery);
 				problemPstmt.setString(1, userId);
 				problemPstmt.setString(2, algorithmSort);
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
	
	<br><br><br>

	<footer></footer>

</body>
</html> 