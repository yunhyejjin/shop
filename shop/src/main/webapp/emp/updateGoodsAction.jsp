<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>  
<%@ page import="java.net.URLEncoder"%>
<!--controller Layer -->
<%
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	//Session 설정값 : 입력시 로그인 emp의 emp_id값이 필요해서
	// 세션변수 이름 - loginEmp
	HashMap<String, Object> loginMember 
		= (HashMap<String, Object>)(session.getAttribute("loginEmp"));
	System.out.println(loginMember);
	System.out.println(loginMember.get("empId"));

%>
<%
	//1. 요청 분석 (입력값 받기)
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String category = request.getParameter("category");
	String empId = request.getParameter("empId");
	String goodsTitle = request.getParameter("goodsTitle");
	String filename = request.getParameter("filename");
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	String goodsContent = request.getParameter("goodsContent");
	
	String goodsImg = request.getParameter("goodsImg");
	
	//디버깅
	System.out.println("empId(수정사원) : " + loginMember.get("empId"));
	System.out.println("goodsNo(update) : " + goodsNo);
	System.out.println("category : " + category);	
	System.out.println("goodsTitle : " + goodsTitle);
	System.out.println("filename : " + filename);
	System.out.println("goodsAmount : " + goodsAmount);
	System.out.println("goodsPrice : " + goodsPrice);
	System.out.println("goodsContent : " + goodsContent);
	
	//새로 수정할 이미지
	String newImg = "";
	Part part = request.getPart("newImg");
	
	String originalName = part.getSubmittedFileName();
	int dotIdx = originalName.lastIndexOf(".");
	String ext = originalName.substring(dotIdx);// .png
	
	UUID uuid = UUID.randomUUID(); // 랜덤문자열(파일명)
	filename = filename + ext;
	
	newImg = filename;
	//디버깅
	System.out.println("newImg : " + newImg);
	
	
	String sql = "UPDATE goods SET category=?, goods_title=?, filename=?, goods_amount=?, goods_price=?, goods_content=? where goods_no=?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null; //초기화
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, category);
	stmt.setString(2, goodsTitle);
	stmt.setString(3, newImg);
	stmt.setInt(4, goodsAmount);
	stmt.setInt(5, goodsPrice);
	stmt.setString(6, goodsContent);
	stmt.setInt(7, goodsNo);
	
	System.out.println(stmt);
	
	int row = 0;
	row = stmt.executeUpdate();
	
	String msg = "";
	if(row == 1) { 
		
		// part -> is -> os -> 빈파일
		// 1)
		InputStream is = part.getInputStream();
		// 3)+ 2)
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath, newImg); // 빈파일
		OutputStream os = Files.newOutputStream(f.toPath()); // os + file
		is.transferTo(os);
		
		is.close();
		os.close();
		msg =  URLEncoder.encode("수정성공!", "UTF-8");
		response.sendRedirect("/shop/emp/goodsOne.jsp?goodsNo="+goodsNo+"&msg="+ msg);
		
	} else {
		msg =  URLEncoder.encode("수정실패!", "UTF-8");
		response.sendRedirect("/shop/emp/goodsOne.jsp?goodsNo="+goodsNo+"&msg="+ msg);
	}
	
	
	
%>