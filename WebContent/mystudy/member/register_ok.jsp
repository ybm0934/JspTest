<%@page import="com.herbmall.register.model.MemberVO"%>
<%@page import="com.herbmall.register.model.MemberDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String userid = request.getParameter("id");
	String pwd = request.getParameter("password2");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String address3 = request.getParameter("address3");
	String hp1 = request.getParameter("phone1");
	String hp2 = request.getParameter("phone2");
	String hp3 = request.getParameter("phone3");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String email3 = request.getParameter("email3");

	String hp = "";
	String email = "";

	//휴대폰을 입력한 경우에만 처리되도록
	if (hp2 != null && !hp2.isEmpty() && hp3 != null && !hp3.isEmpty()) {
		hp = hp1 + "-" + hp2 + "-" + hp3;
	}

	//이메일이 입력된 경우에만 처리되도록, 직접 입력인 경우에는 email3의 값을 연결시킨다
	if (email1 != null && !email1.isEmpty()) {
		if (email2.equals("etc")) {
			if (email3 != null && !email3.isEmpty()) {
				email = email1 + "@" + email3;
			}
		} else {
			email = email1 + "@" + email2;
		}
	}//if
	
	MemberDAO dao = new MemberDAO();
	MemberVO vo = new MemberVO();
	
	vo.setUserid(userid);
	vo.setName(name);
	vo.setPwd(pwd);
	vo.setEmail(email);
	vo.setHp(hp);
	vo.setGender(gender);
	vo.setGender(gender);
	vo.setZipcode(address1);
	vo.setAddress(address2);
	vo.setAddressDetail(address3);
	
	String msg = "", url = "";
	try{
		int n = dao.insertMember(vo);
		if(n > 0){
			msg = "회원가입 성공!";
			url = "../login.jsp";
		}else{
			msg = "회원가입 실패!";
			url = "register.jsp";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>