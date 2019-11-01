<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String no = request.getParameter("no");
	if(no == null || no.isEmpty()){
%>
	<script>
		alert("잘못된 url 주소입니다.");
		location.href="list.jsp";
	</script>
<%		
		return;
	}
	
	ReBoardDAO rDao = new ReBoardDAO();
	ReBoardVO rVo = new ReBoardVO();
	
	try{
		rVo = rDao.selectByNo(Integer.parseInt(no));
		
		System.out.println("--------------");
		System.out.println(rVo);
		System.out.println("--------------");
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	String content = rVo.getContent();
	if(content != null && !content.isEmpty()){
		content = content.replace("\r\n", "<br>");
	}else{
		content = "";
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
				<td scope="col"><%=rVo.getTitle() %></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=rVo.getName() %></td>
			</tr>
			<tr>
				<th>등록일</th>
				<td><%=rVo.getRegdate() %></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=rVo.getReadcount() %></td>
			</tr>
			<tr>
				<th rowspan="2">첨부파일</th>
			<%
				if(rVo.getFileName1() != null && !rVo.getFileName1().isEmpty()){
			%>
				<td class="down_td">
					<a href="downCount.jsp?no=<%=no%>&fileName=<%=rVo.getFileName1()%>">
						<%=Utility.displayFile(rVo.getFileName1())%>&nbsp;<%=rVo.getFileName1() %> (<%=rVo.getFileSize1() %>) KB
					</a>
					<span class="downcnt"> + <%=rVo.getDownCount1() %></span>
				</td>
			<%	}else { %>
				<td rowspan="2"></td>
			<%	} %>
			</tr>
			<tr>
			<%	if(rVo.getFileName2() != null && !rVo.getFileName2().isEmpty()){ %>
				<td class="down_td">
					<a href="#">
						<%=Utility.displayFile(rVo.getFileName2())%>&nbsp;<%=rVo.getFileName2() %> (<%=rVo.getFileSize2() %>) KB
					</a>
					<span class="downcnt"> + <%=rVo.getDownCount2() %></span>
				</td>
			<%	}else { %>
				<td rowspan="2"></td>
			<%	} %>
			</tr>			
		</table>
		<div class="content"><%=content %></div>
		<div class="redirect_div">
			<a href="edit.jsp?no=<%=no%>">수정</a>&nbsp;|
			<a href="delete.jsp?no=<%=no%>&step=<%=rVo.getStep()%>&groupNo=<%=rVo.getGroupNo()%>">삭제</a>&nbsp;|
			<a href="reply.jsp?no=<%=no%>&title=<%=rVo.getTitle()%>">답변</a>&nbsp;|
			<a href="list.jsp">목록</a>
		</div>
	</div>
</body>
</html>
<%@ include file ="list.jsp"%>