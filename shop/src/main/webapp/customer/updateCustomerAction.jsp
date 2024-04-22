<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	
	if(session.getAttribute("loginCustomer") == null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>

<%
	//입력값
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	
	System.out.println("customer pw(수정) : " + pw);
	System.out.println("customer name(수정) : " + name);
	System.out.println("customer gender(수정) : " + gender);
	
	String sql = "UPDATE customer SET pw = ?, name = ?, gender = ?";
	
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	Connection conn = null;
	PreparedStatement stmt = null;
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql); 
	stmt.setString(1,pw);
	stmt.setString(2,name);
	stmt.setString(3,gender);
	
	int row = 0;
	row = stmt.executeUpdate();
	
	
	if(row == 1) {
		System.out.println("추가완료");	
	
	}else {
		System.out.println("추가실패. 다시확인해주세요.");
		response.sendRedirect("/shop/customer/updateCustomerForm.jsp");
	}
	
	response.sendRedirect("/shop/customer/customerOne.jsp");
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

</body>
</html>