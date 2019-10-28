<%@page import="java.sql.SQLException"%>
<%@page import="com.mystudy.board.model.BoardVO"%>
<%@page import="com.mystudy.board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String title = request.getParameter("title");
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");
	String email = request.getParameter("email");
	String content = request.getParameter("content");

	BoardVO boardVo = new BoardVO();
	BoardDAO boardDao = new BoardDAO();

	boardVo.setTitle(title);
	boardVo.setName(name);
	boardVo.setPwd(pwd);
	boardVo.setEmail(email);
	boardVo.setContent(content);

	try {
		int n = boardDao.insertBoard(boardVo);
		if (n > 0) {
			System.out.println("글쓰기 성공");
%>
<script>
	alert("글쓰기 성공!");
</script>
<%
	response.sendRedirect("list.jsp");
		} else {
			System.out.println("글쓰기 실패");
%>
<script>
	alert("글쓰기 실패!");
	history.back();
</script>
<%
	}
	} catch (SQLException e) {
		System.out.println("글쓰기 sql error : " + e);
	}
%>