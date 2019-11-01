<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//파일 전송 방법 2 (다중 파일 업로드)

	request.setCharacterEncoding("UTF-8");

	String realFolder = ""; //웹 어플리케이션 상의 절대 경로
	String uploadFolder = "pds_upload"; //파일이 업로드 되는 폴더
	String encType = "UTF-8"; //인코딩 타입
	int maxSize = 5 * 1024 * 1024; //최대 업로드 될 파일크기 5MB

	//현재 jsp페이지의 웹 어플리케이션 상의 절대 경로를 구한다.
	ServletContext context = getServletContext();

	//주어진 가상 경로에 대한 실제 경로를 리턴함
	//realFolder = context.getRealPath(uploadFolder);
	realFolder = "D:\\Workspace-java\\ex\\WebContent\\mystudy\\fileload\\upload";
	out.println("the realpath is : " + realFolder + "<br>");

	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	try {
		//전송을 담당할 컴포넌트를 생성하고 파일을 전송한다.
		//전송할 파일명을 가지고 있는 객체, 서버상의 절대경로, 최대 업로드 될 파일크기,
		//문자코드, 기본 보안 적용(파일 업로드시 기존 파일과 동일한 파일이 있을 때 덮어쓰기 방지)
		MultipartRequest mr = new MultipartRequest(request, realFolder, maxSize, encType, policy);
		System.out.println("파일 업로드 완료!!");

		//Form의 파라미터 목록을 가져온다.
		Enumeration params = mr.getParameterNames();

		//파라미터를 출력한다.
		while (params.hasMoreElements()) {
			String name = (String) params.nextElement(); //전송되는 파라미터 이름
			String value = mr.getParameter(name); //전송되는 파라미터 값
			out.println(name + " : " + value + "<br>");
		}

		out.println("--------------------------------------------------------<br>");

		//전송한 파일 정보를 가져와 출력
		Enumeration files = mr.getFileNames();

		//파일 정보가 있다면
		while (files.hasMoreElements()) {
			//input 태그의 속성이 file인 태그의 name 속성 값 : 파라미터 이름
			String name = (String) files.nextElement();

			//서버에 저장된 파일 이름
			String filename = mr.getFilesystemName(name);

			//전송 전 원래의 파일 이름
			String original = mr.getOriginalFileName(name);

			//전송된 파일의 내용 타입
			String type = mr.getContentType(name);

			//전송된 파일 속성이 file인 태그의 name 속성 값을 이용해 파일 객체 생성
			File file = mr.getFile(name);
			out.println("파라미터 이름 : " + name + "<br>");
			out.println("실제 파일 이름 : " + original + "<br>");
			out.println("저장된 파일 이름 : " + filename + "<br>");
			out.println("파일 타입 : " + type + "<br>");

			if (file != null) {
				out.println("크기 : " + file.length() + " byte<br><br>");
			}
			
			if(original == null) continue; //2번째 파일이 null 값일시 그냥 패스 
			new ReBoardDAO().fileUpload(fileName, original);
			
		} //while

		//사용자가 입력한 요청 파라미터 읽어오기
		String id = request.getParameter("id");
		String id2 = mr.getParameter("id");
		String address = mr.getParameter("address");
		
		out.println("<hr>아이디 : " + id + ", 아이디2 : " + id2 + "<br>");
		out.println("주소 : " + address + "<br>");
		
	} catch (IOException ioe) {
		System.out.println("5MB 이상의 파일은 업로드할 수 없습니다.");
		ioe.printStackTrace();
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>