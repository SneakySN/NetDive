<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter, java.util.ArrayList, java.net.URLEncoder" %>
<%@ page import="user.*, content.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>강의평가 웹 사이트</title>
<!-- bootstrap CSS 추가 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- custom CSS 추가 -->
<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String lectureDivide = "전체";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	
	if(request.getParameter("contentDivide") != null) 
		lectureDivide = request.getParameter("contentDivide");
	if(request.getParameter("searchType") != null) 
		searchType = request.getParameter("searchType");
	if(request.getParameter("search") != null) 
		search = request.getParameter("search");
	if(request.getParameter("pageNumber") != null) 
		try {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} catch(Exception e) {
			System.out.println("검색 페이지 번호 오류");
			
		}
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'my_login.jsp';");
		script.println("</script>");
		script.close();
		return;
	}

%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">목표 공유 챌린지</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">메인</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
						회원관리
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
<%
						if(userID == null) {
%>
						<a class="dropdown-item" href="my_login.jsp">로그인</a>
						<a class="dropdown-item" href="my_join.jsp">회원가입</a>
<%
						} else {
%>
						<a class="dropdown-item" href="logoutAction.jsp">로그아웃</a>
<%
						}
%>
					</div>
				</li>
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<select name = "contentDivide" class = "form-control mx-1,mt-2">
		 			<option value="전체">전체</option>
		 		
		 			<!--  현재는 학분 파트와 취미파트 두개만 설정 -->
		 			<option value="전체">학습</option>
		 			<option value="전체">취미</option>
		 		</select>
		 		
		 		<!--  검색창 제작 -->
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search"/>
				
				<!--  검색 버튼 제작 -->
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<section class = "conatiner">
		<form method = "get" action = "./content_page.jsp" class ="form-inline mt-3 ">
		 	
		 	<!--  등록버튼 모달 형식으로 만들어 주고, 등록하기 버튼의 id값은 register_c 이라고 해줬다 -->
		 	<button type = "button" class = "btn btn-primary mx-1 mt-2" data-toggle = "modal" data-target = "#registerc">
		 	등록
		 	</button>
		 	
		 </form>
	</section>

	<!-- 모달 형식의 클래스를 사용하고 연결되는 아이디로 register_c를 넣어 주었다(c = content의 약자) -->

	<div class="modal fade" id="registerc" tabindex="-1" role="dialog">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
      				<!--  제목작성 -->
        			<h5 class="modal-title" id = "modal" >게시글 작성</h5>
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
        			<span aria-hidden = "true">x</span>
      			</div>
      			
      				<!--  모달 내부에 들어갈, 내용 작성 -->
      			<div class="modal-body">
      				<form method = "post" action = "contentRegisterAction.jsp">
      					
      					<!--  한줄씩 작성한다는 의미. -->
        				<div class="form-group">
           					<label for="recipient-name" class="col-form-label">제목:</label>
           					<input type = "text" name = "contentName" class = "form-control" maxlength = "40" id = "textbox">
           						<script type="text/javascript">
           							id = "textbox".value= null;
           						</script>

         				</div>
         				
          				<div class="form-group">
            				<label for="message-text" class="col-form-label">내용:</label>
            				<textarea name = "contentTextbox" class="form-control" maxlength = "2048" style = "height:180px" ></textarea>
         				</div>
          				
      					<!--  제목 밑에 한 줄 더 생성, 총 길이 12 임으로 그의 1/3에 해당하도록 칸 지정 -->
      					<div class = "form-row">
      						<div class = "form-group col-sm-4">
      						     
      						    <!--  챌린지 기간을 선택할 수 있도록 설정.. 현재 변수명이 start year로 되어 있는데 추후 수정 필요함 -->
      							<label>챌린지 기간</label>
      							<select name = "contentstartYear" class = "form-control">
      								<option value = "1">1개월</option>
      								<option value = "2">2개월</option>
      								<option value = "3">3개월</option>
      								<option value = "6">6개월</option>
      								<option value = "기타">기타</option>
      							</select>
      						</div>
      						
      						<div class = "form-group col-sm-4">
      							<label>챌린지 참여 간격</label>
      							<select name = "contentperiod" class = "form-control">
      								<option value = "매일">매일</option>
      								<option value = "매주">매주</option>
      								<option value = "격주">격주</option>
      								<option value = "기타">기타</option>
      							</select>
      						</div>
      						
      						<div class = "form-group col-sm-4">
      							<label>태그 분류</label>
      							<select name = "tagDivide" class = "form-control">
      								<option value = "학습">학습</option>
      								<option value = "취미">취미</option>
      							</select>
      						</div>
      						
      						
      					<div class="form-group">
      						<!--  검색 기능 추가하면, 태그 리스트 작성 후 검색태그를 그 안에 넣는 방법 생각해야함. 임시로 contentTitle에 저장. -->
        				    <label for="message-text" class="col-form-label">검색태그:</label>
        			  		<input type="text" name = "contentTitle" class="form-control" id="recipient-name">
         				</div>
         				<div class="modal-footer">
        					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        					<button type="submit" class="btn btn-primary">게시글 등록</button>
      					</div>
      					</div>
      				</form>
      			</div>		
    		</div>
  		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2" crossorigin="anonymous"></script>
</body>
</html>
