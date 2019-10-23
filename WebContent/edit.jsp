<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%!
	Connection connection;
	Statement statement;
	ResultSet resultSet;
	
	String no, id, name, password, phone1, phone2, phone3, phone, gender;
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.6.166:1521:orcl";
	String uid = "hr";
	String upw = "hr123";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" href="CSS/register.css">
</head>
<body>
<%
	no = (String) session.getAttribute("no");

	String sql = "select * from member where no = '" + no + "'";
	
	Class.forName(driver);
	connection = DriverManager.getConnection(url, uid, upw);
	statement = connection.createStatement();
	resultSet = statement.executeQuery(sql);
	
	while(resultSet.next()){
		id = resultSet.getString("id");
		password = resultSet.getString("password");
		name = resultSet.getString("name");
		phone1 = resultSet.getString("phone1");
		phone2 = resultSet.getString("phone2");
		phone3 = resultSet.getString("phone3");
		phone = resultSet.getString("phone");
		gender = resultSet.getString("gender");
	}
%>
	<form action="Edit" method="post">
	<input type="hidden" name="no" value="<%=no%>">
		<table class="reg_tbl">
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="id" class="text_box" value="<%=id %>">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="password" class="text_box">
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="name" class="text_box" value="<%=name%>">
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<select name="phone1" class="select">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="019">019</option>
						<option value="02">02</option>
						<option value="054">054</option>
						<option value="032">032</option>
					</select>
					&nbsp;-&nbsp;
					<input type="text" name="phone2" class="phone_box" value="<%=phone2%>">
					&nbsp;-&nbsp;
					<input type="text" name="phone3" class="phone_box" value="<%=phone3%>">
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
				<%
					if(gender.equals("남자")) {
				%>
					<label>
						<input type="radio" name="gender" value="남자" checked="checked">남자
					</label>
					<label>
						<input type="radio" name="gender" value="여자">여자					
					</label>
				<% } else { %>
					<label>
						<input type="radio" name="gender" value="남자">남자
					</label>
					<label>
						<input type="radio" name="gender" value="여자" checked="checked">여자					
					</label>
				<% } %>
					
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" value="수정하기" class="sub_btn">
					<input type="reset" value="다시작성" class="res_btn">
				</th>
			</tr>
		</table>
	</form>
</body>
</html>