<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays"%>
<%@page import="java.net.InetAddress"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%!String name, id, pwd, major, protocol, ip, port;
	String[] hobbys;%>

	<%
		request.setCharacterEncoding("UTF-8");
		InetAddress inetAddress = InetAddress.getLocalHost();

		name = request.getParameter("name");
		id = request.getParameter("id");
		pwd = request.getParameter("pwd");
		protocol = request.getParameter("protocol");
		major = request.getParameter("major");
		hobbys = request.getParameterValues("hobby");
		ip = inetAddress.getHostAddress();
		port = Integer.toString(request.getServerPort());
	%>

	이름 :
	<%=name%><br> 아이디 :
	<%=id%><br> 비밀번호 :
	<%=pwd%><br> 취미 :
	<%=Arrays.toString(hobbys)%><br> 전공 :
	<%=major%><br> 프로토콜 :
	<%=protocol%><br> IP :
	<%=ip%><br> Port :
	<%=port%>
</body>
</html>