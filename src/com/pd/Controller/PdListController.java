package com.pd.Controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;
import com.pd.Model.PdDAO;
import com.pd.Model.PdDTO;

public class PdListController implements Controller {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		PdDAO dao = new PdDAO();
		
		List<PdDTO> list = new ArrayList<PdDTO>();
		try {
			list = dao.selectAll();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("list", list);
		
		String viewPage = "/pd_mvc2/pdList.jsp";
		
		return viewPage;
	}
	
	public boolean isRedirect() {
		return false;
	}
}
