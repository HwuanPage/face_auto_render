<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/main/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>작업중입니다.</h1>
	<p>변환된파일은 자동으로 저장됩니다.</p>
</body>
</html>
<script>
$(document).ready(function(){
	checkFileExists();
		});
function checkFileExists(){
	$.ajax({
		url:"/check-file-exists",
		type:"GET",
		data:{
			objectPath:"user1/rendering/0/"
		},
		success:function(data){
			if(data.fileExists){
				location.href="/download";
			}else{
				setTimeout(checkFileExists,5000);
			}
		},
		error:function(){
			setTimeout(checkFileExists,5000);
		}
	});
}
</script>