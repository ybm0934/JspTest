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
	request.setCharacterEncoding("UTF-8");
	int no = Integer.parseInt(request.getParameter("no"));
	String pwd = request.getParameter("pwd");

	ReBoardDAO dao = new ReBoardDAO();
	int result = 0;
	try {
		if(dao.checkPwd(no, pwd)){
			result = dao.deleteReboard(no);
			if(result > 0){
%>
			<script>
				alert("글 삭제 성공!");
				location.href="list.jsp";
			</script>
<%			}else {	%>
			<script>
				alert("글 삭제 실패!");
				history.back();
			</script>
<%			}
		}else{	%>
			<script>
				alert("비밀번호가 일치하지 않습니다!");
				history.back();
			</script>
<%		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>