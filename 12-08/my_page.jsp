<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter, java.util.ArrayList, java.net.URLEncoder, java.util.List, java.util.Arrays" %>
<%@ page import="user.*, content.*, participateTable.*, myPageManagement.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width = device-width" initial-scale = "1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<title>TO DO LIST - 마이페이지</title>
<!-- Google fonts-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<style>*{font-family: 'Do Hyeon', sans-serif;}</style> 
</head>
<!--<body style="background-image: url('img/bg.jpg');"> -->
<%
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
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="myfront.jsp">To do list</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="mainpage.jsp">메뉴</a></li>
					<li class="nav-item"><a class="nav-link" href="content_view.jsp">게시판</a></li>
					<li class="nav-item dropdown">
						<button class="btn btn-secondary dropdown-toggle" type="button"
							id="dropdownMenuButton" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false">접속하기</button>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="my_join.jsp">회원가입</a></li>
							<li><a class="dropdown-item" href="my_login.jsp">로그인</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	
<div class="container">
 <div class="jumbotron bg-dark text-white" style="padding-top:30px;margin-top:30px;margin-left:30px;margin-right:30px">
  <div class="container text-center" >
    <h3 style="text-align: center;">${userID}의 마이페이지</h3>
    <table class="table bg-white text-dark" style="padding-top:30px;margin-top:30px;">
  	<thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">프로젝트 이름</th>
      <th scope="col">프로젝트 내용</th>
    </tr>
  	</thead>
  	<tbody>
    <%
    List<String> myPageList = new ArrayList<>();
	myPageList = new myPageAction().fetchAll_FromUserID(userID);
	System.out.println(myPageList);
		if(myPageList != null){
			for(int i=0; i<myPageList.size()/2;i++){
				if(i==20) break;
				%>
				<tr>
				  <th scope="row"><%=i%></th>
				  <td>
				  <%=myPageList.get(i*2)%>
				  </td>
				  <%
				  String curData = myPageList.get(i*2+1);
				  int dataLength = curData.length();
				  if (dataLength < 20) {
					  %>
					  <td><%=curData%></td>
					  <%
				  } else {
					  %>
					  <td><%=curData.substring(0, dataLength - 3 - 20) + "..."%></td>
					  <%
				  }
				%>
				</tr>
				<%
			}
		}
    %>
    </tbody>
    </table>
  </div>
 </div>
</div>
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
			integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
			crossorigin="anonymous"></script>
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
			integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
			crossorigin="anonymous"></script>
		<script
			src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
			integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
			crossorigin="anonymous"></script>
</body>
</html>