<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String no = request.getParameter("no");
	if(no == null || no.isEmpty()){
%>
	<script type="text/javascript">
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
		
		System.out.println("----------------------------------------------");
		System.out.println(rVo);
		System.out.println("----------------------------------------------");
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	String content = rVo.getContent();
	if(content != null && !content.isEmpty()){
		content = content.replace("\r\n", "<br>");
	}else{
		content = "";
	}
	
	double fileSize = 0;
	if(rVo.getFileSize() != null && !rVo.getFileSize().isEmpty()){
		//파일 사이즈 문자 제거 숫자만 추출
		fileSize = Double.parseDouble(rVo.getFileSize().replaceAll("[^0-9]", ""));
	}
	
	String fileInfo = "";
	//파일이미지 + 파일명 (파일크기) + 다운수
	if(rVo.getFileName() != null && !rVo.getFileName().isEmpty()){
		//파일이 첨부된 경우에만
		fileInfo = Utility.displayFile(rVo.getFileName()) + "&nbsp;";
		fileInfo += rVo.getOriginalFileName() + "&nbsp;";
		fileInfo += "(" + Utility.displaySize(rVo.getFileName(), fileSize) + ")";
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
				if(rVo.getFileName() != null && !rVo.getFileName().isEmpty()){
			%>
				<td class="down_td">
					<a href="downCount.jsp?no=<%=no%>&fileName=<%=rVo.getFileName()%>"><%=fileInfo %></a>
					<span class="downcnt"> + <%=rVo.getDownCount() %></span>
				</td>
			<%	}else { %>
				<td rowspan="2"></td>
			<%	} %>
			</tr>	
		</table>
		<div class="content"><%=content %></div>
		<div class="redirect_div">
			<a href="edit.jsp?no=<%=no%>">수정</a>&nbsp;|
			<a href="delete.jsp?no=<%=no%>&step=<%=rVo.getStep()%>&groupNo=<%=rVo.getGroupNo()%>&fileName=<%=rVo.getFileName()%>">삭제</a>&nbsp;|
			<a href="reply.jsp?no=<%=no%>&title=<%=rVo.getTitle()%>">답변</a>&nbsp;|
			<a href="list.jsp">목록</a>
		</div>
	</div>
</body>
</html>
<%@ include file ="list.jsp"%>