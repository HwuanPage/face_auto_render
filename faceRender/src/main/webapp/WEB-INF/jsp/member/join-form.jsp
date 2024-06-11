<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/main/header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="${CSS}/join.css">

<%-- Google Jquery Library --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
<div class="container">
    <h2>회원가입</h2>
    <form>
        <div class="form-group">
            <label for="id">아이디:</label>
            <input type="text" id="id" name="memId" required>
        </div>
        <div class="form-group">
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="memPwd" required>
        </div>
        <div class="form-group">
            <label for="confirm_password">비밀번호 확인:</label>
            <input type="password" id="confirm_password" name="reMemPwd" required>
        </div>
        <div class="form-group">
            <label for="nick">닉네임:</label>
            <input type="text" id="nick" name="memName" required>
        </div>
        <div class="form-group">
            <input type="button" value="가입하기" id="btn_join">
        </div>
    </form>
</div>
</body>
</html>

<script>
$(document).ready(function(){
	
	
	$('#btn_join').click(function(){
		
		var formSetting = {
				"action" : "/member/join",
				"method" : "post"
			};
			
		var formData = $('form').serialize();
			
		// Ajax 호출
		$.ajax({
			type : formSetting.method,
			url : formSetting.action,
			data : formData,
			success : function(response){
				location.href="/member/loginForm";
			},
			error : function(response){
				alert("정보가 정확하지 않습니다.");
			}
		});
	});

});
</script>