<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	// active 변환값 받기
	
	String empId = request.getParameter("empId");
	String active = request.getParameter("active");
	
	System.out.println("변환전 empId : " + empId);
	System.out.println("변환전 active : " + active);
	
	if(active.equals("OFF")) {
		active = "ON";
	} else {
		active = "OFF";
	}
	
	System.out.println("변환후 empId : " + empId);
	System.out.println("변환후 active : " + active);

	/*
		update emp
		set active = ?
		where emp_id = ?
	*/
	String sql = "update emp set active = ? where emp_id = ?";
	
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	Connection conn = null;
	PreparedStatement stmt = null;
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,active);
	stmt.setString(2,empId);
	
	System.out.println(stmt);
	
	int row = 0;
	row = stmt.executeUpdate();
	
	if(row == 1) {
		System.out.println("변환성공");
		response.sendRedirect("/shop/emp/empList.jsp");
	}
	
%>	
	