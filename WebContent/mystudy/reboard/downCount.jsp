<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//다운로드 처리 및 다운로드 수 증가시키기
	int no = Integer.parseInt(request.getParameter("no"));
	String fileName = request.getParameter("fileName"); //fileName1만 증가. fileName2까지는 내 선에서 구현 어려움

	ReBoardDAO dao = new ReBoardDAO();

	int n = dao.updateDownCount(no, fileName);

	String path = "D:\\Workspace-java\\ex\\WebContent\\mystudy\\upload";

	try {
		File file = new File(path, fileName);

		response.reset();
		response.setContentType("application/octet-stream");

		//다운로드시 무조건 파일다운로드 대화상자가 뜨도록 하는 헤더속성
		//url 전송시 ISO-8859-1로 인코딩되므로 한글 처리 위해 인코딩
		response.setHeader("Content-Disposition",
				"attachment;filename=" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "");

		//cache에서 해당 페이지 읽기방지, 로딩시마다 새로고침한 것
		response.setHeader("Pargma", "no-cache");

		//cache 막기
		response.setHeader("Expires", "-1");

		out.clear();
		out = pageContext.pushBody();

		byte[] data = new byte[1024 * 1024];
		BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());

		int count = 0;
		while ((count = bis.read(data)) != -1) {
			bos.write(data);
		}
		if (bis != null)
			bis.close();
		if (bos != null)
			bos.close();

	} catch (Exception e) {
		e.printStackTrace();
	}
%>