<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>

<%
	String empId = request.getParameter("empId");
	String active = request.getParameter("active");
	
	System.out.println("empId : " + empId);
	System.out.println("변환전 active : " + active);
	
	if(active.equals("OFF")) {
		active = "ON";
	
	} else {
		active = "OFF";
	}
	
	System.out.println("empId : " + empId);
	System.out.println("변환후 active : " + active);

	int row = EmpDAO.EmpActive(active, empId);
	System.out.println("호출성공시 '1' : " + row);
	
	if(row == 1) {
		System.out.println("변환성공");
		response.sendRedirect("/shop/emp/empList.jsp");
	}
	
%>	
	