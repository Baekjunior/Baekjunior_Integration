<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, javax.naming.*, Baekjunior.db.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Baekjunior</title>
<link rel="stylesheet" href="Baekjunior_css.css">

<script>
	
</script>

</head>
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
			<li><a href="#">User</a></li>
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
				<li><a href="0_Baekjunior.jsp">ALL</a></li>
				<li><a href="1_Baekjunior.jsp"><b>BOOKMARK</b></a></li>
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
		<div>
			<div id="page_bookmark">BOOKMARK</div>
		</div>
		<div id="main_bar">
			<div id="sort" class="content_set">
				<div id="sort_select" class="content_set_b">
					<button>sort</button>
				</div>
				<ul>
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
				<button onclick="location.href='create_note.jsp'">create note</button>
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
	    			<li><a href="#">Split screen</a></li>
	    			<li><a href="#">Setting</a></li>
	    			<li><a href="#">Delete</a></li>
	    		</ul>
	    	</div>
 				<div class="content_title"><a href="note_detail.jsp">Hello World</a></div>
 			</li>
 			<li class="item">
    			<div class="content_number">2# 1000</div>
    			<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
    			<div class="content_title">A+B</div>
 			</li>
		    <li class="item">
		    	<div class="content_number">3# 18108</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title"><span>1998년생인 내가 태국에서는 2541년생?!</span></div>
		    </li>
			<li class="item">
		    	<div class="content_number">4# 15818</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">오버플로우와 모듈러</div>
			</li>
			<li class="item">
		    	<div class="content_number">5# 11653</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">소인수분해</div>
 			</li>
		    <li class="item">
		    	<div class="content_number">6# 10831</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">오늘은 코딩하고 싶은 날</div>
		    </li>
			<li class="item">
		    	<div class="content_number">7# 1541</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">잃어버린 괄호</div>
			</li>
			<li class="item">
		    	<div class="content_number">8# 1011</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">Fly me to the Alpha Centauri</div>
 			</li>
		    <li class="item">
		    	<div class="content_number">9# 1022</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">소용돌이 예쁘게 출력하기</div>
		    </li>
			<li class="item">
		    	<div class="content_number"># 15803</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">PLAYERJINAH’S BOTTLEGROUNDS</div>
			</li>
			<li class="item">
		    	<div class="content_number"># 10831</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">오늘은 코딩하고 싶은 날</div>
		    </li>
			<li class="item">
		    	<div class="content_number"># 1541</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">잃어버린 괄호</div>
			</li>
			<li class="item">
		    	<div class="content_number"># 1011</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">Fly me to the Alpha Centauri</div>
 			</li>
		    <li class="item">
		    	<div class="content_number"># 1022</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">소용돌이 예쁘게 출력하기</div>
		    </li>
			<li class="item">
		    	<div class="content_number"># 15803</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">PLAYERJINAH’S BOTTLEGROUNDS</div>
			</li>
			<li class="item">
		    	<div class="content_number"># 10831</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">오늘은 코딩하고 싶은 날</div>
		    </li>
			<li class="item">
		    	<div class="content_number"># 1541</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">잃어버린 괄호</div>
			</li>
			<li class="item">
		    	<div class="content_number"># 1011</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">Fly me to the Alpha Centauri</div>
 			</li>
		    <li class="item">
		    	<div class="content_number"># 1022</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">소용돌이 예쁘게 출력하기</div>
		    </li>
			<li class="item">
		    	<div class="content_number"># 15803</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">PLAYERJINAH’S BOTTLEGROUNDS</div>
			</li>
			<li class="item">
		    	<div class="content_number"># 10831</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">오늘은 코딩하고 싶은 날</div>
		    </li>
			<li class="item">
		    	<div class="content_number"># 1541</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">잃어버린 괄호</div>
			</li>
			<li class="item">
		    	<div class="content_number"># 1011</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">Fly me to the Alpha Centauri</div>
 			</li>
		    <li class="item">
		    	<div class="content_number"># 1022</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">소용돌이 예쁘게 출력하기</div>
		    </li>
			<li class="item">
		    	<div class="content_number"># 15803</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">PLAYERJINAH’S BOTTLEGROUNDS</div>
			</li>
			<li class="item">
		    	<div class="content_number"># 10831</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">오늘은 코딩하고 싶은 날</div>
		    </li>
			<li class="item">
		    	<div class="content_number"># 1541</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">잃어버린 괄호</div>
			</li>
			<li class="item">
		    	<div class="content_number"># 1011</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">Fly me to the Alpha Centauri</div>
 			</li>
		    <li class="item">
		    	<div class="content_number"># 1022</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">소용돌이 예쁘게 출력하기</div>
		    </li>
			<li class="item">
		    	<div class="content_number"># 15803</div>
		    	<div class="content_set">
		    		<img class="content_set_a" src="img/pin.png">
		    		<button class="content_set_b"><img src="img/....png"></button>
		    		<ul>
		    			<li><a href="#">Unpin / Pin to top</a></li>
		    			<li><a href="#">Split screen</a></li>
		    			<li><a href="#">Setting</a></li>
		    			<li><a href="#">Delete</a></li>
		    		</ul>
		    	</div>
		    	<div class="content_title">PLAYERJINAH’S BOTTLEGROUNDS</div>
			</li>
		</ul>
			
		</div>
	</div>
	
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

	<footer></footer>

</body>
</html> 