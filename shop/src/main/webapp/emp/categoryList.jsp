<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>

<%
	// 인증분기 : 세션변수 이름 - loginEmp	
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLogForm.jsp");
		return;
	}
%>
<%
	ArrayList<HashMap<String, Object>> categoryList = CategoryDAO.categoryList();
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
		<jsp:include page="/inc/empMenu.jsp"></jsp:include>
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
						<td><%=(String)(h.get("createdate"))%></td>
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