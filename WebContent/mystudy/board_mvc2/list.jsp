<%@page import="com.herbmall.utility.Utility"%>
<%@page import="com.herbmall.utility.PagingVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mystudy.board.model.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.mystudy.board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	List<BoardVO> list = (ArrayList<BoardVO>) request.getAttribute("list");
	PagingVO pvo = (PagingVO) request.getAttribute("pvo");
	
	//Integer는 null값을 처리할 수 있기에 sql 연동에 용이
	Integer totalRecord = (Integer) request.getAttribute("totalRecord");
	
	String category = request.getParameter("category");
	String keyword = request.getParameter("keyword");
	if(keyword == null) keyword = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/mystudy/CSS/list.css">
<script type="text/javascript">
	function pageProc(currentPage){
		frmPage.currentPage.value = currentPage;
		frmPage.submit();
	}
</script>
</head>
<body>
<%	if(keyword != null && !keyword.isEmpty()){ %>
<p>검색어 : <%=keyword %>, <%=totalRecord %>건이 검색되었습니다.</p>
<%	} %>
<form name="frmPage" method="post" action="<%=request.getContextPath() %>/board/list.do">
	<input type="hidden" name="category" value="<%=category %>">
	<input type="hidden" name="keyword" value="<%=keyword %>">
	<input type="hidden" name="currentPage">
	
</form>
<div class="list_div">
<h1><a href="<%=request.getContextPath() %>/board/list.do" style="color: black; text-decoration: none;">게시판</a></h1>
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
		<%	if (list == null || list.isEmpty()) {	%>
		<tr>
			<td colspan="5" style="text-align: center; color: gray;">글이 존재하지 않습니다.</td>
		</tr>
		<%	} else {
				int curPos = pvo.getCurPos();
				int num = pvo.getNum();
				for(int i = 1; i <= pvo.getPageSize(); i++){
					if(num < 1) break;
					BoardVO vo = list.get(curPos++);
					num--;	%>
		<tr>
			<td><%=vo.getNo() %></td>
			<td>
				<a href="<%=request.getContextPath() %>/board/readcount.do?no=<%=vo.getNo() %>" class="title_a">
					<%=Utility.cutString(vo.getTitle(), 15) %>
					<%=Utility.displayNew(vo.getRegdate(), request.getContextPath())%>
				</a>
			</td>
			<td><%=vo.getName()%></td>
			<td><%=sdf.format(vo.getRegdate())%></td>
			<td><%=vo.getReadcount()%></td>
		</tr>
			<%	}//for %>
		<%	}//if %>
	</table>
	<div class="page_div">
		<%	if(pvo.getFirstPage() > 1){	%>
			<a href="#" onclick="pageProc(<%=pvo.getFirstPage()-1 %>)">PREV</a>
		<%	}	%>
		
		<%	for(int i = pvo.getFirstPage(); i <= pvo.getLastPage(); i++){
				if(i > pvo.getTotalPage()) break; //i가 실제 총 페이지 수를 넘어서면 stop
				if(i == pvo.getCurrentPage()){	%>
					<span style="color:red; font-weight:bold;"><%=i %></span>
		<%		}else {	%>			
					<a href="#" onclick="pageProc(<%=i %>)"><%=i %></a>
		<%		}//if
			}//for	%>
		
		<%	if(pvo.getLastPage() < pvo.getTotalPage()){	%>
				<a href="#" onclick="pageProc(<%=pvo.getLastPage()+1 %>)">NEXT</a>
		<%	}	%>
	</div>
	<div class="search_div">
		<form action="<%=request.getContextPath() %>/board/list.do" name="frmSearch" method="post">
			<select name="category" class="search_select">
				<option value="title"
					<% if("title".equals(category)){ %>
						selected="selected"
					<%	} %>>제목</option>
				<option value="content"
					<% if("content".equals(category)){ %>
						selected="selected"
					<% } %>>내용</option>
				<option value="name"
					<% if("name".equals(category)){ %>
						selected="selected"
					<% } %>>작성자</option>
			</select>
			<input type="text" name="keyword" class="search" value="<%=keyword %>" placeholder="검색어 입력">
			<input type="submit" name="search_btn" class="search_btn" value="검색">
		</form>
	</div>
	<div class="write">
		<input type="button" value="글쓰기" class="write_btn" onclick="location.href='<%=request.getContextPath() %>/board/writeForm.do'">
	</div>
</div>
</body>
</html>