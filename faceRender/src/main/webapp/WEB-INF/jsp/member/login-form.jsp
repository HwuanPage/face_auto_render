<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/main/header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>login</title>
<link rel="stylesheet" href="${CSS}/login.css">
</head>
<body>
<div class="container">
    <h2>로그인</h2>
    <form>
        <div class="form-group">
            <label for="username">아이디:</label>
            <input type="text" id="id" name="memberId" required>
        </div>
        <div class="form-group">
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="memberPwd" required>
        </div>
        <div class="form-group">
            <input type="button" value="로그인" id="btn_login">
        </div>
    </form>
</div>
</body>
</html>
<script>
$(document).ready(function(){
	
	
	$('#btn_login').click(function(){
		
		var formSetting = {
				"action" : "/member/login",
				"method" : "get"
			};
			
		var formData = $('form').serialize();
		
		// Ajax 호출
		$.ajax({
			type : formSetting.method,
			url : formSetting.action,
			data : formData,
			success : function(response){
				location.href="/";
			},
			error : function(response){
				alert("비밀번호 혹은 아이디가 틀립니다.");
			}
		});
	});

});
</script>