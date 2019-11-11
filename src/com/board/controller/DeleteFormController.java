package com.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;

public class DeleteFormController implements Controller {

	public String requestProcess(HttpServletRequest request, HttpServletResponse response) {
		
		String no = request.getParameter("no");
		request.setAttribute("no", no);
		
		String viewPage = "/mystudy/board_mvc2/delete.jsp";
		
		return viewPage;
	}

	public boolean isRedirect() {
		return false;
	}
	
	

}
