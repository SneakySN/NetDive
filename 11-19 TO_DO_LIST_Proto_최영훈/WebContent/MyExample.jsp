<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!-- 
지원하는 Examples:

 -->
<!-- 웹사이트 타이틀 -->
<head>
<!-- 포맷은 무조건 UTF-8 -->
<meta charset="UTF-8">
<meta name = "viewport" content  = "width = device-width" initial-scale = "1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<title>MyExample Object Examples</title>
</head>
<!-- Body - 웹사이트의 실질적 부분을 처리 -->
<body>
<!-- 웹사이트에 텍스트 띄우기 -->
  <!-- 웹사이트 바 생성 -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class = navbar-brand" href="test.jsp">
        테스트 바 텍스트 Test bar text
        <!-- test.jsp에는 누르면 이동할 페이지를 넣는다 -->
      </a>
      <!-- 드랍드운 메뉴 생성 -->
      <div class="dropdown">
	    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	      Dropdown button
	    </button>
	    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
	      <a class="dropdown-item" href="#">Action</a>
	      <a class="dropdown-item" href="#">Another action</a>
	      <a class="dropdown-item" href="#">Something else here</a>
	    </div>
      </div>
    </nav>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>