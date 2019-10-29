<%@page import="java.sql.SQLException"%>
<%@page import="com.mystudy.board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String no = request.getParameter("no");
	if (no == null || no.isEmpty()) {
%>
<script>
	alert("잘못된 url 주소입니다.");
	location.href = "list.jsp";
</script>

<%
	}

	BoardDAO dao = new BoardDAO();
	int n = dao.updateReadCount(Integer.parseInt(no));

	if (n > 0) {
		System.out.println("조회수 증가 성공");
		response.sendRedirect("detail.jsp?no=" + no);
	} else {
%>
<script>
	alert("조회수 증가 실패");
	history.back();
</script>
<%
	}
%>