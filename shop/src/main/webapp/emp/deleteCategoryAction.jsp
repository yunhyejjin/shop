<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%
	request.setCharacterEncoding("UTF-8"); //한글깨짐 방지
%>

<%
	// 인증분기 : 세션변수 이름 - loginEmp	
	// if(session.getAttribute("loginEmp") == null) {
	//	response.sendRedirect("/shop/emp/empLogForm.jsp");
	//	return;
	//}
%>

<%
	String category = request.getParameter("category");
	System.out.println("delete-category : " + category);
	
	int row = CategoryDAO.deleteCategory(category);
	System.out.println("delete-row : " + category);
	
	if(row == 1) {
		System.out.println("삭제완료");
	
	}else {
		System.out.println("삭제실패. 다시확인해주세요.");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}
	
	response.sendRedirect("/shop/emp/categoryList.jsp");
%>

