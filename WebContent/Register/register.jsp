<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<script type="text/javascript">
	function send(){
		if(document.frm1.id.value == ""){
			alert("아이디를 입력하세요.");
			document.frm1.id.focus();
			return false;
		}else if(frm1.pwd.value.length == 0){
			alert("비밀번호를 입력하세요.");
			frm1.pwd.focus();
			return false;
		}else if(frm1.name.value == ""){
			alert("이름을 입력하세요");
			frm1.name.focus();
			return false;
		}else if(document.frm1.gender.value == ""){
			alert("성별을 입력하세요.");
			return false;
		}else if(document.frm1.grade.value == ""){
			alert("학년을 선택하세요.");
			frm1.grade.focus();
			return false;
		}
	}
</script>
</head>
<body>
	<form name="frm1" method="post" action="register_ok.jsp" onsubmit="return send()">
	아이디 : <input type="text" name="id" maxlength="10"><br>
	비밀번호 : <input type="password" name="pwd"><br>
	이름 : <input type="text" name="name"><br>
	휴대폰 번호 : <input type="text" name="hp"><br>
	취미 : 
	<label><input type="checkbox" name="hobby" value="축구">축구</label>
	<label><input type="checkbox" name="hobby" value="야구">야구</label>
	<label><input type="checkbox" name="hobby" value="낚시">낚시</label><br>
	성별 : 
	<label><input type="radio" name="gender" value="남자">남자</label>
	<label><input type="radio" name="gender" value="여자">여자</label><br>
	자기소개 : <textarea name="intro" rows="5" cols="10"></textarea><br>
	학년 : 
	<select name="grade">
		<option value="" selected>선택</option>
		<option value="1">1학년</option>
		<option value="2">2학년</option>
		<option value="3">3학년</option>
	</select><br><br>
	<input type="submit" value="전송">
	<input type="reset" value="취소">
	</form>
</body>
</html>