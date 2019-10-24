<%@page import="com.pd.Model.PdDTO"%>
<%@page import="com.pd.Model.PdDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	//1. post방식으로 넘긴 요청 파라미터에 대한 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	//2. post방식으로 넘긴 파라미터 읽어오기
	String pdName = request.getParameter("pdName");
	String price = request.getParameter("price");

	//3. DB 작업
	PdDAO pdDao = new PdDAO();
	PdDTO pdDto = new PdDTO();
	pdDto.setPdName(pdName);
	pdDto.setPrice(Integer.parseInt(price));

	try {

		int n = pdDao.insertPd(pdDto);
		if (n > 0) {
			response.sendRedirect("pdList.jsp");
		} else {
			System.out.println("입력 실패!!");
			response.sendRedirect("pdWrite.jsp");
		}

	} catch (SQLException e) {
		System.out.println("상품 입력, sql error : " + e);
	}
%>