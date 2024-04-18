<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="shop.dao.*" %>
<!--controller Layer -->
<%
	request.setCharacterEncoding("UTF-8");
	// 인증분기 : 세션변수 이름 - loginEmp	
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLogForm.jsp");
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
	String empId = (String)loginMember.get("empId");
%>

<!--Model Layer -->
<%
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsContent = request.getParameter("goodsContent");
	String goodsPrice = request.getParameter("goodsPrice");
	String goodsAmount = request.getParameter("goodsAmount");
	
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

	int row = addGoodsActionDAO.addGoodsAction(category, empId, goodsTitle, filename, goodsContent, goodsPrice, goodsAmount);
	System.out.println(row);

	if (row == 1) { // insert 성공하면 파일업로드
		// part -> is -> os -> 빈파일
		// 1)
		System.out.println("상품등록성공");
		InputStream is = part.getInputStream();
		// 3)+ 2)
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath, filename); // 빈파일
		OutputStream os = Files.newOutputStream(f.toPath()); // os + file
		is.transferTo(os);
		
		is.close();
		os.close();
	
	}  else {
		
		System.out.println("상품등록실패,다시확인해주세요");
		response.sendRedirect("/shop/goods/addGoodsForm.jsp");
	}
	
	response.sendRedirect("/shop/goods/goodsList.jsp");
	
	//파일 삭제 API
	/*
	File df = new File(filePath, rs.getString("filename"));
	df.delete()
	*/

%>
