<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println("goodsNo : " + goodsNo);
	
	ArrayList<HashMap<String, Object>> goodsOne = GoodsDAO.goodsOne(goodsNo);	
	System.out.println("goodsOne(update전) : " + goodsOne);
	
	for(HashMap g : goodsOne) {
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
			<input value="<%=(String)(g.get("category"))%>" name="category" readonly="readonly">
		</div>
		
		<!-- empId값음 action쪽에서 세션변수에서 바인딩(가져오기) -->
		<div>
		 	goodsNo :
		 	<input value="<%=(Integer)(g.get("goodsNo"))%>" name="goodsNo" readonly="readonly">
		</div>
		
		<div>
		 	goodsTitle :
		 	<input type="text" name="goodsTitle" value="<%=(String)(g.get("goodsTitle"))%>">
		</div>
		
		<div>
		 	goodsImage :
		 	<img src="/shop/upload/<%=(String)(g.get("goodsImg"))%>"> <!-- 불러올 경로가 없었어..... -->
		 	<input type="file" name="newImg">
		</div>
		
		<div>
		 	goodsAmount :
		 	<input type="number" name="goodsAmount" value="<%=(Integer)(g.get("goodsAmount"))%>">
		 	
		</div>
		
		<div>
		 	goodsPrice :
		 	<input type="number" name="goodsPrice" value="<%=(Integer)(g.get("goodsPrice"))%>">
		</div>
		
		<div>
		 	goodsContent :
		 	<textarea rows="5" cols="50" name="goodscontent"></textarea>
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

	
	
	
	
	
