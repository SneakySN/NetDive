<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!-- 자바스크립트문을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 모든 데이터를 UTF-8로 받음 -->
<jsp:useBean id="user" class="user.User" scope="page" />
<!-- scope => 현재의 페이지에서만 빈즈 사용 -->
<jsp:setProperty name="user" property="*" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판!!</title>
</head>
<body>
	<%
		session.invalidate();
	%>
	<script>
		location.herf = "my_login.jsp";
	</script>
</body>
</html>