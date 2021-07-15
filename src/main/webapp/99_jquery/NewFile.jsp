<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script>

	function a(){
		document.getElementById("msg").innerHTML = "afdaafdsf";
		document.getElementById("btn").click();
	}
	
	function b(){
		document.getElementById("msg").innerHTML += "버튼 b가 클릭되었습니다.";
	}

</script>
</head>
<body>
	<input type="button" value="확인" onclick="a();"/>
	<div id="msg">
	
	
	</div>
	<input type="button" value="버튼b" id="btn" onclick="b();"/>
</body>
</html>