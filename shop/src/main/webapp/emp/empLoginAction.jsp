<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import= "java.net.*"%> 

<%
	// 인증분기 : 세션변수 이름 - loginEmp
	String loginEmp = (String)(session.getAttribute("loginEmp"));
	System.out.println("loginEmp(session) : " + loginEmp);
	
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>

<%
	// 요청값
	String empid = request.getParameter("empid"); 
	String emppw = request.getParameter("emppw"); 
	
	System.out.println("empid : " + empid);
	System.out.println("emppw : " + emppw);
	
	/*
		select emp_id emp Id from emp 
		where active='ON' and emp_id =? and emp_pw = password(?) ->> emp_pw = password(?) 암호화처리???
	*/
	String sql = "select emp_id empId from emp where active='ON' and emp_id =? and emp_pw = password (?)";
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql); 
	stmt.setString(1,empid);
	stmt.setString(2,emppw);
	rs = stmt.executeQuery(); // 쿼리문
%>	

<%	
	/*
		실패 / emp/empLoginForm.jsp	
		성공 / emp/empList.jsp	
	*/
	
	if(rs.next()) {
		System.out.println("로그인 성공");
		session.setAttribute("loginEmp", rs.getString("empid")); // session이 "loginEmp"이고 empid인 사람이 로그인함
		response.sendRedirect("/shop/emp/empList.jsp");
		
	} else {
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요.", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?=errMsg" +errMsg);	
		
	}
	
	
%>
