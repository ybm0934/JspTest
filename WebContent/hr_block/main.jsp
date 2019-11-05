<%@ include file="top.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<section class="sect">
	<div class="sec_div1">
	<div class="sec_spn_div"><span class="sec_spn1">HR_BLOCK 추천</span><span class="sec_spn2"> 공고를 확인하세요</span><br></div>
		<div class="notice">
			<h3>(주)삼구아이앤씨</h3>
			<p class="no_p1">SK이노베이션 서산 2차전지 생산직 채용(결원 충원)</p>
			<p class="no_p2">#기계·기계설비 #안성시</p>
			<button type="button" class="no_p3">즉시지원</button>
		</div>
		<div class="notice">
			<h3>(주)휴온스그룹</h3>
			<p class="no_p1">디에이피 안산 정규직 채용 생산파트 신입</p>
			<p class="no_p2">#상품기획 #성남시 분당구</p>
			<button type="button" class="no_p3">즉시지원</button>
		</div>
		<div class="notice">
			<h3>(주)오투피플</h3>
			<p class="no_p1">공채 정규직 [할리스커피] 정직원 바리스타 채용</p>
			<p class="no_p2">#외식·식음료 #서울전체</p>
			<button type="button" class="no_p3">즉시지원</button>
		</div>
	</div>
	<div class="sec_div2">
	<div class="reg_div">
		<a href="#"><span>회원가입</span></a>
		<a href="#"><span>아이디/비번 찾기</span></a>
	</div>
		<table class="log_tbl">
			<tr>
				<td>
					<input type="text" class="log" placeholder="아이디">
				</td>
				<td rowspan="2">
					<button class="log_btn" type="button">로그인</button>						
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" class="log" placeholder="비밀번호">
				</td>
			</tr>
		</table>
		<div class="log_bottom">
			<input type="checkbox" class="log_check" id="log_check">
			<label for="log_check">로그인 유지</label>
			<input type="checkbox" class="log_check2" id="log_check2">
			<label for="log_check2">아이디 저장</label>
			<span class="img_spn">
				<a href="#"><img src="<%=request.getContextPath()%>/hr_block/images/naver.png"></a>
				<a href="#"><img src="<%=request.getContextPath()%>/hr_block/images/kakao.png"></a>
				<a href="#"><img src="<%=request.getContextPath()%>/hr_block/images/facebook.png"></a>
				<a href="#"><img src="<%=request.getContextPath()%>/hr_block/images/google.png"></a>
			</span>
		</div>
	</div>
</section>
<%@ include file="bottom.jsp" %>