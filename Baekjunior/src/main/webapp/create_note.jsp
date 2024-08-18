<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, javax.naming.*, Baekjunior.db.*" session="false"%>
<%
request.setCharacterEncoding("utf-8"); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>create_note</title>
<link rel="stylesheet" href="Baekjunior_css.css">
</head>
<script>
function fnCheck(btn) {
    var problemId = document.getElementById("problemId");
    var cppCode = document.getElementById("cppCode");
    var importCheck = document.getElementById("importCheck");
    var problemTitle = document.getElementById("title");
    var form = document.querySelector('form');

    if(problemId.value == "") {
        alert("문제 번호를 입력하세요.");
        return false;
    }
    else if(importCheck.value == "0") {
        alert("문제가 import 되지 않았습니다.");
        return false;
    }
    else if(problemTitle.value == "not_found") {
    	alert("존재하지 않는 문제 번호입니다.");
    	return false;
    }
    else if(cppCode.value == "") {
        alert("코드를 입력하세요.");
        return false;
    }

    if(btn === 'save_and_note'){
        form.action = 'note_save.jsp?open_note=true'; // Save and Note 버튼 클릭 시
    } else if(btn === 'save'){
        form.action = 'note_save.jsp?open_note=false'; // Save 버튼 클릭 시
    }
    
    form.submit(); // 폼 제출
}

function resetImportCheck() {
	document.getElementById("importCheck").value = "0";
}
function importClick() {
    var problemId = document.getElementById("problemId").value;
    
    if (problemId) {
        location.href = 'create_note.jsp?problemId=' + encodeURIComponent(problemId);
    } else {
        alert("문제 번호를 입력해주세요.");
    }
    return false; // 문제 정보 가져오기만 하고 제출은 x
}
</script>
<%
ProblemInfoGet getPI = new ProblemInfoGet();
String problemId = request.getParameter("problemId"); // 문제 번호 입력 받기
String userId = "none";
String title = "";
String url = "";
String algorithms = "";
int level = 0;
String tier_name = "";
int tier_num = 0;

if (problemId != null && !problemId.isEmpty()) {
    // 문제 정보를 가져오는 메서드 호출
    title = getPI.getTitle(problemId);
    if (title.equals("not_found")) {
        out.println("<script>alert('존재하지 않는 문제입니다.');</script>");
    } else {
        url = getPI.getProblemURL(problemId);
        algorithms = getPI.getAlgorithms(problemId);
        level = getPI.getLevel(problemId);
        tier_name = getPI.getTierName();
        tier_num = getPI.getTierNum();
    }
}

HttpSession session = request.getSession(false);
if(session != null) {
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
	
	<form action="#" method="post">
	<div style="margin-top:20px;">
		<div style="width:80%; margin:0 auto; border:3px solid black;">
			<div style="font-size:30px; font-weight:bold; padding:40px; padding-left:10px; padding-right:10px; border-bottom:3px solid black; background:#5F99EB">
				<img src="img/dot1.png" style="width:15px; margin:0 20px 0 40px; padding-bottom:3px;">
				Create Note : BAEKJOON
			</div>
			
			<br>
			
			<div style="padding:30px;">
				<div id="note_info">
					<input type="hidden" name="userId" id="userId" value="<%=userId%>"> 
					<input type="hidden" name="level" id="level" value="<%=level%>">
					<input type="hidden" name="tier_name" id="tier_name" value="<%=tier_name%>">
					<input type="hidden" name="tier_num" id="tier_num" value="<%=tier_num%>">
					<input type="hidden" name="importCheck" id="importCheck" value="0">
					<div>
						Problem Number :
						<span style="border-bottom:3px solid black;">
							<input type="text" id="problemId" name="problemId" value="<%=Util.nullChk(problemId, "") %>" oninput="resetImportCheck()" style="background:transparent; outline:none; border:none;">
						</span>
						<span><button type="button" style="font-size:15px; font-weight:bold; padding:5px 20px; background:white; border:3px soild black;"
								onclick="importClick()">import</button>
						</span>
					</div>
					<div>
						Problem Title :
						<span style="border-bottom:3px solid black;">
							<input type="text" id="title" name="title" value="<%=title%>" style="background:transparent; outline:none; border:none; width:50%;">
						</span>
					</div>
					<div>
						Problem URL :
						<span style="border-bottom:3px solid black;">
							<input type="text" id="problem_url" name="problem_url" value="<%=url%>" style="background:transparent; outline:none; border:none; width:50%;">
						</span>
					</div>
					<div>
						Problem Category :
						<div id="problem_category">
							<ul>
                                <%
                                    String[] algorithmList = algorithms.split(",");
                                	if(algorithms == null || algorithms.trim().isEmpty()) {
                                %>
	                                <li>
	                                    <input type="checkbox" name="sorts" id="check_btn" value="unsorted" checked onclick="return false"> unsorted
	                                </li>
                                <%	
                                	} else {
                                    for (String algo : algorithmList) {
                                        if (!algo.isEmpty()) {
                                %>
                                <li>
                                    <input type="checkbox" name="sorts" id="check_btn" value="<%=algo%>" checked onclick="return false"> <%= algo %>
                                </li>
                                <%
                                        }
                                    }
                                }
                                %>
							</ul>
						</div>
					</div>	
				</div>
				
			<div id="note">
				<div style="margin-top:20px;">
					Bookmark <input type="checkbox" name="check_btn" id="check_btn" value="1">
				</div>
				<div>Code</div>
				<div id="code-editor">
			        <div id="lineNumbers"></div>
			        	<textarea id="cppCode" name="cppCode" rows="10" placeholder="Enter your C++ code here..."></textarea>
			    </div>
			</div>
			</div>
		</div>
	</div>
	
	<div style="width:80%; margin:0 auto; margin-top:30px;">
		<div style="float:right;">
			<button type="submit" style="font-size:15px; font-weight:bold;  background:white; border:3px solid black; padding:5px 20px; margin-right:10px;"
					onclick="return fnCheck('save_and_note')">
				Save and Note</button> 
			<button type="submit" style="font-size:15px; font-weight:bold;  background:white; border:3px solid black; padding:5px 20px;"
					onclick="return fnCheck('save')">Save</button>
		</div>
	</div>
</form>
	
	<!-- 역시 chatgpt -->
	<!-- 코드 입력창 -->
	<script>
		const textarea = document.getElementById('cppCode');
		const lineNumbers = document.getElementById('lineNumbers');
		
		function updateLineNumbers() {
		    const numberOfLines = textarea.value.split('\n').length;
		    lineNumbers.innerHTML = '';
		    for (let i = 1; i <= numberOfLines; i++) {
		        lineNumbers.innerHTML += '<div id="line_num' + i + '">' + i + '</div>';
		    }
		}
		
		// 초기 라인 번호 업데이트
		updateLineNumbers();
		
		// 사용자가 텍스트를 입력하거나 줄을 변경할 때 라인 번호 업데이트
		textarea.addEventListener('input', updateLineNumbers);
		textarea.addEventListener('scroll', () => {
		    lineNumbers.scrollTop = textarea.scrollTop;
		});
		// problemId 가 입력되면 importCheck를 1로 업데이트
		<% if (problemId != null && !problemId.isEmpty()) { %>
        	document.addEventListener("DOMContentLoaded", function() {
            	document.getElementById('importCheck').value = '1';
        	});
    	<% } %>
		function submitCppCode() {
		    const code = textarea.value;
		    console.log("Submitted C++ Code:", code);
		
		    // 서버에 코드를 전송하거나 WebAssembly로 처리하는 로직을 여기에 추가합니다.
		}
	</script>
	

	<footer></footer>

</body>
</html> 