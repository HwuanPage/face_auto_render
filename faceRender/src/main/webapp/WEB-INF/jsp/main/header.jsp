<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/context/global-context.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${CSS}/header.css">

<title>얼굴을 3D모델로!</title>
<!-- Google Jquery Library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
    <div class="header">
        <div class="logo">FACEAutoRender</div>
        <div class="auth-buttons">
            <button id="btn_loginpage" onclick="location.href='/login'">로그인</button>
            <button id="btn_joinpage" onclick="location.href='/signup'">회원가입</button>
            <!-- 마이페이지 버튼을 추가합니다. 기본적으로는 숨겨져 있어야 하므로 style에서 display를 none으로 설정합니다. -->
            <button id="btn_mypage" style="display:none;">마이페이지</button>
            <div id="welcomeMessage"></div>
        </div>
    </div>
</body>
</html>
<script>
$(document).ready(function(){
    checkSession();
});

function checkSession() {
    // AJAX를 이용하여 서버에 세션 확인 요청
    $.ajax({
        url: "checkSession", // 세션 확인을 위한 서버의 URL을 정확히 설정해야 합니다.
        method: "GET",
        success: function(data) {
            if(data.loggedIn) {
                $("#btn_loginpage").hide();
                $("#btn_joinpage").hide();
                
                $("#btn_mypage").show();
                $("#btn_mypage").click(function() {
                    location.href = '/mypage'; // 여기 경로를 적절히 수정하세요.
                });

                $("#welcomeMessage").text(data.memName + "님 환영합니다.");
            } else {
                $("#btn_loginpage").show(); // 로그인 버튼 표시
                $("#btn_joinpage").show(); // 회원가입 버튼 표시
                
                $("#btn_mypage").hide();
            }
        },
        error: function(xhr, status, error) {
            console.error("Error checking session:", error);
        }
    });
}
</script>
