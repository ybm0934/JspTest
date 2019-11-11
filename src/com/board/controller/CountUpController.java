package com.board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;
import com.mystudy.board.model.BoardDAO;

public class CountUpController implements Controller {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {

		String no = request.getParameter("no");

		BoardDAO dao = new BoardDAO();

		try {
			dao.updateReadCount(Integer.parseInt(no));
		} catch (SQLException e) {
			e.printStackTrace();
		}

		String viewPage = request.getContextPath() + "/board/detail.do?no=" + no;

		return viewPage;
	}

	@Override
	public boolean isRedirect() {
		return true;
	}

}
