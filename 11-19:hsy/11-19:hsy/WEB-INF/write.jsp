<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class = "container">
	<div class="row"></div>
	<form= method="post" action="writeAction.jsp">
		<table class = "table table-striped" style = "text-align : center;border : 1px solid #dddddd">
			<thread>
			<tr>
			<th colspan= " 2" style = "background-color : #eeeee; text-align: center;">게시판 글쓰기 양식</th>
			</tr>
			</thread>
			<tbody></tbody>
			<tr>
				<td><input type= "text" class = "form-control" placeholder="글 제목" name = "bbsTitle" maxlength="50"></td>
				</tr>
				
				<tr>
				<td><textarea class = "form-control" placeholder="글 내용 " name = "bbsContent" maxlength="2080" style = "height : 350px">안녕하세요.</textarea></td>
			</tr>
		</tbody>
		
		</table>
		<input type = "sumbit" class = btn btn-primary pull-right" valuse="글쓰기 ">
		</form>
		
</body>
</html>