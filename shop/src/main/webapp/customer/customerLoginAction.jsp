<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%> 
<%@ page import="java.util.*"  %>
<%@ page import="shop.dao.*" %>

<%
	// 인증분기 : 세션변수 이름 - loginCustomer
	//String loginCustomer = (String)(session.getAttribute("loginCustomer"));
	//System.out.println("loginCustomer(session) : " + loginCustomer);
	// 로그인을 한 적이 없으면 null(초기화값)로그아웃상태, null이 아니면 goodsList로 넘어감 
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>

<%
// DAO 요청값
	String customerMail = request.getParameter("customerMail");
	String customerPw = request.getParameter("customerPw");
	//디버깅
	System.out.println("customerMail : " + customerMail);
	System.out.println("customerPw : " + customerPw);
	
	HashMap<String, Object> loginCustomer = CustomerDAO.customerLogin(customerMail, customerPw); // 로그인한 customer mail,pw
	System.out.println("loginCustomer(session) : " + loginCustomer);
%>

<%	
	/*
		실패 / customer/customerLoginForm.jsp	
		성공 / customer/customerGoodsList.jsp	
	*/
	
	if(loginCustomer == null) {
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요.", "utf-8");
		response.sendRedirect("/shop/customer/customerLoginForm.jsp?=errMsg" +errMsg);			
		
	} else {
		System.out.println("로그인 성공");
		session.setAttribute("loginCustomer", loginCustomer); // session(속성명,값)이 "loginCustomer" 생성
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
	}
	
	
%>
