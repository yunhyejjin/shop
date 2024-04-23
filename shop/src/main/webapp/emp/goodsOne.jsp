<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"  %>
<%@ page import="shop.dao.*" %>

<%
	int goodsNo	= Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println("goodsNo(goodsOne) : " + goodsNo);

	ArrayList<HashMap<String,Object>>goodsOne = GoodsDAO.goodsOne(goodsNo);
	System.out.println(goodsOne); // goodsNo() 상세보기 
	
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
		for(HashMap<String,Object> m : goodsOne) {
	%>	
	
		<div class="container">
			<div class ="row">
				<div class="col" >
					<div class ="card m-3" style="width:500px">
						<img class="card-img-top" src="/shop/upload/<%=(String)(m.get("fileName"))%>">
						<div class ="card-body">
							<p class="card-text">상품번호:<%=(Integer)(m.get("goodsNo"))%></p>
							<p class="card-text">상품명:<%=(String)(m.get("goodsTitle"))%></p>
							<p class="card-text">상품내용:<%=(String)(m.get("goodsContent"))%></p>
							<p class="card-text">가격:<%=(Integer)(m.get("goodsPrice"))%></p>
						</div>
					</div>	
				</div>		
			</div>
		</div>
	
	<%
		}
	%>
	
	<div>
		<a href="/shop/emp/updateGoodsForm.jsp?goodsNo=<%=goodsNo%>">상품수정</a>
		<a href="/shop/emp/deleteGoodsAction.jsp?goodsNo=<%=goodsNo%>">상품삭제</a>
	</div>

</body>
</html>