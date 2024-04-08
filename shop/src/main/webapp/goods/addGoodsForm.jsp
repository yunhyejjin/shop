<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<!--controller Layer -->
<%
	
	// 인증분기 : 세션변수 이름 - loginEmp	
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLogForm.jsp");
		return;
	}
%>

<!--Model Layer -->
<%
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "SELECT category FROM category";
	stmt1 = conn.prepareStatement(sql1); 
	rs1 = stmt1.executeQuery();
	
	ArrayList<String> categoryList = new ArrayList<String>();
	
	while(rs1.next()) {
		
		categoryList.add(rs1.getString("category")); // categoryList 객체저장
	}
	
	System.out.println("goods-categoryList : " + categoryList);
%>
<!-- View Layer -->
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
		 	goodsAmount :
		 	<input type="number" name="goodsAmount">
		</div>
		<div>
		 	goodsContent :
		 	<textarea rows="5" cols="50" name="goodsContent"></textarea>
		</div>
		
		<div>
			<button type="submit">상품등록</button>
		</div>
	</form>
</body>
</html>