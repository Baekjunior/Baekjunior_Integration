<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, javax.naming.*, Baekjunior.db.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Baekjunior</title>
<link rel="stylesheet" href="Baekjunior_css.css">

</head>
<%
request.setCharacterEncoding("utf-8");
String userId = "none";
HttpSession session = request.getSession(false);
if(session != null && session.getAttribute("login.id") != null) {
	userId = (String) session.getAttribute("login.id");
}
Connection con = DsCon.getConnection();
PreparedStatement pstmt = null;
ResultSet rs = null;
%>
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
						<li><a href="#"><img src="img/dot1.png">BFS</a></li>
						<li><a href="#"><img src="img/dot2.png">DFS</a></li>
						<li><a href="#"><img src="img/dot3.png">Graph</a></li>
						<li><a href="#"><img src="img/dot4.png">DP</a></li>
					</ul>
				</li>
				<li><a href="#">LEVEL</a>
					<ul class="sub">
						<li><a href="#"><img src="img/star_silver.png">SILVER4</a></li>
						<li><a href="#"><img src="img/star_silver.png">SILVER3</a></li>
						<li><a href="#"><img src="img/star_silver.png">SILVER2</a></li>
						<li><a href="#"><img src="img/star_silver.png">SILVER1</a></li>
						<li><a href="#"><img src="img/star_gold.png">GOLD5</a></li>
						<li><a href="#"><img src="img/star_gold.png">GOLD4</a></li>
						<li><a href="#"><img src="img/star_gold.png">GOLD3</a></li>
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
					<li><a href="#">Latest</a></li>
					<li><a href="#">Earliest</a></li>
					<li><a href="#">Ascending number</a></li>
					<li><a href="#">Descending number</a></li>
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
 			<li class="item">
 				<div class="content_number"><a href="note_detail.jsp">1# 2557</a></div>
 				<div class="content_set">
	    		<img class="content_set_a" src="img/pin.png">
	    		<button class="content_set_b"><img src="img/....png"></button>
	    		<ul>
	    			<li><a href="#">Unpin / Pin to top</a></li>
	    			<li><a href="splitscreen1.jsp">Split screen</a></li>
	    			<li><a href="#">Setting</a></li>
	    			<li><a href="#">Delete</a></li>
	    		</ul>
	    	</div>
 				<div class="content_title"><a href="note_detail.jsp">Hello World</a></div>
 			</li>
 		<%
 			if(userId != "none"){
 				int cnt = 0;
	 			try {
					String sql = "SELECT * FROM problems WHERE user_id=?";
	 				pstmt = con.prepareStatement(sql);
	 				pstmt.setString(1, userId);
	 				rs = pstmt.executeQuery();
	 				while(rs.next()){
	 					++cnt;
 		%>
 			<li class="item">
 				<div class="content_number"><a href="note_detail.jsp"><%=cnt %># <%=rs.getInt("problem_id") %></a></div>
 				<div class="content_set">
	    		<img class="content_set_a" src="img/pin.png">
	    		<button class="content_set_b"><img src="img/....png"></button>
	    		<ul>
	    			<li><a href="#">Unpin / Pin to top</a></li>
	    			<li><a href="splitscreen.jsp">Split screen</a></li>
	    			<li><a href="#">Setting</a></li>
	    			<li><a href="#">Delete</a></li>
	    		</ul>
	    	</div>
 				<div class="content_title"><a href="note_detail.jsp"><%=rs.getString("memo_title") %></a></div>
 			</li>
 		<%
 					con.close();
 					pstmt.close();
 					rs.close();
	 			}
	 		} catch(SQLException e) {
	 			out.print(e);
	 			return;
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