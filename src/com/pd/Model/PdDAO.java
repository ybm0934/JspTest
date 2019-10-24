package com.pd.Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.pd.Controller.ConnectionPoolMgr;

public class PdDAO {
	private ConnectionPoolMgr pool;

	public PdDAO() {
		pool = new ConnectionPoolMgr();
	}

	public int insertPd(PdDTO pdDto) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		int n = 0;

		try {
			// [1], [2] 드라이버 로딩, 연결 객체 생성
			con = pool.getConnection();

			// [3] sql문 처리
			String sql = "insert into pd(no, pdName, price)" + "values(pd_seq.nextval, ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, pdDto.getPdName());
			ps.setInt(2, pdDto.getPrice());

			// [4] 실행
			n = ps.executeUpdate();
			System.out.println("상품 등록 여부, n = " + n + ", 입력값 pdDto : " + pdDto);
		} finally {
			pool.dbClose(ps, con);
		}

		return n;
	}

}
