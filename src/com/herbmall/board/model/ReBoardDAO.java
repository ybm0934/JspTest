package com.herbmall.board.model;

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

			String sql = "insert into reboard(no, name, pwd, title, email, content, groupno, ip, port, browser, filename, originalfilename, filesize)"
					+ "values(reboard_seq.nextval, ?, ?, ?, ?, ?, reboard_seq.nextval, ?, ?, ?, ?, ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getTitle());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getContent());
			ps.setString(6, vo.getIp());
			ps.setString(7, vo.getPort());
			ps.setString(8, vo.getBrowser());
			ps.setString(9, vo.getFileName());
			ps.setString(10, vo.getOriginalFileName());
			ps.setString(11, vo.getFileSize());

			n = ps.executeUpdate();
			System.out.println("게시판 글쓰기 n = " + n + "입력 값 vo = " + vo);

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
				String fileName = rs.getString("filename");
				String original = rs.getString("originalfilename");
				String fileSize = rs.getString("filesize");

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
				vo.setFileName(fileName);
				vo.setOriginalFileName(original);
				vo.setFileSize(fileSize);

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
				String fileName = rs.getString("filename");
				String original = rs.getString("originalfilename");
				String fileSize = rs.getString("filesize");
				int downCount = rs.getInt("downcount");

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
				vo.setFileName(fileName);
				vo.setOriginalFileName(original);
				vo.setFileSize(fileSize);
				vo.setDownCount(downCount);

			}

			System.out.println("reboard 상세 조회 입력값 no = " + no);
		} finally {
			pool.dbClose(rs, ps, con);
		}

		return vo;
	}// selectByNo

	public int updateReadCount(int no) throws SQLException {
		int n = 0;

		try {
			con = pool.getConnection();

			String sql = "update reboard set readcount = readcount + 1 where no = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);

			n = ps.executeUpdate();
			System.out.println("조회수 증가 입력값 no = " + no);
		} finally {
			pool.dbClose(ps, con);
		}

		return n;
	}// updateReadCount

	public int updateReboard(ReBoardVO vo) throws SQLException {
		int n = 0;

		try {
			con = pool.getConnection();

			String sql = "update reboard set name=?, pwd=?, title=?, email=?, content=?";
			if(vo.getFileName() != null && !vo.getFileName().isEmpty()) {
				sql += ", filename=?, originalfilename=?, filesize=?";
			}
			sql += " where no = ? and pwd = ?";
			
			ps = con.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getTitle());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getContent());
			if(vo.getFileName() != null && !vo.getFileName().isEmpty()) {
				ps.setString(6, vo.getFileName());
				ps.setString(7, vo.getOriginalFileName());
				ps.setString(8, vo.getFileSize());
				ps.setInt(9, vo.getNo());
				ps.setString(10, vo.getPwd());
			}else {
				ps.setInt(6, vo.getNo());
				ps.setString(7, vo.getPwd());
			}

			n = ps.executeUpdate();
			System.out.println("글 수정 결과 n = " + n);
			System.out.println("글 수정 입력값 vo = " + vo);
		} finally {
			pool.dbClose(ps, con);
		}

		return n;
	}// updateReboard

	// 답글까지 삭제하는 메서드
	public int deleteReboard(int no) throws SQLException {
		int cnt = 0;

		try {
			con = pool.getConnection();

			//String sql = "update reboard set delflag = 'Y' where no = ?";
			String sql = "delete from reboard where no = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);

			cnt = ps.executeUpdate();
			System.out.println("게시글 삭제 성공 cnt = " + cnt + ", 입력값 no = " + no);

		} finally {
			pool.dbClose(ps, con);
		}

		return cnt;
	}// deleteReboard

	// 답변 달기
	public int reply(ReBoardVO vo) throws SQLException {
		int n = 0;
		try {
			con = pool.getConnection();
			con.setAutoCommit(false); // 자동 커밋이 안 되게 막는다

			// insert 하기 전에 sortNo를 위한 자리 확보
			String sql = "update reboard" + " set sortno = sortno + 1" + " where groupno = ? and sortno > ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, vo.getGroupNo());
			ps.setInt(2, vo.getSortNo());
			n = ps.executeUpdate();

			// insert
			sql = "insert into reboard(no, name, pwd, title, email, content, groupNo, step, sortNo) "
					+ "values(reboard_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getTitle());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getContent());
			ps.setInt(6, vo.getGroupNo());
			ps.setInt(7, vo.getStep() + 1);
			ps.setInt(8, vo.getSortNo() + 1);

			n = ps.executeUpdate();
			System.out.println("답변형 게시판 글쓰기 성공 n = " + n);
			System.out.println("답변형 게시판 글쓰기 입력값 vo = " + vo);

			con.commit();

		} catch (SQLException e) {
			System.out.println("답변형 게시판 글쓰기 실패!");
			e.printStackTrace();
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				con.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}

			pool.dbClose(ps, con);
		}

		return n;
	}// reply

	public boolean checkPwd(int no, String pwd) throws SQLException {
		boolean result = false;

		try {
			con = pool.getConnection();

			String sql = "select pwd from reboard where no = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);

			rs = ps.executeQuery();
			if (rs.next()) {
				String dbPwd = rs.getString("pwd");
				if (dbPwd.equals(pwd)) {
					result = true;
				}
			}
			System.out.println("비밀번호 조회, result = " + result + ", 입력값 no = " + no + ", pwd = " + pwd);
		} finally {
			pool.dbClose(rs, ps, con);
		}

		return result;
	}// checkPwd
	
	public int updateDownCount(int no) throws SQLException {
		int n = 0;

		try {
			con = pool.getConnection();

			String sql = "update reboard set downcount = downcount + 1 where no = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);

			n = ps.executeUpdate();
			System.out.println("다운로드 결과 n = " + n + ", 입력 값 no = " + no);
		} finally {
			pool.dbClose(ps, con);
		}

		return n;
	}// updateDownCount

/*	
	public int fileUpload(String fileName, String original, String fileSize) throws SQLException {
		int n = 0;

		try {
			con = pool.getConnection();

			// insert가 무사히 성공해야 실행할 수 있음
			String sql = "update reboard set filename = ?, originalfilename = ?, filesize = ? where filename = ?";
			// where절에는 CLOB 타입이 들어갈 수 없다
			ps = con.prepareStatement(sql);
			ps.setString(1, fileName);
			ps.setString(2, original);
			ps.setString(3, fileSize);
			ps.setString(4, fileName); // 서버에 저장된 파일이름(중복 제거된 파일이름)이 같은 데이터를 불러오기

			n = ps.executeUpdate();
			System.out.println(
					"파일 업로드 값 fileName = " + fileName + ", original = " + original + ", fileSize = " + fileSize);
		} finally {
			pool.dbClose(ps, con);
		}

		return n;
	}// fileUpload

	
	// 허용되지 않은 확장자의 파일이 올라올 경우 글 삭제
	public int fileDelete(String fileName) throws SQLException {
		int n = 0;
		try {
			con = pool.getConnection();

			String sql = "delete from reboard where filename = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, fileName);

			n = ps.executeUpdate();
			System.out.println("허용되지 않은 확장자 파일 삭제 fileName = " + fileName);
		} finally {
			pool.dbClose(ps, con);
		}
		
		return n;
	}// fileDelete
*/

}
