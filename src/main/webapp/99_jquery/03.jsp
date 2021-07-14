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
		//$("span").eq(0).html("adfa");
		
		//$("div.aaa1 span.zzz").html("<a href=''>asdfadsf</a>");
		//$("div.aaa1").css("visibility", "visible");
		$("div.aaa1").show(3000);
	}

</script>
<style>

	.aaa1{
		width:300px;
		height:300px;
		border:1px solid red;
		display:none;
		/*visibility:hidden;*/
	}
	.aaa3{
		width:300px;
		height:300px;
		border:1px solid red;
		display:show;
		/*visibility:visible;*/
	}

</style>
</head>
<body>

	<div class="aaa1">
		<span class="zzz">1</span>
		<span>2</span>
	</div>
	<div class="aaa2">
		<span>3</span>
		<span>4</span>
	</div>
	<div>
		<input type="button" value="확인" onclick="a()"/>
	</div>
	<ul  class="aaa3">
		<span>5</span>
		<span>6</span>
	</ul>

</body>
</html>