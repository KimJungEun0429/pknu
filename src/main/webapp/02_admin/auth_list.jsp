<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="PKG_ADMIN_DAO.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<style>

	body{
		margin:0px;
	}
	
	.txt{
		width:98%;
		height:40px;
		border-width:0px;
		text-align:center;
		font-size:16px;
	}
	
	.selectedMenu{
		background-color:#444444;
		color:#fefefe;
		font-weight:bolder;
	}
</style>

<script src="/ServBoard/js/jquery-3.6.0.js"></script>
<script>

	var authSearch = function(){
		
		var authname = $("#s_authname").val();
		
		location.href = "/ServBoard/Admin_AuthList?authname=" + authname;
		
	}
	
	var checkAll = function(){
		
		var rst = $("#chkAll").prop("checked");
		
		if(rst){
			$("input[name='chk']").prop("checked", true);
		}
		else{
			$("input[name='chk']").prop("checked", false);
		}
	}
	
	var isAddRow = true;
	var addRow = function(){
		
		//ajax로 새로운 AUTHID를 받아온다.
		setNewAuthID();

		
	}
	
	var addRow_Res = function(newID){
		
		
		var strHTML = "";
		strHTML += "<tr>";
		strHTML += "	<td width='10%' height='40' align='center'>";
		strHTML += "		<input type='checkbox' name='chk' value='" + newID+ "'/>";
		strHTML += "	</td>";
		strHTML += "	<td width='25%' height='40' align='center'>";
		strHTML += "		<input type='text' name='authid' class='txt' value='" + newID + "' readonly/>";
		strHTML += "	</td>";
		strHTML += "	<td width='45%' height='40' align='center'>";
		strHTML += "		<input type='text' name='authname' class='txt'/>";
		strHTML += "	</td>";
		strHTML += "	<td width='1px'>";
		strHTML += "		<input type='hidden' name='gbn' value='I' />";
		strHTML += "	</td>";
		strHTML += "</tr>";
	
		if(isAddRow){
			$("#authListTbl tbody").append(strHTML);
		}
		
		isAddRow = false;
	}
	
	var modify = function(){
		
		var cnt = 0;
		var len = $("input[name='authname']").length;
		for(var i=0;i<len;i++){
			var authname_val = $("input[name='authname']").eq(i).val();
			//alert(authname_val);
			
			if(authname_val.trim() == ""){
				cnt += 1;
			}
		}
		
		if(cnt > 0){
			
			alert("권한이름을 정확하게 입력해 주세요 !!!");
			return;
		}
		
		
		$("#authForm").submit();
	}

	
	var setNewAuthID = function(){

		var newAuthID = "";
		
		var ajaxObj = {
				
				type:"post", 
				async:"true", 
				url:"/ServBoard/Admin_NewAuthID", 
				data:"", 
				dataType:"xml",  
				success: function(data){
					//alert(data);
					newAuthID = $(data).find("authNewID").text();
					
				},
		  		error : function(xhr,status,error) {
		      		alert("err")
		  		},
		  		complete:function(data,textStatus) {
		  			addRow_Res(newAuthID);
		  		}

			  }
		
		$.ajax(ajaxObj);
		
		
	}
	
	
	var delRow = function(){
		
		//하나라도 체크가 되지 않았다면 체크해라 이놈아
		
		//삭제 하시겠습니까?
		var isRst = confirm("삭제 하시겠습니까?");
		
		if(isRst){
			$("#authForm").attr("action","/ServBoard/Admin_DelAuthList");
			$("#authForm").submit();
		}
	}
</script>

</head>

<%

	ArrayList<AuthListDAO> authLists = (ArrayList<AuthListDAO>)request.getAttribute("authLists");

%>


<body>
	<form name="authForm" id="authForm" action="/ServBoard/Admin_ModAuthList" method="post">
	<table border="1" width="100%" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="100%" height="70px" align="center">
				<!-- 메뉴구성 테이블 시작 -->
				<table border="1" width="80%" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td width="16%" height="40" align="center" class="selectedMenu">
							<span>권한관리</span>
						</td>
						<td width="16%" height="40" align="center">
							<a href="/ServBoard/Admin_MemList"><span>회원관리</span></a>
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
			<td width="100%" height="890px" align="center" valign="top" id="authListTbl">
				<!-- 권한리스트 테이블 시작 -->
				<table border="1" width="80%" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td width="35%" height="50" colspan="2">
							<input type="text" name="s_authname" id="s_authname" />
							<input type="button" value="조회" onclick="authSearch()"/>
						</td>
						<td width="45%" height="50" align="right" colspan="2">
							<input type="button" value="추가" onclick="addRow()"/>
							<input type="button" value="저장" onclick="modify()"/>
							<input type="button" value="삭제" onclick="delRow()"/>
						</td>
					</tr>
					<tr>
						<td width="10%" height="30" align="center">
							<input type="checkbox" name="chkAll" id="chkAll" onclick="checkAll()"/>
						</td>
						<td width="25%" height="30" align="center">
							권한아이디
						</td>
						<td width="45%" height="30" align="center">
							권한명
						</td>
						<td width="1px">
						
						</td>
					</tr>
					
					<%
						for(AuthListDAO auth : authLists){
					%>
					<tr>
						<td width="10%" height="40" align="center">
							<input type="checkbox" name="chk" value="<%=auth.getAuthID() %>"/>
						</td>
						<td width="25%" height="40" align="center">
							<input type="text" name="authid" class="txt" value="<%=auth.getAuthID() %>" readonly/>
						</td>
						<td width="45%" height="40" align="center">
							<input type="text" name="authname" class="txt" value="<%=auth.getAuthName() %>"/>
						</td>
						<td width="1px">
							<input type="hidden" name="gbn" value="U" />
						</td>
					</tr>
					<% } %>
					
					
					
				</table>
				<!-- 권한리스트 테이블 끝 -->
			</td>
		</tr>
	</table>
	
	
	
	</form>
</body>
</html>