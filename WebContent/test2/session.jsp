<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		session.setAttribute("sn", "ABCDEFG");
		session.setAttribute("mynum", "1234");
	%>
	
	<a href="sessionget.jsp">session get</a>
</body>
</html>