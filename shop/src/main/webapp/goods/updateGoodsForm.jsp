<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import= "java.net.*"%> 
<%@ page import= "shop.dao.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	// 인증분기 : 세션변수 이름 - loginEmp	
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLogForm.jsp");
		return;
	}
%>

<%
	ArrayList<String> categoryList = addGoodsDAO.addGoods();
	System.out.println("goods-categoryList : " + categoryList);	
%>

<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println("goodsNo(update) : " + goodsNo);

	String sql = "select * from goods WHERE goods_no = ?";	
	
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1,goodsNo);
	System.out.println("stmt: " + stmt);
	
	rs = stmt.executeQuery();
	
	
	if(rs.next()) {
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>

	<h1>상품등록</h1>
	
	<form method="post" action="/shop/goods/addGoodsAction.jsp" 
			enctype="multipart/form-data">
		
		<div>
			category :
			<select name="category">
				<option value="">선택</option>
				<%
					for(String s : categoryList){
				%>
					 <option value="<%=s%>"><%=s%></option>
				<% 		
					}
				%>		
			</select>
		</div>
		
		<!-- empId값음 action쪽에서 세션변수에서 바인딩(가져오기) -->
		<div>
		 	goodsTitle :
		 	<input type="text" name="goodsTitle">
		</div>
		
		<div>
		 	goodsImage :
		 	<input type="file" name="goodsImg">
		</div>
		
		<div>
		 	goodsPrice :
		 	<input type="number" name="goodsPrice">
		</div>
		
		<div>
		 	goodsContent :
		 	<textarea rows="5" cols="50" name="goodsContent"></textarea>
		</div>
		
		<div>
			<button type="submit">상품수정</button>
		</div>
	</form>
</body>
</html>

<%		
	} 
	
%>

	
	
	
	
	
