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

/**
 * Servlet implementation class RegisterOk
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Connection con;
	private Statement stmt;

	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@192.168.6.166:1521:orcl";
	private String uid = "hr";
	private String upw = "hr123";

	private String id, password, name, phone1, phone2, phone3, phone, gender;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Register() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("doGet 실행");
		actionDo(request, response);
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

		id = request.getParameter("id");
		password = request.getParameter("password");
		name = request.getParameter("name");
		phone1 = request.getParameter("phone1");
		phone2 = request.getParameter("phone2");
		phone3 = request.getParameter("phone3");
		phone = phone1 + phone2 + phone3;
		gender = request.getParameter("gender");
		
		System.out.println("파라미터 확인");
		System.out.println(id + ", " + password + ", " + name + ", " + phone1 + ", " + phone2 + ", " + phone3 + ", " + phone + ", " + gender);

		String sql = "insert into member values(member_seq.nextval, '" + id + "', '" + password + "', '" + name + "', '"
				+ phone1 + "', '" + phone2 + "', '" + phone3 + "', '" + phone + "', '" + gender + "', sysdate)";

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, uid, upw);
			stmt = con.createStatement();
			int i = stmt.executeUpdate(sql);
			if (i == 1) {
				System.out.println("insert 성공");
				response.sendRedirect("registerResult.jsp");
			} else {
				System.out.println("insert 실패");
				response.sendRedirect("register.html");
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("insert 실패");
			response.sendRedirect("register.html");
		} finally {
			try {
				if (stmt != null)
					stmt.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

}
