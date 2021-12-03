<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="participateTable.ParticipateDAO"%>
<%@ page import="participateTable.ParticipateDTO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="participateTable" class="participateTable.ParticipateDTO" scope="page" />
<jsp:setProperty name="participateTable" property="*" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> JSP content</title>
</head>
<body>
<%
	String userID = null;
	int evaluationID = 0;
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
	}
	System.out.print("participateAction evaluationID: ");
	System.out.println(request.getParameter("evaluationID"));
	evaluationID = Integer.parseInt(request.getParameter("evaluationID"));
	System.out.print("userID: ");
	System.out.println(userID);
	System.out.print("evaluationID: ");
	System.out.println(evaluationID);
	ParticipateDAO partDAO = new ParticipateDAO();
	int result = partDAO.join(new ParticipateDTO(evaluationID, userID));
	
	if(result!=0 || result!=-1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		System.out.println(result);
		script.println("alert('프로젝트 참여 성공.')");
		script.println("location.href = 'content_view.jsp'");
		script.println("</script>"); 
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('프로젝트 참여 실패.')");
		script.println("location.href = 'content_view.jsp'");
		script.println("</script>"); 
    }
%>
</body>
</html>