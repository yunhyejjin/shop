<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>>
<%@ page import="java.net.*"%> 
<%@ page import="java.util.*"  %>
<%@ page import="shop.dao.*" %>

<%
	// 인증분기 : 세션변수 이름 - loginEmp
	//String loginEmp = (String)(session.getAttribute("loginEmp"));
	//System.out.println("loginEmp(session) : " + loginEmp);
	// 로그인을 한 적이 없으면 null(초기화값)로그아웃상태, null이 안나오면 로그인 상태
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
	
	// controller
	// emploginForm에서 받은 값
	String empId = request.getParameter("empId"); 
	String empPw = request.getParameter("empPw"); 
	
	System.out.println("empId : " + empId);
	System.out.println("empPw : " + empPw);
		
	HashMap<String, Object> loginEmp = EmpDAO.empLogin(empId, empPw);
	System.out.println("loginEmp : " + loginEmp);
	
	//controller
	if(loginEmp == null) {
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요.", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?=errMsg" +errMsg);

	} else {
		System.out.println("로그인 성공");
		session.setAttribute("loginEmp", loginEmp); // session.setAttribute->"loginEmp" session생성
		response.sendRedirect("/shop/emp/empList.jsp");
		
	}
	
%>
