package com.pd.Controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;
import com.pd.Model.PdDAO;
import com.pd.Model.PdDTO;

public class PdDetailController implements Controller {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		String no = request.getParameter("no");
		
		PdDAO dao = new PdDAO();
		PdDTO dto = new PdDTO();
		
		try {
			dto = dao.selectByNo(Integer.parseInt(no));
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("dto", dto);
		
		String viewPage = "/pd_mvc2/pdDetail.jsp";
		
		return viewPage;
	}
	
	@Override
	public boolean isRedirect() {
		return false;
	}
}
