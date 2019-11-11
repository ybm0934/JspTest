package com.pd.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;

public class PdWriteFormController implements Controller {

	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		String viewPage = "/pd_mvc2/pdWrite.jsp";

		return viewPage;
	}

	public boolean isRedirect() {
		return false;	//forward
	}

}
