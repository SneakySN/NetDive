<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width = device-width" initial-scale = "1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<title>To do list - 로그인</title>
</head>
<body style="background-image: url('img/bg.jpg');">
 <nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="justify-content: center;">
  <a class="navbar-brand" href="mainpage.jsp">JSP 게시판 웹 사이트</a>
   <a class="navbar-brand text-secondary" href="mainpage.jsp">메뉴</a>
   <a class="navbar-brand text-secondary" href="bbs.jsp">게시판</a>
   <div class="dropdown">
      <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        접속하기
      </button>
    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
     <li>
     <a class="dropdown-item" href="my_join.jsp">회원가입</a>
     <a class="dropdown-item" href="my_login.jsp">로그인</a>
     </li>
    </div>
   </div>
  </nav>
 <div class="container" >
   <div class="jumbotron" style="padding-top: 30px;margin-top: 20%;margin-left: 25%;margin-right: 25%">
   <div class="container text-center" >
    <form method="post" action="loginAction.jsp">
     <h3 style="text-align: center;">로그인 화면</h3>
     <br>
     <div class="form-row" style="margin: auto; width: 90%">
      <input type="text" class="form-control" id="userID" name="userID" placeholder="아이디" maxlength="20">
     </div>
     <br>
     <div class="form-row" style="margin: auto; width: 90%">
      <input type="password" class="form-control" id="userPassword" name="userPassword"  placeholder="비밀번호" maxlength="20">
     </div>
     <br>
     <input type="submit" class="btn btn-info form-control" value="로그인" style="width: 90%">
    </form>
    </div>
   </div>
  </div>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>