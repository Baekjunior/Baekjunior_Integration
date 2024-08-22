<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, java.util.*, java.io.*, javax.naming.*, Baekjunior.db.*, Baekjunior.multipart.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/c9057320ee.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="editProfilest.css?v=1.2">
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
try {
	if(userId != "none") {
		String sql = "SELECT * FROM users WHERE user_id=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, userId);
		rs = pstmt.executeQuery();
		rs.next();
	}
%>

<script type="text/javascript">
    function confirmDeletion(userId) {
        var result = confirm("정말 탈퇴하시겠습니까?");
        if (result) {
            window.location.href = "user_delete_do.jsp?user_id=" + userId;
        } else {
            return false;
        }
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
			<li><a href="#"><%=userId %></a></li>
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
	<div class="contents">
		<div class="menu">
			<div class="menu_box">
				<ul>
					<li><a href="#">내 활동</a></li>
					<li><a href="#">프로필 수정</a></li>
				</ul>
			</div>
		</div>
		<div class="inner_contents">
			<div class="myinfo">
				<form action="modify_profileImage.jsp?user_id=<%=userId %>" method="POST" enctype="multipart/form-data">
				<div class="img_box">
					<img src="./upload/<%=rs.getString("savedFileName") %>" class="profileimg" alt="profileimg">
					<input type="file" accept="image/jpg,image/gif" name="fileName" class="imgUpload">사진 업로드	
					<button type="submit" class="imgUpload">사진 업로드</button>
				</div>
				</form>
				<div class="info_box">
					<h1><%=rs.getString("user_id") %></h1>
					<form name="mytext" action="modify_intro.jsp?user_id=<%=userId %>" method="POST">
						<textarea name="intro"><%=Util.nullChk(rs.getString("intro"), "") %></textarea>
						<input type="submit">
					</form>
				</div>
			</div>
			<div>
				<table>
					<tr>
						<td><a href="">비밀번호 변경 ></a></td>
					</tr>
					<tr>
						<td><a href="">이메일 변경 ></a></td>
					</tr>
					<tr>
						<td><a href="information.jsp">로그아웃 ></a></td>
					</tr>
					<tr>
						<td><a href="#" onclick="confirmDeletion('<%=userId %>')">회원 탈퇴 ></a></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
<%
	con.close();
	pstmt.close();
	rs.close();
} catch (SQLException e){
	out.print(e);
	return;
}
%>