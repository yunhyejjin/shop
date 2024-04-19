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
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	System.out.println("customer mail : " + mail);
	System.out.println("customer pw : " + pw);
	System.out.println("customer name : " + name);
	System.out.println("customer birth : " + birth);
	System.out.println("customer gender : " + gender);
	
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