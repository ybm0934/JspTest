<%@page import="java.sql.SQLException"%>
<%@page import="com.mystudy.board.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<link rel="stylesheet" type="text/css" href="../CSS/pwdCheck.css">
<script type="text/javascript" src="../JS/pwdCheck.js"></script>
</head>
<body>
	<form action="edit.jsp" name="pwdfrm" method="post" onsubmit="send()">
	<input type="hidden" name="no" value="<%=request.getParameter("no") %>">
		<fieldset>
			<legend style="font-weight: bold;">비밀번호</legend>
			<div class="pwd_div">
				<div class="pwd_div2">
					<div><input type="password" name="pwd" class="pwd_box"></div>
					<div class="button_div">
						<input type="submit" class="btn ok" value="확인">
						<input type="button" class="btn cancel" value="취소" onclick="history.back()">
					</div>
				</div>
			</div>
		</fieldset>
		
	</form>
</body>
</html>