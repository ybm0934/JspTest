<%@page import="com.herbmall.register.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@ include file="../login/loginCheck.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String userid = (String) session.getAttribute("id");
	String pwd = request.getParameter("pwd");

	MemberService service = new MemberService();

	String msg = "", url = "memberOut.jsp";
	try {
		int n = service.checkIdPwd(userid, pwd);

		if (n == MemberService.LOGIN_OK) {
			int cnt = service.withdrawMember(userid);
			if (cnt > 0) {
				session.invalidate();

				msg = "회원 탈퇴 성공";
				url = "../main.jsp";
			} else {
				msg = "회원 탈퇴 실패!";
			}

		} else if (n == MemberService.PASSWORD_DISAGREE) {
			msg = "비밀번호가 틀립니다.";
		} else {
			msg = "비밀번호 체크 실패!";
		}

	} catch (SQLException e) {
		e.printStackTrace();
	}

	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>