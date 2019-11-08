<%@page import="com.herbmall.utility.Utility"%>
<%@page import="com.herbmall.utility.PagingVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ReBoardDAO reDao = new ReBoardDAO();
	
	List<ReBoardVO> list = new ArrayList<ReBoardVO>();
	
	try{
		list = reDao.listNotice();
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style type="text/css">
	.notice_tbl {
		width: 100%;
		border-collapse: collapse;
		border: 1px solid gray;
	}

	.notice_tbl th{
		padding: 10px;
	    background: gainsboro;
	}
	
	.notice_tbl td{
		padding: 10px;
		border: 1px solid gray;
	}

	.more {
		color: black;
		text-decoration: none;
	}
		
	.more:hover {
		color: red;
	}
	
	.title {
		text-decoration: none;
		color: gray;
	}

	.title:hover {
		font-weight: bold;
		color: red;
	}
</style>
</head>
<body>
	<table class="notice_tbl">
		<colgroup>
			<col style="width: 90%;">
			<col style="width: *;">
		</colgroup>
		<tr>
			<th scope="col">공지사항</th>
			<th scope="col"><a href="reboard/list.jsp" class="more">more</a></th>
		</tr>
		<% if(list == null || list.isEmpty()){ %>
		<tr>
			<td colspan="2" style="text-align: center; color: gray;">공지사항이 없습니다.</td>
		</tr>
		<% }else { %>
			<% for(int i = 0; i < list.size(); i++){
				ReBoardVO reVo = list.get(i);
			%>
		<tr>
			<td colspan="2">
				<img src="images/dot3.JPG">&nbsp;<a href="reboard/detail.jsp?no=<%=reVo.getNo()%>" class="title"><%=reVo.getTitle() %></a>
				<%=Utility.displayNew(reVo.getRegdate(), request.getContextPath()) %>
			</td>
		</tr>
			<% } %>
		<% } %>
	</table>
</body>
</html>