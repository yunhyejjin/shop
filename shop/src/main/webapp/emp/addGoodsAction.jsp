<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>

<!--controller Layer -->
<%
	request.setCharacterEncoding("UTF-8");
	// 인증분기 : 세션변수 이름 - loginEmp	
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLogForm.jsp");
		return;
	}
%>

<!-- Session 설정값 : 입력시 로그인 emp의 emp_id값이 필요해서 -->
<%
	// 세션변수 이름 - loginEmp
	HashMap<String, Object> loginMember 
		= (HashMap<String, Object>)(session.getAttribute("loginEmp"));
%>

<!--Model Layer -->
<%
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsContent = request.getParameter("goodsContent");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));

	System.out.println("category : " + category);
	System.out.println("goodsTitle : " + goodsTitle);
	System.out.println("goodsContent : " + goodsContent);
	System.out.println("goodsPrice : " + goodsPrice);
	System.out.println("goodsAmount : " + goodsAmount);

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;

	String sql = "insert into goods(category, emp_id, goods_title, goods_content, goods_price, goods_amount, update_date, create_date) value(?,?,?,?,?,?,now(),now())";
	conn = DriverManager.getConnection( // DB접속
	"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, category);
	stmt.setString(2, (String) (loginMember.get("empId")));
	stmt.setString(3, goodsTitle);
	stmt.setString(4, goodsContent);
	stmt.setInt(5, goodsPrice);
	stmt.setInt(6, goodsAmount);

	System.out.println(stmt);

	int row = 0;
	row = stmt.executeUpdate();

	if (row == 1) {
		System.out.println("상품등록성공");

	} else {
		System.out.println("상품등록실패,다시확인해주세요");
		response.sendRedirect("/shop/emp/addGoodsForm.jsp");
	}
%>

<!--controller Layer -->
<%
	response.sendRedirect("/shop/emp/goodsList.jsp");
%>