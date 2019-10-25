<%@page import="com.pd.Model.PdDAO"%>
<%@page import="com.pd.Model.PdDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String no = request.getParameter("no");

	if (no == null || no.isEmpty()) {
		System.out.println("파라미터 no 값이 없습니다. 잘못된 url 경로!");
	}

	PdDAO dao = new PdDAO();
	try {
		int n = dao.deletePd(Integer.parseInt(no));
		if (n > 0) {
			System.out.println("상품 삭제 성공!");
			response.sendRedirect("pdList.jsp");
		} else {
			System.out.println("삭제 실패!");
			response.sendRedirect("pdDetail.jsp?no=" + no);
		}

	} catch (SQLException e) {
		System.out.println("상품 삭제, sql error : " + e);
	}
%>