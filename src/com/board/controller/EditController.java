package com.board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;
import com.mystudy.board.model.BoardDAO;
import com.mystudy.board.model.BoardVO;

public class EditController implements Controller {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {

		String no = request.getParameter("no");
		String title = request.getParameter("title");
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		String email = request.getParameter("email");
		String content = request.getParameter("content");

		BoardDAO dao = new BoardDAO();
		BoardVO vo = new BoardVO();
		vo.setNo(Integer.parseInt(no));
		vo.setTitle(title);
		vo.setName(name);
		vo.setPwd(pwd);
		vo.setEmail(email);
		vo.setContent(content);

		int n = 0;
		String msg = "", url = "";
		try {
			n = dao.updateBoard(vo);

			if (n > 0) {
				msg = "글 수정 성공!";
				url = request.getContextPath() + "/board/detail.do?no=" + no;
			} else {
				msg = "글 수정 실패!";
				url = "/board/editForm.do?no=" + no;
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
