<%@page import="com.herbmall.utility.Utility"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.IOException"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	//파일 처리-----------------------------------------------------------------------------------
	//현재 jsp페이지의 웹 어플리케이션 상의 절대 경로를 구한다.
	ServletContext context = getServletContext();

	//주어진 가상 경로에 대한 실제 경로를 리턴함
	//realFolder = context.getRealPath(uploadFolder);
	String realFolder = "D:\\Workspace-java\\ex\\WebContent\\mystudy\\upload"; //웹 어플리케이션 상의 절대 경로
	//String uploadFolder = "pds_upload"; //파일이 업로드 되는 폴더
	String encType = "UTF-8"; //인코딩 타입
	int maxSize = 500 * 1024 * 1024; //최대 업로드 될 파일크기 500MB

	System.out.println("파일 저장 경로 : " + realFolder);

	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();

	try {
		//전송을 담당할 컴포넌트를 생성하고 파일을 전송한다.
		//전송할 파일명을 가지고 있는 객체, 서버상의 절대경로, 최대 업로드 될 파일크기, 문자코드, 기본 보안 적용(파일 업로드시 기존 파일과 동일한 파일이 있을 때 덮어쓰기 방지)
		MultipartRequest mr = new MultipartRequest(request, realFolder, maxSize, encType, policy);
		System.out.println("파일 업로드 완료!!");

		//서버에 저장된 파일 이름
		String fileName1 = mr.getFilesystemName("fileName1");
		String fileName2 = mr.getFilesystemName("fileName2");

		//전송 전 원래의 파일 이름
		String original1 = mr.getOriginalFileName("fileName1");
		String original2 = mr.getOriginalFileName("fileName2");

		System.out.println("----------------------------------------------");
		System.out.println("저장된 파일 이름1 : " + fileName1);
		System.out.println("실제 파일 이름1 : " + original1);
		System.out.println("저장된 파일 이름2 : " + fileName2);
		System.out.println("실제 파일 이름2 : " + original2);
		System.out.println("----------------------------------------------");

		System.out.println("----------------------------------------------");
		//전송된 파일 속성이 file인 태그의 name 속성 값을 이용해 파일 객체 생성
		double fileSize1 = 0, fileSize2 = 0;

		if (fileName1 != null) {
			File file = mr.getFile("fileName1");
			fileSize1 = Utility.displaySize(fileName1, file.length()); //파일 크기
		} //if

		if (fileName2 != null) {
			File file = mr.getFile("fileName2");
			fileSize2 = Utility.displaySize(fileName2, file.length()); //파일 크기
		} //if
		System.out.println("----------------------------------------------");

		//----------------------------------------------------------------------------------------

		//파라미터 읽어오기
		String title = mr.getParameter("title");
		String name = mr.getParameter("name");
		String pwd = mr.getParameter("pwd");
		String email = mr.getParameter("email");
		String content = mr.getParameter("content");

		//아이피, 포트, 브라우저 정보 가져오기
		InetAddress inet = InetAddress.getLocalHost();
		String ip = inet.getHostAddress();
		String port = Integer.toString(request.getServerPort());
		String browser = request.getHeader("User-Agent");
		System.out.println("아이피 포트 주소 : " + ip + ":" + port);
		System.out.println("브라우저 정보 : " + browser);

		ReBoardVO vo = new ReBoardVO();
		ReBoardDAO dao = new ReBoardDAO();

		vo.setTitle(title);
		vo.setName(name);
		vo.setPwd(pwd);
		vo.setEmail(email);
		vo.setContent(content);
		vo.setIp(ip);
		vo.setPort(port);
		vo.setBrowser(browser);
		vo.setFileName1(fileName1);
		vo.setOriginalFileName1(original1);
		vo.setFileSize1(fileSize1);
		vo.setFileName2(fileName2);
		vo.setOriginalFileName2(original2);
		vo.setFileSize2(fileSize2);

		int cnt = dao.insertReBoard(vo);

		if (cnt > 0) {
%>
<script type="text/javascript">
	alert("글쓰기가 처리되었습니다.");
	location.href = "list.jsp";
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("글쓰기 처리 실패!");
	history.back();
</script>
<%
	}
	} catch (IOException ioe) {
		String str = "<script>";
		str += "alert('5MB 이상의 파일은 업로드할 수 없습니다!')";
		str += "history.back();";
		str += "</script>";
		out.print(str);
		System.out.println("5MB 이상의 파일은 업로드할 수 없습니다.");
		ioe.printStackTrace();
	} catch (Exception e) {
		e.printStackTrace();
	}
%>