<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���Ѻ� �޴�</title>


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
				<!-- �޴����� ���̺� ���� -->
				<table border="1" width="80%" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td width="16%" height="40" align="center">
							<a href="/ServBoard/Admin_AuthList"><span>���Ѱ���</span></a>
						</td>
						<td width="16%" height="40" align="center" class="selectedMenu">
							<span>ȸ������</span>
						</td>
						<td width="16%" height="40" align="center">
							<a href="/ServBoard/Admin_MenuList"><span>�޴�����</span></a>
						</td>
						<td width="16%" height="40" align="center">
							<a href="/ServBoard/02_admin/program_list.jsp"><span>���α׷�����</span></a>
						</td>
						<td width="16%" height="40" align="center">
							<span>���Ѻ��󼼰���</span>
						</td>
					</tr>
				</table>
				<!-- �޴����� ���̺� �� -->
			</td>
		</tr>
		<tr>
			<td>
			
				<!-- ���Ѻ��� ���̾ƿ� ���� -->
				<table border="1" cellpadding="0" cellspacing="0" width="100%" align="center">
					<tr>
						<td width="20%" height="670px" align="center" rowspan="2" valign="top">
							<!-- ���Ѹ���Ʈ �������� -->
							<div id="authList"></div>
							<!-- ���Ѹ���Ʈ �������� -->
						</td>
						<td width="80%" height="200px" align="center">
						
						</td>
					</tr>
					<tr>
						<td width="80%" height="470px" align="center">
						
						</td>
					</tr>
				</table>
				<!-- ���Ѻ��� ���̾ƿ� �� -->
			
			</td>
		</tr>
	</table>
	
</body>
</html>