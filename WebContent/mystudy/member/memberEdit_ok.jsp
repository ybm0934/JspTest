<%@page import="com.herbmall.register.model.MemberService"%>
<%@page import="com.herbmall.register.model.MemberDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.register.model.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String name = request.getParameter("name");
	String userid = (String) session.getAttribute("id");
	String pwd = request.getParameter("password2");
	String gender = request.getParameter("gender");
	String zipcode = request.getParameter("address1");
	String address = request.getParameter("address2");
	String addressDetail = request.getParameter("address3");
	String hp1 = request.getParameter("phone1");
	String hp2 = request.getParameter("phone2");
	String hp3 = request.getParameter("phone3");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String email3 = request.getParameter("email3");
	
	String hp = "", email = "";
	if(hp2 != null && !hp2.isEmpty() && hp3 != null && !hp3.isEmpty()){
		hp = hp1 + "-" + hp2 + "-" + hp3;		
	}
	
	if(email1 != null && !email1.isEmpty()){
		if(email2.equals("etc")){
			if(email3 != null && !email3.isEmpty()){
				email = email1 + "@" + email3;
			}
		}else {
			email = email1 + "@" + email2;
		}
	}
	
	MemberVO vo = new MemberVO();
	
	vo.setName(name);
	vo.setUserid(userid);
	vo.setPwd(pwd);
	vo.setGender(gender);
	vo.setZipcode(zipcode);
	vo.setAddress(address);
	vo.setAddressDetail(addressDetail);
	vo.setHp(hp);
	vo.setEmail(email);
	
	MemberService service = new MemberService();
	
	String msg = "", url = "memberEdit.jsp";
	try{
		int result = service.checkIdPwd(userid, pwd);
		if(result == MemberService.LOGIN_OK){
			int n = service.updateMember(vo);
			if(n > 0){
				msg = "회원정보 수정 완료!";
				url = "../main.jsp";
			}else {
				msg = "회원정보 수정 실패!";
			}
		}else if(result == MemberService.PASSWORD_DISAGREE){
			msg = "비밀번호가 일치하지 않습니다.";
			
		}else {
			msg = "비밀번호 체크 실패!";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>