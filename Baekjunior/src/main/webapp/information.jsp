<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>information</title>
<script src="https://kit.fontawesome.com/c9057320ee.js" crossorigin="anonymous"></script>
<script>
function openmenu() {
	document.getElementById("menub").style.display = "none";
	document.getElementById("x").style.display = "block";
	document.getElementById("menu").style.display = "block";
}
function closemenu() {
	document.getElementById("menub").style.display = "block";
	document.getElementById("x").style.display = "none";
	document.getElementById("menu").style.display = "none";
}
function centerfix(elementID) {
	const element = document.getElementById(elementID);
	const parent = element.parentElement;
	
	if (window.scrollY >= 2078 && window.scrollY < 4078 ) {
		element.style.position = 'fixed';
		element.style.top = '50%';
		element.style.left = '50%';
		element.style.transform = 'translate(-50%, -50%)';
	}
	else {
		element.style.position = 'relative';
		element.style.left = 'initial';
		element.style.transform = 'initial';
		element.style.top = 'initial';
	}
}
</script>
<link rel="stylesheet" type="text/css" href="informst.css?v=1.2">
</head>
<body>
<div>
	<header style="background:white;">
		<i class="fa-solid fa-bars fa-2xl" id="menub" style="color: #000000;" onclick="openmenu()"></i>
		<i class="fa-solid fa-xmark fa-2xl" id="x" onclick="closemenu()"></i>
	</header>
	<div class="menu" id="menu" style="top:70px;z-index:3;">
		<div class="menu_box">
			<ul>
				<li><a href="information.jsp">INFORMATION</a></li>
				<li><a href="login.jsp">LOG IN</a></li>
				<li><a href="signup.jsp">SIGN UP</a></li>
			</ul>
		</div>
	</div>
	<div class="first">
		<img src="images/blue.png" class="pink" alt="pink">
		<img src="images/white.png" class="white" alt="white">
		<img src="images/black.png" class="black" alt="black">
		<img src="images/white.png" class="white2" alt="white2">
		<img src="images/yellow.png" class="green" alt="green">
		<h1>gather<br>your code<br>at a<br>glance.</h1>
	</div>
	<div class="second">
		<img src="images/code.png" class="code1" alt="code">
		<img src="images/code.png" class="code2" alt="code">
		<img src="images/code.png" class="code3" alt="code">
		<img src="images/code.png" class="code4" alt="code">
		<img src="images/code.png" class="code5" alt="code">
		<img src="images/code.png" class="code6" alt="code">
		<img src="images/code.png" class="code7" alt="code">
		<img src="images/code.png" class="code8" alt="code">
		<h1>Compare your code with a friend's code.</h1>
	</div>
	<div class="third_wrapper">
		<div class="fixx" id="fixx">
			<div class="third" id="third">
				<img src="images/ball.png" class="circle" alt="circle">
				<h1>Briefly review your code.</h1>
				<script>
				let cir = document.querySelector(".circle");
				let h = window.innerHeight;
				let th = document.querySelector(".third");
				
				window.addEventListener("scroll", function(){
					const scrollYBottom = window.scrollY + document.documentElement.clientHeight;
					console.log(window.scrollY);
					centerfix("fixx");
					let cirwid;
					let cirl;
					let cirt;
					if(window.scrollY >= 2078 && window.scrollY < 2578){
						cir.style.width = 700 - (650/500 * (window.scrollY-2078))+'px';
						cir.style.left = -350 + (window.scrollY-2078)*4+'px';
						cir.style.top = -580 + (window.scrollY-2078)*(1050/500)+'px';
					}
					else if (window.scrollY >= 2578 && window.scrollY < 3078){
						cir.style.width = 52.6 + (700/500 * (window.scrollY-2578))+'px';
						cir.style.left = 1642- (window.scrollY-2578)*4+'px';
						cir.style.top = 465.8 + (window.scrollY-2578)*0.7+'px';
					}
				})
				</script>
			</div>
		</div>
	</div>
	<div class="join_us">
		<div class="join">
			<p>For an easy and effortless way to organize your code notes.<br>Sign up today!</p>
			<button><a href="signup.jsp">JOIN US</a></button>
		</div>
	</div>
	<div class="introduce_back">
		<div class="introduce">
			<img src="images/introduce.png" class="intro1" alt="intro">
			<img src="images/introduce.png" class="intro2" alt="intro">
			<img src="images/introduce.png" class="intro3" alt="intro">
		</div>
		<div class="photos">
			<img src="images/cat.jpg" class="cat" alt="cat">
			<img src="images/pome.jpg" class="pome" alt="pome">
			<img src="images/teddy.jpg" class="teddy" alt="teddy">
		</div>
		<div class="names">
			<h3 class="name1">Dodam</h3>
			<h3 class="name2">Yumin</h3>
			<h3 class="name3">Doyeon</h3>
		</div>
	</div>
</div>
</body>
</html>