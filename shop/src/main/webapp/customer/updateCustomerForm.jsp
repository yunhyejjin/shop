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
	
	String sql = " select * from customer";
	
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql); 
	rs = stmt.executeQuery();
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>회원정보수정</h1>
	
	<%
		if(rs.next()){
	%>
	<form method="post" action="/shop/customer/updateCustomerAction.jsp">
		
		<div>mail</div>
		<input type="text" name="mail" value="<%=rs.getString("mail")%>" readonly="readonly">
		
		<div>pw</div>
		<input type="password" name="pw">
		
		<div>name</div>
		<input type="text" name="name">
		
		<div>birth</div>
		<input type="datetime" name="birth" readonly="readonly">
		
		<div>gender</div>
		<input type="radio" name="남"> 남
		<input type="radio" name="여"> 여 
		
		<div>
			<button type="submit">수정하기</button>
		</div>
	
	</form>
	<%
		}
	%>
	<hr>
	
	<div>
		<a href="/shop/customer/customerOne.jsp">
			<button type="submit">마이페이지</button>
		</a>
	</div>

</body>
</html>