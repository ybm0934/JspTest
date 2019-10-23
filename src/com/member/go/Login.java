package com.member.go;

import java.io.IOException;
import java.net.InetAddress;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Connection connection;
	private Statement statement;
	private ResultSet resultSet;

	private String no, id, password, name, ip, port;

	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@192.168.6.166:1521:orcl";
	private String uid = "hr";
	private String upw = "hr123";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Login() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		id = request.getParameter("id");
		password = request.getParameter("password");

		String sql = "select * from member where id = '" + id + "' and password = '" + password + "'";

		try {
			Class.forName(driver);
			connection = DriverManager.getConnection(url, uid, upw);
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);

			while (resultSet.next()) {
				no = resultSet.getString("no");
				id = resultSet.getString("id");
				password = resultSet.getString("password");
				name = resultSet.getString("name");
			}

			HttpSession session = request.getSession();
			InetAddress inet = InetAddress.getLocalHost();

			ip = inet.getHostAddress();
			port = Integer.toString(request.getServerPort());

			session.setAttribute("no", no);
			session.setAttribute("name", name);
			session.setAttribute("id", id);
			session.setAttribute("password", password);
			session.setAttribute("ip", ip);
			session.setAttribute("port", port);
			
			response.sendRedirect("loginResult.jsp");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (resultSet != null)
					resultSet.close();
				if (statement != null)
					statement.close();
				if (connection != null)
					connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

}
