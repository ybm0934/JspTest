<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL 테스트</title>
</head>
<body>
<h1>JSTL 테스트입니다.</h1>
<c:set var="browser" value="${header['user-agent'] }"/>
<h3>el 표현식 이용</h3>
브라우저 정보 : ${browser }<br>

<h3>JSTL 이용</h3>
브라우저 정보 : <c:out value="${browser }"/>

<h3>browser 변수 제거 후</h3>
<c:remove var="browser"/>
브라우저 정보 : <c:out value="${browser }"/>

<c:set var="country" value="korea"/>
<h3>if 이용</h3>
<c:if test="${!empty country }">
	${country }에서 살아요.
</c:if>
<c:if test="${empty country }">
	변수에 값이 없습니다.
</c:if>
<h3>choose 이용</h3>
<c:choose>
	<c:when test="${country == 'korea' }">
		${country }(한국)에서 살아요
	</c:when>
	<c:when test="${country == 'canada' }">
		${country }(캐나다)에서 살아요
	</c:when>
	<c:otherwise>
		그 외의 나라에서 살아요
	</c:otherwise>
</c:choose>
<h3>forEach 이용</h3>
<c:forEach begin="2" end="9" var="i">
	<c:forEach begin="1" end="9" var="j">
		<c:out value="${i}"/> * <c:out value="${j}"/> = 
		<c:out value="${i * j }"/><br>
	</c:forEach><br>
</c:forEach>
<h3>forEach 이용2</h3>
<c:set var="sum" value="0"/>
<c:set var="totalPrice" value="25000"/>
<c:set var="delivery" value="0"/>
<c:if test="${totalPrice < 30000 }">
	totalPrice = <c:out value="${totalPrice}"/><br>
	delivery = ${delivery = 3000}<br>
	sum = ${sum = totalPrice + delivery}<br>
</c:if>
<h3>format 이용</h3>
number : <fmt:formatNumber value="12345.678" type="number"/><br>
pattern : <fmt:formatNumber value="12345.678" pattern="#,###"/><br>
<c:set var="now" value="<%=new java.util.Date() %>"/>
<c:out value="${now}"/><br>
date : <fmt:formatDate value="${now}" type="date"/><br>
time : <fmt:formatDate value="${now}" type="time"/><br>
both : <fmt:formatDate value="${now}" type="both"/><br>
pattern : <fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/>
</body>
</html>