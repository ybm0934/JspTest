package com.board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;
import com.mystudy.board.model.BoardDAO;

public class DeleteController implements Controller {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		String no = request.getParameter("no");
		String pwd = request.getParameter("pwd");
		
		BoardDAO dao = new BoardDAO();

		int n = 0;
		String msg = "", url = "";
		try {
			if(dao.pwdCheck(Integer.parseInt(no), pwd)) {
				n = dao.deleteBoard(Integer.parseInt(no), pwd);
				
				if(n > 0) {
					msg = "글 삭제 성공";
					url = request.getContextPath() + "/board/list.do";
				}else {
					msg = "글 삭제 실패";
					url = "/board/deleteForm.do?no=" + no;
				}
			}else {
				msg = "비밀번호가 일치하지 않습니다.";
				url = request.getContextPath() + "/board/deleteForm.do?no=" + no;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		
		String viewPage = "/common/message.jsp";
		
		return viewPage;
	}

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return false;
	}
	
	

}
