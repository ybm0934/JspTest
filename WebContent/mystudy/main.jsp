<%@page import="com.herbmall.register.model.MemberDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.register.model.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String) session.getAttribute("id");
	System.out.println("로그인 세션 id : " + id);
	
/*	
	//쿠키값 가져오기
	Cookie[] cookies = request.getCookies();
	
	String ckName = "", ckValue = "";
	if(cookies != null){
		for(int i = 0; i < cookies.length; i++){
			Cookie ck = cookies[i];
				
			ckName = ck.getName();
			ckValue = ck.getValue();
			
			System.out.println("로그인 쿠키 ckName : " + ckName);
			System.out.println("로그인 쿠키 ckValue : " + ckValue);
		}
	}
*/
	
	MemberDAO dao = new MemberDAO();
	MemberVO vo = new MemberVO();
	
	try{
		vo = dao.selectMember(id);
		System.out.println("메인 페이지 회원 정보 vo = " + vo);
		
	}catch(SQLException e){
		e.printStackTrace();
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<style type="text/css">
.main_tbl {
	border-collapse: collapse;
	width: 30%;
	margin-top: 50px;
}

table.main_tbl tr th {
	width: 30%;
}

table.main_tbl tr th, table.main_tbl tr td {
	border-top: 1px solid black;
	padding: 10px;
}

.logout_div{
	margin-top: 50px;
}
</style>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#id").focus();
		$("form[name=loginform]").submit(function(){
			if($("#id").val() == ""){
				alert("아이디를 입력하세요.");
				$("#id").focus();
				return false;
			}else if($("#pwd").val().length < 1){
				alert("비밀번호를 입력하세요.");
				$("#pwd").focus();
				return false;
			}
		});
		
		$("#logout").click(function(){
			if(confirm("로그아웃 하시겠습니까?")){
				location.href="login/logout.jsp";
			}
		});
		
	});
	
		function register() {
			location.href = "member/register.jsp";
		}
</script>
</head>
<body>
	<h1>메인 페이지입니다.</h1>
	<% if(id == null){ %>
	<form action="login/login_ok.jsp" name="loginform" method="post">
		아이디 : <input type="text" name="userid" id="id">
		비밀번호 : <input type="password" name="pwd" id="pwd">
		<input type="submit" value="로그인">
		<input type="button" value="회원가입" onclick="register()">
	</form>
	<% }else { %>
	<table class="main_tbl">
	<caption style="font-weight: bold; font-size:1.3em;">회원 정보</caption>
		<tr>
			<th>번호</th>
			<td><%=vo.getNo() %></td>
		</tr>
		<tr>
			<th>아이디</th>
			<td><%=id %></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><%=vo.getPwd() %></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><%=vo.getEmail() %></td>
		</tr>
		<tr>
			<th>핸드폰</th>
			<td><%=vo.getHp() %></td>
		</tr>
		<tr>
			<th>성별</th>
			<td><%=vo.getGender() %></td>
		</tr>
		<tr>
			<th>우편번호</th>
			<td><%=vo.getZipcode() %></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><%=vo.getAddress() %></td>
		</tr>
		<tr>
			<th>상세주소</th>
			<td><%=vo.getAddressDetail() %></td>
		</tr>
		<tr>
			<th>가입일</th>
			<td><%=vo.getRegdate() %></td>
		</tr>
		<tr>
			<th>마일리지</th>
			<td><%=vo.getMileage() %></td>
		</tr>
		<tr>
			<th>권한</th>
			<td><%=vo.getAuthCode() %></td>
		</tr>
	</table>
	<div class="logout_div">
		<input type="button" id="logout" name="logout" value="로그아웃">
	</div>
	<% } %>
</body>
</html>