<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String no = request.getParameter("no");

	ReBoardDAO dao = new ReBoardDAO();
	try {
		int cnt = dao.updateReadCount(Integer.parseInt(no));
		if (cnt > 0) {
			response.sendRedirect("detail.jsp?no=" + no);
		} else {
	%>
	<script>
		alert("조회수 증가 실패!");
		history.back();
	</script>
	<%
			}//if
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>