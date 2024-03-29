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
	//단일 파일 업로드 이용

	request.setCharacterEncoding("UTF-8");

	ReBoardVO vo = new ReBoardVO();
	ReBoardDAO dao = new ReBoardDAO();

	//파일 처리
	//현재 jsp페이지의 웹 어플리케이션 상의 절대 경로를 구한다.
	ServletContext context = getServletContext();

	//주어진 가상 경로에 대한 실제 경로를 리턴함
	//realFolder = context.getRealPath(uploadFolder);
	String realFolder = "D:\\Workspace-java\\ex\\WebContent\\mystudy\\upload\\"; //웹 어플리케이션 상의 절대 경로
	//String uploadFolder = "pds_upload"; //파일이 업로드 되는 폴더
	String encType = "UTF-8"; //인코딩 타입
	int maxSize = 100 * 1024 * 1024; //최대 업로드 될 파일크기 100MB

	System.out.println("파일 저장 경로 : " + realFolder);

	try {
		DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();

		//전송을 담당할 컴포넌트를 생성하고 파일을 전송한다.
		//전송할 파일명을 가지고 있는 객체, 서버상의 절대경로, 최대 업로드 될 파일크기, 문자코드, 기본 보안 적용(파일 업로드시 기존 파일과 동일한 파일이 있을 때 덮어쓰기 방지)
		MultipartRequest mr = new MultipartRequest(request, realFolder, maxSize, encType, policy);
		System.out.println("파일 업로드 완료!!");

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

		//vo 작업
		vo.setTitle(title);
		vo.setName(name);
		vo.setPwd(pwd);
		vo.setEmail(email);
		vo.setContent(content);
		vo.setIp(ip);
		vo.setPort(port);
		vo.setBrowser(browser);

		//서버에 저장된 파일 이름
		String fileName = mr.getFilesystemName("fileName");

		//전송 전 원래의 파일 이름
		String original = mr.getOriginalFileName("fileName");

		String fileSize = "0";
		int cnt = 0;
		if (fileName != null) {
			//전송된 파일 속성이 file인 태그의 name 속성 값을 이용해 파일 객체 생성
			File file = mr.getFile("fileName");
			//전송된 파일의 크기
			double fileLength = file.length();
			fileSize = Utility.displaySize(fileName, fileLength);
			
			System.out.println("----------------------------------------------");
			System.out.println("저장된 파일 이름 : " + fileName);
			System.out.println("실제 파일 이름 : " + original);
			System.out.println("파일 크기 : " + fileSize);
			System.out.println("----------------------------------------------");

			//확장자가 정해진 것 외의 파일이 업로드 되는 것 방지(보안성 강화 코딩)
			if (!original.endsWith(".hwp") && !original.endsWith(".png") && !original.endsWith(".jpg")
					&& !original.endsWith(".txt") && !original.endsWith(".zip") && !original.endsWith(".7z")
					&& !original.endsWith(".pdf")) {
				file = new File(realFolder + original);
				file.delete();
			%>
			<script type="text/javascript">
				alert("업로드 할 수 없는 확장자입니다.");
			</script>
			<%
			} else {
				
			vo.setFileName(fileName);
			vo.setOriginalFileName(original);
			vo.setFileSize(fileSize);

			cnt = dao.insertReBoard(vo);
			}//if

		}else {
			cnt = dao.insertReBoard(vo);
		}//if
		
		System.out.println("글쓰기 결과 cnt = " + cnt);
		
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
		}//if

	} catch (IOException ioe) {
		String str = "<script type='text/javascript'>";
		str += "alert('100MB 이상의 파일은 업로드할 수 없습니다!');";
		str += "history.back();";
		str += "</script>";
		out.print(str);
		System.out.println("100MB 이상의 파일은 업로드할 수 없습니다.");
		ioe.printStackTrace();
	} catch (Exception e) {
		e.printStackTrace();
	}
%>