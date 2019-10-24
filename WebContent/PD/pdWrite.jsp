<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<script type="text/javascript">
	function send(){
		var key = Number(document.write.price.value);
		
		if(document.write.pdName.value == ""){
			alert("상품명을 입력하세요.");
			document.write.pdName.focus();
			return false;
		}else if(document.write.price.value == ""){
			alert("가격을 입력하세요.");
			write.price.focus();
			return false;
		}else if(isNaN(key) || key < 0){
			alert("가격을 다시 입력하세요.");
			write.price.focus();
			return false;
		}
	}
</script>
</head>
<body>
	<h1>상품 등록</h1>
	<form name="write" method="post" action="pdWrite_ok.jsp" onsubmit="return send()">
		<table>
			<tr>
				<th>상품명</th>
				<td>
					<input type="text" name="pdName">
				</td>
			</tr>
			<tr>
				<th>가격</th>
				<td>
					<input type="text" name="price">
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" name="regit" value="등록">
					<input type="reset" name="reset" value="취소">
				</th>
			</tr>
		</table>
		<br><br>
		<a href="pdList.jsp">상품 목록</a>
	</form>
</body>
</html>