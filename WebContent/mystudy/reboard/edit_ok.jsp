<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
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

	ReBoardDAO dao = new ReBoardDAO();

	try {
		ReBoardVO vo = new ReBoardVO();
		vo.setNo(Integer.parseInt(no));
		vo.setTitle(title);
		vo.setName(name);
		vo.setPwd(pwd);
		vo.setEmail(email);
		vo.setContent(content);

		int cnt = dao.updateReboard(vo);
		if (cnt > 0) {
%>
<script>
	alert("글 수정 성공!");
	location.href = "detail.jsp?no=<%=no%>";
</script>
<%
		} else {
%>
<script>
	alert("글 수정 실패!");
	history.back();
</script>
<%
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>