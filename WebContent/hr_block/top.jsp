<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HR_BLOCK</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/hr_block/hr_css/main.css">
</head>
<body>
<div class="top">
	<img src="<%=request.getContextPath() %>/hr_block/images/logo.png">
	<span class="top_spn1">어떤 채용정보</span><span class="top_spn2">를 찾고 싶으세요?</span>
</div>
<header class="head">
	<div class="head_div">
		<ul>
			<li><a href="#">지역별</a></li>
			<li><a href="#">직업별</a></li>
			<li><a href="#">공채</a></li>
			<li><a href="#">추천</a></li>
			<li> | </li>
			<li><a href="#">기업·연봉</a></li>
			<li><a href="#">인재검색</a></li>
			<li><a href="#">인적성검사</a></li>
		</ul>
	</div>
</header>
<div class="head_search">
	<label class="search">
		<input type="text" name="search" class="search">
	</label>
	<label class="search2">
		<input type="text" name="search2" class="search2">
	</label>
	<label class="search3">
		<input type="text" name="search3" class="search3">
	</label>
	<button type="button" class="src_btn">검색</button>
</div>
