<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.*" %>
<%
	DecimalFormat df = new DecimalFormat("#,###");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.6.166:1521:orcl";
	String uid = "herb";
	String upw = "herb123";
	
	try{
		Class.forName(driver);
		System.out.println("드라이버 로딩 성공!");
		
		con = DriverManager.getConnection(url, uid, upw);
		System.out.println("DB 연결 성공!");
		
		String sql = "select * from pd order by no desc";
		ps = con.prepareStatement(sql);
		
		rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<link rel="stylesheet" href="../CSS/pdList.css">
</head>
<body>
	<h1>상품 목록</h1>
	<table class="pdList_tbl">
		<tr>
			<th>번호</th>
			<th>상품명</th>
			<th>가격</th>
			<th>등록일</th>
		</tr>
<%
	while(rs.next()){
		int no = rs.getInt("no");
		String pdName = rs.getString("pdName");
		int price = rs.getInt("price");
		Timestamp regdate = rs.getTimestamp("regdate");
%>		
		<tr>
			<td><%=no %></td>
			<td>
				<a href="pdDetail.jsp?no=<%=no %>">
					<%=pdName %>
				</a>
			</td>
			<td><%=df.format(price) %>원</td>
			<td><%=sdf.format(regdate) %></td>
		</tr>
<%
	}//while
%>
	</table>
	<br><br>
	<a href="pdWrite.jsp">상품 등록</a>
</body>
</html>
<%
	}catch(ClassNotFoundException e){
		System.out.println("class not found!!" + e + "<br>");
	}catch(SQLException e){
		System.out.println("상품 전체 조회시 sql 예외발생!" + e);
		e.printStackTrace();
	}finally{
		try{
			if(rs != null) rs.close();
			if(ps != null) ps.close();
			if(con != null) con.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
%>