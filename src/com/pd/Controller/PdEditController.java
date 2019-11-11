package com.pd.Controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.controller.Controller;
import com.pd.Model.PdDAO;
import com.pd.Model.PdDTO;

public class PdEditController implements Controller {

	@Override
	public String requestProcess(HttpServletRequest request, HttpServletResponse response) throws Throwable {

		String no = request.getParameter("no");
		String pdName = request.getParameter("pdName");
		String price = request.getParameter("price");

		PdDTO dto = new PdDTO();
		dto.setNo(Integer.parseInt(no));
		dto.setPdName(pdName);
		dto.setPrice(Integer.parseInt(price));

		PdDAO dao = new PdDAO();
		String msg = "", url = "";
		try {
			int n = dao.updatePd(dto);

			if (n > 0) {
				msg = "상품 수정 성공";
				url = "/pd/pdDetail.do?no=" + no;
			} else {
				msg = "상품 수정 실패";
				url = request.getContextPath() + "/pd/pdEditForm.do?no=" + no;
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
