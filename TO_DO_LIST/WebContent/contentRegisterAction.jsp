<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="content.contentDTO"%>
<%@ page import="content.contentDAO"%>

<%@ page import="java.io.PrintWriter"%>
<!-- 자바스크립트문을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 모든 데이터를 UTF-8로 받음 -->
<jsp:useBean id="content" class="content.contentDAO" scope="page" />
<!-- scope => 현재의 페이지에서만 빈즈 사용 -->
<jsp:setProperty name="content" property="*" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판!!</title>
</head>
<%
	System.out.println("중간 결과");
	request.setCharacterEncoding("UTF-8");
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
	
	String contentName = null; // 컨텐츠이름 (항목)
	int contentstartYear= 0; // 컨텐츠 시작 시간
	String contentperiod= null; // 컨텐츠 지속 기간 (3개월)
	String tagDivide= null; // 태그분류
	String contentTitle= null; // 컨텐츠 제목
	String contentTextbox= null; // //컨텐츠 텍스트 작성란
	String totalScore= null; // 목표 점수
	String creditScore= null; // 신용점수
	String comfortableScore= null; // 난이도점수
	String contentScore= null; //종합 컨텐츠 점수
	

	
	if(request.getParameter("contentName") != null)
		contentName = request.getParameter("contentName");
	if(request.getParameter("contentstartYear") != null) {
		try {
			contentstartYear = Integer.parseInt(request.getParameter("contentstartYear"));
		} catch(Exception e) {
			System.out.println("강의 연도 데이터 오류");
		}
	}
	if(request.getParameter("contentperiod") != null)
		contentperiod = request.getParameter("contentperiod");
	
	if(request.getParameter("tagDivide") != null)
		tagDivide = request.getParameter("tagDivide");
	
	if(request.getParameter("contentTitle") != null)
		contentTitle = request.getParameter("contentTitle");
	
	if(request.getParameter("contentTextbox") != null)
		contentTextbox = request.getParameter("contentTextbox");
	/*
	if(request.getParameter("totalScore") != null)
		totalScore = request.getParameter("totalScore");
	
	if(request.getParameter("creditScore") != null)
		creditScore = request.getParameter("creditScore");
	
	if(request.getParameter("comfortableScore") != null)
		comfortableScore = request.getParameter("comfortableScore");
	
	if(request.getParameter("contentScore") != null)
		contentScore = request.getParameter("contentScore");
	*/
	if(contentName == null || contentperiod == null || contentstartYear == 0 || tagDivide == null || contentTitle == null || contentTextbox == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	contentDAO ContentDAO = new contentDAO();
	
	int result = ContentDAO.content_write(new contentDTO(0, userID, contentName, contentstartYear, contentperiod,
			tagDivide, contentTitle, contentTextbox, totalScore, creditScore,
			comfortableScore, contentScore, 0));

	if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('강의 평가 등록 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'content_view.jsp'");
		script.println("</script>");
		script.close();
		System.out.println(result);
		return;
	}
	
	
%>