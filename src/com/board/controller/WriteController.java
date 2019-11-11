package com.board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;
import com.mystudy.board.model.BoardDAO;
import com.mystudy.board.model.BoardVO;

public class WriteController implements Controller {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {

		String title = request.getParameter("title");
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		String email = request.getParameter("email");
		String content = request.getParameter("content");

		BoardVO vo = new BoardVO();
		vo.setTitle(title);
		vo.setName(name);
		vo.setPwd(pwd);
		vo.setEmail(email);
		vo.setContent(content);

		BoardDAO dao = new BoardDAO();

		String msg = "", url = "";
		try {
			int n = dao.insertBoard(vo);

			if (n > 0) {
				msg = "글 쓰기 성공";
				url = "/board/list.do";
			} else {
				msg = "글 쓰기 실패";
				url = "/board/write.do";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		request.setAttribute("msg", msg);
		request.setAttribute("url", url);

		String viewPage = "/common/message.jsp";

		return viewPage;
	}

	@Override
	public boolean isRedirect() {
		return false;
	}

}
