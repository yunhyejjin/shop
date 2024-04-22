<%@page import="shop.dao.customerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="shop.dao.*" %>
<%@ page import="java.util.*"%>

<%
	//인증분기 : 세션변수 이음 - loginCustomer	
	if(session.getAttribute("loginCustomer") == null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}

	HashMap<String, Object> loginCustomer 
	= (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
	System.out.println(loginCustomer);
	System.out.println("loginCustomerMail : " + loginCustomer.get("customerMail"));
%>

<%	
	
	ArrayList<HashMap<String, Object>> customerOne 
		= customerDAO.customerOne((String)loginCustomer.get("customerMail"));
	
	System.out.println("customerOne : " + customerOne);
	
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
		for(HashMap m : customerOne) {
	%>
		<form method="post" action="/shop/customer/updateCustomerForm.jsp">
		
			<div>mail</div>
			<input type="text" name="oneMail" value="<%=(String)(m.get("mail"))%>" readonly="readonly">
			
			<div>name</div>
			<input type="text" name="oneName" value="<%=(String)(m.get("name"))%>" readonly="readonly">
			
			<div>birth</div>
			<input type="datetime" name="oneBirth" value="<%=(String)(m.get("birth"))%>" readonly="readonly">
			
			<div>gender</div>
			
			<%
				if(((String)(m.get("gender"))).equals("남")) {
			%>
				<input type="radio" name="oneGender" checked="checked" readonly="readonly" > 남
				<input type="radio" name="oneGender" disabled="disabled"> 여 
			<% 	
				}else if(((String)(m.get("gender"))).equals("여")) {	
			%>
				<input type="radio" name="oneGender" disabled="disabled"> 남
				<input type="radio" name="oneGender" checked="checked" readonly="readonly"> 여 
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