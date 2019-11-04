<%@page import="com.herbmall.utility.Utility"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mystudy.board.model.BoardVO"%>
<%@page import="com.mystudy.board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String no = request.getParameter("no");
	if(no == null || no.isEmpty()){
	%>
	<script>
		alert("잘못된 url 주소입니다.");
		location.href = "list.jsp";
	</script>
	<%		
		return;
	}
	
	ReBoardDAO dao = new ReBoardDAO();
	ReBoardVO vo = new ReBoardVO();

	try{
		vo = dao.selectByNo(Integer.parseInt(no));
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	String content = vo.getContent();
	String email = vo.getEmail();
	if(content == null) content = "";
	if(email == null) email = "";
	
	double fileSize = 0;
	if(vo.getFileSize() != null && !vo.getFileSize().isEmpty()){
		//파일 사이즈 문자 제거 숫자만 추출
		fileSize = Double.parseDouble(vo.getFileSize().replaceAll("[^0-9]", ""));
	}
	
	String fileInfo = "";
	//파일이미지 + 파일명 (파일크기) + 다운수
	if(vo.getFileName() != null && !vo.getFileName().isEmpty()){
		//파일이 첨부된 경우에만
		fileInfo = Utility.displayFile(vo.getFileName()) + "&nbsp;";
		fileInfo += vo.getOriginalFileName() + "&nbsp;";
		fileInfo += "(" + Utility.displaySize(vo.getFileName(), fileSize) + ")<br>";
		fileInfo += "<span class='file_spn'>첨부파일을 새로 지정할 경우 기존 파일은 삭제됩니다.</span>";
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정하기</title>
<link rel="stylesheet" type="text/css" href="../CSS/write.css">
<script type="text/javascript" src="../JS/write.js"></script>
</head>
<body>
<div class="write_div">
	<h1>글쓰기</h1>
	<form action="edit_ok.jsp" name="frmWrite" method="post" onsubmit="return send()"  encType="multipart/form-data">
	<input type="hidden" name="no" value="<%=no%>">
	<input type="hidden" name="oldFileName" value="<%=vo.getFileName() %>">
		<table class="write_tbl">
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" class="text" spellcheck="false" value="<%=vo.getTitle()%>"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="name" class="text" spellcheck="false" value="<%=vo.getName()%>"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd" class="text"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="email" class="text" spellcheck="false" value="<%=email%>"></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="fileName"><span class="file_spn">(최대 100MB)</span></td>
			</tr>
			<tr>
				<th>첨부파일 목록</th>
				<td><span class="fileInfo"><%=fileInfo %></span></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea spellcheck="false" name="content" class="textarea"><%=content%></textarea></td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" class="btn regit" value="수정">
					<input type="button" class="btn list" value="글목록" onclick="location.href='list.jsp'">
				</th>
			<tr>
		</table>
	</form>
</div>
</body>
</html>