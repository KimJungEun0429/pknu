<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script src="../js/jquery-3.6.0.js"></script>
<script>

	function a(){
		//$("div:has(.bbb)").css("background-color", "red");
		
		//$(":button").css("border", "3px solid red");
		$("input[type='button']").css("border", "3px solid red");
		
	}

</script>

</head>
<body>
	<div>
		<span>12345</span>
		<span>12345</span>
	</div>
	<div>
		<input type="text" class="bbb"/>
		<span>1245667</span>
	</div>
	<div>
		<input type="button" value="확인" onclick="a();"/>
	</div>
	<span>
		<input type="button" value="확인"/>
	</span>
	<div>
		<span class="bbb">12345</span>
	</div>
</body>
</html>