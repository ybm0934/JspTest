<%@page import="java.sql.SQLException"%>
<%@page import="com.mystudy.board.model.BoardDAO"%>
<%@page import="com.mystudy.board.model.BoardVO"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String no = request.getParameter("no");

	BoardDAO boardDao = new BoardDAO();
	BoardVO boardVo = new BoardVO();
	String content = "";

	try {
		boardVo = boardDao.selectByNo(Integer.parseInt(no));
		content = boardVo.getContent();
		if (content != null) {
			content = content.replace("\r\n", "<br>");
		} else {
			content = "";
		}
	} catch (SQLException e) {
		System.out.println("글 상세보기 error = " + e);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 상세보기</title>
<link rel="stylesheet" type="text/css" href="../CSS/detail.css">
</head>
<body>
	<div class="detail_div">
		<h1>글 상세보기</h1>
		<table class="detail_tbl">
			<colgroup>
				<col style="width: 20%;">
				<col style="width: *;">
			</colgroup>
			<tr>
				<th scope="col">제목</th>
				<td scope="col"><%=boardVo.getTitle() %></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=boardVo.getName() %></td>
			</tr>
			<tr>
				<th>등록일</th>
				<td><%=boardVo.getRegdate() %></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=boardVo.getReadcount() %></td>
			</tr>
		</table>
		<div class="content"><%=content %></div>
		<div class="redirect_div">
			<a href="pwdCheck.jsp?no=<%=no%>">수정</a>&nbsp;|
			<a href="delete.jsp?no=<%=no%>">삭제</a>&nbsp;|
			<a href="list.jsp">목록</a>
		</div>
	</div>
</body>
</html>
<%@ include file ="list.jsp" %>