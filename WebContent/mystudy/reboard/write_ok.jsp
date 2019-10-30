<%@page import="java.net.InetAddress"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String title = request.getParameter("title");
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");
	String email = request.getParameter("email");
	String content = request.getParameter("content");

	//아이피 가져오기
	InetAddress inet = InetAddress.getLocalHost();
	String ip = inet.getHostAddress();
	System.out.println("아이피 주소 : ip");

	ReBoardDAO dao = new ReBoardDAO();
	ReBoardVO vo = new ReBoardVO();

	try {
		vo.setTitle(title);
		vo.setName(name);
		vo.setPwd(pwd);
		vo.setEmail(email);
		vo.setContent(content);

		int cnt = dao.insertReBoard(vo);

		if (cnt > 0) {
%>
<script type="text/javascript">
	alert("글쓰기가 처리되었습니다.");
	location.href = "list.jsp";
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("글쓰기 처리 실패!");
	history.back();
</script>
<%
	}
	} catch (SQLException e) {
		System.out.println("글쓰기 sql error : " + e);
	}
%>