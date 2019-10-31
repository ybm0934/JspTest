<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//파일 전송 방법1 (단일 파일 업로드)
	request.setCharacterEncoding("UTF-8");
	
	//업로드 할 폴더의 절대 경로 구하기()
	//D:\Workspace-java\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\프로젝트명\폴더명
	//String saveDirectory = application.getRealPath("/mystudy/fileload/upload");
	String saveDirectory = "D:\\Workspace-java\\ex\\WebContent\\mystudy\\fileload\\upload";
	int maxSize = 2 * 1024 * 1024;	//2MB => 업로드 최대 용량 2메가로 제한
	String encoding = "UTF-8";
	
	out.print("upload 디렉토리 : " + saveDirectory + "<br>");
	
	//업로드 시 동일한 파일명이 있을 경우 나중에 업로드한 파일에 번호를 붙여 구분해줌
	DefaultFileRenamePolicy df = new DefaultFileRenamePolicy();
	MultipartRequest multi = new MultipartRequest(request, saveDirectory, maxSize, encoding, df);
	out.print("업로드 완료!<br>");
	
	//파일 정보 출력
	String id = request.getParameter("id");
	out.print("id : " + id + "<br>");
	
	id = multi.getParameter("id");
	out.print("id : " + id + "<br>");
	
	String filename = multi.getFilesystemName("fileName");
	out.print("업로드 된 파일명(변경 후) : " + filename + "<br>");
	
	String orgFilename = multi.getOriginalFileName("fileName");
	out.print("업로드 된 파일명(원본) : " + orgFilename + "<br>");
	
	String contentType = multi.getContentType("fileName");
	out.print("contentType : " + contentType + "<br>");
	
	File myFile = multi.getFile("fileName");
	long size = myFile.length();
	out.print("file size : " + size + " byte");	
	
	//MultipartRequest 객체 생성 성공 => 업로드 완료
	//실패 => IOException 발생(파일 용량 초과 등)
	
%>