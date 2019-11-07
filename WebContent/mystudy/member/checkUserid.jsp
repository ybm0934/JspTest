<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.register.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String userid = request.getParameter("userid");
	
	if(userid == null) userid = "";
	
	MemberDAO dao = new MemberDAO();
	String flag = "";
	try{
		if(userid != null && !userid.isEmpty()){
			if(dao.checkUserid(userid) == true){	//아이디가 존재
				flag = "N";
			}else {
				flag = "Y";
			}
		}
		System.out.println("flag 값 : " + flag);
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 검사</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#userid").focus();
		
		$("#check_id").click(function(){
			if($("#userid").val().length < 1){
				alert("아이디를 입력하세요.");
				$("#userid").focus();
				return false;
			}
		
		});
		
		$("#ok_id").click(function(){
			opener.reg_form.id.value = "<%=userid %>";
			opener.reg_form.id_ck.value = "Y";
			self.close();
		});
	});
</script>
</head>
<body>
<h1>아이디 중복 검사</h1>
<form action="checkUserid.jsp" name="checkform" method="post">
	<input type="text" id="userid" name="userid" placeholder="아이디를 입력하세요." value="<%=userid %>">
	<input type="submit" id="check_id" class="check_btn" value="아이디 확인">
	<% if(flag.equals("Y")){ %>
	<input type="button" id="ok_id" class="check_btn" value="사용하기">
		<p>사용 가능한 아이디입니다. [사용하기] 버튼을 누르세요.</p>
	<% } %>
	<% if(flag.equals("N")){ %>
		<p>이미 등록된 아이디입니다. 다른 아이디를 입력하세요.</p>
	<% } %>
</form>
</body>
</html>