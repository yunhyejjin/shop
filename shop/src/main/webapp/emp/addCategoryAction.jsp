<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8"); //한글깨짐 방지
%>

<%
	// 인증분기 : 세션변수 이름 - loginEmp	
	//if(session.getAttribute("loginEmp") == null) {
	//	response.sendRedirect("/shop/emp/empLogForm.jsp");
	//	return;
	//}
%>

<%
	String category = request.getParameter("category");
	System.out.println("Add-category : " + category);
	
	String sql = " insert into category(category) values(?)";
	
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	Connection conn = null;
	PreparedStatement stmt = null;
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, category);
	
	System.out.println("stmt확인 : " + stmt);
	
	int row = 0;
	row = stmt.executeUpdate();
	
	if(row == 1) {
		System.out.println("추가완료");
	
	}else {
		System.out.println("추가실패. 다시확인해주세요.");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}
	
	response.sendRedirect("/shop/emp/categoryList.jsp");
%>
