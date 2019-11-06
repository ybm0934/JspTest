<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.register.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String userid = request.getParameter("userid");
	String pwd = request.getParameter("pwd");

	MemberDAO dao = new MemberDAO();

	int n = 0;
	String msg = "", url = "../main.jsp";
	try {
		n = dao.checkIdPwd(userid, pwd);
		System.out.println("로그인 결과 n = " + n);

		if (n == 1) {
			msg = "로그인 성공!";

			session.setAttribute("id", userid); //세션 설정
			session.setMaxInactiveInterval(10); //세션 시간 10초
			
			//Cookie ck = new Cookie("id", userid);	//쿠키 설정
			//ck.setMaxAge(10);	//쿠키 시간 10초
			//response.addCookie(ck);
			

		} else if (n == 2) {
			msg = "아이디가 존재하지 않습니다.";
		} else if (n == 3) {
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