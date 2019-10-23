<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!Connection con;
	Statement stm;
	ResultSet rs;

	String driver = "oracle.jdbc.driver.OracleDriver";
	//String url = "jdbc:oracle:thin:@192.168.6.166:1521:orcl";
	String url = "jdbc:oracle:thin:@192.168.123.7:1521:xe";
	String uid = "hr";
	String upw = "hr123";%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, uid, upw);
			out.println("DB 연결 성공!<br><br>");
			String sql = "select * from member";
			stm = con.createStatement();
			rs = stm.executeQuery(sql);

			while (rs.next()) {
				String no = rs.getString("no");
				String id = rs.getString("id");
				String pw = rs.getString("pw");
				String name = rs.getString("name");
				String phone = rs.getString("phone");
				Timestamp regdate = rs.getTimestamp("regdate");

				out.println("번호 : " + no + "<br>");
				out.println("아이디 : " + id + "<br>");
				out.println("비밀번호 : " + pw + "<br>");
				out.println("이름 : " + name + "<br>");
				out.println("전화번호 : " + phone + "<br>");
				out.println("등록일 : " + regdate + "<br><br>");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stm != null)
					stm.close();
				if (con != null)
					con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	%>

</body>
</html>