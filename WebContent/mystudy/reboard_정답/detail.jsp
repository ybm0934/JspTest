<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	//list.jsp에서 [제목]을 클릭하면 get방식으로 이동
	//=> http://localhost:9090/herbmall/reBoard/detail.jsp?no=4
	//=> 파라미터를 읽어와서 파라미터인 no에 해당하는 글을 조회해서 화면 출력
	//1. 요청 파라미터 읽어오기
	String no =request.getParameter("no");
	if(no==null || no.isEmpty()){%>
		<script type="text/javascript">
			alert('잘못된 url입니다.');
			location.href="list.jsp";
		</script>	
<%
		return;
	}
	  
	//2. db작업 -select
	ReBoardDAO dao=new ReBoardDAO();
	ReBoardVO vo=null;
	try{
		vo=dao.selectByNo(Integer.parseInt(no));	
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3.결과 처리
	String content=vo.getContent();	
	if(content!=null && !content.isEmpty()){
		//  "\r\n"	=> <br>
		//public String replace(CharSequence target, CharSequence replacement)
		content=content.replace("\r\n", "<br>");
	}else{
		content="";
	}
	
%>    
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>자유게시판 상세보기 - 허브몰</title>
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<link rel="stylesheet" type="text/css" href="../css/clear.css" />
<link rel="stylesheet" type="text/css" href="../css/formLayout.css" />
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<style type="text/css">
	body{
		padding:5px;
		margin:5px;
	 }
	.divForm {
		width: 500px;
		}
</style>  
</head>
<body>
	<h2>글 상세보기</h2>
	<div class="divForm">
		<div class="firstDiv">
			<span class="sp1">제목</span> <span><%=vo.getTitle() %></span>
		</div>
		<div>
			<span class="sp1">작성자</span> <span><%=vo.getName() %></span>
		</div>
		<div>
			<span class="sp1">등록일</span> <span><%=vo.getRegdate() %></span>
		</div>
		<div>
			<span class="sp1">조회수</span> <span><%=vo.getReadcount() %></span>
		</div>
		<div class="lastDiv">			
			<p class="content"><%=content%></p>
		</div>
		<div class="center">
			<a href='edit.jsp?no=<%=no%>'>수정</a> |
        	<a href='delete.jsp?no=<%=no%>'>삭제</a> |
        	<a href='list.jsp'>목록</a>			
		</div>
	</div>

	
</body>
</html>


