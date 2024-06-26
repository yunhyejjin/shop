<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.util.*" %>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>  
<%@ page import="java.net.URLEncoder"%>
<%@ page import="shop.dao.*" %>
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
	System.out.println("updateGoodsAction-loginMember : " + loginMember);
	System.out.println("updateGoodsAction-empId : " + loginMember.get("empId"));

%>
<%
	//1. 요청 분석 (입력값 받기)
	
	String empId = request.getParameter("empId");
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String goodsTitle = request.getParameter("goodsTitle");
	String fileName = request.getParameter("fileName");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	String goodsContent = request.getParameter("goodsContent");
	
	//디버깅
	System.out.println("updateGoodsAction-empId(수정할직원ID) : " + loginMember.get("empId"));
	System.out.println("updateGoodsAction-goodsNo : " + goodsNo);	
	System.out.println("updateGoodsAction-goodsTitle : " + goodsTitle);
	System.out.println("updateGoodsAction-filename : " + fileName);
	System.out.println("updateGoodsAction-goodsPrice : " + goodsPrice);
	System.out.println("updateGoodsAction-goodsContent : " + goodsContent);
	
	//새로 수정할 이미지
	String newImg = "";
	Part part = request.getPart("goodsImg");
	
	if(newImg.equals("")){
		
		String originalName = part.getSubmittedFileName();
		
		int dotIdx = originalName.lastIndexOf(".");
		String ext = originalName.substring(dotIdx);// .png
			
		UUID uuid = UUID.randomUUID(); // 랜덤문자열(파일명)
		/* fileName = fileName + ext; */
		fileName = originalName; 
		
		int row = GoodsDAO.updateGoods(goodsNo, goodsTitle, newImg, goodsPrice, goodsContent);
		System.out.println("updateGoods Row : " + row);
		
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
			
			System.out.println("수정성공");
			msg =  URLEncoder.encode("수정성공!", "UTF-8");
			response.sendRedirect("/shop/emp/goodsOne.jsp?goodsNo="+goodsNo+"&msg="+ msg);
		} else {
			
			System.out.println("수정실패");
			msg =  URLEncoder.encode("수정실패!", "UTF-8");
			response.sendRedirect("/shop/emp/goodsOne.jsp?goodsNo="+goodsNo+"&msg="+ msg);
		}
		
	} else {
		
		int row = GoodsDAO.updateGoods(goodsNo, goodsTitle, newImg, goodsPrice, goodsContent);
		System.out.println("updateGoods Row : " + row);
		
		String originalName = part.getSubmittedFileName();
			
		int dotIdx = originalName.lastIndexOf(".");
		String ext = originalName.substring(dotIdx);// .png
			
		UUID uuid = UUID.randomUUID(); // 랜덤문자열(파일명)
		/* fileName = fileName + ext; */
		fileName = originalName; 

		newImg = fileName;
		//디버깅
		System.out.println("newImg : " + newImg);
		
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
			
			System.out.println("수정성공");
			msg =  URLEncoder.encode("수정성공!", "UTF-8");
			response.sendRedirect("/shop/emp/goodsOne.jsp?goodsNo="+goodsNo+"&msg="+ msg);
			
		} else {
			
			System.out.println("수정실패");
			msg =  URLEncoder.encode("수정실패!", "UTF-8");
			response.sendRedirect("/shop/emp/goodsOne.jsp?goodsNo="+goodsNo+"&msg="+ msg);
		}
		
	}
	


	

%>