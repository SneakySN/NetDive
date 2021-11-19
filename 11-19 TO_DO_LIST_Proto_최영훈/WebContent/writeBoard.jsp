<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.BoardWrite" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="board.Board" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 업로드 중...</title>
</head>
<body>
	<%
		if (board.getBoardTitle() == null || board.getBoardText() == null || board.getBoardTags() == null) {
			PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('입력이 안 된 사항이 있습니다.')");
	        script.println("history.back()");
	        script.println("</script>");
		} else {
			while (true) {
				BoardWrite boardWrite = new BoardWrite();
				int result = boardWrite.newPost(board);
				if (result == 0) continue;
				else break;
			}
		}
	%>
</body>
</html>