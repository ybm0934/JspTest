<%@page import="java.util.ArrayList"%>
<%@page import="com.pd.Model.PdDAO"%>
<%@page import="com.pd.Model.PdDTO"%>
<%@page import="com.pd.Controller.ConnectionPoolMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<link rel="stylesheet" href="../CSS/pdList.css">
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
		<%
			DecimalFormat df = new DecimalFormat("#,###");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			PdDAO pdDao = new PdDAO();

			try {
				ArrayList<PdDTO> list = pdDao.selectAll();
				for (int i = 0; i < list.size(); i++) {
					PdDTO dto = list.get(i);
		%>
		<tr>
			<td><%=dto.getNo()%></td>
			<td><a href="pdDetail.jsp?no=<%=dto.getNo()%>"><%=dto.getPdName()%></a></td>
			<td><%=df.format(dto.getPrice())%>원</td>
			<td><%=sdf.format(dto.getRegdate())%></td>
		</tr>
		<%
				} //for
			} catch (SQLException e) {
				System.out.println("상품 목록 조회, sql error : " + e);
			}
		%>
	</table>
	<br>
	<br>
	<a href="pdWrite.jsp">상품 등록</a>
</body>
</html>