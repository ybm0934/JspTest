<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome</title>
</head>
<body>
	<h1>로그인 하신 걸 축하합니다!</h1>
	
	<%
		Cookie[] ck = request.getCookies();
	
		for(int i=0; i<ck.length; i++){
			String str = ck[i].getName();
			if(str.equals("id")){
				out.println("ck[" + i + "] name : " + ck[i].getName() + "<br>");
				out.println("ck[" + i + "] value : " + ck[i].getValue() + "<br>");
			}
		}
	%>

	
	
</body>
</html>