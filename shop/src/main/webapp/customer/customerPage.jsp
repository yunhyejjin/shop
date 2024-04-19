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
<title>Insert title here</title>
</head>
<body>
	<h1>마이페이지</h1>
	
	<%
		if(rs.next()) {
	%>
		<form method="post" action="/shop/customer/updateCustomerForm.jsp">
		
			<div>mail</div>
			<input type="text" name="mail" value="<%=rs.getString("mail")%>" readonly="readonly">
			
			<div>name</div>
			<input type="text" name="name" value="<%=rs.getString("name")%>" readonly="readonly">
			
			<div>birth</div>
			<input type="datetime" name="birth" value="<%=rs.getString("birth")%>" readonly="readonly">
			
			<div>gender</div>
			<%
				if(rs.getString("gender").equals("남")){
			%>
				<input type="radio" name="남" checked> 남
				<input type="radio" name="여"> 여 
			<% 	
				}else{	
			%>
				<input type="radio" name="남"> 남
				<input type="radio" name="여" checked> 여 
			<%
				}
			%>
			
			<div>
				<button type="submit">개인정보수정하기</button>
			</div>
		
		</form>
	
	<%
		}
	%>
	
	<hr>
	
	<div>
		<a href="/shop/customer/customerGoodsList.jsp">
			<button type="submit">리스트</button>
		</a>
	</div>

</body>
</html>