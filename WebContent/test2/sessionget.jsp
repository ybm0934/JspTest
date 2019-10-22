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
		String mySession = (String) session.getAttribute("sn");
		out.println(mySession + "<br>");

		String mySession2 = (String) session.getAttribute("mynum");
		out.println(mySession2 + "<br>");
		int myNum = Integer.parseInt(mySession2);
		out.println(myNum + "<br>");

		out.println("---------------------<br>");

		String sessionID = session.getId();
		out.println("sessionID : " + sessionID + "<br>");
		int sessionInter = session.getMaxInactiveInterval();
		out.println("sessionInter : " + sessionInter + "<br>");

		out.println("---------------------<br>");

		session.invalidate();
		if (request.isRequestedSessionIdValid()) {
			out.println("session valid");
		} else {
			out.println("session invalid");
		}
	%>
</body>
</html>