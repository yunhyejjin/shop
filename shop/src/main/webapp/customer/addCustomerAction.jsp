<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%
	//1.입렵값 받기
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	System.out.println("add-mail :  "  + mail);
	System.out.println("add-pw :  "  + pw);
	System.out.println("add-name :  "  + name);
	System.out.println("add-birth :  "  + birth);
	System.out.println("add-gender :  "  + gender);
		
	int row = CustomerDAO.addCustomer(mail, pw, name, birth, gender);
	
	if(row == 1) {
		System.out.println("회원가입성공");
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
	
	} else {
		System.out.println("회원가입실패");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
	}
	 
%>