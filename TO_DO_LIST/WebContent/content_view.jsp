<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter, java.util.ArrayList, java.net.URLEncoder" %>
<%@ page import="user.*, content.*, participateTable.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="write_funcUI.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>TO DO LIST - 메인 화면, 게시판</title>
<!-- bootstrap CSS 추가 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- custom CSS 추가 -->
<link rel="stylesheet" href="album.css">
</head>
<body style="background-image: url('img/bg.jpg');">
<%
		request.setCharacterEncoding("UTF-8");
		String tagDivide = "전체"; // 기본선택사항 = 전체
		String searchType = "최신순";
		String search = "";
		int pageNumber = 0;
		if(request.getParameter("tagDivide")!=null){
			tagDivide = request.getParameter("tagDivide");
		}
		if(request.getParameter("searchType")!=null){
			searchType = request.getParameter("searchType");
		}
		if(request.getParameter("search")!=null){
			search = request.getParameter("search");
		}
		if(request.getParameter("pageNumber")!=null){
			try{
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			} catch (Exception e){
				System.out.println("검색 페이지 오류");
			}
			
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
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
			<a class="navbar-brand" href="content_view.jsp">TO DO LIST</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active">
						<a class="nav-link" href="content_view.jsp">메인</a>
					</li>
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
							회원관리
						</a>
						<div class="dropdown-menu" aria-labelledby="dropdown">
						    <a class="dropdown-item" href="my_page.jsp">마이페이지</a>
							<a class="dropdown-item" href="logoutAction.jsp">로그아웃</a>
						</div>
					</li>
				</ul>
			<!-- 검색 란 -->
			<div class = "form-group">
				<form action="./content_view.jsp" method="get" class="form-inline my-1 my-lg-0">
					<select name = "contentDivide" class = "form-control ">
		 				<option value="전체">전체</option>
		 		
		 				<!--  현재는 학분 파트와 취미파트 두개만 설정 -->
		 				<option value="전공"><% if(tagDivide.equals("전공"))out.println("selected"); %>학습</option>
		 				<option value="취미"><% if(tagDivide.equals("취미"))out.println("selected"); %>취미</option>
		 			</select>
		 			<select name = "searchType" class = "form-control mx-1,mt-2">
		 		
		 			<!--  기본 정렬타입 = 최신순 -->
		 			<option value="전체">최신순</option>
		 			</select>
		 		
		 			<!--  검색창 제작 -->
					<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search"/>
				
					<!--  검색 버튼 제작 -->
					<button class="btn btn-outline-success" type="submit">검색</button>
					<button type = "button" class = "btn btn-primary " data-toggle = "modal" data-target = "#registerc">
	 				등록
	 				</button>
	 			</form>
	 		</div>
		</div>
		</nav>

		<div class="row" id = "contentrow" >
			<div class="col-sm-7">

			<div data-spy="scroll" data-target="contentrow" data-offset="0">
   				 <div class="card">
      				
      									<!--  게시판 글 게시 부분 출력 -->
<%
					ArrayList<contentDTO> contentList = new ArrayList<contentDTO>();
					contentList = new contentDAO().get_searchList(tagDivide,searchType,search,pageNumber);
						if(contentList != null){
							for(int i=0; i<contentList.size();i++){
								if(i==3) break;
								contentDTO contentdata = contentList.get(i);
								System.out.println(i);
%>						<div class="card" style="prefers-color-scheme: dark">
						<div class="card-body"style = "height:280px">
      					<h5 class="card-title"><%=contentdata.getContentName()%>&nbsp;</h5>
        				<p class="card-text"style = "height:180px"><%=contentdata.getContentTextbox()%>&nbsp;</p>
      					</div>
      					<!--  # 부분에 참여하기 버튼에 따른 기능 추가. -->
      					<div class = "card-bottom">
      					<form action="participateAction.jsp" method="get">
      					<%
      					int evaluationID = contentdata.getEvaluationID();
      					System.out.print("content_view evaluationID: ");
      					System.out.println(evaluationID);
      					%>
      					<input type="submit" class="btn btn-info form-control" value="참여하기">
      					<input type="hidden" name="evaluationID" value="<%=evaluationID%>">
      					</form>
      					</div>
      				</div>
<%
					}
%>   					
    			</div>
  			</div>
			</div>
		
  			<div class="col-sm-5">
			  	<div class="list-group">
  					<a href="#" class="list-group-item list-group-item-action">
  					  <div class="d-flex w-100 justify-content-between">
     					 <h5 class="mb-1">List group item heading</h5> 
     					 <small>3 days ago</small>
    				  </div> 
    					<p class="mb-1">Some placeholder content in a paragraph.</p>
					</a>
				</div>
 			</div>
		</div>
    <ul class="pagination justify-content-center mt-3">
      <li class="page-item">
      
<%  if(pageNumber <= 0) {%>
	    <a class="page-link disabled">이전</a>
<%} else {%>
		<a class="page-link" href="./content_view.jsp?lectureDivide=<%=URLEncoder.encode(tagDivide, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber - 1%>">이전</a>
<%
	}
%>
      </li>
      <li class="page-item">
<%	if(contentList.size() < 4) {%>     
        <a class="page-link disabled">다음</a>
<%	} else {%>
		<a class="page-link" href="./content_view.jsp?lectureDivide=<%=URLEncoder.encode(tagDivide, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber + 1%>">다음</a>
<%	}
}
%>
</li>
</ul>


<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2" crossorigin="anonymous"></script>
</body>
</html>
	

