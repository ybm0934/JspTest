<%@page import="com.mystudy.board.model.BoardVO"%>
<%@page import="com.mystudy.board.model.BoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String no = request.getParameter("no");
	String title = request.getParameter("title");
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");
	String email = request.getParameter("email");
	String content = request.getParameter("content");

	BoardDAO dao = new BoardDAO();
	BoardVO vo = new BoardVO();

	vo.setTitle(title);
	vo.setName(name);
	vo.setPwd(pwd);
	vo.setEmail(email);
	vo.setContent(content);
	vo.setNo(Integer.parseInt(no));

	int n = 0;

	try {
		n = dao.updateBoard(vo);
		System.out.println("수정하기 값 vo = " + vo);

		if (n > 0) {
%>
<script>
	alert("글 수정 성공");
	location.href = "detail.jsp?no=<%=no%>";
</script>
<%
	} else {
%>
<script>
	alert("글 수정 실패");
	history.back();
</script>
<%
	}
	} catch (SQLException e) {
		System.out.println("글 수정 처리 error = " + e);
	}
%>