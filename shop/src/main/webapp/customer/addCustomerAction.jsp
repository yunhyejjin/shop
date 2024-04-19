<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//1.입렵값 받기
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	System.out.println("mail :  "  + mail);
	System.out.println("pw :  "  + pw);
	System.out.println("name :  "  + name);
	System.out.println("birth :  "  + birth);
	System.out.println("gender :  "  + gender);
	
	// 2. DB접속해서 입력값 입력한다.
	String sql = "insert into customer(mail, pw, name, birth, gender, update_date, create_date) values(?,password(?),?,?,?,now(),now())";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,mail);
	stmt.setString(2,pw);
	stmt.setString(3,name);
	stmt.setString(4,birth);
	stmt.setString(5,gender);
	
	System.out.println("stmt : " + stmt);
	
	int row = stmt.executeUpdate();
	
	if(row == 1) {
		System.out.println("회원가입성공");
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
	
	} else {
		System.out.println("회원가입실패");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
	}
	 
%>
