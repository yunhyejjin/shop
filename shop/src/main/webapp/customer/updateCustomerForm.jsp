<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import="java.util.*"%>
<%
	
	if(session.getAttribute("loginCustomer") == null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>
<%
	// 요청값
	String oneMail = request.getParameter("oneMail");
	System.out.println("updatecustomerForm.jsp mail : " + oneMail);
	
	ArrayList<HashMap<String, Object>> customerOne = CustomerDAO.customerOne(oneMail);
	System.out.println("updatecustomerForm.jsp customerOne : " + oneMail);
	
	
	
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
		for(HashMap c : customerOne){
	%>
	<form method="post" action="/shop/customer/updateCustomerAction.jsp">
		
		<div>mail</div>
		<input type="text" name="mail" value="<%=(String)(c.get("mail"))%>" readonly="readonly">
		
		<div>pw</div>
		<input type="password" name="pw">
		
		<div>name</div>
		<input type="text" name="name">
		
		<div>birth</div>
		<input type="datetime" name="birth" value="<%=(String)(c.get("birth"))%>" readonly="readonly">
		
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