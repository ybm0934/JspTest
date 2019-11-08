<%@page import="com.herbmall.register.model.MemberVO"%>
<%@page import="com.herbmall.register.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.register.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String userid = request.getParameter("userid");
	String pwd = request.getParameter("pwd");
	String chkSave = request.getParameter("chkSave");
	
	MemberDAO dao = new MemberDAO();
	MemberService service = new MemberService();

	int n = 0;
	String msg = "", url = "../main.jsp";
	try {
		n = dao.checkIdPwd(userid, pwd);
		System.out.println("로그인 결과 n = " + n);
		
		if (n == MemberDAO.LOGIN_OK) {
			MemberVO vo = service.selectMember(userid);
			
			msg = vo.getName() + "님 로그인 되었습니다.";

			//세션에 로그인 정보를 저장한다
			session.setAttribute("id", userid); //세션 설정
			session.setAttribute("authCode", vo.getAuthCode());
			session.setAttribute("userName", vo.getName());
			session.setMaxInactiveInterval(5 * 60); //세션 시간 5분
			
			//아이디 저장하기 체크 된 경우 쿠키에 저장
			if(chkSave != null){
				//체크하면 on, 체크 안하면 null
				Cookie ck = new Cookie("ckUserid", userid);	//쿠키 설정
				ck.setPath("/"); //경로 설정(모든 경로에서 접근 가능하게)
				ck.setMaxAge(1 * 24 * 60 * 60);	//쿠키 시간 1일
				response.addCookie(ck);
			}else {	//체크하지 않은 경우 기존 쿠키 제거
				Cookie ck = new Cookie("ckUserid", userid);
				ck.setPath("/");
				ck.setMaxAge(0);
				response.addCookie(ck);
			}

		} else if (n == MemberDAO.ID_NONE) {
			msg = "아이디가 존재하지 않습니다.";
		} else if (n == MemberDAO.PWD_DISAGREE) {
			msg = "비밀번호가 틀립니다!";
		} else {
			msg = "로그인 실패 error!";
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}

	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>