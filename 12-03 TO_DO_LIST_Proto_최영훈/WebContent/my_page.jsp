<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter, java.util.ArrayList, java.net.URLEncoder, java.util.List, java.util.Arrays" %>
<%@ page import="user.*, content.*, participateTable.*, myPageManagement.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width = device-width" initial-scale = "1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<title>TO DO LIST - 마이페이지</title>
</head>
<body style="background-image: url('img/bg.jpg');">
<%
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
%>
 <nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="justify-content:space-between;">
  <a class="navbar-brand" href="content_view.jsp">TO DO LIST</a>
  <a class="navbar-brand" href="content_view.jsp">게시판</a>
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
<div class="container">
 <div class="jumbotron bg-dark text-white" style="padding-top:30px;margin-top:30px;margin-left:30px;margin-right:30px">
  <div class="container text-center" >
    <h3 style="text-align: center;">${userID}의 마이페이지</h3>
    <table class="table bg-white text-dark" style="padding-top:30px;margin-top:30px;">
  	<thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">프로젝트 이름</th>
      <th scope="col">프로젝트 내용</th>
    </tr>
  	</thead>
  	<tbody>
    <%
    List<String> myPageList = new ArrayList<>();
	myPageList = new myPageAction().fetchAll_FromUserID(userID);
	System.out.println(myPageList);
		if(myPageList != null){
			for(int i=0; i<myPageList.size()/2;i++){
				if(i==20) break;
				%>
				<tr>
				  <th scope="row"><%=i%></th>
				  <td>
				  <%=myPageList.get(i*2)%>
				  </td>
				  <%
				  String curData = myPageList.get(i*2+1);
				  int dataLength = curData.length();
				  if (dataLength < 20) {
					  %>
					  <td><%=curData%></td>
					  <%
				  } else {
					  %>
					  <td><%=curData.substring(0, dataLength - 3 - 20) + "..."%></td>
					  <%
				  }
				%>
				</tr>
				<%
			}
		}
    %>
    </tbody>
    </table>
  </div>
 </div>
</div>
</body>
</html>