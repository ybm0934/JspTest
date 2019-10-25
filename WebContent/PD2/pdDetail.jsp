<%@page import="com.pd.Model.PdDAO"%>
<%@page import="com.pd.Model.PdDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String no = request.getParameter("no");
	if (no == null || no.isEmpty()) {
		System.out.println("파라미터인 no가 없습니다. 잘못된 url경로!");
		return;
	}

	DecimalFormat df = new DecimalFormat("#,###");

	PdDAO pdDao = new PdDAO();
	PdDTO dto = null;

	try {
		dto = pdDao.selectByNo(Integer.parseInt(no));
	} catch (SQLException e) {
		System.out.println("상품 상세보기, sql error : " + e);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세보기</title>
<script type="text/javascript">
	function del(no){
		var del = confirm("삭제하시겠습니까?");
		if(del){
			location.href="pdDelete_ok.jsp?no=" + no;
		}
	}
</script>
</head>
<body>
	<h1>상품 상세보기</h1>
	<%=no%>을 클릭하였습니다.
	<br>
	<br> 번호 :
	<%=no%><br> 상품명 :
	<%=dto.getPdName()%><br> 가격 :
	<%=df.format(dto.getPrice())%>원
	<br> 등록일 :
	<%=dto.getRegdate()%><br>
	<br>
	<a href="pdList.jsp">목록</a>&nbsp;
	<a href="pdEdit.jsp?no=<%=no%>">수정</a>&nbsp;
	<a href="#" onclick="del(<%=no%>)">삭제</a>
</body>
</html>