<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"  %>
<%@ page import="shop.dao.*" %>

<%
	
	if(session.getAttribute("loginCustomer") == null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>

<%
	int goodsNo	= Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println("customer goodsNo(goodsOne) : " + goodsNo);
	
	ArrayList<HashMap<String, Object>> customerGoodsOne 
		= GoodsDAO.goodsOne(goodsNo);	

%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
		<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	
	<h1>상품상세정보</h1>
	
	<%
		for(HashMap c : customerGoodsOne) {
	%>	
	
		<div class="container">
			<div class ="row">
				<div class="col" >
					<div class ="card m-3" style="width:500px">
						<img class="card-img-top" src="/shop/upload/<%=(String)(c.get("fileName"))%>">
						<div class ="card-body">
							<p class="card-text">상품번호:<%=(Integer)(c.get("goodsNo"))%></p>
							<p class="card-text">상품명:<%=(String)(c.get("goodsTitle"))%></p>
							<p class="card-text">상품내용:<%=(String)(c.get("goodsContent"))%></p>
							<p class="card-text">가격:<%=(Integer)(c.get("goodsPrice"))%></p>
						</div>
						<div><a href="/shop/customer/customerOrdersForm.jsp?=<%=goodsNo%>">주문하기</a></div>
					</div>	
				</div>		
			</div>
		</div>
	
	<%
		}
	%>
	
	<div>
		<a href="/shop/customer/customerGoodsList.jsp">리스트로</a>
	</div>

</body>
</html>