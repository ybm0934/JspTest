<%@page import="java.util.ArrayList"%>
<%@page import="com.herbmall.register.model.MemberDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.register.model.ZipcodeVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String dong = request.getParameter("dong");

	if (dong == null) dong = "";

	MemberDAO dao = new MemberDAO();
	List<ZipcodeVO> list = new ArrayList<ZipcodeVO>();
	
	try {
		if (dong != null && !dong.isEmpty()) {
			list = dao.selectZipcode(dong);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
	//페이징 처리
	String sCurPage = request.getParameter("currentPage");
	System.out.println("sCurPage = " + sCurPage);
	
	int currentPage = 1;
	if(sCurPage != null && !sCurPage.isEmpty()){
		currentPage = Integer.parseInt(sCurPage);
	}
	
	int totalRecord = list.size();
	int pageSize = 5;
	int totalPage = (int) Math.ceil((double) totalRecord / pageSize);
	int blockSize = 10;
	int firstPage = currentPage - ((currentPage - 1) % blockSize);
	int lastPage = firstPage + (blockSize - 1);
	int curPos = (currentPage - 1) * pageSize;
	int num = totalRecord - curPos;
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우편번호 찾기</title>
<style type="text/css">
.zipcode_tbl {
	border-collapse: collapse;
}

.zipcode_tbl th, .zipcode_tbl td {
	border: 1px solid gray;
	padding: 10px;
}

.zipcode_tbl th {
	background: gainsboro;
}

.zipcode_tbl td a {
	text-decoration: none;
	color: gray;
}

.zipcode_tbl td a:hover {
	color: black;
	text-decoration: underline;
}

.zip_page {
	width: 470px;
	text-align: center;
	margin-top: 18px;
}

.zip_page_a {
	text-decoration: none;
	color: gray;
	padding: 5px;
}

.zip_page_a:hover {
	font-weight: bold;
}
</style>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#dong").focus();
		$("form[name=frmZipcode]").submit(function(){
			if($("#dong").val().length < 1){
				alert("동을 입력하세요.");
				$("#dong").focus();
				return false;
			}
		});
	});
	
	//부모창(회원가입 창)에 우편번호, 주소값 넣기
	function setZipcode(address, zipcode){
		opener.reg_form.address1.value = zipcode;
		opener.reg_form.address2.value = address;
		self.close();
	}
</script>
</head>
<body>
<h2>우편번호 검색</h2><br>
	<p>찾고 싶으신 주소의 동(읍/면)을 입력하세요</p>
	<form name="frmZipcode" method="post" action="zipcode.jsp">
		<label for="dong">지역명 : </label>
		<input type="text" name="dong" id="dong" style="ime-mode: active">
		<!-- ime-mode:active는 기본으로 한글모드(한/영 변경 방지용). IE에서만 작동 -->
		<input type="submit" id="submit_btn" value="찾기">
	</form>
	<br>
	<table style="width: 470px" class="zipcode_tbl" summary="우편번호 검색 결과에 관한 표로써, 우편번호, 주소에 대한 정보를 제공합니다.">
		<colgroup>
			<col style="width: 20%;" />
			<col style="width: *;" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">우편번호</th>
				<th scope="col">주소</th>
			</tr>
		</thead>
		<tbody>
			<% if(list == null || list.isEmpty()){ %>
			<tr>
				<td colspan="2" style="text-align: center">해당하는 주소가 없습니다.</td>
			</tr>
			<% }else { %>
				<%	for(int i = 0; i < pageSize; i++){
						if(num-- < 1) break;
						
						ZipcodeVO vo = list.get(curPos++);
						String address = vo.getSido() + " " + vo.getGugun() + " " + vo.getDong();
						String sbunji = vo.getStartbunji();
						String ebunji = vo.getEndbunji();
						
						if(sbunji == null) sbunji = "";
						
						String bunji = "";
						if(ebunji != null && !ebunji.isEmpty()){
							bunji = sbunji + " ~ " + ebunji;
						}else {
							bunji = sbunji;
						}//if
						
						String zipcode = vo.getZipcode();	%>
				<tr>
					<td style="text-align: center;"><a href="#" onclick="setZipcode('<%=address %>','<%=zipcode %>')"><%=zipcode %></a></td>
					<td><a href="#" onclick="setZipcode('<%=address %>','<%=zipcode %>')"><%=address %> <%=bunji %></a></td>
				</tr>
				<%	}//for %>
			<% }//if %>
		</tbody>
	</table>
	<div class="zip_page">
	<% if(firstPage > 1){ %>
		<a href="zipcode.jsp?currentPage=<%=firstPage-1 %>&dong=<%=dong %>"><img alt="이전블록으로 이동" src="../images/first.JPG"></a>
	<% } %>
		<%	for(int i = firstPage; i <= lastPage; i++){
				if(i > totalPage) break;
				
				if(i == currentPage){	%>
				<span style="font-weight: bold; color: red; padding: 5px;"><%=i %></span>
			<%	}else { %>
				<a href="zipcode.jsp?currentPage=<%=i %>&dong=<%=dong %>" class="zip_page_a"><%=i %></a>
			<%	}//if %>
		<%	}//for %>
	<% if(lastPage < totalPage){ %>
		<a href="zipcode.jsp?currentPage=<%=lastPage+1 %>&dong=<%=dong %>"><img alt="다음블록으로 이동" src="../images/last.JPG"></a>
	<% } %>
	</div>
</body>
</html>