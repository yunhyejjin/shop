<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>

<%
	// 인증분기 : 세션변수 이름 - loginEmp	
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLogForm.jsp");
		return;
	}
%>

<%
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "select * from category";
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	
	while(rs1.next()) {
		HashMap<String, Object> h = new HashMap<String, Object>();
		h.put("category", rs1.getString("category"));
		h.put("createDate", rs1.getString("create_date"));
		categoryList.add(h);
	}
	
	System.out.println("categoryList : " + categoryList);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>카테고리관리</title>
</head>
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<div><a href="/shop/emp/empLogout.jsp">로그아웃</a></div>
	
	<h1>카테고리 관리</h1>
	
	<div>

		<table border= "1">
			
			<tr>
				<td>category</td>
				<td>create_date</td>
				<td>관리</td>
			</tr>
			
			<%
				for(HashMap<String, Object> h : categoryList) {
			%>
					<tr>
						<td><%=(String)(h.get("category"))%></td>
						<td><%=(String)(h.get("createDate"))%></td>
						<td>
							<a href="/shop/emp/deleteCategoryAction.jsp?category=<%=(String)(h.get("category"))%>">
								<button type="submit">삭제</button>
							</a>
						</td>
					</tr>		
			<%		
				}
			%>
			
		</table>
		
	</div>
	
	<div>
		<form method="post" action="/shop/emp/addCategoryAction.jsp" >
			<input type="text" name="category" placeholder="category name">
			<button type="submit">추가</button>		
		</form>
	</div>

</body>
</html>