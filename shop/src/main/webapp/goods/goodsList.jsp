<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>

<!--controller Layer -->
<%
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	Connection conn = null;
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
%>

<%
	//현재페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 6; // 한페이지당 보여지는 row수 20개
	int startRow = ((currentPage-1) * rowPerPage); // 시작 row
%>

<!--Model Layer -->
<%	
	// category 요청값
	String category = request.getParameter("category");	
	System.out.println("category : " + category);
	
	if(category == null) {
		category = ""; // category 값이 null값이면(전체출력) 공백으로 값을 나타냄.
	}
	
	//전체 출력문
	ArrayList<HashMap<String, Object>> total = GoodsCntDAO.CategoryList(category, cnt);
	System.out.println("categoryList : " + CategoList);
	
	// 카테고리별 출력문
	ArrayList<HashMap<String, Object>> goodsList = GoodsDAO.GoodsList(category, startRow, rowPerPage);
	
	System.out.println("goodsList : " + goodsList);
	
	
	
	//카테고리별 페이징 출력문
	String sql2 = "select count(*) cnt from goods where category like ?";
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1,"%"+category+"%"); // 이 "category" 가 들어가는 부분을 페이징
	
	rs2 = stmt2.executeQuery();
	
	int totalRow = 0;
	if(rs2.next()) {
		totalRow = rs2.getInt("cnt");
	}

	System.out.println("totalRow: " + totalRow);
	
	int lastPage = totalRow / rowPerPage; 
	if(totalRow%rowPerPage !=0) { 
		lastPage = lastPage + 1; 
	}
	
	System.out.println("lastPage: " + lastPage);
	
	
%>
<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsList</title>
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<div><a href="/shop/emp/empLogout.jsp">로그아웃</a></div>
	
	<div>
		<a href="/shop/goods/addGoodsForm.jsp">상품등록</a>
	</div>
	
	<!-- 서브메뉴 카테고리별 상품리스트-->
	<nav class="navbar navbar-expand-sm bg-danger justify-content-center">
		<div class="container">
			<ul class="navbar-nav">
						 	<li class="nav-item">
								<a class="nav-link" href="/shop/goods/goodsList.jsp">전체</a>
							</li>
				<%
						for(HashMap<String,Object> m : categoryList) {		
				%>
							<li class="nav-item">
								<a class="nav-link" href="/shop/goods/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
									<%=(String)(m.get("category"))%>(<%=(Integer)(m.get("cnt"))%>)
								</a>
							</li>			
				<%
						}
				%>	
			<ul class="navbar-nav">
		</div>
	</nav>
	
	<div class ="row">
	
			<% 
					for(HashMap<String,Object> m1 : goodsList) {	
						
			%>	
					<div class="col-4" >
						<div class ="card m-3" style="width:500px">
							<a href="/shop/goods/goodsOne.jsp?goodsNo=<%=(Integer)(m1.get("goodsNo"))%>">
								<img class="card-img-top" src="/shop/upload/<%=(String)(m1.get("fileName"))%>">
							</a>
							<div class ="card-body">
								<p class="card-text">상품번호:<%=(Integer)(m1.get("goodsNo"))%></p>
								<p class="card-text">상품명:<%=(String)(m1.get("goodsTitle"))%></p>
								<p class="card-text">가격:<%=(Integer)(m1.get("goodsPrice"))%></p>
							</div>
						</div>	
					</div>		
			<%			
					}
			%>	

	</div>
	
		<!-- 페이징 -->
	<div>
		<ul class="pagination">
		
			<%
				if(currentPage > 1) {
			%>
					<li class="page-item">
						<a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=1&category=<%=category%>">처음페이지</a>
					</li>
					<li class="page-item">	
						<a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">이전페이지</a>
					</li>				
			<%		
				} else {
			%>
					<li class="page-item disabled">
						<a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=1&category=<%=category%>">처음페이지</a>
					</li>
					<li class="page-item disabled">
						<a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">이전페이지</a>
					</li>
			<%		
				}
			%>
				
			<%
				if(currentPage < lastPage) {
			%>
					<li class="page-item">
						<a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">다음페이지</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">마지막페이지</a>
					</li>
			<% 	
				}
			%>	
					
		</ul>
	</div>
</body>
</html>