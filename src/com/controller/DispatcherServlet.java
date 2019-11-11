package com.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DispatcherServlet extends HttpServlet {

	Properties props;
	String configFile;
	String realConfigFile;

	// 해당 서블릿이 요청될 때 최초로 한번만 호출되는 메서드
	public void init(ServletConfig config) {
		// 매핑 파일을 읽어서 Properties 컬렉션에 담아 놓는다
		// web.xml에서 <inti-param>의 값 읽기 - CommandPro.properties 파일
		configFile = config.getInitParameter("configFile"); // =>/config/CommandPro.properties

		// 매핑 파일의 실제 경로 구하기
		// realConfigFile = config.getServletContext().getRealPath(configFile);
		realConfigFile = "D:\\Workspace-java\\ex\\WebContent\\config\\Command.properties";

		props = new Properties();

		FileInputStream fis = null;
		try {
			fis = new FileInputStream(realConfigFile);
			props.load(fis);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (fis != null) fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}// init

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		requestProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		requestProcess(request, response);
	}

	private void requestProcess(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		// 사용자의 URI 읽어오기
		String uri = request.getRequestURI();

		// Context Path 제거하기
		String contextPath = request.getContextPath();

		if (uri.indexOf(contextPath) == 0) {
			uri = uri.substring(contextPath.length());
		}

		System.out.println("\nconfigFile : " + configFile);
		System.out.println("realConfigFile : " + realConfigFile);
		System.out.println("uri : " + uri + "\n");

		try {
			String className = props.getProperty(uri);
			Class commandClass = Class.forName(className); // 해당 문자열을 클래스로 만든다
			Controller controller = (Controller) commandClass.newInstance();
			String viewPage = controller.requestProcess(request, response);

			if (controller.isRedirect()) {
				response.sendRedirect(viewPage);
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
				dispatcher.forward(request, response);
			}

		} catch (Throwable e) {
			e.printStackTrace();
		}

	}// requestPro

}
