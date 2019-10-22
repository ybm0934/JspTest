<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@page import="java.util.Arrays"%>
	<%@page import="java.util.Random"%>
	<%!Random ran = new Random();
	int[] lotto = new int[6];%>

	<%
		for (int i = 0; i < lotto.length; i++) {
			lotto[i] = ran.nextInt(45) + 1;
			for (int j = 0; j < i; j++) {
				if (lotto[i] == lotto[j]) {
					i--;
				}
			}
		}

		int temp = 0;

		for (int i = 0; i < lotto.length; i++) {
			for (int j = i + 1; j < lotto.length; j++) {
				if (lotto[i] > lotto[j]) {
					temp = lotto[i];
					lotto[i] = lotto[j];
					lotto[j] = temp;
				}
			}
		}

		for (int i = 0; i < lotto.length; i++) {
			out.println("lotto[ " + (i + 1) + " ] = " + lotto[i] + "<br>");
		}
		out.println("<br>");
	%>

	<%
		int[] arr = { 10, 20, 30 };
		out.println(Arrays.toString(arr));
		out.println("<br>");
	%>

	<%!int i = 10;
	String str = "ABCD";%>

	<%!public int sum(int a, int b) {
		return a + b;
	}%>

	<%
		out.println("i = " + i + "<br>");
		out.println("str = " + str + "<br>");
		out.println("sum = " + sum(1, 5) + "<br>");
	%>

	<%=i%>
	<%=str%>
	<%=sum(2, 6)%>
	<%-- 주석입니다. --%>
</body>
</html>