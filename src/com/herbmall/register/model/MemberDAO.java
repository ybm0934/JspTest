package com.herbmall.register.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.mystudy.board.controller.ConnectionPoolMgr;

public class MemberDAO {

	private ConnectionPoolMgr pool;
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;

	public static final int LOGIN_OK = 1;
	public static final int ID_NONE = 2;
	public static final int PWD_DISAGREE = 3;

	public MemberDAO() {
		pool = new ConnectionPoolMgr();
	}

	// 아이디 중복 확인
	public boolean checkUserid(String userid) throws SQLException {
		boolean exist = false;

		try {
			con = pool.getConnection();

			String sql = "select userid from member where userid = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, userid);

			rs = ps.executeQuery();

			if (rs.next()) {
				exist = true;
			}

			System.out.println("아이디 조회 exist = " + exist + ", userid = " + userid);
		} finally {
			pool.dbClose(rs, ps, con);
		}

		return exist;
	}// checkUserid

	public int insertMember(MemberVO vo) throws SQLException {
		int n = 0;

		try {
			con = pool.getConnection();

			String sql = "insert into member(no, userid, name, pwd, email, hp, gender, zipcode, address, addressdetail)"
					+ "values(member_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, vo.getUserid());
			ps.setString(2, vo.getName());
			ps.setString(3, vo.getPwd());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getHp());
			ps.setString(6, vo.getGender());
			ps.setString(7, vo.getZipcode());
			ps.setString(8, vo.getAddress());
			ps.setString(9, vo.getAddressDetail());

			n = ps.executeUpdate();

			System.out.println("회원 가입 vo = " + vo);
		} finally {
			pool.dbClose(ps, con);
		}

		return n;
	}// insertMember

	public int checkIdPwd(String userid, String pwd) throws SQLException {
		int result = 0;

		try {
			con = pool.getConnection();

			String sql = "select pwd from member where userid = ? and outdate is null";
			ps = con.prepareStatement(sql);
			ps.setString(1, userid);

			rs = ps.executeQuery();
			if (rs.next()) {
				String dbPwd = rs.getString("pwd");
				if (pwd.equals(dbPwd)) { // 비밀번호 일치
					result = LOGIN_OK;
				} else { // 비밀번호 불일치
					result = PWD_DISAGREE;
				}
			} else { // 해당 아이디가 없는 경우
				result = ID_NONE;
			}

			System.out.println("아이디 비번 체크 result = " + result + ", userid = " + userid + ", pwd = " + pwd);
		} finally {
			pool.dbClose(rs, ps, con);
		}

		return result;
	}// checkIdPwd

	public MemberVO selectMember(String userid) throws SQLException {
		MemberVO vo = new MemberVO();

		try {
			con = pool.getConnection();
			String sql = "select * from member where userid = ? and outdate is null";
			ps = con.prepareStatement(sql);
			ps.setString(1, userid);

			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setNo(rs.getInt("no"));
				vo.setUserid(rs.getString("userid"));
				vo.setName(rs.getString("name"));
				vo.setPwd(rs.getString("pwd"));
				vo.setEmail(rs.getString("email"));
				vo.setHp(rs.getString("hp"));
				vo.setGender(rs.getString("gender"));
				vo.setZipcode(rs.getString("zipcode"));
				vo.setAddress(rs.getString("address"));
				vo.setAddressDetail(rs.getString("addressdetail"));
				vo.setRegdate(rs.getTimestamp("regdate"));
				vo.setMileage(rs.getInt("mileage"));
				vo.setAuthCode(rs.getString("authcode"));
			}

			System.out.println("회원 조회 vo = " + vo + ", userid = " + userid);

		} finally {
			pool.dbClose(rs, ps, con);
		}

		return vo;
	}// selectMember

	public List<ZipcodeVO> selectZipcode(String dong) throws SQLException {
		List<ZipcodeVO> list = new ArrayList<ZipcodeVO>();

		try {
			con = pool.getConnection();

			String sql = "select * from zipcode";
			if(dong != null && !dong.isEmpty()) {
				sql += " where dong like '%" + dong + "%'";
			}
			sql += " order by seq asc";
			ps = con.prepareStatement(sql);

			rs = ps.executeQuery();
			while (rs.next()) {
				int seq = rs.getInt("seq");
				String zipcode = rs.getString("zipcode");
				String sido = rs.getString("sido");
				String gugun = rs.getString("gugun");
				dong = rs.getString("dong");
				String startbunji = rs.getString("startbunji");
				String endbunji = rs.getString("endbunji");

				ZipcodeVO vo = new ZipcodeVO();
				vo.setSeq(seq);
				vo.setZipcode(zipcode);
				vo.setSido(sido);
				vo.setGugun(gugun);
				vo.setDong(dong);
				vo.setStartbunji(startbunji);
				vo.setEndbunji(endbunji);

				list.add(vo);
			}

			System.out.println("우편번호 불러오기 list.size() = " + list.size() + ", dong = " + dong);

		} finally {
			pool.dbClose(rs, ps, con);
		}

		return list;
	}// selectZipcode

}
