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
	System.out.println("goodsNo : " + goodsNo);
	
	String sql = "select * from goods where goods_no = ? ";	
	
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
		<jsp:include page="/inc/empMenu.jsp"></jsp:include>
	</div>

	<h1>상품수정</h1>
	
	<form method="post" action="/shop/emp/updateGoodsAction.jsp" 
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
		 	goodsNo :
		 	<input value="<%=rs.getInt("goods_no")%>" name="goodsNo" readonly="readonly">
		</div>
		
		<div>
		 	goodsTitle :
		 	<input type="text" name="goodsTitle" value="<%=rs.getString("goods_title")%>">
		</div>
		
		<div>
		 	goodsImage :
		 	<input type="hidden" name="goodsImg" value="<%=rs.getString("filename")%>">
		 	<input type="file" name="newImg">
		</div>
		
		<div>
		 	goodsAmount :
		 	<input type="number" name="goodsAmount" value="<%=rs.getInt("goods_amount")%>">
		 	
		</div>
		
		<div>
		 	goodsPrice :
		 	<input type="number" name="goodsPrice" value="<%=rs.getInt("goods_price")%>">
		</div>
		
		<div>
		 	goodsContent :
		 	<textarea rows="5" cols="50" name="goodsContent" value="<%=rs.getString("goods_content")%>"></textarea>
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

	
	
	
	
	
