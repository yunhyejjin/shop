<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%
	// 세션변수 이름 - loginEmp
	HashMap<String, Object> loginMember 
		= (HashMap<String, Object>)(session.getAttribute("loginEmp"));
%>

<div>
	<span>
		<!-- 개인정보보기 -->
		<a href="/shop/emp/empOne.jsp">
			<%=(String)(loginMember.get("empName"))%>님
		</a>반갑습니다
	</span>
</div>

<div>	
	<a href="/shop/emp/empList.jsp">사원관리</a>
	<!-- category CRUD -->
	<a href="/shop/goods/categoryList.jsp">카테고리관리</a>
	<a href="/shop/goods/goodsList.jsp">상품관리</a>	
</div>