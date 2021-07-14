<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

	<style>
	
		span{
			width:100px;
			height:20px;
			padding-top:5px;
			float:left;
			border:1px solid blue;
			
		}
	
		div{
		
			clear:both;
		
		}
	</style>

<script src="../js/jquery-3.6.0.js"></script>

<script>


	var chkAll = function(obj, num){
		
		//alert();
		
		if($(obj).prop("checked")){
			$("input[name='chk']").prop("checked", true);
		}
		else{
			$("input[name='chk']").prop("checked", false);
		}
		
	}
	
	var chkAll2 = function(obj, objName){
		
		//alert();
		var objChks = document.getElementsByName(objName);
		if(obj.checked){
			for(var i=0;i<objChks.length;i++){
				
				//if(i % 2 == 1){
					objChks[i].checked = true;
				//}
			}
		}
		else{
			for(var i=0;i<objChks.length;i++){
				objChks[i].checked = false;
			}
		}
		
		
		
		
	}

</script>

</head>
<body>

	<%
		for(int i = 0;i<10;i++){
	%>
	<div id="divName<%=i%>">
		<span>
			<input type="checkbox" name="chk" onclick="chkAll(this, <%=i%>)" />
		</span>
		<span>
			<input type="checkbox" name="chk1"  />
		</span>
		<span>
			<input type="checkbox" name="chk2"  />
		</span>
		<span>
			<input type="checkbox" name="chk3"  />
		</span>
	</div>
	<%
		}
	%>
</body>
</html>