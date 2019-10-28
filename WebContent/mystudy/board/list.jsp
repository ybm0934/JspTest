<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mystudy.board.model.BoardDAO"%>
<%@page import="com.mystudy.board.model.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="../CSS/list.css">
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String category = request.getParameter("category");
		String keyword = request.getParameter("keyword");
		if(keyword == null) keyword = "";

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		BoardDAO dao = new BoardDAO();

		try {
			List<BoardVO> list = dao.selectAll(category, keyword);
	%>
	<div class="list_div">
		<h1>게시판</h1>
		<form action="list.jsp" name="frmList" method="post">
			<table class="list_tbl">
				<colgroup>
					<col style="width:10%;">
					<col style="width:50%;">
					<col style="width:15%;">
					<col style="width:15%;">
					<col style="width:10%;">
				</colgroup>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일</th>
					<th scope="col">조회수</th>
				</tr>
				<%
					for (int i = 0; i < list.size(); i++) {
							BoardVO vo = list.get(i);
				%>
				<tr>
					<td><%=vo.getNo()%></td>
					<td><%=vo.getTitle() %></td>
					<td><%=vo.getName() %></td>
					<td><%=sdf.format(vo.getRegdate()) %></td>
					<td><%=vo.getReadcount() %></td>
				</tr>
				<%
					}
						System.out.println("게시판 목록 불러오기 성공");
					} catch (SQLException e) {
						System.out.println("게시판 목록 불러오기 error = " + e);
					}
				%>
			</table>
			<div class="page_div">
			
			
			</div>
			<div class="search_div">
				<select name="category" class="search_select">
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="name">작성자</option>
				</select>
				<input type="text" name="keyword" class="search">
				<input type="submit" name="search_btn" class="search_btn" value="검색">
			</div>
			<div class="write">
				<input type="button" name="write_btn" class="write_btn" value="글쓰기">
			</div>
		</form>
	</div>
</body>
</html>