<%@page import="java.sql.SQLException"%>
<%@page import="com.mystudy.board.model.BoardVO"%>
<%@page import="com.mystudy.board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String no = request.getParameter("no");
	
	BoardVO vo = (BoardVO) request.getAttribute("vo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정하기</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/mystudy/CSS/write.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/mystudy/JS/write.js"></script>
</head>
<body>
<div class="write_div">
	<h1>글쓰기</h1>
	<form action="/board/edit.do" name="frmWrite" method="post" onsubmit="return send()">
	<input type="hidden" name="no" value="<%=vo.getNo() %>">
		<table class="write_tbl">
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" class="text" spellcheck="false" value="<%=vo.getTitle() %>"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="name" class="text" spellcheck="false" value="<%=vo.getName( )%>"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd" class="text"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="email" class="text" spellcheck="false" value="<%=vo.getEmail() %>"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea spellcheck="false" name="content" class="textarea"><%=vo.getContent() %></textarea></td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" class="btn regit" value="수정">
					<input type="button" class="btn regit" value="글목록" onclick="location.href='<%=request.getContextPath() %>/board/list.do'">
				</th>
			<tr>
		</table>
	</form>
</div>
</body>
</html>