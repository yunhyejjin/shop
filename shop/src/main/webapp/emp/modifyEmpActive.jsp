<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>

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

	int row = EmpActiveDAO.EmpActive(active, empId);
	System.out.println(row);
	
	if(row == 1) {
		System.out.println("변환성공");
		response.sendRedirect("/shop/emp/empList.jsp");
	}
	
%>	
	