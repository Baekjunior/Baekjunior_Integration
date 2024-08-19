<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, Baekjunior.db.*, java.util.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
   function fnCheck() {
	   var userId = document.getElementById("id");
	   var userPwd = document.getElementById("pw");
	   
	   if(userId.value == "") {
		   alert("아이디를 입력하세요.");
		   userId.focus();
		   return false;
	   }
	   else if(userPwd.value == ""){
		   alert("비밀번호를 입력하세요.");
		   userPwd.focus();
		   return false;
		}
	   	return true;
   }
</script>
<link rel="stylesheet" type="text/css" href="loginst.css?v=1.2">
</head>
<body>
<div>
   <header>
      <i class="fa-solid fa-bars fa-2xl" id="menub" style="color: #000000;" onclick="openmenu()"></i>
      <i class="fa-solid fa-xmark fa-2xl" id="x" onclick="closemenu()"></i>
   </header>
   <div class="menu" id="menu">
      <div class="menu_box">
         <ul>
            <li><a href="information.jsp">INFORMATION</a></li>
            <li><a href="login.jsp">LOG IN</a></li>
            <li><a href="signup.jsp">SIGN UP</a></li>
         </ul>
      </div>
   </div>
   <div class="login_pg">
      <img src="images/baeddy1.png" class="blue" alt="teddy">
      <div class="logbox">
         <form name="loginf" action="login_do.jsp" method="POST" onsubmit="return fnCheck()">
            <div>
               <label for="id">ID</label>
               <br>
               <input type="text" id="id" name="id">
            </div>
            <div>
               <label for="pw">PASSWORD</label>
               <br>
               <input type="password" id="pw" name="pw">
            </div>
            <div>
               <input type="submit" value="LOG IN">
               <br>
               <a href="signup.jsp" class="tosign">SIGN UP</a>
            </div>
         </form>
      </div>
   </div>
</div>
</body>
</html>