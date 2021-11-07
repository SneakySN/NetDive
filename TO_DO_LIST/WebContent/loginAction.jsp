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
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(), user.getUserPassword());
	
	if (result == 1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	if (result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다')");
		script.println("history.back()");
		script.println("</script>");
	}
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디 입니다.')");
		script.println("history.back()");
		script.println("</script>");
	}

	if (result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터 베이스 오류가 발생하였습니다. ')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
</body>
</html>