<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import="java.util.*"%>

<%
	String checkMail = request.getParameter("checkMail");
	System.out.println("checkAction.jsp check-Mail : " + checkMail);
	
	int row = CustomerDAO.check(checkMail);
	
	if(row == 1) {
		// 메일 사용 불가능 (이미 가입한 메일이 존재)
		System.out.println("메일 사용 불가능");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?ck=X");
		
	} else {
		// 메일 사용 가능
		System.out.println("메일 사용 가능");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkMail="+checkMail+"&ck=O");
	} 
	
%>
