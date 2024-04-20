<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import= "java.net.*"%> 

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
	System.out.println("goodsNo : " + goodsNo);
	
	String sql = "DELETE FROM goods WHERE goods_no= ?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null; // 초기화
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql); // sql 불러오기
	stmt.setInt(1, goodsNo);
	
	int row = stmt.executeUpdate(); // 쿼리문 실행(출력)
	
	System.out.println("delete row : " +row);
	
	if(row == 1) { //삭제할 게시글은 1개니까...
		System.out.println("goods 삭제성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	} else {
		System.out.println("goods 삭제실패");
		response.sendRedirect("/shop/emp/goodsOne.jsp?goodsNo=" + goodsNo);
	}
	
%>
