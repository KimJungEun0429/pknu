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
	
	.auth{
	
		font-size:20px;
	
	}
</style>

<script src="/ServBoard/js/jquery-3.6.0.js"></script>

<script>

	var authSearch = function(){
		
		var memberName = $("#s_membername").val();
		
		location.href = "/ServBoard/Admin_MemList?membername=" + memberName;
		
	}


	var addRow = function(data){
		
		var strSelectHTML = "";
		
		var authList_Length = $(data).find("authID").length
		
		strSelectHTML += "<select name='auth' class='auth' title='auth1'>";
		for(var i=0;i<authList_Length;i++){
			
			var authID = $(data).find("authID").eq(i).text();
			
			var authName = $(data).find("authName").eq(i).text();;
			strSelectHTML += "<option value='" + authID + "'>" + authName + "</option>";
		}
		
		strSelectHTML += "</select>";
		
		var strHTML = "";
		strHTML += "<tr>";
		strHTML += "	<td width='10%' height='40' align='center'>";
		strHTML += "		<input type='checkbox' name='chk' value=''/>";
		strHTML += "	</td>";
		strHTML += "	<td width='15%' height='40' align='center'>";
		strHTML += "		�ڵ�����";
		strHTML += "	</td>";
		strHTML += "	<td width='35%' height='40' align='center'>";
		strHTML += "		<input type='text' name='authname' class='txt' title='auth1'/>";
		strHTML += "	</td>";
		strHTML += "	<td width='30%' height='40' align='center'>";
				
		strHTML += strSelectHTML	
		
		strHTML += "	</td>";
		strHTML += "	<td width='1px'>";
		strHTML += "		<input type='hidden' name='gbn' value='I' />";
		strHTML += "	</td>";
		strHTML += "</tr>";
		
		
		$("#memberListTbl tbody").append(strHTML);
	}
	
	
	var setAuthLists = function(){

		
		
		var ajaxObj = {
				
				type:"post", 
				async:"true", 
				url:"/ServBoard/Admin_AuthList_AJAX", 
				data:"", 
				dataType:"xml",  
				success: function(data){
					addRow(data);
					
					
				},
		  		error : function(xhr,status,error) {
		      		alert("err")
		  		},
		  		complete:function(data,textStatus) {
		  			
		  		}

			  }
		
		$.ajax(ajaxObj);
		
		
	}
	
	
	var modify = function(){
		
		var isSubmit = true;
		
		//ȸ���̸��� �� ó��, ���ѿ� ���� �󰪵� ó��
		$("[title='auth1']").each(
				
				function(){
					var fieldName = $(this).val();
					
					if(fieldName.trim().length <= 0){
						alert("����ִ� �ʵ带 �����ּ���");
						$(this).focus();
						isSubmit = false;
						return false;
					}
				}
				
		);
		
		if(isSubmit){
		
			$("#memberForm").submit();
		}
		
		//���ѿ� ���� �󰪵� ó��
		/*
		$("select[name='auth']").each(
				
				function(){
					var authName = $(this).val();
					if(authName.trim().length <= 0){
						alert("����ִ� ������ ������ �ּ���");
						$(this).focus();
						return false;
					}
				}
				
		);
		*/
	}

	
	var delRow = function(){
		
		$("#memberForm").attr("action", "/ServBoard/Admin_DelMemberList");
		
		
		$("#memberForm").submit();
	}
</script>

</head>

<%
	ArrayList<MemberListDAO> memberLists = (ArrayList<MemberListDAO>)request.getAttribute("memberLists");
	ArrayList<AuthListDAO> authLists = (ArrayList<AuthListDAO>)request.getAttribute("authLists");
%>



<body>

	<form name="memberForm" id="memberForm" action="/ServBoard/Admin_ModMemberList" method="post">
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
			<td width="100%" height="890px" align="center" valign="top" id="memberListTbl">
				<!-- ���Ѹ���Ʈ ���̺� ���� -->
				<table border="1" width="80%" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td width="25%" height="50" colspan="2">
							<input type="text" name="s_membername" id="s_membername" />
							<input type="button" value="��ȸ" onclick="authSearch()"/>
						</td>
						<td width="55%" height="50" align="right" colspan="3">
							<input type="button" value="�߰�" onclick="setAuthLists()"/>
							<input type="button" value="����" onclick="modify()"/>
							<input type="button" value="����" onclick="delRow()"/>
						</td>
					</tr>
					<tr>
						<td width="10%" height="30" align="center">
							<input type="checkbox" name="chkAll" id="chkAll" onclick="checkAll()"/>
						</td>
						<td width="15%" height="30" align="center">
							ȸ�����̵�
						</td>
						<td width="35%" height="30" align="center">
							ȸ����
						</td>
						<td width="20%" height="30" align="center">
							����
						</td>
						<td width="1px">
					
							
						
						</td>
					</tr>
					
					<%
						for(MemberListDAO member : memberLists){
					%>
					<tr>
						<td width="10%" height="40" align="center">
							<input type="checkbox" name="chk" value="<%=member.getMID() %>"/>
						</td>
						<td width="15%" height="40" align="center">
							<input type="text" name="authid" class="txt" value="<%=member.getMID() %>" readonly/>
						</td>
						<td width="35%" height="40" align="center">
							<input type="text" title="auth1" name="authname" class="txt" value="<%=member.getMName() %>"/>
						</td>
						<td width="20%" height="30" align="center">
							<select name="auth" class='auth' title="auth1">
							
								<%
									for(AuthListDAO authList : authLists){
										
									String selectedAuthID = member.getAuthID();
									String authID = authList.getAuthID();
									String authName = authList.getAuthName();
								%>
									<option value="<%=authID%>" 
								<%	
										if(selectedAuthID.equals(authID)){
								%>
										selected
								<%			
										}
								%>	
									><%=authName %></option>
								<%		
									}
								%>
							
							
							</select>
						</td>
						<td width="1px">
							<input type="hidden" name="gbn" value="U" />
						</td>
					</tr>
					<% } %>
					
					
					
				</table>
				<!-- ���Ѹ���Ʈ ���̺� �� -->
			</td>
		</tr>		
	</table>
	</form>

</body>
</html>