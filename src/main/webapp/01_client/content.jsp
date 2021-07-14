<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
     
<%@ page import="PKG_DAO.listDAO" %>   
<%

	listDAO content = (listDAO)request.getAttribute("content");

	String strIdx = content.getIdx();
	String strTitle = content.getTitle();
	String strContent = content.getContents();
%>     
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div>
		<%=strTitle %>
	</div>
	<div>
		<%=strContent %>
	</div>
	<div>
		<a href="/ServBoard/BoardWrite">글쓰기</a>
		<a href="/ServBoard/BoardList">리스트</a>
		<a href="/ServBoard/BoardDelete?idx=<%=strIdx%>">삭제</a>
		<a href="/ServBoard/BoardUpdate?idx=<%=strIdx%>">수정</a>
	</div>
</body>
</html>