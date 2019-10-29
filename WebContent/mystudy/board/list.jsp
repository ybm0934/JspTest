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
		BoardDAO dao = new BoardDAO();

		//페이징 처리
		int currentPage = 1; //현재 페이지
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}

		int totalRecord = dao.count(); //총 레코드(행) 수
		int pageSize = 5; //한 페이지에 보여줄 레코드(행) 수
		int totalPage = (int) Math.ceil((double) totalRecord / pageSize); // 총 페이지 수
		int blockSize = 10; //한 블럭에 보여줄 페이지 수

		int firstPage = currentPage - ((currentPage - 1) % blockSize); //[1], [11], [21]...
		int lastPage = firstPage + (blockSize - 1);

		//페이지 당 ArrayList에서의 시작 index => 0, 5, 10, 15, 20...
		int curPos = (currentPage - 1) * pageSize;

		//페이지 당 글 리스트 시작 번호
		int num = totalRecord - (curPos);
	%>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String category = request.getParameter("category");
		String keyword = request.getParameter("keyword");
		if(keyword == null) keyword = "";

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		try {
			List<BoardVO> list = dao.selectAll(category, keyword);
	%>
	<div class="list_div">
		<h1>
			<a href="list.jsp" style="color: black; text-decoration: none;">게시판</a>
		</h1>
		<form action="list.jsp" name="frmList" method="post">
			<table class="list_tbl">
				<colgroup>
					<col style="width: 10%;">
					<col style="width: 50%;">
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: 10%;">
				</colgroup>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일</th>
					<th scope="col">조회수</th>
				</tr>
				<%
					if (list.isEmpty()) {
				%>
				<tr>
					<td colspan="5" style="text-align: center; color: gray;">글이
						존재하지 않습니다.</td>
				</tr>
				<%
					} else {
							/*	for (int i = 0; i < list.size(); i++) {
									BoardVO vo = list.get(i);	*/
							for (int i = 1; i <= pageSize; i++) {
								if (num < 1)
									break;
								BoardVO vo = list.get(curPos++);
								num--;
				%>
				<tr>
					<td><%=vo.getNo()%></td>
					<td><a href="readcount.jsp?no=<%=vo.getNo()%>" class="title_a"><%=vo.getTitle()%></a></td>
					<td><%=vo.getName()%></td>
					<td><%=sdf.format(vo.getRegdate())%></td>
					<td><%=vo.getReadcount()%></td>
				</tr>
				<%
					}
						}
						System.out.println("게시판 목록 불러오기 성공");
					} catch (SQLException e) {
						System.out.println("게시판 목록 불러오기 error = " + e);
					}
				%>
			</table>
			<div class="page_div">
				<%
					if(firstPage > 1){
				%>
					<a href="list.jsp?currentPage=<%=firstPage-1 %>">PREV</a>
				<%
					}
				
					for(int i=firstPage; i<=lastPage;i++){
						if(i > totalPage) break; //i가 실제 총 페이지 수를 넘어서면 stop
						if(currentPage == i){
				%>
						<span style="color:red; font-weight:bold;"><%=i %></span>
				<%		
						}else {
				%>			
						<a href="list.jsp?currentPage=<%=i %>">[<%=i %>]</a>
				<%			
						}
						if(lastPage < totalPage){
				%>
						<a href="list.jsp?currentPage=<%=lastPage+1 %>">NEXT</a>
				<%							
						}
					}
				%>
			</div>
			<div class="search_div">
				<select name="category" class="search_select">
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="name">작성자</option>
				</select> <input type="text" name="keyword" class="search"> <input
					type="submit" name="search_btn" class="search_btn" value="검색">
			</div>
			<div class="write">
				<input type="button" class="write_btn" value="글쓰기"
					onclick="location.href='write.jsp'">
			</div>
		</form>
	</div>
</body>
</html>