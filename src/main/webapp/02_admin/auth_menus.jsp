<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>권한별 메뉴</title>


<script type="text/javascript" src="../js/jquery-3.6.0.js"></script>
<script>

	$(document).ready(
	
			function(){
				setAuthList();
			}
			
	);
	

	var setAuthList = function(){
	
		var strHTML = "";
		
		var ajaxObj = {
				
				type:"post", 
				async:"true", 
				url:"/ServBoard/Admin_AuthList_AJAX", 
				data:"authname=''", 
				dataType:"xml",  
				success: function(data){
					
					strHTML += "<table border='1' width='90%' align='center'>";
					
					$(data).find("authList").each(
					
							function(){
								var authID = $(this).find("authID").text();
								var authName = $(this).find("authName").text();
								
								if(authID != ""){
								
									strHTML += "<tr onclick='javascript:setTopMenuList(&quot;" + authID + "&quot;)'>";
									strHTML += "<td width='30%' height='40px' align='center'>";
									strHTML += authID;
									strHTML += "</td>";
									strHTML += "<td width='70%' height='40px' align='center'>";
									strHTML += authName;
									strHTML += "</td>";
									strHTML += "</tr>";
								}
							}
					)
					
					
					strHTML += "</table>";
					
					$("#authList").html(strHTML);
					
				},
		  		error : function(xhr,status,error) {
		      		alert("err")
		  		},
		  		complete:function(data,textStatus) {
		  			
		  		}
	
			  }
		
		$.ajax(ajaxObj);
		
		
	}
	
	var setTopMenuList = function(selectedAuthID){
		alert(selectedAuthID);
	}


</script>


</head>
<body>
	
		<table border="1" width="100%" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="100%" height="70px" align="center">
				<!-- 메뉴구성 테이블 시작 -->
				<table border="1" width="80%" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td width="16%" height="40" align="center">
							<a href="/ServBoard/Admin_AuthList"><span>권한관리</span></a>
						</td>
						<td width="16%" height="40" align="center" class="selectedMenu">
							<span>회원관리</span>
						</td>
						<td width="16%" height="40" align="center">
							<a href="/ServBoard/Admin_MenuList"><span>메뉴관리</span></a>
						</td>
						<td width="16%" height="40" align="center">
							<a href="/ServBoard/02_admin/program_list.jsp"><span>프로그램관리</span></a>
						</td>
						<td width="16%" height="40" align="center">
							<span>권한별상세관리</span>
						</td>
					</tr>
				</table>
				<!-- 메뉴구성 테이블 끝 -->
			</td>
		</tr>
		<tr>
			<td>
			
				<!-- 권한별상세 레이아웃 시작 -->
				<table border="1" cellpadding="0" cellspacing="0" width="100%" align="center">
					<tr>
						<td width="20%" height="670px" align="center" rowspan="2" valign="top">
							<!-- 권한리스트 가져오자 -->
							<div id="authList"></div>
							<!-- 권한리스트 가져오자 -->
						</td>
						<td width="80%" height="200px" align="center">
						
						</td>
					</tr>
					<tr>
						<td width="80%" height="470px" align="center">
						
						</td>
					</tr>
				</table>
				<!-- 권한별상세 레이아웃 끝 -->
			
			</td>
		</tr>
	</table>
	
</body>
</html>