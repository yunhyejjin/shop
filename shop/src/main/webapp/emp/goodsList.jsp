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

<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 20; // 한페이지당 보여지는 행수가 20개다
	int stratRow = ((currentPage-1) * 20);
%>	

<%	
	String category = request.getParameter("category");		
%>

<!--Model Layer -->
<%
	/*
		null이면
		SELECT category, COUNT(*)
		FROM goods
		GROUP BY category
		ORDER BY category asc; 카테고리별 오름차순으로 정렬
		null 아니면
		SELECT * FROM goods where category = ?	
	*/



	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "SELECT category, COUNT(*) cnt FROM goods GROUP BY category ORDER BY category asc";
	stmt1 = conn.prepareStatement(sql1); 
	rs1 = stmt1.executeQuery();
	
	ArrayList<HashMap<String, Object>> categoryList 
		= new ArrayList<HashMap<String, Object>>();
	
	while(rs1.next()) {
		HashMap<String,Object> hm = new HashMap<String,Object>(); 
		hm.put("category", rs1.getString("category"));
		hm.put("cnt", rs1.getString("cnt"));
		categoryList.add(hm); // categoryList 객체저장
	}
	
	System.out.println(categoryList);
%>

<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsList</title>
</head>
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<div>
		<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>
	</div>
	
	<!-- 서브메뉴 카테고리별 상품리스트-->
	<div>
		<%
			for(HashMap hm : categoryList) {
		%>
				<a href="/shop/emp/goodsList.jsp?=<%=(String)(hm.get("category"))%>">
					<%=(String)(hm.get("category"))%>(<%=(String)(hm.get("cnt"))%>)
				</a>
		
		<%
			}
		%>
	
		<a href="/shop/emp/goodsList.jsp">전체</a>
		
	</div>
	
	<div>
		<table border="1">
			<tr>
				<th>category</th>
				<th>goodsTitle</th>
				<th>goodscontent</th>
				<th>goodsprice</th>
				<th>update_date</th>
			</tr>
			<%
			
			%>
		</table>
	</div>

</body>
</html>