<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%> 
<%@ page import="java.util.*"  %>

<%
	// 인증분기 : 세션변수 이름 - loginCustomer
	//String loginCustomer = (String)(session.getAttribute("loginCustomer"));
	//System.out.println("loginCustomer(session) : " + loginCustomer);
	
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/goodsList.jsp");
		return;
	}
%>

<%
	String customerMail = request.getParameter("customerMail");
	String customerPw = request.getParameter("customerPw");
	
	System.out.println("customerMail : " + customerMail);
	System.out.println("customerPw : " + customerPw);
	
	/*
	select * from customer 
	where mail =? and pw = password(?)
	*/
	
	String sql="select * from customer where mail =? and pw = password(?)";
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql); 
	stmt.setString(1,customerMail);
	stmt.setString(2,customerPw);
	rs = stmt.executeQuery(); // 쿼리문
	
	System.out.println(rs);
%>

<%	
	/*
		실패 / customer/LoginForm.jsp	
		성공 / customer/goodsList.jsp	
	*/
	
	if(rs.next()) {
		System.out.println("로그인 성공");
		// 하나의 세션변수안에 여러개의 값을 저장하기 위해서 HashMap타입을 사용
		HashMap<String, Object> loginCustomer = new HashMap<String, Object>();
		loginCustomer.put("customerMail", rs.getString("mail"));
		loginCustomer.put("customerPw", rs.getString("pw"));
		
		session.setAttribute("loginCustomer", loginCustomer); // session이 "loginCustomer"
		
		// 디버깅
		HashMap<String, Object> m = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
		
		System.out.println("login-mail : " + (String)m.get("customerMail"));
		System.out.println("login-pw : " + (String)m.get("customerPw"));
		
		response.sendRedirect("/shop/customer/goodsList.jsp");
		
	} else {
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요.", "utf-8");
		response.sendRedirect("/shop/customer/LoginForm.jsp?=errMsg" +errMsg);	
		
	}
	
	
%>
