package com.mystudy.board.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
			System.out.println("insertBoard 결과 n = " + n);
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
				String title = rs.getString("title");
				String name = rs.getString("name");
				Timestamp regdate = rs.getTimestamp("regdate");
				int readcount = rs.getInt("readcount");

				BoardVO vo = new BoardVO();
				vo.setNo(no);
				vo.setTitle(title);
				vo.setName(name);
				vo.setRegdate(regdate);
				vo.setReadcount(readcount);

				list.add(vo);
				System.out.println("글 목록 조회 list.size() = " + list.size() + ", 입력값 category = " + category
						+ ", keyword = " + keyword);
			}

		} finally {
			pool.dbClose(rs, ps, con);
		}

		return list;
	}// selectAll

	public int count() throws SQLException {
		int cnt = 0;
		try {
			con = pool.getConnection();

			String sql = "select count(*) as count from board";
			ps = con.prepareStatement(sql);

			rs = ps.executeQuery();
			while (rs.next()) {
				cnt = rs.getInt("count");
			}

			System.out.println("레코드 갯수 조회 cnt = " + cnt);

		} finally {
			pool.dbClose(rs, ps, con);
		}

		return cnt;
	}

	public BoardVO selectByNo(int no) throws SQLException {
		BoardVO vo = new BoardVO();

		try {
			con = pool.getConnection();

			String sql = "select * from board where no = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);

			rs = ps.executeQuery();

			while (rs.next()) {
				String title = rs.getString("title");
				String name = rs.getString("name");
				String email = rs.getString("email");
				Timestamp regdate = rs.getTimestamp("regdate");
				int readcount = rs.getInt("readcount");
				String content = rs.getString("content");

				vo.setTitle(title);
				vo.setName(name);
				vo.setEmail(email);
				vo.setRegdate(regdate);
				vo.setReadcount(readcount);
				vo.setContent(content);
			}

			System.out.println("글 상세보기, 입력값 no = " + no);
		} finally {
			pool.dbClose(rs, ps, con);
		}

		return vo;
	}// selectByNo

	public int updateBoard(BoardVO vo) throws SQLException {
		int n = 0;
		try {
			con = pool.getConnection();

			String sql = "update board set name = ?, pwd = ?, title = ?, email = ?, content = ? where no = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getTitle());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getContent());
			ps.setInt(6, vo.getNo());

			n = ps.executeUpdate();
			System.out.println("글 수정 성공 n = " + n);
		} finally {
			pool.dbClose(ps, con);
		}

		return n;
	}// updateBoard

	public int updateReadCount(int no) throws SQLException {
		int n = 0;
		try {
			con = pool.getConnection();

			String sql = "update board set readcount = readcount + 1 where no = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);

			n = ps.executeUpdate();
			System.out.println("조회수 증가 성공, n = " + n);
		} finally {
			pool.dbClose(ps, con);
		}

		return n;
	}// updateReadCount

	public int deleteBoard(int no, String pwd) throws SQLException {
		int n = 0;

		try {
			con = pool.getConnection();

			String sql = "delete from board where no = ? and pwd = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			ps.setString(2, pwd);

			n = ps.executeUpdate();
			System.out.println("게시글 삭제 결과 n = " + n + "입력값 no = " + no + ", pwd = " + pwd);

		} finally {
			pool.dbClose(ps, con);
		}

		return n;
	}// deleteBoard

	public int pwdCheck(int no, String pwd) throws SQLException {
		int n = 0;
		
		try {
			con = pool.getConnection();

			String sql = "select * from board where no = ? and pwd = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			ps.setString(2, pwd);

			rs = ps.executeQuery();

			

			System.out.println("글 상세보기, 입력값 no = " + no + ", pwd = " + pwd);

		} finally {
			pool.dbClose(ps, con);
		}
		
		return n;

	}// pwdCheck
/*	
	public void pwdCheck(HttpServletResponse response, int no, String pwd) throws SQLException {
		try {
			con = pool.getConnection();
			
			String sql = "select pwd from board where no = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			
			rs = ps.executeQuery();
			
			while (rs.next()) {
				String corPwd = rs.getString("pwd");
				PrintWriter out = response.getWriter();
				if (pwd.equals(corPwd)) {
					response.sendRedirect("edit.jsp?no=" + no);
					System.out.println("비밀번호 확인 성공");
				} else {
					response.setContentType("text/html; charset=UTF-8");
					out.println("<script>");
					out.println("alert('비밀번호가 틀립니다.');");
					out.println("history.back();");
					out.println("</script>");
					
					System.out.println("비밀번호 확인 실패");
				}
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			pool.dbClose(ps, con);
		}
		
	}// pwdCheck
*/
}
