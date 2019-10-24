package com.pd.Controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnectionPoolMgr {
	public ConnectionPoolMgr() {
		try {
			String driver = "oracle.jdbc.driver.OracleDriver";
			Class.forName(driver);
			System.out.println("드라이버 로딩 성공!");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패!");
			e.printStackTrace();
		}
	}

	public Connection getConnection() throws SQLException {
		Connection con = null;
		String url = "jdbc:oracle:thin:@192.168.6.166:1521:orcl";
		String uid = "herb";
		String upw = "herb123";
		con = DriverManager.getConnection(url, uid, upw);
		System.out.println("DB연결 : con = " + con);

		return con;
	}

	public void dbClose(PreparedStatement ps, Connection con) throws SQLException {
		if (ps != null)
			ps.close();
		if (con != null)
			con.close();
	}

	public void dbClose(ResultSet rs, PreparedStatement ps, Connection con) throws SQLException {
		if (rs != null)
			rs.close();
		if (ps != null)
			ps.close();
		if (con != null)
			con.close();
	}
	
}
