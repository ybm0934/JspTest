package com.pd.Controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;
import com.pd.Model.PdDAO;

public class PdDeleteController implements Controller {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {

		String no = request.getParameter("no");

		PdDAO dao = new PdDAO();

		String msg = "", url = "";
		try {
			int n = dao.deletePd(Integer.parseInt(no));

			if (n > 0) {
				msg = "품목 삭제 성공";
				url = "/pd/pdList.do";
			} else {
				msg = "품목 삭제 실패";
				url = "/pd/pdDetail.do?no=" + no;
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
