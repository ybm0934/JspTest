<%@page import="com.herbmall.utility.Utility"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//1. 요청 파라미터 읽어오기	
	//post
	request.setCharacterEncoding("UTF-8");
	String searchCondition = request.getParameter("searchCondition");
	String searchKeyword = request.getParameter("searchKeyword");
	
	if(searchCondition == null) searchCondition = "";
	if(searchKeyword == null) searchKeyword = "";
	
	//2. db작업 - select
	ReBoardDAO dao = new ReBoardDAO();
	List<ReBoardVO> list = new ArrayList<ReBoardVO>();
	
	try{
		list = dao.selectAll(searchCondition, searchKeyword);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3. 결과 처리
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	//페이징 처리 관련 변수
	String sCurPage = request.getParameter("currentPage");
	System.out.println("sCurPage = " + sCurPage);
	
	int currentPage = 1;
	if(sCurPage != null && !sCurPage.isEmpty()){
		currentPage = Integer.parseInt(sCurPage);
	}
	
	//[1] 현재 페이지와 무관한 변수
	int totalRecord = list.size();	//전체 레코드 개수, 예) 17건
	int pageSize = 5;	//한 페이지에 보여줄 레코드(행) 수,  5
	int totalPage = (int) Math.ceil((double) totalRecord / pageSize); //총 페이지 수, 4
	int blockSize = 10;	//블럭 사이즈-한 블럭에 보여줄 페이지 수
	
	//[2] 현재 페이지를 이용해서 계산하는 변수
	int firstPage = currentPage - ((currentPage - 1) % blockSize);	//시작 페이지
	//=> 1, 11, 21, 31...
	int lastPage = firstPage + (blockSize - 1);	//마지막 페이지, 10,20,30,40...
	int curPos = (currentPage - 1) * pageSize;	//ArrayList에서 시작 인덱스
	//=> 0,5,10,15...
	int num = totalRecord - curPos;//페이지당 글 리스트 시작번호
	//=> 17,12,7,2
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="../CSS/list.css">
</head>
<body>
<% if(searchKeyword != null && !searchKeyword.isEmpty()){	%>
	<p>검색어 : <%=searchKeyword %>, <%=list.size() %>건 조회되었습니다.</p>
<%	}else {	%>
	<p>전체조회 : <%=list.size() %>건 조회되었습니다.</p>
<%	}	%>
<a href="../main.jsp" style="text-decoration: none; color: black;">메인페이지</a>
<div class="list_div">
	<h1>
		<a href="list.jsp" style="color: black; text-decoration: none;">게시판</a>
	</h1>
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
		<%	if(list == null || list.isEmpty()){ %>
		<tr>
			<td colspan="5" style="text-align: center; color: gray;">글이 존재하지 않습니다.</td>
		</tr>
		<%	}else {	%>
			<%	for(int i = 0; i < pageSize; i++){
					if(num-- < 1) break;
					
					ReBoardVO vo = list.get(curPos++);
		%>
		<tr>
			<td><%=vo.getNo() %></td>
			<td>
			<%if(vo.getDelFlag().equals("Y")){ %>
				<span style="color:silver; font-style:oblique;">삭제된 글입니다.</span>
			<%}else { %>
				<%=Utility.displayRe(vo.getStep()) %>
				<%=Utility.displayFile(vo.getFileName())%>
				<a href="countUpdate.jsp?no=<%=vo.getNo()%>"><%=Utility.cutString(vo.getTitle(), 15) %></a>
				<%=Utility.displayNew(vo.getRegdate(), request.getContextPath()) %>
			<%} %>
			</td>
			<td><%=vo.getName() %></td>
			<td><%=sdf.format(vo.getRegdate()) %></td>
			<td><%=vo.getReadcount() %></td>
		</tr>
		<%		}//for	%>
		<%	}//if	%>
	</table>
	<div class="page_div">
		<%if(firstPage > 1){ %>
			<a href="list.jsp?currentPage=<%=firstPage-1 %>&searchKeyword=<%=searchKeyword %>&searchCondition=<%=searchCondition %>">
				<img alt="이전블록으로 이동" src="../images/first.JPG">
			</a>
		<%} %>
		
		<%
			for(int i=firstPage; i <= lastPage; i++){
				if(i > totalPage) break;
				
				if(i == currentPage){	%>
				<span style="color: blue; font-weight: bold; font-size:1.0em;"><%=i %></span>
			<%	}else { %>
				<a href="list.jsp?currentPage=<%=i %>&searchKeyword=<%=searchKeyword %>&searchCondition=<%=searchCondition %>"><%=i %></a>
			<%	}//if	%>
		<%	}//for	%>
		
		<%if(lastPage < totalPage){ %>
			<a href="list.jsp?currentPage=<%=lastPage+1 %>&searchKeyword=<%=searchKeyword %>&searchCondition=<%=searchCondition %>">
				<img alt="다음블록으로 이동" src="../images/last.JPG">
			</a>
		<%} %>
	</div>
	<div class="search_div">
	<form action="list.jsp" name="frmList" method="post">
		<select name="searchCondition" class="search_select">
			<option value="title"
			<% if("title".equals(searchCondition)){ %>
				selected="selected"
			<% } %>
			>제목</option>
			<option value="content"
			<% if("content".equals(searchCondition)){ %>
				selected="selected"
			<% } %>
			>내용</option>
			<option value="name"
			<% if("name".equals(searchCondition)){ %>
				selected="selected"
			<% } %>
			>작성자</option>
		</select>
		<input type="text" name="searchKeyword" class="search">
		<input type="submit" name="search_btn" class="search_btn" value="검색">
	</form>
	</div>
	<div class="write">
		<input type="button" class="write_btn" value="글쓰기" onclick="location.href='write.jsp'">
	</div>
</div>
</body>
</html>