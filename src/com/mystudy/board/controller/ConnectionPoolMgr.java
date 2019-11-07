package com.mystudy.board.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnectionPoolMgr {
	public ConnectionPoolMgr() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버 로딩 성공");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패");
			e.printStackTrace();
		}
	}

	public Connection getConnection() throws SQLException {
		String url = "jdbc:oracle:thin:@192.168.6.166:1521:orcl";
		//String url = "jdbc:oracle:thin:@192.168.123.7:1521:xe";
		String uid = "herb";
		String upw = "herb123";
		Connection con = DriverManager.getConnection(url, uid, upw);
		System.out.println("DB 연결 con = " + con);

		return con;
	}

	public void dbClose(PreparedStatement ps, Connection con) throws SQLException {
		if (ps != null) ps.close();
		if (con != null) con.close();
	}

	public void dbClose(ResultSet rs, PreparedStatement ps, Connection con) throws SQLException {
		if (rs != null) rs.close();
		if (ps != null) ps.close();
		if (con != null) con.close();
	}

}
