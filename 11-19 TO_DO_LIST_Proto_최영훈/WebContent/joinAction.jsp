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
<meta charset=UTF-8>
<title>게시판!!</title>
</head>
<body>
 <%
    if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserGender() == null){

         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('입력이 안 된 사항이 있습니다.')");
         script.println("history.back()");
         script.println("</script>");

   } else{
        UserDAO userDAO = new UserDAO(); //인스턴스생성
        int result = userDAO.join(user);				
        if(result == -1){ // 아이디가 기본키기. 중복되면 오류.
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 존재하는 아이디 입니다.')");
        script.println("history.back()");
        script.println("</script>");
        } //가입성공

    else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
        }

     }

 %>
</body>
</html>