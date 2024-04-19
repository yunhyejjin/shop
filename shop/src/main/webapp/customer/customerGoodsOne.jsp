<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<%
	
	if(session.getAttribute("loginCustomer") == null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>

<%
	int goodsNo	= Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println("goodsNo(goodsOne) : " + goodsNo);

	String sql = "select * FROM goods where goods_no = ? ";	
	
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1,goodsNo);
	rs = stmt.executeQuery();
	
	System.out.println("rs : " + rs);
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
		if(rs.next()) {
	%>	
	
		<div class="container">
			<div class ="row">
				<div class="col" >
					<div class ="card m-3" style="width:500px">
						<img class="card-img-top" src="/shop/upload/<%=rs.getString("filename")%>">
						<div class ="card-body">
							<p class="card-text">상품번호:<%=rs.getInt("goods_no")%></p>
							<p class="card-text">상품명:<%=rs.getString("goods_title")%></p>
							<p class="card-text">상품내용:<%=rs.getString("goods_content")%></p>
							<p class="card-text">가격:<%=rs.getInt("goods_price")%></p>
						</div>
					</div>	
				</div>		
			</div>
		</div>
	
	<%
		}
	%>
	
	<div>
		<a href="/shop/orders/ordersForm.jsp">주문하기</a>
		<a href="/shop/customer/customerGoodsList.jsp">리스트로</a>
	</div>

</body>
</html>