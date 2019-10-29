<%@page import="java.sql.SQLException"%>
<%@page import="com.mystudy.board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String no = request.getParameter("no");
	if (no == null || no.isEmpty()) {
%>
<script>
	alert('잘못된 url 주소입니다.');
	location.href = "list.jsp";
</script>
<%
	return;
	}

	String pwd = request.getParameter("pwd");

	BoardDAO dao = new BoardDAO();
	try {
		int n = dao.deleteBoard(Integer.parseInt(no), pwd);
		if (n > 0) {
%>
<script>
	alert("글 삭제 성공");
	location.href = "list.jsp";
</script>
<%
	} else {
%>
<script>
	alert("글 삭제 실패");
	history.back();
</script>
<%
	}
	} catch (SQLException e) {
		System.out.println("글 삭제, sql error : " + e);
	}
%>