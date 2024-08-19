<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, Baekjunior.db.*, javax.naming.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/c9057320ee.js" crossorigin="anonymous"></script>
<script>
	function showAlert(message) {
	    alert(message);
	}
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
   		var userPwdConfirm = document.getElementById("pwConfirm");
   		var userEmail = document.getElementById("email");
   		var idCheck = document.getElementById("idDuplication");
   		
   		if(userId.value == "") {
   			alert("아이디를 입력하세요.");
   			userId.focus();
   			return false;
   		} 
   		else if(idCheck.value == "0") {
   			alert("아이디 중복체크를 해주세요.");
   			return false;
   		} 
   		else if(userPwd.value == "") {
   			alert("비밀번호를 입력하세요.");
   			userPwd.focus();
   			return false;
   		}
   		else if(userPwdConfirm.value == "") {
   			alert("비밀번호를 입력하세요.");
   			userPwdConfirm.focus();
   			return false;
   		}
   		else if(userPwd.value != userPwdConfirm.value) {
   			alert("비밀번호가 일치하지 않습니다.");
   			userPwdConfirm.value = "";
   			userPwdConfirm.focus();
   			return false;
   		}
   		else if(userEmail.value == ""){
   			alert("이메일을 입력하세요.");
   			userEmail.focus();
   			return false;
   		}
   		return true;
   	}
   	function checkID() {
        var userId = document.getElementById("id");
        if(userId.value == "") {
      	  alert("아이디를 입력하세요.");
      	  userId.focus();
        }
        else {
      	  window.open("signup_idCheck.jsp?id=" + userId.value , "", "width=400 height=300");
        }
    }
   	function resetIdCheck() {
   		document.getElementById("idDuplication").value = "0";
   	}
</script>
<link rel="stylesheet" type="text/css" href="signupst.css?v=1.2">
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
         <form action="signup_do.jsp" method="POST" name="signupf" onsubmit="return fnCheck()">
         <input type="hidden" name="idDuplication" id="idDuplication" value="0">
            <div>
               <label for="id">ID</label>
               <br>
               <input type="text" id="id" name="id" oninput="resetIdCheck()">
               <input type="button" id="checkid" name="checkid" value="Duplicate check" onclick="checkID()">
            </div>
            <div>
               <label for="pw">PASSWORD</label>
               <br>
               <input type="password" id="pw" name="pw">
            </div>
            <div>
               <label for="pw">PASSWORD CHECK</label>
               <br>
               <input type="password" id="pwConfirm" name="pwConfirm">
            </div>
            <div>
               <label for="email">E-MAIL</label>
               <br>
               <input type="email" id="email" name="email">
            </div>
            <div>
               <input type="submit" value="SIGN UP">
            </div>
         </form>
      </div>
   </div>
</div>
</body>
</html>