<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=session.getAttribute("name") %>님의 회원정보 수정 완료!</h1>
	<a href="logout.jsp">로그아웃</a>
	<a href="edit.jsp">정보수정</a>
</body>
</html>