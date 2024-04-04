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
	int startRow = ((currentPage-1) * 20);
%>

<!--Model Layer -->
<%
	String category = request.getParameter("category");	
			
	System.out.println("category : "+ category);
	
	/*
		null이면 
		SELECT category, COUNT(*)
		FROM goods
		GROUP BY category
		ORDER BY category asc; 카테고리별 오름차순으로 정렬
		
		null 아니면 
		SELECT * FROM goods where category = ? limit ?,?	
	*/

	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	//null일떄
	String sql1 = "select category, COUNT(*) cnt FROM goods GROUP BY category ORDER BY category asc;";
	stmt1 = conn.prepareStatement(sql1); 
	rs1 = stmt1.executeQuery();
	
	ArrayList<HashMap<String, Object>> categoryList 
		= new ArrayList<HashMap<String, Object>>();
	
	while(rs1.next()) {
		HashMap<String,Object> m1 = new HashMap<String,Object>(); 
		m1.put("category", rs1.getString("category")); // HashMap(key, value)
		m1.put("cnt", rs1.getString("cnt"));
		categoryList.add(m1); // categoryList에 HashMap(m1)객체 추가
	}
	
	System.out.println("categoryList : " + categoryList);
	 
	//null이 아닐때
	String sql2 = "select * FROM goods where category = ? limit ?, ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, category); // 카테고리별 품목조회
	stmt2.setInt(2, startRow);
	stmt2.setInt(3, rowPerPage);
	
	rs2 = stmt2.executeQuery();
	
	System.out.println(rs2); //오류확인
	
	ArrayList<HashMap<String, Object>> goodsList 
		= new ArrayList<HashMap<String, Object>>(); 
	
	while(rs2.next()){
		HashMap<String,Object> m2 = new HashMap<String,Object>();
		m2.put("goodsNo", rs2.getInt("goods_no"));
		m2.put("category", rs2.getString("category"));
		m2.put("goodsTitle", rs2.getString("goods_title"));
		m2.put("goodsContent", rs2.getString("goods_content"));
		m2.put("goodsPrice", rs2.getInt("goods_price"));
		m2.put("updateDate", rs2.getString("update_date"));	
		goodsList.add(m2);
	}
	
	System.out.println("goodsList : " + goodsList);
	
%>

<%
	//페이징 쿼리
	String sql3 = "select count(*) from goods";
	
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	
	stmt3 = conn.prepareStatement(sql3);
	rs3 = stmt3.executeQuery();
	
	int totalRow = 0;
	if(rs3.next()) {
		totalRow = rs3.getInt("count(*)");
	}
	
	System.out.println("totalRow: " + totalRow); // 전체행 500
	
	int lastPage = totalRow/rowPerPage; //마지막 페이지 = 전체 행/한 페이지당 보여지는 행(20)
	if(totalRow%rowPerPage !=0) {
		lastPage = lastPage + 1;  // 나머지 값(남은 행)이 생기기 때문에 +1(다음페이지)을 해줘야 함  
	}
	
	System.out.println("lastPage: " + lastPage);
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
		
			<a href="/shop/emp/goodsList.jsp?category=">상품전체보기</a>	
		
		<%
				
				for(HashMap<String,Object> m1 : categoryList) {
					
		%>
				
				<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m1.get("category"))%>">
					<%=(String)(m1.get("category"))%>(<%=(String)(m1.get("cnt"))%>)
				</a>
				
		<%
				}
		%>
		
	</div>	
				
	<div>	
		
		<table border="1">
			<tr>
				<th>goods_No</th>
				<th>goodsTitle</th>
				<th>goodsContent</th>
				<th>goodsPrice</th>
				<th>update_Date</th>
			</tr>
		
		<% 		
				
				for(HashMap<String,Object> m2 : goodsList) {
		
		%>
					<tr>
						<td><%=(Integer)(m2.get("goodsNo"))%></td>
						<td><%=(String)(m2.get("category"))%></td>
						<td><%=(String)(m2.get("goodsTitle"))%></td>
						<td><%=(String)(m2.get("goodsContent"))%></td>
						<td><%=(Integer)(m2.get("goodsPrice"))%></td>
						<td><%=(String)(m2.get("updateDate"))%></td>
					</tr>
		<%			
					
				}
		
		%>
		
		</table>
	
	</div>

</body>
</html>