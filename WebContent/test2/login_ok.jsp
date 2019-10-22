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
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		if (id.equals("abcd") && pw.equals("1234")) {
			Cookie ck = new Cookie("id", id);
			ck.setMaxAge(30 * 1);
			response.addCookie(ck);
			response.sendRedirect("welcome.jsp");
		} else {
			response.sendRedirect("login.html");
		}
	%>


</body>
</html>