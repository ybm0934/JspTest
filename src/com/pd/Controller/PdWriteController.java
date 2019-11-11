package com.pd.Controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;
import com.pd.Model.PdDAO;
import com.pd.Model.PdDTO;

public class PdWriteController implements Controller {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {

		String pdName = request.getParameter("pdName");
		String price = request.getParameter("price");

		PdDAO dao = new PdDAO();
		PdDTO dto = new PdDTO();
		dto.setPdName(pdName);
		dto.setPrice(Integer.parseInt(price));

		String msg = "", url = request.getContextPath() + "/pd/pdWriteForm.do";
		try {
			int n = dao.insertPd(dto);

			if (n > 0) {
				msg = "상품 등록 성공";
				url = request.getContextPath() + "/pd/pdList.do";
			} else {
				msg = "상품 등록 실패";
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		request.setAttribute("msg", msg);
		request.setAttribute("url", url);

		String viewPage = "/common/message.jsp";

		return viewPage;
	}// requestProcess

	@Override
	public boolean isRedirect() {
		return false;
	}

}
