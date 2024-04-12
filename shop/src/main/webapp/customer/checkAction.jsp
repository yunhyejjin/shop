<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	String checkMail = request.getParameter("checkMail");

	System.out.println("check-Mail : " + checkMail);
	
	// 회원가입하려는 메일이 중복인지 확인
	String sql = "select mail from customer where mail=?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,checkMail);
	System.out.println("stmt : " + stmt);
	
	rs = stmt.executeQuery();
	
	if(rs.next()) {
		// 메일 사용 불가능 (이미 가입한 메일이 존재)
		System.out.println("메일 사용 불가능");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?ck=X");
	} else {
		// 메일 사용 가능
		System.out.println("메일 사용 가능");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkMail="+checkMail+"&ck=O");
	}
	
	
%>
