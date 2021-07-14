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
			
			//javascript
			//1. id   - document.getElementById()
			//2. name - document.getElementsByName();
			//3. tagname - document.getElementsByTagName();
			
			/*
			var objInputs = document.getElementsByTagName("input");
			for(var i=0;i<objInputs.length;i++){
				objInputs[i].value = "a";
			}
			*/
			//jquery
			//$("*").val();
			
			//1.selector - tagname
			//$("input").val("a");
			
			//2.selector - id
			//$("#test2").val("1234");
			
			//3.selector - class
			//$(".back").val("adafsd");
			
			//4.selector -all
			//$("*").css("background-color","yellow");
			
			//5.selector - multi Selector
			
			//class = 'back' id="test3" 인객체를 배경색깔을 보라색으로 해보자
			//$(".back").css("background-color","violet");
			//$("#test3").css("background-color","violet");
			//$(".back, #test3").css("background-color","violet")
			//                  .val("1234567");
			
			//6. attribute - 태그안에 속성값으로 selector
			//$("input[name='test1']").val("1234568798");
			//$("input[type='button']").val("메롱");
			//$("*[name='test1']").val("12");
			
			//7. :eq()
			//$("input:eq(2)").val("1234");
			
			//8. :focus
			$("input:focus").css("background-color","blue");
		}
		
		function b(color){
			$("input:focus").css("background-color",color);
		}
	
	</script>
	
	<style>
	
		.back{
			background-color:red;
		}
	
	</style>

</head>
<body>
	<input type="text" name="test1" id="test1" class="back" 
						onfocus="b('blue')" onblur="b('white')"/><br/>
	<input type="text" name="test1" id="test2" onfocus="b('blue')" onblur="b('white')"/><br/>
	<input type="text" name="test2" id="test3" onfocus="b('blue')" onblur="b('white')"/><br/>
	<input type="text" name="test2" id="test4" class="back" onfocus="b('blue')" onblur="b('white')"/><br/>
	
	<input type="button" value="확인" onclick="a();"/>
</body>
</html>