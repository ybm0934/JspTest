<%@page import="com.pd.Model.PdDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	PdDTO dto = (PdDTO) request.getAttribute("dto");	
	DecimalFormat df = new DecimalFormat("#,###");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세보기</title>
<script type="text/javascript">
	function del(no){
		if(confirm("삭제하시겠습니까?")){
			location.href = "/pd/pdDelete.do?no=" + no;
		}
	}
</script>
</head>
<body>
	<h1>상품 상세보기</h1>
	<%=dto.getNo() %>을 클릭하였습니다.<br><br>
	번호 : <%=dto.getNo() %><br>
	상품명 : <%=dto.getPdName() %><br>
	가격 : <%=df.format(dto.getPrice()) %>원<br>
	등록일 : <%=dto.getRegdate() %><br><br>
	<a href="<%=request.getContextPath() %>/pd/pdList.do">목록</a>&nbsp;
	<a href="<%=request.getContextPath() %>/pd/pdEditForm.do?no=<%=dto.getNo() %>">수정</a>&nbsp;
	<a href="#" onclick="del(<%=dto.getNo() %>)">삭제</a>
</body>
</html>