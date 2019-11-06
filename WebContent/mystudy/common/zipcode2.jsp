<%@page import="com.herbmall.register.model.MemberDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.register.model.ZipcodeVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String dong = request.getParameter("dong");
	if(dong == null) dong = "";
	
	MemberDAO dao = new MemberDAO();
	
	List<ZipcodeVO> list = null;
	try{
		if(dong != null && !dong.isEmpty()){
			list = dao.selectZipcode(dong);
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우편번호 찾기</title>
</head>
<body>
<h2>우편번호 검색</h2>
	<form name="frmZipcode" method="post" action="zipcode2.jsp">
		<label for="dong">지역명 : </label>
		<input type="text" name="dong" id="dong" value="<%=dong %>">
		<input type="submit" id="submit_btn" value="찾기">
	</form>
	<table>
		<thead>
			<tr>
				<th>우편번호</th>
				<th>주소</th>
			</tr>
		</thead>
		<tbody>
			<% if(list.isEmpty()){ %>
			<tr>
				<td colspan="2">해당하는 주소가 없습니다.</td>
			</tr>
			<% }//if %>
		</tbody>
	</table>
</body>
</html>