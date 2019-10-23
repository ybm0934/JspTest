package com.member.go;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Edit
 */
@WebServlet("/Edit")
public class Edit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Connection connection;
	private Statement statement;

	HttpSession session;

	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@192.168.6.166:1521:orcl";
	private String uid = "hr";
	private String upw = "hr123";

	private String no, id, password, name, phone1, phone2, phone3, phone, gender;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Edit() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("doGet 실행");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("doPost 실행");
		actionDo(request, response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		session = request.getSession();

		no = request.getParameter("no");
		id = request.getParameter("id");
		password = request.getParameter("password");
		name = request.getParameter("name");
		phone1 = request.getParameter("phone1");
		phone2 = request.getParameter("phone2");
		phone3 = request.getParameter("phone3");
		phone = phone1 + phone2 + phone3;
		gender = request.getParameter("gender");

		System.out.println("파라미터 확인");
		System.out.println(no + ", " + id + ", " + password + ", " + name + ", " + phone1 + ", " + phone2 + ", "
				+ phone3 + ", " + phone + ", " + gender);

		String sql = "UPDATE MEMBER" + " SET id = '" + id + "', " + "     password = '" + password + "', "
				+ "     name = '" + name + "', " + "     phone1 = '" + phone1 + "', " + "     phone2 = '" + phone2
				+ "', " + "     phone3 = '" + phone3 + "', " + "     phone = '" + phone + "', " + "     gender = '"
				+ gender + "'" + " WHERE no = '" + no + "'";

		if (pwCheck() == true) {

			try {
				Class.forName(driver);
				connection = DriverManager.getConnection(url, uid, upw);
				statement = connection.createStatement();
				int i = statement.executeUpdate(sql);
				if (i == 1) {
					System.out.println("edit 성공");
					session.setAttribute("name", name);
					response.sendRedirect("editResult.jsp");
				} else {
					System.out.println("edit 실패");
					response.sendRedirect("edit.jsp");
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (statement != null)
						statement.close();
					if (connection != null)
						connection.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		} else {
			System.out.println("비밀번호  NG");
			response.sendRedirect("edit.jsp");
		}

	}

	private boolean pwCheck() {
		boolean result = false;

		String sessionPw = (String) session.getAttribute("password");

		if (sessionPw.equals(password)) {
			result = true;
		} else {
			result = false;
		}

		return result;
	}

}
