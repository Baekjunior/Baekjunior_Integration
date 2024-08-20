<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, javax.naming.*, Baekjunior.db.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/c9057320ee.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="MyPagest.css?v=1.2">
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
		<div class="inner_contents">
			<div class="select_div">
				<Button class="note_div" onclick="'">
					<div>
						<h3>노트</h3>
						<p>35</p>
						<i class="fa-solid fa-note-sticky fa-lg"></i>
					</div>
				</Button>
				<Button class="draft_div" onclick="location.href='#'">
					<div>
						<h3>임시저장</h3>
						<p>3</p>
						<i class="fa-solid fa-box-open fa-lg"></i>
					</div>
				</Button>
				<Button class="bookmark_div" onclick="location.href='#'">
					<div>
						<h3>북마크</h3>
						<p>15</p>
						<i class="fa-solid fa-bookmark fa-lg"></i>
					</div>
				</Button>
			</div>
			<div class="calender">
				<div class="calender_box">
					<h2>2024년 8월</h2>
					<table>
						<tr>
							<th>일</th>
							<th>월</th>
							<th>화</th>
							<th>수</th>
							<th>목</th>
							<th>금</th>
							<th>토</th>
						</tr>
						<tr>
							<td><div>
								
							</div></td>
							<td><div>
								
							</div></td>
							<td><div>
								
							</div></td>
							<td><div>
								
							</div></td>
							<td><div>
								<p>1</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>2</p>
								<p>1</p>
							</div></td>
							<td><div>
								<p>3</p>
								<p>3</p>
							</div></td>
						</tr>
						<tr>
							<td><div>
								<p>4</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>5</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>6</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>7</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>8</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>9</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>10</p>
								<p>3</p>
							</div></td>
						</tr>
						<tr>
							<td><div>
								<p>11</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>12</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>13</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>14</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>15</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>16</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>17</p>
								<p>3</p>
							</div></td>
						</tr>
						<tr>
							<td><div>
								<p>18</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>19</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>20</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>21</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>22</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>23</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>24</p>
								<p>3</p>
							</div></td>
						</tr>
						<tr>
							<td><div>
								<p>25</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>26</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>27</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>28</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>29</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>30</p>
								<p>3</p>
							</div></td>
							<td><div>
								<p>31</p>
								<p>3</p>
							</div></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	
</body>
</html>