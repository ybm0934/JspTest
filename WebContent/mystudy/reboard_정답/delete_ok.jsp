<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//delete.jsp에서 [삭제]버튼을 클릭하면 post방식으로 submit됨
	//=> 파라미터들을 읽어와서 글 삭제하기
	//1.
	//post
	request.setCharacterEncoding("utf-8");
	String no =request.getParameter("no");
	String pwd =request.getParameter("pwd");
	
	//2.
	ReBoardDAO dao = new ReBoardDAO();
	try{
		ReBoardVO vo = new ReBoardVO();
		vo.setNo(Integer.parseInt(no));
		vo.setPwd(pwd);
				
		int cnt = dao.deleteReBoard(vo);
		
		//3.
		if(cnt>0){ %>
			<script type="text/javascript">
				alert("글 삭제되었습니다.");
				location.href="list.jsp";
			</script>		
<%		}else{ %>
			<script type="text/javascript">
				alert("글 삭제 실패");
				history.go(-1);
			</script>		
<%		}
	}catch(SQLException e){
		e.printStackTrace();	
	}
	
	
%>