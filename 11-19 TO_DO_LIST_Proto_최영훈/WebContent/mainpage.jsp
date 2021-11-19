<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name = "viewport" content  = "width = device-width",initial-scale = "1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<title>Main Page</title>
</head>
<body>
  <%
      String userID = null;
	  if (session.getAttribute("userID") != null) {
		  userID = (String) session.getAttribute("userID");
		  session.setAttribute("BoardUserID", userID);
	  }
  %>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="mainpage.jsp">TO DO LIST 게시판</a>
    <a class="navbar-brand" href="mainpage.jsp">메인 화면</a>
    <div class="dropdown">
      <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      계정
      </button>
      <% if (userID == null) { %>
      <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
        <a class="dropdown-item" href="#">로그인</a>
        <a class="dropdown-item" href="#">회원가입</a>
      </div>
      <% } else { %>
      <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
        <a class="dropdown-item" href="#">프로필</a>
        <a class="dropdown-item" href="#">현재 계획</a>
        <a class="dropdown-item" href="#">설정</a>
        <a class="dropdown-item" href="#">로그아웃</a>
      </div>
      <% } %>
    </div>
  </nav>
  <div class="container">
    <div class="col-lg-4">
      <div class="jumbotron" style="padding-top: 50px; margin-top: 50px">
        <form method="post" action="writeBoard.jsp">
          <h5>
          글쓰기 보드
          </h5>
          <br>
          <div class="form-row">
            <input type="text" class="form-control" id="boardTitle" name="boardTitle" placeholder="글 제목">
          </div>
          <br>
          <div class="form-group">
            <textarea class="form-control" id="boardText" name="boardText" placeholder="글 내용" rows="4"></textarea>
          </div>
          <div class="form-row">
            <input type="text" class="form-control" id="boardTags" name="boardTags" placeholder="태그">
          </div>
          <input type="submit" class="btn btn-info form-control" value="Submit">
        </form>
      </div>
    </div>
  </div>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>