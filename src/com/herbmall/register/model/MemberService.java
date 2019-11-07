package com.herbmall.register.model;

import java.sql.SQLException;
import java.util.List;

public class MemberService {
	private MemberDAO dao;
	
	//로그인 관련 상수
	public static final int LOGIN_OK = 1;	//로그인 성공
	public static final int ID_NONE = 2;	//아이디가 없음
	public static final int PASSWORD_DISAGREE = 3;	//비밀번호 불일치
	
	public MemberService() {
		dao = new MemberDAO();
	}
	
	public boolean checkUserid(String userid) throws SQLException {
		return dao.checkUserid(userid);
	}
	
	public int insertMember(MemberVO vo) throws SQLException {
		return dao.insertMember(vo);
	}
	
	public int checkIdPwd(String userid, String pwd) throws SQLException {
		return dao.checkIdPwd(userid, pwd);
	}
	
	public MemberVO selectMember(String userid) throws SQLException {
		return dao.selectMember(userid);
	}
	
	public List<ZipcodeVO> selectZipcode(String dong) throws SQLException {
		return dao.selectZipcode(dong);
	}

}
