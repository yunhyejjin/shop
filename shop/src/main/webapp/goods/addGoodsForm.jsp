<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>

<!--controller Layer -->
<%
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<!--Model Layer -->
<%
	ArrayList<String> categoryList = addGoodsDAO.addGoods();
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
		<jsp:include page="/inc/empMenu.jsp"></jsp:include>
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
			<button type="submit">상품등록</button>
		</div>
	</form>
</body>
</html>