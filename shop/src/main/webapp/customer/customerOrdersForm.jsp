<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"  %>
<%@ page import="shop.dao.*" %>
    
<%
	// 주문고객확인용 session
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
	System.out.println(loginCustomer);
	System.out.println(loginCustomer.get("customerMail"));
%>
<%
	// 요청값
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println("customerOrdersForm-goodsNo : " + goodsNo);	
%>
<%
	// 주문창에 보여질 상품정보 가져오기
	ArrayList<HashMap<String,Object>> goodsList = GoodsDAO.goodsOne(goodsNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>상품주문</h1>
	
	<form method="post" action="/shop/customer/customerOrdersAction.jsp">
		<input type="hidden" value="<%=loginCustomer.get("customerMail")%>">
		<input type="hidden" value="<%="state"%>">
		
		<%
			for(HashMap<String,Object> c : goodsList) {
		%>
			<input type="hidden" name="goodsNo" value="<%=(Integer)(c.get("goodsNo"))%>">
			<div>주문할상품</div>
				<img alt="" src="/shop/upload/<%=(String)(c.get("fileName"))%>">
			<div>상품이름</div>
				<input type="text" name="goodsTitle" value="<%=(String)(c.get("goodsTitle"))%>" readonly="readonly">
				
			<div>상품금액</div>
				<input type="number" name="goodsPrice" value="<%=(Integer)(c.get("goodsPrice"))%>" readonly="readonly">
				
			<div>남은수량</div>
				<input type="number" name="goodsAmount" value="<%=(Integer)(c.get("goodsAmount"))%>" readonly="readonly">
		<%
			}
		%>
		<!-- 고객입력부분 -->
		<hr>	
		<div>주문수량</div>
			<input type="number" name="totalAmount">
		<div>총주문금액</div>
			<input type="number" name="totalPrice">
		<div>주소</div>
			<input type="text" name="address">
		
		<div>
		 	<button type="submit">주문하기</button>
		</div>
		
	</form>
	
	

</body>
</html>