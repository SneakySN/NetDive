<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!-- 자바스크립트문을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 모든 데이터를 UTF-8로 받음 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<!-- scope => 현재의 페이지에서만 빈즈 사용 -->
<jsp:setProperty name="bbs" property="bbsTitle"  />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>게시판!!</title>
</head>
<body>
<%--
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
 --%>
 	<%
	String userID = null;
 	if(session.getAttribute("userID")!=null){
 		userID = (String) session.getAttribute("userID");
 		
 	}
 	if(userID == null){
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('로그인을 하세요.')");
 		script.println("location.href=login.jsp");
 		script.println("history.back()");
 		script.println("</script>");
 	}else{
 		if(bbs.getBbsTitle() == null || bbs.getBbsContent()==null){
 			PrintWriter script= response.getWriter();
 			script.println("<script>");
 			script.println("alert'입력이 안 된 사항이 있습니다.')");
 			script.println("history.back()");
 			script.println("</script>");
 		} else{
 		BbsDAO bbsDAO = new BbsDAO();
        int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());				
        if(result == -1){ // 아이디가 기본키기. 중복되면 오류.
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('글쓰기에 실패했습니다. ')");
        script.println("history.back()");
        script.println("</script>");
        } //가입성공
    else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = "bbs.jsp'");
        script.println("</script>");
        }
 		}
 	}
 	%>
 
</body>
</html>