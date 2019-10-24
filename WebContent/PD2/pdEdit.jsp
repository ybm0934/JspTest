<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String no = request.getParameter("no");
	System.out.println("no : " + no);

	String pdName = "";
	int price = 0;
	Timestamp regdate = null;

	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.6.166:1521:orcl";
	String uid = "herb";
	String upw = "herb123";

	try {
		//[1]드라이버 연결
		Class.forName(driver);
		System.out.println("pdEdit.jsp 드라이버 연결 성공");

		//[2]DB 연결
		con = DriverManager.getConnection(url, uid, upw);
		System.out.println("pdEdit.jsp DB 연결 성공");

		//[3]SQL 처리
		String sql = "select * from pd where no = ?";
		ps = con.prepareStatement(sql);
		ps.setInt(1, Integer.parseInt(no));

		//[4]SQL 실행
		rs = ps.executeQuery();

		//[5]출력
		if (rs.next()) {
			pdName = rs.getString("pdname");
			price = rs.getInt("price");
			regdate = rs.getTimestamp("regdate");
		}
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<script type="text/javascript">
	function retrac(){
		history.back();
	} 

	function send(){
		var key = Number(document.edit.price.value);
		
		if(document.edit.pdName.value == ""){
			alert("상품명을 입력하세요.");
			document.edit.pdName.focus();
			return false;
		}else if(document.edit.price.value == ""){
			alert("가격을 입력하세요.");
			edit.price.focus();
			return false;
		}else if(isNaN(key) || key < 0){
			alert("가격을 다시 입력하세요.");
			edit.price.focus();
			return false;
		}
	}
	
</script>
</head>
<body>
	<h1>상품 등록</h1>
	<form name="edit" method="post" action="pdEdit_ok.jsp" onsubmit="return send()">
	<input type="hidden" name="no" value="<%=no%>">
		<table>
			<tr>
				<th>상품명</th>
				<td>
					<input type="text" name="pdName" value="<%=pdName%>">
				</td>
			</tr>
			<tr>
				<th>가격</th>
				<td>
					<input type="text" name="price" value="<%=price%>">
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" name="regit" value="등록">
					<button type="button" onclick="retrac()">취소</button>
				</th>
			</tr>
		</table>
		<br><br>
		<a href="pdList.jsp">상품 목록</a>
	</form>
</body>
</html>