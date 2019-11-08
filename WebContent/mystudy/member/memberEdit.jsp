<%@page import="com.herbmall.register.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.register.model.MemberVO"%>
<%@ include file="../login/loginCheck.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid = (String) session.getAttribute("id");
	
	MemberService service = new MemberService();

	MemberVO vo = null;
	String hp1 = "", hp2 = "", hp3 = "";
	String email1 = "", email2 = "";
	String address="", addressDetail="";
	String[] emailList = {"naver.com", "google.com", "lycos.com", "yahoo.com"};
	boolean isEtc = false;	//직접 입력인지 여부
	
	try{
		vo = service.selectMember(userid);
		
		//휴대폰 숫자만 분리
		String hp = vo.getHp();
		if(hp != null && !hp.isEmpty()){
			String[] hpArr = hp.split("-");
			hp1 = hpArr[0];
			hp2 = hpArr[1];
			hp3 = hpArr[2];
		}
		
		//이메일 분할
		String email = vo.getEmail();
		int count = 0;
		if(email != null && !email.isEmpty()){
			String[] emailArr = email.split("@");
			email1 = emailArr[0];
			email2 = emailArr[1];
			
			//직접 입력인지 확인
			for(int i = 0; i < emailList.length; i++){
				if(email2.equals(emailList[i])){
					count++;
					break;
				}
			}//for
			
			//직접 입력이면 isEtc를 true로 셋팅
			if(count == 0){
				isEtc = true;
			}
			
		}//if
		
		address = vo.getAddress();
		addressDetail = vo.getAddressDetail();
		if(address == null) address = "";
		if(addressDetail == null) addressDetail = "";
		
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/mystudy/CSS/register.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#name").focus();
		$("form[name='reg_form']").submit(function(){
			if($("#name").val() == ""){
				alert("이름을 입력하세요.");
				$("#name").focus();
				return false;
			}else if($("#password1").val() == ""){
				alert("비밀번호를 입력하세요.");
				$("#password1").focus();
				return false;
			}else if($("#password2").val() == ""){
				alert("비밀번호를 입력하세요.");
				$("#password2").focus();
				return false;
			}else if($("#password1").val() != $("#password2").val()){
				alert("비밀번호가 일치하지 않습니다.");
				$("#password2").focus();
				return false;
			}else if($("#address1").val() == ""){
				alert("주소를 입력하세요.");
				$("#address1").focus();
				return false;
			}else if(!validate_phoneno($("#phone2").val()) || !validate_phoneno($("#phone3").val())){
				alert("전화번호는 숫자만 가능합니다.");
				$("#phone2").focus();
				event.preventDefault();
			}
		});
		
		$("#srch_zip").click(function(){
			window.open("../common/zipcode.jsp", "zip", "top=10, left=10, width=500, height=500, scrollbars=yes, resizable=yes");
		});

		//직접 입력을 선택하면 email3 텍스트 상자가 보이게
		$("#email2").change(function(){
			if($("#email2").val() == "etc"){
				$("#email3").val("");
				$("#email3").css("visibility", "visible");
				$("#email3").focus();
			}else {
				$("#email3").css("visibility", "hidden");
			}
		});
		
		function validate_phoneno(ph){
			var pattern = new RegExp(/^[0-9]*$/g);
			return pattern.test(ph);	//정규식과 일치하면 true
			/* 정규식 /^[0-9]*$/g
			0 에서 9사이의 숫자로 시작하거나 끝나야 한다는 의미 (^는 시작, $는 끝을 의미)
			닫기 대괄호(]) 뒤의 * 기호는 0번 이상 반복
			*/
		}
		
		function validate_userid(uid){
			var pattern = new RegExp(/^[a-zA-Z0-9_]+$/g);
			return pattern.test(uid);
			/*
			정규식 /^[a-zA-Z0-9_]+$/g
			a에서 z 사이의 문자, A~Z사이의 문자, 0 에서 9사이의 숫자나 _로 시작하거나 끝나야 한다는 의미
			닫기 대괄호(]) 뒤의 + 기호는 이 패턴이 한 번 또는 그 이상 반복된다는 의미
			*/
		}
		
		$("#reg_back").click(function(){
			if(confirm("정말 취소하시겠습니까?")){
				location.href = "../main.jsp";
			}
		});
		
		$("#out").click(function(){
			location.href = "memberOut.jsp";
		});
	});
</script>
</head>
<body>
	<div class="reg_div">
		<h1>회원 가입</h1>
		<form action="memberEdit_ok.jsp" name="reg_form" method="post">
			<table class="reg_tbl">
				<tr>
					<th>성명</th>
					<td><input type="text" name="name" id="name" value="<%=vo.getName() %>"></td>
				<tr>
				<tr>
					<th>성별</th>
					<td>
						<label for="gender1">
							<input type="radio" name="gender" id="gender1" value="남자"
							<% if("남자".equals(vo.getGender())){ %>
								checked="checked"
							<% } %> >남자
						</label>
						<label for="gender2">
							<input type="radio" name="gender" id="gender2" value="여자"
							<% if("여자".equals(vo.getGender())){ %>
								checked="checked"
							<% } %> >여자
						</label>
					</td>
				<tr>
				<tr>
					<th>회원ID</th>
					<td>
						<input type="text" name="id" id="id" disabled="disabled" value="<%=vo.getUserid() %>">
					</td>
				<tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="password1" id="password1"></td>
				<tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="password2" id="password2"></td>
				<tr>
				<tr>
					<th>주소</th>
					<td>
						<input type="text" name="address1" id="address1" readonly="readonly" value="<%=vo.getZipcode() %>">
						<input type="button" id="srch_zip" class="reg_btn" value="우편번호 찾기"><br>
						<input type="text" name="address2" id="address2" readonly="readonly" value="<%=vo.getAddress() %>"><br>
						<input type="text" name="address3" id="address3" value="<%=vo.getAddressDetail() %>">
					</td>
				<tr>
				<tr>
					<th>핸드폰</th>
					<td>
					<select name="phone1" id="phone1">
						<option value="010" 
						<% if("010".equals(hp1)){ %>
							selected="selected"
						<% } %> >010</option>
						<option value="011"
						<% if("011".equals(hp1)){ %>
							selected="selected"
						<% } %> >011</option>
						<option value="012"
						<% if("012".equals(hp1)){ %>
							selected="selected"
						<% } %> >012</option>
						<option value="013"
						<% if("013".equals(hp1)){ %>
							selected="selected"
						<% } %> >013</option>
						<option value="014"
						<% if("014".equals(hp1)){ %>
							selected="selected"
						<% } %> >014</option>
					</select>
					 - <input type="text" name="phone2" id="phone2" value="<%=hp2 %>">
					 - <input type="text" name="phone3" id="phone3" value="<%=hp3 %>">
					</td>
				<tr>
				<tr>
					<th>이메일 주소</th>
					<td>
						<input type="text" name="email1" id="email1" value="<%=email1 %>"> @ 
						<select name="email2" id="email2">
							<% for(int i = 0; i < emailList.length; i++){ %>
								<option value="<%=emailList[i] %>"
								<% if(email2.equals(emailList[i])){ %>
									selected="selected"
								<% } %> ><%=emailList[i] %></option>
							<% }//for %>
							<option value="etc"
							<% if(isEtc == true){ %>
								selected="selected"
							<% } %> >직접입력</option>
						</select>
						<input type="text" name="email3" id="email3"
						<% if(isEtc){ %>
							style="visibility: visible;" value="<%=email2 %>"
						<% }else { %>
							style="visibility: hidden;"
						<% } %> >
					</td>
				<tr>
				<tr>
					<th colspan="2">
						<input type="submit" name="reg_sub" id="reg_sub" class="reg_btn" value="수정하기">
						<input type="button" name="reg_back" id="reg_back" class="reg_back" value="취소">
						<input type="button" name="out" id="out" class="reg_back" value="회원 탈퇴">
					</th>
				<tr>
			</table>
		</form>
	</div>
</body>
</html>