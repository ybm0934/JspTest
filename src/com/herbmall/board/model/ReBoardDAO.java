package com.herbmall.board.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.mystudy.board.controller.ConnectionPoolMgr;

public class ReBoardDAO {

	private ConnectionPoolMgr pool;
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;

	public ReBoardDAO() {
		pool = new ConnectionPoolMgr();
	}

	public int insertReBoard(ReBoardVO vo) throws SQLException {
		int n = 0;
		try {
			con = pool.getConnection();

			String sql = "insert into reboard(no, name, pwd, title, email, content, groupno)"
					+ "values(reboard_seq.nextval, ?, ?, ?, ?, ?, reboard_seq.nextval)";
			ps = con.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getTitle());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getContent());

			n = ps.executeUpdate();
			System.out.println("게시판 글쓰기 n = " + n);
		} finally {
			pool.dbClose(ps, con);
		}

		return n;
	}// updateReBoard

	public List<ReBoardVO> selectAll(String category, String keyword) throws SQLException {
		List<ReBoardVO> list = new ArrayList<ReBoardVO>();

		try {
			con = pool.getConnection();

			String sql = "select * from reboard";
			if (keyword != null && !keyword.isEmpty()) {
				sql += " where " + category + " like '%" + keyword + "%'";
			}
			sql += " order by groupno desc, sortno asc";

			ps = con.prepareStatement(sql);

			rs = ps.executeQuery();

			while (rs.next()) {
				int no = rs.getInt("no");
				String name = rs.getString("name");
				String title = rs.getString("title");
				Timestamp regdate = rs.getTimestamp("regdate");
				int readcount = rs.getInt("readcount");
				int groupNo = rs.getInt("groupno");
				int step = rs.getInt("step");
				int sortNo = rs.getInt("sortno");
				String delFlag = rs.getString("delflag");

				ReBoardVO vo = new ReBoardVO();
				vo.setNo(no);
				vo.setName(name);
				vo.setTitle(title);
				vo.setRegdate(regdate);
				vo.setReadcount(readcount);
				vo.setGroupNo(groupNo);
				vo.setStep(step);
				vo.setSortNo(sortNo);
				vo.setDelFlag(delFlag);

				list.add(vo);
			}

			System.out.println("답글형 게시판 글 목록 조회!, list.size() = " + list.size());
			System.out.println("입력 값 category : " + category + ", keyword : " + keyword);

		} finally {
			pool.dbClose(rs, ps, con);
		}

		return list;
	}// selectAll

	public ReBoardVO selectByNo(int no) throws SQLException {
		ReBoardVO vo = new ReBoardVO();

		try {
			con = pool.getConnection();

			String sql = "select * from reboard where no = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);

			rs = ps.executeQuery();

			while (rs.next()) {
				String name = rs.getString("name");
				String pwd = rs.getString("pwd");
				String title = rs.getString("title");
				String email = rs.getString("email");
				Timestamp regdate = rs.getTimestamp("regdate");
				int readcount = rs.getInt("readcount");
				String content = rs.getString("content");
				int groupNo = rs.getInt("groupNo");
				int step = rs.getInt("step");
				int sortNo = rs.getInt("sortNo");
				String delFlag = rs.getString("delFlag");

				vo.setName(name);
				vo.setPwd(pwd);
				vo.setTitle(title);
				vo.setEmail(email);
				vo.setRegdate(regdate);
				vo.setReadcount(readcount);
				vo.setContent(content);
				vo.setGroupNo(groupNo);
				vo.setStep(step);
				vo.setSortNo(sortNo);
				vo.setDelFlag(delFlag);
			}

			System.out.println("reboard 상세 조회 입력값 no = " + no);
		} finally {
			pool.dbClose(rs, ps, con);
		}

		return vo;
	}// selectByNo

	public void deleteReboard(int no, int step, int groupNo) throws SQLException {
		CallableStatement cs = null;

		try {
			con = pool.getConnection();

			String sql = "{call deleteReboard(?,?,?)}";
			cs = con.prepareCall(sql);
			cs.setInt(1, no);
			cs.setInt(2, step);
			cs.setInt(3, groupNo);

			cs.execute();
			System.out.println("글 삭제, 입력값 no = " + no + ", groupNo = " + groupNo + ", step = " + step);
		} finally {
			pool.dbClose(cs, con);
		}
	}// deleteReboard

}
