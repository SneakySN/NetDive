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
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<style>*{font-family: 'Do Hyeon', sans-serif;}</style> 
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
</head>
<!-- <body style="background-image: url('img/bg.jpg');"> -->
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
<!-- Navigation-->	
	<nav class="navbar navbar-expand-lg navbar-light" id="mainNav">
	<div class="container px-4 px-lg-5">
	<a class="navbar-brand" href="content_view.jsp">메인</a>
	<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
	Menu
	<i class="fas fa-bars"></i>
	</button>
	<div class="collapse navbar-collapse" id="navbarResponsive">
	<ul class="navbar-nav ms-auto py-4 py-lg-0">
	<li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="my_page.jsp">마이페이지</a></li>
	<li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="logoutAction.jsp">로그아웃</a></li>
	</ul>
	</div>

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


   				         <!-- Page Header-->
        <header class="masthead" style="background-image: url('https://cdn.pixabay.com/photo/2016/10/15/07/27/background-1742039_960_720.jpg')">
            <div class="container position-relative px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <div class="site-heading">
                            <h1><center>To do list</center> </h1>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        
           <div class="container px-4 px-lg-5">
            <div class="row gx-4 gx-lg-5 justify-content-center">
                <div class="col-md-10 col-lg-8 col-xl-7">
                     
		<!-- <div class="row" id = "contentrow" > 
			<div class="col-sm-7"> -->

			<div data-spy="scroll" data-target="contentrow" data-offset="0">
   				 <div class="card">
   				 
   				 
   				 <script>console.log('The weather today is predicted to be ❄snowy!')
   				svg_str = `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 512 512"><path fill="currentColor" d="M440.5 345.8L408.1 327c11.8-12.3 26-18.2 26.2-18.3 7.5-3 11.4-11.4 8.9-19.1-1.9-5.9-7.4-9.8-13.5-9.8-1.9 0-3.7.4-5.5 1.1-1 .4-24.4 10-41.9 31.2l-96.3-56 96.3-56c17.5 21.2 40.8 30.8 41.9 31.2 1.8.7 3.6 1.1 5.5 1.1 6.1 0 11.6-4 13.5-9.8 2.5-7.7-1.4-16.1-8.9-19.1-.1-.1-14.3-6-26.2-18.3l32.4-18.8c7.2-4.2 9.6-13.4 5.5-20.6-2.7-4.7-7.7-7.6-13.1-7.6-2.6 0-5.3.7-7.6 2L393.1 159c-4.5-16.2-2.7-31.4-2.6-32 1.1-8.1-4.1-15.6-12-17.3-1-.2-2-.3-3-.3-7.1 0-13 5.2-14.1 12.4-.2 1.1-3.6 26 6.1 52.2l-96 56v-99.2c26.9-4.7 46.8-20.2 47.7-20.9 3.1-2.5 5.1-6 5.4-10 .3-4-.9-7.8-3.6-10.8-2.9-3.2-7-5.1-11.4-5.1-3.4 0-6.8 1.2-9.5 3.3-.1.1-12.2 9.4-28.6 13.6V63.1c0-8.2-7.1-15.1-15.5-15.1s-15.5 6.9-15.5 15.1v37.5c-16.3-4.2-28.4-13.5-28.6-13.6-2.7-2.1-6-3.3-9.5-3.3-4.4 0-8.5 1.9-11.4 5.1-2.7 3-4 7-3.6 10.9.3 3.9 2.3 7.4 5.4 9.9.9.7 20.8 16.2 47.7 20.9v99.2l-96-56c9.6-26 6.2-51.1 6-52.2-1-7.2-6.9-12.4-14-12.4-1 0-2 .1-3 .3-7.9 1.6-13.2 9.3-12 17.3 0 .2 2 15.5-2.6 31.9L86.6 140c-2.3-1.3-4.9-2-7.6-2-5.4 0-10.4 2.9-13.1 7.6-4.1 7.2-1.7 16.5 5.5 20.6l32.4 18.8c-11.7 12.1-25.7 18.1-26.2 18.3-7.5 3-11.4 11.4-8.9 19.1 1.9 5.9 7.4 9.8 13.5 9.8 1.9 0 3.7-.4 5.5-1.1 1-.4 24.4-10 41.9-31.2l96.3 56-96.3 56c-17.5-21.2-40.8-30.8-41.9-31.2-1.8-.7-3.6-1.1-5.5-1.1-6.1 0-11.6 4-13.5 9.8-2.5 7.7 1.4 16 8.9 19.1.5.2 14.5 6.2 26.2 18.3l-32.4 18.8c-7.2 4.2-9.6 13.4-5.5 20.6 2.7 4.7 7.7 7.6 13.1 7.6 2.6 0 5.3-.7 7.6-2l32.3-18.8c4.6 16.5 2.6 31.8 2.6 32-1.2 8 4.1 15.7 12 17.3 1 .2 2 .3 3 .3 7.1 0 13-5.2 14.1-12.4.2-1.1 3.6-26-6.1-52.2l96-56v99.2c-26.9 4.7-46.8 20.2-47.7 20.9-3.1 2.5-5.1 6-5.4 10-.3 4 .9 7.8 3.6 10.8 2.9 3.2 7 5.1 11.4 5.1 3.4 0 6.8-1.2 9.5-3.3.1-.1 12.3-9.4 28.6-13.6v37.5c0 8.2 7.1 15.1 15.5 15.1s15.5-6.9 15.5-15.1v-37.5c16.3 4.2 28.4 13.5 28.6 13.6 2.7 2.1 6.1 3.3 9.5 3.3 4.4 0 8.5-1.9 11.4-5.1 2.7-3 4-7 3.6-10.9-.3-3.9-2.3-7.4-5.4-9.9-.9-.7-20.8-16.2-47.7-20.9V282l96 56c-9.6 26-6.2 51.1-6 52.2 1 7.2 6.9 12.4 14 12.4 1 0 2-.1 3-.3 7.9-1.6 13.1-9.2 12-17.3-.1-.5-1.9-15.7 2.6-32l32.2 18.8c2.3 1.3 4.9 2 7.6 2 5.4 0 10.4-2.9 13.1-7.6 4.1-6.9 1.7-16.2-5.5-20.4z"/></svg>`
   					snow = new DOMParser().parseFromString(svg_str, 'text/xml').children[0]

   					// set the svg's position to fixed
   					snow.style.position = "fixed"
   					snow.style.top = '-24px'

   					// new snowflake
   					let newSnow = () => {
   						// create a new snow
   						let clonedSnow = snow.cloneNode(true);

   						// assign to it a random left
   						let left = Math.floor(document.body.offsetWidth * Math.random())
   						clonedSnow.style.left = left + 'px';

   						// add it to the dom
   						document.body.append(clonedSnow)

   						// assign to it a random speed
   						let time = Math.max(10 * Math.random(), 5) * 1000

   						let anim = clonedSnow.animate([ { top: (window.innerHeight + 24) + 'px' } ], { duration: time, fill: 'forwards' })

   						// garbage collection
   						anim.onfinish = el => el.target.effect.target.remove()

   						return snow
   					}

   					wait = time => new Promise(res => setTimeout(res, time))

   					let asyncIterate = async (start, iterations, fn) => {
   						let i = start;
   						let call = res => fn(res)
   							.then(async result => {
   								if (i >= iterations) return result;
   								i++
   								return await call(i)
   							});
   						return await call(i);
   					}

   					// also don't run it for people who do not 
   					if(window.matchMedia && window.matchMedia('(prefers-reduced-motion: true)').matches) {
   						console.log('No snow for you because you (prefers-reduced-motion)')
   					} else {
   						asyncIterate(0, Infinity, async () => {
   							// wait 10 seconds if the user is not active
   							// if (navigator.userActivation && !navigator.userActivation.isActive) return await wait(10000);
   							if (document.visibilityState && document.visibilityState != 'visible') return await wait(10000).then(() => console.log('page was not visible'));
   							await wait(Math.max(3 * Math.random(), 1) * 300)
   							newSnow();
   						})
   					}</script>


      				
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
      					<h5 class="card-title"><center><%=contentdata.getContentName()%>&nbsp;</center></h5>
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
      					<input type="submit" class="btn btn-info form-control btn-dark" value="참여하기">
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
		
<!--			<div class="col-sm-5">
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
		</div>  -->  
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


	

