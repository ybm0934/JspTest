<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%! int age; %>
	
	<%
		String str = request.getParameter("age");
		age = Integer.parseInt(str);
	%>

	<h1>당신의 나이는 20세 미만입니다.</h1>
	
	<a href="request.html">처음으로 이동</a>
</body>
</html>