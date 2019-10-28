package com.mystudy.board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.mystudy.board.controller.ConnectionPoolMgr;

public class BoardDAO {
	private ConnectionPoolMgr pool;
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;

	public BoardDAO() {
		pool = new ConnectionPoolMgr();
	}

	public int insertBoard(BoardVO boardVo) throws SQLException {
		int n = 0;

		try {
			con = pool.getConnection();

			String sql = "insert into board(no, name, pwd, title, email, content)"
					+ "values(board_seq.nextval, ?, ?, ?, ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, boardVo.getName());
			ps.setString(2, boardVo.getPwd());
			ps.setString(3, boardVo.getTitle());
			ps.setString(4, boardVo.getEmail());
			ps.setString(5, boardVo.getContent());

			n = ps.executeUpdate();
			System.out.println("insertBoard 결과 n = " + n + ", 입력값 boardVo = " + boardVo);
		} finally {
			pool.dbClose(ps, con);
		}

		return n;
	}// insertBoard

	public List<BoardVO> selectAll(String category, String keyword) throws SQLException {
		List<BoardVO> list = new ArrayList<BoardVO>();

		try {
			con = pool.getConnection();

			String sql = "select * from board";
			if (keyword != null && !keyword.isEmpty()) {
				sql += " where " + category + " like '%" + keyword + "%'";
			}
			sql += " order by no desc";

			ps = con.prepareStatement(sql);

			rs = ps.executeQuery();

			while (rs.next()) {
				int no = rs.getInt("no");
				String name = rs.getString("name");
				String pwd = rs.getString("pwd");
				String title = rs.getString("title");
				String email = rs.getString("email");
				Timestamp regdate = rs.getTimestamp("regdate");
				int readcount = rs.getInt("readcount");
				String content = rs.getString("content");

				BoardVO boardVo = new BoardVO();
				boardVo.setNo(no);
				boardVo.setName(name);
				boardVo.setPwd(pwd);
				boardVo.setTitle(title);
				boardVo.setEmail(email);
				boardVo.setRegdate(regdate);
				boardVo.setReadcount(readcount);
				boardVo.setContent(content);

				list.add(boardVo);
				System.out.println("selectAll 결과 list.size() = " + list.size() + ", 입력값 category = " + category
						+ ", keyword = " + keyword);
			}
		} finally {
			pool.dbClose(rs, ps, con);
		}

		return list;
	}// selectAll
}
