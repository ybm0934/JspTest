<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String no = request.getParameter("no");

	DecimalFormat df = new DecimalFormat("#,###");

	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.6.166:1521:orcl";
	String uid = "herb";
	String upw = "herb123";

	String pdName = "";
	int price = 0;
	Timestamp regdate = null;

	try {
		Class.forName(driver);
		System.out.println("드라이버 로딩 성공!");
		con = DriverManager.getConnection(url, uid, upw);
		System.out.println("DB연결 성공!");

		String sql = "select * from pd where no=?";
		ps = con.prepareStatement(sql);
		ps.setInt(1, Integer.parseInt(no));

		rs = ps.executeQuery();

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
<title>상품 상세보기</title>
<script type="text/javascript">
	function del(no){
		var del = confirm("삭제하시겠습니까?");
		if(del){
			location.href="pdDelete_ok.jsp?no=" + no;
		}
	}
</script>
</head>
<body>
	<h1>상품 상세보기</h1>
	<%=no %>을 클릭하였습니다.<br><br>
	번호 : <%=no %><br>
	상품명 : <%=pdName %><br>
	가격 : <%=df.format(price) %>원<br>
	등록일 : <%=regdate %><br><br>
	<a href="pdList.jsp">목록</a>&nbsp;
	<a href="pdEdit.jsp?no=<%=no%>">수정</a>&nbsp;
	<a href="#" onclick="del(<%=no%>)">삭제</a>
</body>
</html>