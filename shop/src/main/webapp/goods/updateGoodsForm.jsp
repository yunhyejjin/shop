<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	// 인증분기 : 세션변수 이름 - loginEmp	
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLogForm.jsp");
		return;
	}
%>

<%
	Int goodsNo = Integer.getParameter("goodsNo");
	System.out.println("goodsNo : " + goodsNo);

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
	
	if(rs.next()) {
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
	
	<h1>상품상세정보수정</h1>
	
	
		<div class="container">
			<div class ="row">
				<div class="col" >
					<div class ="card m-3" style="width:500px">
					
					<form method="post" action="/shop/goods/updateGoodsAction.jsp">
						<img class="card-img-top" input type="file" name="goodsImg">
							<div class ="card-body">
								<p class="card-text">상품번호:<%=rs.getInt("goodsNo")%></p>
								<p class="card-text" input type ="text">상품명:</p>
								<p class="card-text" input type ="text">상품내용:</p>
								<p class="card-text" input type="number">가격:</p>
							</div>
							
							<button type="submit">수정</button>
					</form>	
					
					</div>	
				</div>		
			</div>
		</div>
	
	<div>
		<button type="submit"><a href="/shop/goods/goodsList.jsp">돌아가기</a></button>
	</div>

</body>
</html>

<%		
	} 
	
	response.sendRedirect("/shop/goods/goodsOne.jsp?goodsNo=goodsNo");
%>

	
	
	
	
	