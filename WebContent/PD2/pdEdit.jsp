<%@page import="com.pd.Model.PdDAO"%>
<%@page import="com.pd.Model.PdDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String no = request.getParameter("no");
	if(no == null || no.isEmpty()){
		System.out.println("파라미터 no가 없습니다. 잘못된 url경로!");
		return;
	}
	
	PdDAO pdDao = new PdDAO();
	PdDTO dto = null;

	try {
		dto = pdDao.selectByNo(Integer.parseInt(no));
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<script type="text/javascript">
	function retrac(){
		history.back();
	} 

	function send(){
		var key = Number(document.edit.price.value);
		
		if(document.edit.pdName.value == ""){
			alert("상품명을 입력하세요.");
			document.edit.pdName.focus();
			return false;
		}else if(document.edit.price.value == ""){
			alert("가격을 입력하세요.");
			edit.price.focus();
			return false;
		}else if(isNaN(key) || key < 0){
			alert("가격을 다시 입력하세요.");
			edit.price.focus();
			return false;
		}
	}
	
</script>
</head>
<body>
	<h1>상품 등록</h1>
	<form name="edit" method="post" action="pdEdit_ok.jsp" onsubmit="return send()">
	<input type="hidden" name="no" value="<%=no%>">
		<table>
			<tr>
				<th>상품명</th>
				<td>
					<input type="text" name="pdName" value="<%=dto.getPdName()%>">
				</td>
			</tr>
			<tr>
				<th>가격</th>
				<td>
					<input type="text" name="price" value="<%=dto.getPrice()%>">
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" name="regit" value="등록">
					<button type="button" onclick="retrac()">취소</button>
				</th>
			</tr>
		</table>
		<br><br>
		<a href="pdList.jsp">상품 목록</a>
	</form>
</body>
</html>