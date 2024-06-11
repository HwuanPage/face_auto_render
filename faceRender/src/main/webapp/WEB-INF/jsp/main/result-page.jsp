<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/main/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결과</title>

</head>
<body>
	 <script>
    $(document).ready(function(){
        downloadFile();
    });

    function downloadFile(){
        $.ajax({
            url: "/download",
            type: "GET",
            data: {
                objectPath: "user1/rendering/0/"
            },
            success: function(response) {
                // 다운로드 버튼 생성
                var downloadButton = $('<button>Download File</button>');
                downloadButton.click(function() {
                    // 다운로드 버튼 클릭 시 파일 다운로드 실행
                    window.location.href = "/download?objectPath=" + objectPath;
                });
                $('body').append(downloadButton);
                console.log("파일 다운로드 성공");
            },
            error: function(xhr, status, error) {
                console.log("파일 다운로드 실패: " + error);
            }
        });
    }
    </script>
    <h2>결과 페이지 입니다. 처리된 파일을 미리보기해주고, 다운로드 가능하게 만들어 줍니다.</h2>
	
</body>
</html>