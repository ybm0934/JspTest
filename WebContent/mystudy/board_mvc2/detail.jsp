<%@page import="com.mystudy.board.model.BoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mystudy.board.model.BoardDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	BoardVO vo = (BoardVO) request.getAttribute("vo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 상세보기</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/mystudy/CSS/detail.css">
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
				<td scope="col"><%=vo.getTitle() %></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=vo.getName() %></td>
			</tr>
			<tr>
				<th>등록일</th>
				<td><%=vo.getRegdate() %></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=vo.getReadcount() %></td>
			</tr>
		</table>
		<div class="content"><%=vo.getContent() %></div>
		<div class="redirect_div">
			<a href="/board/editForm.do?no=<%=vo.getNo() %>">수정</a>&nbsp;|
			<a href="/board/deleteForm.do?no=<%=vo.getNo() %>">삭제</a>&nbsp;|
			<a href="/board/list.do">목록</a>
		</div>
	</div>
</body>
</html>