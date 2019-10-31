<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String title = request.getParameter("title");
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");
	String email = request.getParameter("email");
	String content = request.getParameter("content");
	
	//답변형에 필요한 정보 hidden 필드 값
	String groupNo = request.getParameter("groupNo");
	String step = request.getParameter("step");
	String sortNo = request.getParameter("sortNo");
	
	ReBoardVO vo = new ReBoardVO();
	vo.setContent(content);
	vo.setEmail(email);
	vo.setName(name);
	vo.setPwd(pwd);
	vo.setTitle(title);
	vo.setGroupNo(Integer.parseInt(groupNo));
	vo.setStep(Integer.parseInt(step));
	vo.setSortNo(Integer.parseInt(sortNo));
	
	ReBoardDAO dao = new ReBoardDAO();
	try{
		int n = dao.reply(vo);
		if(n > 0){
%>			
		<script>
			alert("답변달기 성공");
			location.href="list.jsp";
		</script>
<%			
		}else{
%>
		<script>
			alert("답변달기 실패");
			history.back();
		</script>
<%			
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
%>