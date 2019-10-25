package com.pd.Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.pd.Controller.ConnectionPoolMgr;

public class PdDAO {
	private ConnectionPoolMgr pool;
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;

	public PdDAO() {
		pool = new ConnectionPoolMgr();
	}

	public int insertPd(PdDTO pdDto) throws SQLException {
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
	}// insertPd

	public ArrayList<PdDTO> selectAll() throws SQLException {
		ArrayList<PdDTO> list = new ArrayList<PdDTO>();

		try {
			con = pool.getConnection();

			String sql = "select * from pd order by no desc";
			ps = con.prepareStatement(sql);

			rs = ps.executeQuery();
			while (rs.next()) {
				int no = rs.getInt("no");
				String pdName = rs.getString("pdname");
				int price = rs.getInt("price");
				Timestamp regdate = rs.getTimestamp("regdate");

				PdDTO pdDto = new PdDTO();
				pdDto.setNo(no);
				pdDto.setPdName(pdName);
				pdDto.setPrice(price);
				pdDto.setRegdate(regdate);

				list.add(pdDto);
			} // while
			System.out.println("상품 목록 조회, list.size() = " + list.size());
			;
		} finally {
			pool.dbClose(rs, ps, con);
		}
		return list;
	}// selectAll

	public PdDTO selectByNo(int no) throws SQLException {

		PdDTO pdDto = new PdDTO();

		try {
			con = pool.getConnection();

			String sql = "select * from pd where no = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);

			rs = ps.executeQuery();
			if (rs.next()) {
				String pdName = rs.getString("pdname");
				int price = rs.getInt("price");
				Timestamp regdate = rs.getTimestamp("regdate");

				pdDto.setNo(no);
				pdDto.setPdName(pdName);
				pdDto.setPrice(price);
				pdDto.setRegdate(regdate);
			}
			System.out.println("상품 상세 조회, pdDto = " + pdDto + ", 입력값 no = " + no);

		} finally {
			pool.dbClose(rs, ps, con);
		}

		return pdDto;

	}// selectByNo

	public int updatePd(PdDTO pdDto) throws SQLException {
		int n = 0;

		try {
			con = pool.getConnection();

			String sql = "update pd set pdname = ?, price = ? where no = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, pdDto.getPdName());
			ps.setInt(2, pdDto.getPrice());
			ps.setInt(3, pdDto.getNo());

			n = ps.executeUpdate();

			System.out.println("상품 수정, n = " + n + ", 입력값 pdDto = " + pdDto);

		} finally {
			pool.dbClose(ps, con);
		}
		return n;
	}// updatePd

	public int deletePd(int no) throws SQLException {
		int n = 0;
		try {
			con = pool.getConnection();
			String sql = "delete from pd where no = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			n = ps.executeUpdate();
			System.out.println("상품 삭제 !, n = " + n + ", 입력값 no = " + no);
		} finally {
			pool.dbClose(ps, con);
		}
		return n;
	}//deletePd

}
