<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*, javax.naming.*, Baekjunior.db.*" session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>create_note</title>
<link rel="stylesheet" href="Baekjunior_css.css">
</head>
<%
request.setCharacterEncoding("utf-8");
String userId = "none";
HttpSession session = request.getSession(false);
if(session != null && session.getAttribute("login.id") != null) {
	userId = (String) session.getAttribute("login.id");
}
int problemIdx = Integer.parseInt(request.getParameter("problem_idx"));

Connection con = DsCon.getConnection();
PreparedStatement pstmt = null;
ResultSet rs = null;
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
	<%
		try {
			String sql = "SELECT * FROM problems WHERE problem_idx=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, problemIdx);
			rs = pstmt.executeQuery();
			if(rs.next()){
	%>
	<section class="banner">
		<a href="#" class="logo"></a>
	</section>
	
	
	<!-- bookmark_star에 대한 SCRIPT -->
	<script>
		document.addEventListener('DOMContentLoaded', function() {
		    const bookmarkStars = document.querySelectorAll('.bookmark_star');
	
		    bookmarkStars.forEach(function(star) {
		        star.addEventListener('click', function() {
		            const currentSrc = this.getAttribute('src');
		            let isChecked = 0;
	
		            if (currentSrc === 'img/star_on.png') {
		                this.setAttribute('src', 'img/star_off.png');
		                isChecked = 0;
		            } else {
		                this.setAttribute('src', 'img/star_on.png');
		                isChecked = 1;
		            }
		            
		            /* 북마크의 상태를 서버로 보냄 */
		            const xhr = new XMLHttpRequest();
	                xhr.open("POST", "updateBookmark.jsp", true);
	                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	                xhr.onreadystatechange = function () {
	                    if (xhr.readyState === 4 && xhr.status === 200) {
	                        console.log(xhr.responseText);  
	                    }
	                };
	                xhr.send("problem_idx=<%=problemIdx%>&is_checked=" + isChecked);
		        });
		    });
		});
	</script>
	
	
	<div style="margin-top:20px;">
		<div style="width:80%; margin:0 auto;">
			<div>
				<div>
					<div style="font-size:30px; font-weight:bold; margin-bottom:40px;">Edit Mode</div>
					<div style="display:inline; width:80%; font-size:25px; font-weight:bold;">
						#<span><%=rs.getInt("problem_id") %></span> : <span><%=rs.getString("problem_title") %></span>
						<!-- is_checked가 1이면 북마크 상태, 아니면 북마크되지 않은 상태 -->
						<% if(rs.getInt("is_checked") == 1) { %> 
						<span><img class="bookmark_star" src="img/star_on.png" style="width:18px;"></span>
						<% } else { %>
						<span><img class="bookmark_star" src="img/star_off.png" style="width:18px;"></span>
						<% } %>
					</div>
					<div style="float:right; font-size:15px; padding:10px;">
						Submit Date : <span><%=rs.getDate("submitDate") %></span>
					</div>
				</div>
				
				<div style="font-weight:bold; font-size:20px; margin-top:15px; margin-left:30px;">
					<div style="display:inline; width:80%;">
					<%
						String problemSortStr = rs.getString("problem_sort");
						String[] algorithmList = problemSortStr.split(",");
                    	if(problemSortStr != null && !problemSortStr.trim().isEmpty()) {
                    		for (String algo : algorithmList) {
                            	if (!algo.isEmpty()) {
					%>
						<span><img src="img/dot1.png" style="width:15px; margin-left:25px;"></span> <span><%=algo %></span>
					<%
                            	}
                    		}
                    	}
                    	else {
					%> <span><img src="img/dot1.png" style="width:15px; margin-left:25px;"></span> <span>default sort</span>
					<% } %>
						<span style="margin-right:50px;"></span>
						<span style="margin-right:50px;"><%=rs.getString("language") %></span>
						Friends who solved : <span style="background:lightgray; font-size:15px; padding:3px 20px; border-radius:20px;"><a href="#">Dodam</a></span> <span style="background:lightgray; font-size:15px; padding:3px 20px; border-radius:20px;"><a href="#">Dam</a></span>
					</div>
					<div style="float:right; font-size:15px; padding:10px;">
						<a onclick="confirmDeletion('<%=rs.getInt("problem_idx") %>')" href="#" style="color:black;">Delete</a>
					</div>
				</div>
			</div>	
			<script>
			document.addEventListener('DOMContentLoaded', function() {
			    const addButton = document.getElementById('add_btn');
			    const container = document.getElementById('container');

			    addButton.addEventListener('click', function(event) {
			        event.preventDefault(); // 링크 기본 동작 방지
			        
			        // 새로운 div 요소 생성
			        const newDiv = document.createElement('div');
			        newDiv.className = 'container_div'; // CSS 클래스 추가
			        newDiv.style.padding = '5px';

			        // div 내부 HTML 설정
			        newDiv.innerHTML = `
			            <span><img src="img/star_red.png" style="width:13px;"></span>
			            <input type="text" name="sub_memo" style="width:90%; background-color:transparent; padding:5px; font-size:15px;" value="">
			            <a class="delete_btn" href="#">X</a>
			        `;

			        // X 버튼 클릭 이벤트 리스너 추가
			        newDiv.querySelector('.delete_btn').addEventListener('click', function(event) {
			            event.preventDefault(); // 링크 기본 동작 방지
			            container.removeChild(newDiv); // div 제거
			        });

			        // 컨테이너에 새로운 div 추가
			        container.appendChild(newDiv);
			    });

			    // 기존의 X 버튼 클릭 이벤트 리스너 추가
			    container.addEventListener('click', function(event) {
			        if (event.target.classList.contains('delete_btn')) {
			            event.preventDefault(); // 링크 기본 동작 방지
			            const divToRemove = event.target.closest('.container_div'); // 클릭한 X 버튼이 포함된 div 찾기
			            container.removeChild(divToRemove); // div 제거
			        }
			    });
			});
			</script>
			<form method="POST" action="note_detail_edit_do.jsp">
			<input type="hidden" name="problem_idx" value="<%=problemIdx %>">
			<div class="sub_note" style="font-weight:bold; font-size:20px; border:3px solid black; background:#5F99EB; padding:30px; margin-top:50px; vertical-align:middle; ">
				<%
					String subMemoStr = rs.getString("sub_memo");
					String[] subMemos = subMemoStr != null ? subMemoStr.split("\n") : new String[]{};
				%>
				<div id="container">
				<% for (String memo : subMemos) { %>
					<div class="container_div" style="padding:5px;">
		           		<span><img src="img/star_red.png" style="width:13px;"></span>
		                <input type="text" name="sub_memo" style="width:90%; background-color:transparent; padding:5px; font-size:15px;" value="<%=memo%>">
		                <a class="delete_btn" href="#">X</a>
		        	</div>
		        <% } %>
		        </div>
		        
		        <div style="padding:5px; margin-bottom:20px;">
		            <a id="add_btn" href="#">+</a>
		        </div>
			</div>
			
			<div style="display: grid; margin-top: 50px; grid-template-columns: 5fr 2fr; column-gap: 30px;">
		        <div style="column-gap: 10px; border: 3px solid black; background: white; padding: 10px;">
		            <div id="code-editor" style="display: grid; grid-template-columns: 1fr 17fr; border: none;">
		                <textarea class="notes" id="lineNumbers" rows="10" wrap="off" style="font-size:15px; overflow:auto; text-align:center; padding-bottom:0px;" readonly></textarea>
		                <textarea class="notes" name="code_note" id="code_note" rows="10" placeholder="Enter your code here..." wrap="off" style="font-size:15px; overflow-x:auto; padding-bottom:60px;"><%=rs.getString("code") %></textarea>
            </div>
        </div>
        

        <div style="column-gap: 10px; border: 3px solid black; background: white; padding: 10px;">
            <div id="code-editor" style="border: none;">
                <textarea class="notes" name="main_memo" id="note_detail" rows="10" placeholder="Enter your note here..." wrap="off" style="font-size:15px; overflow-x:auto; padding-bottom:60px;"><%=Util.nullChk(rs.getString("main_memo"), "") %></textarea>
            </div>
        </div>
    	</div>		
		
	<script>
    const textarea = document.getElementById('code_note');
    const lineNumbers = document.getElementById('lineNumbers');
			
    function updateLineNumbers() {
        const numberOfLines = textarea.value.split('\n').length;
        let lineNumberString = '';

        for (let i = 1; i <= numberOfLines; i++) {
            lineNumberString += i + '\n'
            console.log("DDD: " + i);
        }

        lineNumbers.value = lineNumberString;
    }

    function adjustHeight(element) {
        element.style.height = 'auto'; // Reset height to auto to measure scrollHeight
        element.style.height = element.scrollHeight + 'px'; // Adjust height to fit content
    }

    // Function to sync heights between textareas
    function syncHeights() {
        const maxScrollHeight = Math.max(textarea.scrollHeight, lineNumbers.scrollHeight);
        textarea.style.height = maxScrollHeight + 'px';
        lineNumbers.style.height = maxScrollHeight + 'px';
    }

    // 초기 라인 번호 및 높이 업데이트
    updateLineNumbers();
    syncHeights();

    // 사용자가 텍스트를 입력하거나 줄을 변경할 때 라인 번호 및 높이 업데이트
    textarea.addEventListener('input', () => {
        updateLineNumbers();
        syncHeights();
    });

    // Scroll the line numbers to match the code textarea
    textarea.addEventListener('scroll', () => {
        lineNumbers.scrollTop = textarea.scrollTop;
    });

    function submitcode_note() {
        const code = textarea.value;
        console.log("Submitted C++ Code:", code);

        // 서버에 코드를 전송하거나 WebAssembly로 처리하는 로직을 여기에 추가합니다.
    }
</script>
    	
    	<div style="float:right; margin-top:50px">
    		<button type="submit" style="font-size:15px; font-weight:bold;  background:white; border:3px solid black; padding:5px 20px;">Save</button>
		</div>
		</form>
			
		</div>
		
		
	</div>
	
	<br><br><br><br>

	<footer></footer>

</body>
</html>
<%
}
	con.close();
	pstmt.close();
	rs.close();
} catch(SQLException e) {
	out.print(e);
	return;
	}
%> 