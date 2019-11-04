<%@page import="com.herbmall.utility.Utility"%>
<%@page import="java.io.IOException"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	ReBoardVO vo = new ReBoardVO();
	ReBoardDAO dao = new ReBoardDAO();

	String path = "D:\\Workspace-java\\ex\\WebContent\\mystudy\\upload\\";
	int maxSize = 100 * 1024 * 1024;
	String encoding = "UTF-8";

	try {
		DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
		MultipartRequest mr = new MultipartRequest(request, path, maxSize, encoding, policy);
		System.out.println("파일 업로드 완료!!");

		//파라미터 읽어오기
		String no = mr.getParameter("no");
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
		vo.setNo(Integer.parseInt(no));
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
		//새로운 파일 첨부
		if (fileName != null) {
			//전송된 파일 속성이 file인 태그의 name 속성 값을 이용해 파일 객체 생성
			File file = mr.getFile("fileName");
			//전송된 파일의 크기
			double fileLength = file.length();
			fileSize = Utility.displaySize(fileName, fileLength);
			
			System.out.println("----------------------------------------------");
			System.out.println("새로운 파일 이름 : " + fileName);
			System.out.println("실제 파일 이름 : " + original);
			System.out.println("파일 크기 : " + fileSize);
			System.out.println("----------------------------------------------");
			
			//기존 파일은 삭제
			File oldFile = new File(path, mr.getParameter("oldFileName"));
			if(oldFile.exists()) oldFile.delete();
			
			System.out.println("----------------------------------------------");
			System.out.println("기존 파일명 : " + mr.getParameter("oldFileName"));
			System.out.println("----------------------------------------------");

			//확장자가 정해진 것 외의 파일이 업로드 되는 것 방지(보안성 강화 코딩)
			if (!original.endsWith(".hwp") && !original.endsWith(".png") && !original.endsWith(".jpg")
					&& !original.endsWith(".txt") && !original.endsWith(".zip") && !original.endsWith(".7z")
					&& !original.endsWith(".pdf")) {
				file = new File(path + original);
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

			cnt = dao.updateReboard(vo);
			}//if

		}else {
			cnt = dao.updateReboard(vo);
		}//if
		
		System.out.println("글쓰기 결과 cnt = " + cnt);

		if (cnt > 0) {
			%>
			<script type="text/javascript">
				alert("글 수정 성공");
				location.href = "detail.jsp?no=" + <%=no %>;
			</script>
			<%
				} else {
			%>
			<script type="text/javascript">
				alert("수정 실패!");
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