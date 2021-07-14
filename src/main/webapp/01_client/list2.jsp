<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*" %>  
<%@ page import="java.util.ArrayList" %>  
<%@ page import="PKG_DAO.*" %>   

<%

	

	ArrayList<listDAO> arr = (ArrayList<listDAO>)request.getAttribute("list");
	ArrayList arr2 = (ArrayList)request.getAttribute("list2");
	ArrayList<MemberDAO> members = (ArrayList<MemberDAO>)request.getAttribute("members");



%>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<style>

	span{
	
		display:block;
		width:200px;
		height:25px;
		padding:8px 0px 0px 0px;
		text-align:center;
		border:1px solid #444444;
		float:left
	
	}

	#list{
		clear:both;
	}
</style>

<script>
	function go(){
		
		document.getElementById("listForm").submit();
		
	}
</script>

</head>
<body>
	<div id="">

		
		<div>
		<form name="listForm" action="/ServBoard/BoardUpdate" method="post" id="listForm">
		<table border="1" cellpadding="0" cellspacing="0" width="600">
		<tr>
			<td width="50" height="30" align="center">
				<input type="checkbox" name="chk" />
			</td>
			<td width="100" height="30" align="center">
				번호
			</td>
			<td width="350" height="30" align="center">
				제목
			</td>
			<td width="150" height="30" align="center">
				담당자
			</td>
			<td width="0" height="30" align="center">
				
			</td>
		</tr>
		<%
			for(int i=0;i<arr2.size();i++){
				
			listDAO row = (listDAO)arr2.get(i);
			
			String bnum = row.getBnum();
			String title = row.getTitle();
			String idx = row.getIdx();
			String admin = row.getAdmin();
			
			listDAO row2 = arr.get(i);
			String bnum2 = row2.getBnum();
			String title2 = row2.getTitle();
			String admin2 = row.getAdmin();
			
				
		%>
		
			<tr>
				<td width="50" height="30" align="center">
				<input type="checkbox" name="chk" />
				</td>
				<td width="100" height="30" align="center">
					<%=bnum %>
				</td>
				<td width="350" height="30" align="center">
					<a href="/ServBoard/BoardContent?idx=<%=idx%>"><%=title%></a>
				</td>
				<td width="150" height="30" align="center">
					<select name="admin">
							<option value=''>선택하세요</option>
						<%
							for(int j=0;j<members.size();j++){
							
							MemberDAO member = members.get(j);
							String memID = member.getMemID();
							String memName = member.getMemName();
						%>
						<%
								if(memID.equals(admin)){
						%>
								<option value='<%=memID%>' selected><%=memName %></option>
						<%	
								}//if
								else{
						%>
								<option value='<%=memID%>'><%=memName %></option>
						<%			
								}//else
							} //for
						
						%>
					</select>
				</td>
				<td width="0" height="30" align="center">
					<input type="hidden" name="idx" value="<%=idx %>" />
				</td>
			</tr>
		
		<%
			}
		%>
		</table>
		</form>
		</div>
		<div>
			<input type="button" value="저장" onclick="go();"/>
			<input type="button" value="삭제" onclick="del();"/>
		</div>
	</div>
</body>
</html>