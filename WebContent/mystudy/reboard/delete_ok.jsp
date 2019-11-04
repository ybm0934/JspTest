<%@page import="java.io.File"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int no = Integer.parseInt(request.getParameter("no"));
	String pwd = request.getParameter("pwd");
	String fileName = request.getParameter("fileName");

	ReBoardDAO dao = new ReBoardDAO();
	int result = 0;
	try {
		if(dao.checkPwd(no, pwd)){
			result = dao.deleteReboard(no);
			if(result > 0){
				//파일관련 처리
				String path = "D:\\Workspace-java\\ex\\WebContent\\mystudy\\upload";
				File file = new File(path, fileName);
				//기존 파일이 있으면 파일 삭제
				if(file.exists()){
					file.delete();
				}
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