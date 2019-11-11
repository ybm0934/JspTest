<%@page import="com.pd.Model.PdDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*"%>
<%
	List<PdDTO> list = (List<PdDTO>) request.getAttribute("list");
	System.out.println("list.size() : " + list.size());
	
	DecimalFormat df = new DecimalFormat("#,###");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/CSS/pdList.css">
</head>
<body>
	<h1>상품 목록</h1>
	<table class="pdList_tbl">
		<tr>
			<th>번호</th>
			<th>상품명</th>
			<th>가격</th>
			<th>등록일</th>
		</tr>
		<% for(int i = 0; i < list.size(); i++){
		PdDTO dto = list.get(i);	%>
		<tr>
			<td><%=dto.getNo() %></td>
			<td><a href="<%=request.getContextPath() %>/pd/pdDetail.do?no=<%=dto.getNo() %>"><%=dto.getPdName() %></a></td>
			<td><%=df.format(dto.getPrice()) %>원</td>
			<td><%=sdf.format(dto.getRegdate()) %></td>
		</tr>
		<% }//while	%>
	</table>
	<br><br>
	<a href="<%=request.getContextPath() %>/pd/pdWriteForm.do">상품 등록</a>
</body>
</html>