<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//edit.jsp에서 [수정]버튼을 클릭하면 post방식으로 submit됨
	//=> 요청 파라미터들을 읽어서 reBoard 테이블에 update하기
	
	//1. 요청 파라미터 읽어오기
	//post-요청 파라미터에 대한 한글 인코딩 처리
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String title = request.getParameter("title");
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");
	String email = request.getParameter("email");
	String content = request.getParameter("content");
	
	//2. db작업 - insert
	ReBoardDAO dao = new ReBoardDAO();
	try{
		ReBoardVO vo = new ReBoardVO();
		vo.setContent(content);
		vo.setEmail(email);
		vo.setName(name);
		vo.setPwd(pwd);
		vo.setTitle(title);
		vo.setNo(Integer.parseInt(no));
		int cnt = dao.updateReboard(vo);
		
		//3. 결과 처리
		if(cnt>0){ %>
			<script type="text/javascript">
				alert("글수정 처리되었습니다.");
				location.href="detail.jsp?no=<%=no%>";
			</script>
	<%  }else{  %>
			<script type="text/javascript">
				alert("글수정 처리 실패!");
				history.back();
			</script>
	<%  }
	}catch(SQLException e){
		e.printStackTrace();
	}
	
%>






