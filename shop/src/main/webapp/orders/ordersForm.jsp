<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	
	if(session.getAttribute("loginCustomer") == null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>

<%
	// 받으려고하는 입력값
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String mail = request.getParameter("mail");
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int totalAmount = Integer.parseInt(request.getParameter("totalAmount"));
	int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>주문창</h1>
	
	<form method="post" action="/shop/orders/ordersAction.jsp">
		
		<div>주문번호</div>
		
		<div>상품번호</div>
		
		<div>주문수량</div>
		<input type="number" name="amount">
		<div>총주믄금액</div>
		
		<div>주문하는사람</div>
		<div>주소</div>
		<textarea rows="1" cols="50">주소를입력해주세요</textarea>
		
		<div>
		 <button type="submit">주문하기</button>
		</div>
		
	</form>
	
	

</body>
</html>