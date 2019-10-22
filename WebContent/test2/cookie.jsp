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
		Cookie cookie = new Cookie("ckn", "ckv");
		cookie.setMaxAge(30 * 1);
		response.addCookie(cookie);
	%>
	
	<a href="cookieget.jsp">cookie get</a>

</body>
</html>