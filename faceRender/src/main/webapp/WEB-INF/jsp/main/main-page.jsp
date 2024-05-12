<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/main/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FaceAutoRender Main Page</title>

</head>
<body>
	<form action="/upload" method="post" enctype="multipart/form-data">
    Select file to upload:
    <input type="file" name="file" accept="image/jpeg,image/jpg, image/png">
    <button type="submit">Upload</button>
</body>
</html>