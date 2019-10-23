<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	String no, name, id, password, ip, port;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 성공</title>
</head>
<body>

	<%
		no = (String) session.getAttribute("no");
		name = (String) session.getAttribute("name");
		id = (String) session.getAttribute("id");
		password = (String) session.getAttribute("password");
		ip = (String) session.getAttribute("ip");
		port = (String) session.getAttribute("port");
	%>
	
	<%=name %>님 안녕하세요!<br>
	no : <%=no %><br>
	id : <%=id %><br>
	password : <%=password %><br>
	ip : <%=ip %><br>
	port : <%=port %><br><br>
	<a href="edit.jsp">회원정보 수정</a>
</body>
</html>