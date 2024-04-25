<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"  %>
<%@ page import="shop.dao.*" %>
<%
	// 주문회원 확인용
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
	System.out.println(loginCustomer);
%>
<%
	String mail = request.getParameter(loginCustomer.get("customerMail"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int totalAmount = Integer.parseInt(request.getParameter("totalAmount"));
	int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
	String address = request.getParameter("address");
	String state = request.getParameter("state");
	
	//System.out.println("customerOrderAction-mail : " + mail);
	System.out.println("customerOrderAction-goodsNo : " + goodsNo);
	System.out.println("customerOrderAction-totalAmount : " + totalAmount);
	System.out.println("customerOrderAction-totalPrice : " + totalPrice);
	System.out.println("customerOrderAction-address : " + address);
	//System.out.println("customerOrderAction-state : " + state);
	
	int row = OrdersDAO.customerOrder(mail, goodsNo, totalAmount, totalPrice, address, state);
	
	if(row == 1) {
		System.out.println("주문성공");
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
	
	} else {
		System.out.println("주문실패");
		response.sendRedirect("/shop/customer/customerOrdersForm.jsp");
	}

%>
