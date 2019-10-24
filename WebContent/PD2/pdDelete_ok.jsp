<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String no = request.getParameter("no");

	Connection con = null;
	PreparedStatement ps = null;

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.6.166:1521:orcl";
	String uid = "herb";
	String upw = "herb123";

	try {
		//[1] 드라이버 로딩
		Class.forName(driver);
		System.out.println("드라이버 로딩 성공!");

		//[2] DB 연결
		con = DriverManager.getConnection(url, uid, upw);
		System.out.println("DB 연결 성공!");

		//[3] sql문 작업
		String sql = "delete from pd where no = ?";
		ps = con.prepareStatement(sql);
		ps.setInt(1, Integer.parseInt(no));

		//[4] sql문 실행
		int n = ps.executeUpdate();

		//[5] 결과 출력
		if (n > 0) {
			System.out.println("삭제 성공!");
			response.sendRedirect("pdList.jsp");
		} else {
			System.out.println("삭제 실패!");
			response.sendRedirect("pdDetail.jsp?no=" + no);
		}

	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if (ps != null)
				ps.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>