<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//list.jsp에서 [제목]을 클릭하면 get방식으로 이동
	//=> http://localhost:9090/herbmall/reBoard/countUpdate.jsp?no=4
	//=> 파라미터를 읽어와서 파라미터인 no에 해당하는 글의 조회수를 증가시킨다
	//1. 요청 파라미터 읽어오기
	String no =request.getParameter("no");
	
	//2. db작업 - update
	ReBoardDAO dao = new ReBoardDAO();
	try{
		int cnt = dao.updateReadCount(Integer.parseInt(no));
		//3. 결과 처리
		if(cnt>0){
			response.sendRedirect("detail.jsp?no="+no);
		}else{%>
			<script type="text/javascript">
				alert("조회수 증가 실패!");
				history.back();
			</script>		
<%		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	
	
	
%>