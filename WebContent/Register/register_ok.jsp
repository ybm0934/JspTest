<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.6.166:1521:orcl";
	String uid = "hr";
	String upw = "hr123";

	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String hobby[] = request.getParameterValues("hobby");
	String gender = request.getParameter("gender");
	String intro = request.getParameter("intro");
	String grade = request.getParameter("grade");

	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, uid, upw);
	out.print("DB연결 성공!<br>");
	String sql = "insert into member(no, id, pwd, name, hp, hobby, gender, intro, grade)"
			+ "values(member_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, pwd);
	pstmt.setString(3, name);
	pstmt.setString(4, hp);
	pstmt.setString(5, Arrays.toString(hobby));
	pstmt.setString(6, gender);
	pstmt.setString(7, intro);
	pstmt.setString(8, grade);

	int result = pstmt.executeUpdate();
	if (result > 0) {
		out.print("<script>");
		out.print("alert('등록 성공!');");
		out.print("location.href='main.jsp';");
		out.print("</script>");
	} else {
		out.print("<script>");
		out.print("alert('등록 실패!');");
		out.print("history.back();");
		out.print("</script>");
	}

	pstmt.close();
	con.close();
%>
