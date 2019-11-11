package com.board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;
import com.mystudy.board.model.BoardDAO;
import com.mystudy.board.model.BoardVO;

public class DetailController implements Controller{
	
	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		String no = request.getParameter("no");
		
		BoardDAO dao = new BoardDAO();
		BoardVO vo = new BoardVO();
		
		try {
			vo = dao.selectByNo(Integer.parseInt(no));
			
			String content = vo.getContent();
			if(content != null && content != "") {
				content = content.replace("\r\n", "<br>");
			}else {
				content = "";
			}
			vo.setContent(content);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("vo", vo);
		
		String viewPage = "/mystudy/board_mvc2/detail.jsp";
		
		return viewPage;
	}
	
	@Override
	public boolean isRedirect() {
		return false;
	}

}
