<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String no = request.getParameter("no");
	String pdName = request.getParameter("pdName");
	String price = request.getParameter("price");
	System.out.println("pdEdit_ok.jsp 파라미터");
	System.out.println("no, pdName, price : " + no + pdName + price);

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.6.166:1521:orcl";
	String uid = "herb";
	String upw = "herb123";

	Connection con = null;
	PreparedStatement ps = null;

	try {
		//[1]드라이버 연결
		Class.forName(driver);
		System.out.println("pdEdit_ok.jsp 드라이버 연결 성공");

		//[2]DB 연동
		con = DriverManager.getConnection(url, uid, upw);
		System.out.println("pdEdit_ok.jsp DB 연결 성공");

		//[3]SQL 작성
		String sql = "update pd set pdname = ?, price = ? where no = ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, pdName);
		ps.setInt(2, Integer.parseInt(price));
		ps.setInt(3, Integer.parseInt(no));

		//[4]SQL 실행
		int n = ps.executeUpdate();

		//[5]출력
		if (n > 0) {
			System.out.println("수정 성공!");
			response.sendRedirect("pdDetail.jsp?no=" + no);
		} else {
			System.out.println("수정 실패!");
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