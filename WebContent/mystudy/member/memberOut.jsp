<%@ include file="../login/loginCheck.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#pwd").focus();
		$("form[name=outfrm]").submit(function(){
			if($("#pwd").val().length < 1){
				alert("비밀번호를 입력해주세요.");
				$("#pwd").focus();
				return false;
			}
		});
		
		$("#back").click(function(){
			location.href="../main.jsp";
		});
	});
</script>
</head>
<body>
	<form action="memberOut_ok.jsp" name="outfrm" method="post">
		<h1>회원 탈퇴</h1>
		<h4>회원 탈퇴 하시겠습니까?</h4>
		비밀번호 <input type="password" name="pwd" id="pwd">
		<input type="submit" name="outok" id="outok" value="확인">
		<input type="button" name="back" id="back" value="취소">
	</form>
</body>
</html>