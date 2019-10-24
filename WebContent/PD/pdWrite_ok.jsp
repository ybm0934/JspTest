<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	//1. post방식으로 넘긴 요청 파라미터에 대한 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	//2. post방식으로 넘긴 파라미터 읽어오기
	String pdName = request.getParameter("pdName");
	String price = request.getParameter("price");

	//3. DB 작업
	Connection con = null;
	PreparedStatement ps = null;
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.6.166:1521:orcl";
	String uid = "herb";
	String upw = "herb123";

	try {
		//[1] JDBC 드라이버 로딩
		Class.forName(driver);
		System.out.println("드라이버 로딩 성공!!");

		//[2] DB와 연결
		con = DriverManager.getConnection(url, uid, upw);
		System.out.println("DB 연결 성공!!");

		//[3] sql문 작성 및 PreparedStatement 객체 생성
		String sql = "insert into pd(no, pdname, price)" + "values(pd_seq.nextval, ?, ?)";
		ps = con.prepareStatement(sql);
		ps.setString(1, pdName);
		ps.setInt(2, Integer.parseInt(price));

		//[4] sql문 실행
		int n = ps.executeUpdate();

		//[5] 결과 출력
		if (n > 0) {
			System.out.println("입력 성공!!");
			response.sendRedirect("pdList.jsp");
		} else {
			System.out.println("입력 실패!!");
		}

	} catch (ClassNotFoundException e) {
		System.out.println("class not found!!" + e + "<br>");
	} catch (SQLException e) {
		System.out.println("입력시 sql 예외발생 : " + e + "<br>");
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