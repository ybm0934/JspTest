<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="student" class="com.javalec.ex.BeanTest" scope="page"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:setProperty name="student" property="name" value="홍길동"/>
	<jsp:setProperty property="age" name="student" value="13"/>
	<jsp:setProperty property="grade" name="student" value="6"/>
	<jsp:setProperty property="studentNum" name="student" value="97481"/>
	
	이름 : <jsp:getProperty property="name" name="student"/>
	나이 : <jsp:getProperty property="age" name="student"/>
	학년 : <jsp:getProperty property="grade" name="student"/>
	학번 : <jsp:getProperty property="studentNum" name="student"/>
</body>
</html>