<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<link rel="stylesheet" type="text/css" href="../CSS/write.css">
<script type="text/javascript" src="../JS/write.js"></script>
</head>
<body>
	<div class="write_div">
		<h1>글쓰기</h1>
		<form action="write_ok.jsp" name="frmWrite" method="post">
			<table class="write_tbl">
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" class="text"spellcheck="false"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><input type="text" name="name" class="text"spellcheck="false"></td>
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
						<input type="submit" name="regit" class="btn regit" value="등록">
						<input type="button" name="list" class="btn list" value="글목록">
					</th>
				<tr>
			</table>
		</form>
	</div>
</body>
</html>