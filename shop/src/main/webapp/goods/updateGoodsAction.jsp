<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<!--controller Layer -->
<%
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	//1. 요청 분석 (입력값 받기)
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	String filename = request.getParameter("filename");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	String goodsContent = request.getParameter("goodsContent");
	
	System.out.println("goodsNo(update) : " + goodsNo);
	System.out.println("category: " + category);
	System.out.println("goodsTitle: " + goodsTitle);
	System.out.println("filename: " + filename);
	System.out.println("goodsPrice: " + goodsPrice);
	System.out.println("goodsContent: " + goodsContent);
	
	String sql = "UPDATE goods SET category =?, goods_title =? , filename=?, goods_price=?, goods_content=?, where goods_no=?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null; //초기화
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, category);
	stmt.setString(2, goodsTitle);
	stmt.setString(3, filename);
	stmt.setInt(4, goodsPrice);
	stmt.setString(5, goodsContent);
	stmt.setInt(6, goodsNo);
	
	System.out.println(stmt);
	
	int row = 0;
	row = stmt.executeUpdate();
	
	if(row == 1) { // 실행(수정)한 결과가 틀림, 출력실패 -> 입력값이 틀렸다.
		response.sendRedirect("/shop/goods/GoodsOne.jsp?goodsNo="+goodsNo);
	} else {
		response.sendRedirect("/shop/goods/updateGoodsForm.jsp?goodsNo="+goodsNo);
	}
	
	
	
%>