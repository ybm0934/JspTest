<%@page import="java.sql.SQLException"%>
<%@page import="com.pd.Model.PdDAO"%>
<%@page import="com.pd.Model.PdDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String no = request.getParameter("no");
	String pdName = request.getParameter("pdName");
	String price = request.getParameter("price");

	PdDTO dto = new PdDTO();
	PdDAO dao = new PdDAO();

	try {
		dto.setNo(Integer.parseInt(no));
		dto.setPdName(pdName);
		dto.setPrice(Integer.parseInt(price));
		
		int n = dao.updatePd(dto);
		
		if(n > 0){
			System.out.println("상품 수정 성공");
			response.sendRedirect("pdDetail.jsp?no=" + no);
		}else {
			System.out.println("상품 수정 실패");
			response.sendRedirect("pdEdit.jsp?no=" + no);
		}
		
	} catch (SQLException e) {
		System.out.println("상품 수정 error : " + e);
	}
%>