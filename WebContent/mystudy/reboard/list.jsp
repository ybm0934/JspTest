<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String searchCondition = request.getParameter("searchCondition");
	String searchKeyword = request.getParameter("searchKeyword");

	if (searchKeyword == null)
		searchKeyword = "";

	ReBoardDAO dao = new ReBoardDAO();
	List<ReBoardVO> list = null;

	try {
		list = dao.selectAll(searchCondition, searchKeyword);
	} catch (SQLException e) {
		e.printStackTrace();
	}

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	String sCurPage = request.getParameter("currentPage");
	System.out.print("sCurPage = " + sCurPage);

	int currentPage = 1;
	if (sCurPage != null && !sCurPage.isEmpty()) {
		currentPage = Integer.parseInt(sCurPage);
	}

	int totalRecord = list.size();
	int pageSize = 5;
	int totalPage = (int) Math.ceil((float) totalRecord / pageSize);
	int blockSize = 10;

	int firstPage = currentPage - ((currentPage - 1) % blockSize);
	int lastPage = firstPage + (blockSize - 1);
	int curPos = (currentPage - 1) * pageSize;
	int num = totalRecord - curPos;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변형 게시판</title>
<link rel="stylesheet" type="text/css" href="../CSS/list.css">
</head>
<body>
<%	if(searchKeyword != null && !searchKeyword.isEmpty()){	%>
	<p>검색어 : <%=searchKeyword %>, <%=list.size() %>건 검색되었습니다.</p>		
<%	}else {	%>
	<p>전체 조회 : <%=list.size() %>건 조회되었습니다.</p>
<%	}	%>
	<div class="list_div">
		<h1><a href="list.jsp" style="color: black; text-decoration: none;">답변형 게시판</a></h1>
		<table class="list_tbl"
			summary="답변형 게시판, 번호, 제목, 작성자, 작성일, 조회수에 대한 정보 제공">
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
<%	if(list == null || list.isEmpty()) {	%>
		<tr>
			<td colspan="5" style="text-align: center;">데이터가 존재하지 않습니다.</td>
		</tr>
<%	}else {	%>
<%		for(int i=0; i < pageSize; i++){
			if(num-- < 1) break;
			
			ReBoardVO vo = list.get(curPos++);
%>
		<tr>
			<td><%=vo.getNo() %></td>
			<td><a href="countUpdate.jsp?no=<%=vo.getNo() %>" class="title_a"><%=vo.getTitle() %></a></td>
			<td><%=vo.getName() %></td>
			<td><%=sdf.format(vo.getRegdate()) %></td>
			<td><%=vo.getReadcount() %></td>
		</tr>
<%		}//for
	}//if
%>
		</table>
		<div class="page_div">
<%	if(firstPage > 1) {	%>
		<a href="list.jsp?currentPage=<%=firstPage-1 %>">
			<img alt="이전 블럭으로 이동" src="../images/first.JPG">
		</a>
<%	}	%>
<%		for(int i = firstPage; i <= lastPage; i++){
			if(i > totalPage) break;
			
			if(i == currentPage){	%>
				<span style="color: blue; font-weight: bold; font-size:1.0em;"><%=i %></span>
<%			}else {	%>
				<a href="list.jsp?currentPage=<%=i %>"><%=i %></a>			
<%			}//if
		}//for	%>

<%		if(lastPage < totalPage) { %>
			<a href="list.jsp?currentPage=<%=lastPage+1 %>">
				<img alt="다음 블럭으로 이동" src="../images/last.JPG">
			</a>
<% 		} %>		
		</div>
		<div class="search_div">
			<form action="list.jsp" name="frmList" method="post">
				<select name="searchCondition" class="search_select">
					<option value="title"
						<%if("title".equals(searchCondition)){ %>
							selected="selected"
						<%} %>
					>제목</option>
					<option value="content"
						<%if("content".equals(searchCondition)){ %>
							selected="selected"
						<%} %>
					>내용</option>
					<option value="name"
						<%if("name".equals(searchCondition)){ %>
							selected="selected"
						<%} %>
					>작성자</option>
				</select>
				<input type="text" name="searchKeyword" title="검색어 입력" class="search" value="<%=searchKeyword%>">
				<input type="submit" name="search_btn" class="search_btn" value="검색">
			</form>
		</div>
		<div class="write">
			<input type="button" class="write_btn" value="글쓰기" onclick="location.href='write.jsp'">
		</div>
	</div>
</body>
</html>