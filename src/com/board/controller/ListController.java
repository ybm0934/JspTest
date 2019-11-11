package com.board.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;
import com.herbmall.utility.PagingVO;
import com.mystudy.board.model.BoardDAO;
import com.mystudy.board.model.BoardVO;

public class ListController implements Controller {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {

		String category = request.getParameter("category");
		String keyword = request.getParameter("keyword");

		BoardDAO dao = new BoardDAO();

		List<BoardVO> list = new ArrayList<BoardVO>();
		PagingVO pvo = null;
		try {
			list = dao.selectAll(category, keyword);
			
			int currentPage = 1;
			int totalRecord = list.size();
			if (request.getParameter("currentPage") != null) {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			}
			int pageSize = 5;
			int blockSize = 10;
			pvo = new PagingVO(currentPage, totalRecord, pageSize, blockSize);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		request.setAttribute("list", list);
		request.setAttribute("pvo", pvo);
		request.setAttribute("totalRecord", list.size());
		request.setAttribute("keyword", keyword);

		String viewPage = "/mystudy/board_mvc2/list.jsp";

		return viewPage;
	}

	@Override
	public boolean isRedirect() {
		return false;
	}

}
