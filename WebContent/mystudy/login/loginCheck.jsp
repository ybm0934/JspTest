<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인이 되지 않은 경우 에러 처리
	String s_userid = (String) session.getAttribute("id");
	String s_ctxPath = request.getContextPath();	//-> /mystudy
	
	//로그인이 안 된 경우
	if(s_userid == null || s_userid.isEmpty()){
%>
	<script type="text/javascript">
		alert("먼저 로그인하세요.");
		location.href="<%=s_ctxPath %>/mystudy/main.jsp";
	</script>
<%	
		return;
	}
%>