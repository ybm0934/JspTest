package com.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;

public class WriteFormController implements Controller {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		String viewPage = "/mystudy/board_mvc2/write.jsp";
		
		return viewPage;
	}

	@Override
	public boolean isRedirect() {
		return false;
	}
}
