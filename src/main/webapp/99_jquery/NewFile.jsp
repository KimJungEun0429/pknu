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
		document.getElementById("msg").innerHTML += "��ư b�� Ŭ���Ǿ����ϴ�.";
	}

</script>
</head>
<body>
	<input type="button" value="Ȯ��" onclick="a();"/>
	<div id="msg">
	
	
	</div>
	<input type="button" value="��ưb" id="btn" onclick="b();"/>
</body>
</html>