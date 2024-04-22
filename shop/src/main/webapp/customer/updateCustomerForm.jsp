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
	// 요청값
	String oneMail = request.getParameter("oneMail");
	String oneBirth = request.getParameter("oneBirth");
		
	System.out.println("customer mail : " + oneMail);
	System.out.println("customer birth : " + oneBirth);

	
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
		<input type="datetime" name="birth" value="<%=rs.getString("birth")%>" readonly="readonly">
		
		<div>gender</div>
		<input type="radio" name="gender" value="남"> 남
		<input type="radio" name="gender" value="여"> 여 
		
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