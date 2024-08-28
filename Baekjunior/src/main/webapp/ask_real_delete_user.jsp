<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, javax.naming.*, Baekjunior.db.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/c9057320ee.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="MyPagest.css?v=3">
</head>
<%
request.setCharacterEncoding("utf-8");
String userId = "none";
HttpSession session = request.getSession(false);
if(session != null && session.getAttribute("login.id") != null) {
	userId = (String) session.getAttribute("login.id");
}
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
				<li class="main_menu_MyPage"><a href="#">MyPage</a>
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
					<li><a href="editProfile.jsp">프로필 수정</a></li>
				</ul>
			</div>
		</div>
		<div class="inner_content">
			<div class="delete_box">
				<h1 style="font-size: xx-large;">정말 탈퇴하시겠어요?</h1>
				<span>지금 탈퇴하면 내가 작성한 노트들을 복구할 수 없어요!</span>
				<div style="justify-content: flex-start;margin-top:30px;">
					<input type="checkbox" id="realcheck" name="realcheck">
					<label for="realcheck">회원탈퇴 유의사항을 확인하였습니다.</label>
				</div>
				<button onclick="location.href='delete_user.jsp'">다음</button>
			</div>
		</div>
	</div>
	
	
</body>
</html>