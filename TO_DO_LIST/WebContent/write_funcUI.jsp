<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter, java.util.ArrayList, java.net.URLEncoder" %>
<%@ page import="user.*, content.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- bootstrap CSS 추가 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- custom CSS 추가 -->
<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
	<!-- 모달 형식의 클래스를 사용하고 연결되는 아이디로 register_c를 넣어 주었다(c = content의 약자) -->

	<div id="registerc" class="modal fade"  tabindex="-1" role="dialog">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
      				<!--  제목작성 -->
        			<h5 class="modal-title" id = "modal" >게시글 작성</h5>
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
        			<span aria-hidden = "true">x</span>
      			</div>
      			
      				<!--  모달 내부에 들어갈, 내용 작성 -->
      			<div class="modal-body">
      				<form method = "post" action = "contentRegisterAction.jsp">
      					
      					<!--  한줄씩 작성한다는 의미. -->
        				<div class="form-group">
           					<label for="recipient-name" class="col-form-label">제목:</label>
           					<input type = "text" name = "contentName" class = "form-control" maxlength = "40" id = "textbox">
           						<script type="text/javascript">
           							id = "textbox".value= null;
           						</script>

         				</div>
         				
          				<div class="form-group">
            				<label for="message-text" class="col-form-label">내용:</label>
            				<textarea name = "contentTextbox" class="form-control" maxlength = "2048" style = "height:180px" ></textarea>
         				</div>
          				
      					<!--  제목 밑에 한 줄 더 생성, 총 길이 12 임으로 그의 1/3에 해당하도록 칸 지정 -->
      					<div class = "form-row">
      						<div class = "form-group col-sm-4">
      						     
      						    <!--  챌린지 기간을 선택할 수 있도록 설정.. 현재 변수명이 start year로 되어 있는데 추후 수정 필요함 -->
      							<label>챌린지 기간</label>
      							<select name = "contentstartYear" class = "form-control">
      								<option value = "1">1개월</option>
      								<option value = "2">2개월</option>
      								<option value = "3">3개월</option>
      								<option value = "6">6개월</option>
      								<option value = "기타">기타</option>
      							</select>
      						</div>
      						
      						<div class = "form-group col-sm-4">
      							<label>챌린지 참여 간격</label>
      							<select name = "contentperiod" class = "form-control">
      								<option value = "매일">매일</option>
      								<option value = "매주">매주</option>
      								<option value = "격주">격주</option>
      								<option value = "기타">기타</option>
      							</select>
      						</div>
      						
      						<div class = "form-group col-sm-4">
      							<label>태그 분류</label>
      							<select name = "tagDivide" class = "form-control">
      								<option value = "학습">학습</option>
      								<option value = "취미">취미</option>
      							</select>
      						</div>
      						
      						
      					<div class="form-group">
      						<!--  검색 기능 추가하면, 태그 리스트 작성 후 검색태그를 그 안에 넣는 방법 생각해야함. 임시로 contentTitle에 저장. -->
        				    <label for="message-text" class="col-form-label">검색태그:</label>
        			  		<input type="text" name = "contentTitle" class="form-control" id="recipient-name">
         				</div>
         				<div class="modal-footer">
        					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        					<button type="submit" class="btn btn-primary">게시글 등록</button>
      					</div>
      					</div>
      				</form>
      			</div>		
    		</div>
  		</div>
	</div>

</body>
</html>
