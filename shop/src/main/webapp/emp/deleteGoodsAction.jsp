<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.net.*"%> 
<%@ page import="shop.dao.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	// 인증분기 : 세션변수 이름 - loginEmp	
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLogForm.jsp");
		return;
	}
%>

<%
	//요청값
	int goodsNo	= Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println("goodsNo(delete) : " + goodsNo);
	
	int row = GoodsDAO.deleteGoods(goodsNo);
	System.out.println("delete row : " +row);
	
	if(row == 1) { //삭제할 게시글은 1개니까...
		System.out.println("goods 삭제성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	} else {
		System.out.println("goods 삭제실패");
		response.sendRedirect("/shop/emp/goodsOne.jsp?goodsNo=" + goodsNo);
	}
	
%>
