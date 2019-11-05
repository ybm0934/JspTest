<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변하기</title>
<link rel="stylesheet" type="text/css" href="../CSS/write.css">
<script type="text/javascript" src="../JS/write.js"></script>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String no = request.getParameter("no");
	String title = request.getParameter("title");
	if((no == null || no.isEmpty()) || (title == null || title.isEmpty())){
%>		
	<script>
		alert("잘못된 접근입니다.");
		location.href="<%=request.getContextPath() %>/mystudy/reboard/list.jsp";
	</script>	
<%		
	}
	
	ReBoardDAO dao = new ReBoardDAO();
	ReBoardVO vo = new ReBoardVO();

	try {
		vo = dao.selectByNo(Integer.parseInt(no));
	} catch (SQLException e) {
		System.out.println("reply.jsp error : " + e);
	}
%>
	<div class="write_div">
		<h1>답변하기</h1>
		<form action="reply_ok.jsp" name="frmWrite" method="post" onsubmit="return send()">
		<input type="hidden" name="no" value="<%=no %>">
		<input type="hidden" name="groupNo" value="<%=vo.getGroupNo() %>">
		<input type="hidden" name="step" value="<%=vo.getStep() %>">
		<input type="hidden" name="sortNo" value="<%=vo.getSortNo() %>">
			<table class="write_tbl">
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" class="text" spellcheck="false" value="Re: <%=title %>"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><input type="text" name="name" class="text" spellcheck="false"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="pwd" class="text"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="email" class="text" spellcheck="false"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea spellcheck="false" name="content" class="textarea"></textarea></td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="submit" class="btn regit" value="등록">
						<input type="button" class="btn list" value="글목록" onclick="location.href='/mystudy/board/list.jsp'">
					</th>
				<tr>
			</table>
		</form>
	</div>
</body>
</html>