<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%
	
	if(session.getAttribute("loginCustomer") == null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>

<%
	//입력값
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	
	System.out.println("customer mail : " + mail);
	System.out.println("customer pw(수정) : " + pw);
	System.out.println("customer name(수정) : " + name);
	System.out.println("customer gender(수정) : " + gender);
	
	int row = CustomerDAO.updateCustomer(mail, pw, name, gender);
		
	if(row == 1) {
		System.out.println("추가완료");	
		response.sendRedirect("/shop/customer/customerOne.jsp");
	
	}else {
		System.out.println("추가실패. 다시확인해주세요.");
		response.sendRedirect("/shop/customer/updateCustomerForm.jsp");
	}
	
	
%>