<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>

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
	System.out.println("goodsPrice : " + request.getParameter("goodsPrice"));
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	
	System.out.println("category : " + category);
	System.out.println("goodsTitle : " + goodsTitle);
	
	System.out.println("goodsContent : " + goodsContent);
	System.out.println("goodsPrice : " + goodsPrice);
	System.out.println("goodsAmount : " + goodsAmount);
	
	Part part = request.getPart("goodsImg");
	// 업로드된 원본 파일 이름
	String originalName = part.getSubmittedFileName();
	int dotIdx = originalName.lastIndexOf(".");
	String ext = originalName.substring(dotIdx);// .png
	
	UUID uuid = UUID.randomUUID(); // 랜덤문자열(파일명)
	String filename = uuid.toString().replace("-", "");
	filename = filename + ext;
	

	System.out.println("category : " + category);
	System.out.println("goodsTitle : " + goodsTitle);
	System.out.println("filename : " + filename);
	System.out.println("goodsContent : " + goodsContent);
	System.out.println("goodsPrice : " + goodsPrice);
	System.out.println("goodsAmount : " + goodsAmount);

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;

	String sql = "insert into goods(category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, update_date, create_date) value(?,?,?,?,?,?,?,now(),now())";
	conn = DriverManager.getConnection( // DB접속
	"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, category);
	stmt.setString(2, (String) (loginMember.get("empId"))); //  Session 설정값
	stmt.setString(3, goodsTitle);
	stmt.setString(4, filename);
	stmt.setString(5, goodsContent);
	stmt.setInt(6, goodsPrice);
	stmt.setInt(7, goodsAmount);

	System.out.println("stmt 확인 :" + stmt);

	int row = stmt.executeUpdate();

	if (row == 1) { // insert 성공하면 파일업로드
		// part -> is -> os -> 빈파일
		// 1)
		InputStream is = part.getInputStream();
		// 3)+ 2)
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath, filename); // 빈파일
		OutputStream os = Files.newOutputStream(f.toPath()); // os + file
		is.transferTo(os);
		
		is.close();
		os.close();
	} 
	//파일 삭제 API
	/*
	File df = new File(filePath, rs.getString("filename"));
	df.delete()
	*/

%>

<!--controller Layer -->
<%

	if (row == 1) {
		System.out.println("상품등록성공");
	
	} else {
		System.out.println("상품등록실패,다시확인해주세요");
		response.sendRedirect("/shop/emp/addGoodsForm.jsp");
	}

	response.sendRedirect("/shop/emp/goodsList.jsp");
%>