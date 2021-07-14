<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
	
		function check(){
			var title  = $("#title").val();
		
			if(title == ""){
				alert("글제목을 입력하세요 !!!");
				$("#title").focus();
				
				return false;
			}
			else{
				
				//$("#writeForm").submit();
			}
		}
	
	</script>
</head>
<body>
	<form name="writeForm" id="writeForm" action="/ServBoard/BoardInsert" method="post">
		<div>
		
			글제목 : <input type="text" name="title" id="title"/>
			
		</div>
		<div>
		
			<textarea name="content" rows="10" cols="60" id="content"></textarea>
		
		</div>
		<div>
			<input type="submit" value="확인"  onclick="return check()"/>
		</div>
	</form>
</body>
</html>