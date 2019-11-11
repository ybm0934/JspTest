package com.board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;
import com.mystudy.board.model.BoardDAO;
import com.mystudy.board.model.BoardVO;

public class EditFormController implements Controller {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {

		String no = request.getParameter("no");
		if (no == null || no == "") {
			String msg = "잘못된 url 주소입니다.";
			String url = request.getContextPath() + "/board/list.do";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "/common/message.jsp";
		}

		BoardDAO dao = new BoardDAO();
		BoardVO vo = new BoardVO();

		try {
			vo = dao.selectByNo(Integer.parseInt(no));
			String email = vo.getEmail();
			if (email == null)
				email = "";

			String content = vo.getContent();
			if (content == null)
				content = "";

			vo.setContent(content);
			vo.setEmail(email);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		request.setAttribute("vo", vo);

		String viewPage = "/mystudy/board_mvc2/edit.jsp";

		return viewPage;
	}

	@Override
	public boolean isRedirect() {
		return false;
	}

}
