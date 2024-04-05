<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%> 
<%@ page import="java.util.*"  %>

<%
	// 인증분기 : 세션변수 이름 - loginEmp
	//String loginEmp = (String)(session.getAttribute("loginEmp"));
	//System.out.println("loginEmp(session) : " + loginEmp);
	
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>

<%
	// 요청값
	String empId = request.getParameter("empId"); 
	String empPw = request.getParameter("empPw"); 
	
	System.out.println("empId : " + empId);
	System.out.println("empPw : " + empPw);
	
	/*
		select emp_id emp Id from emp 
		where active='ON' and emp_id =? and emp_pw = password(?) ->> emp_pw = password(?) 암호화처리???
	*/
	String sql = "select emp_id empId, emp_name empName, grade from emp where active='ON' and emp_id =? and emp_pw = password (?)";
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql); 
	stmt.setString(1,empId);
	stmt.setString(2,empPw);
	rs = stmt.executeQuery(); // 쿼리문
%>	

<%	
	/*
		실패 / emp/empLoginForm.jsp	
		성공 / emp/empList.jsp	
	*/
	
	if(rs.next()) {
		System.out.println("로그인 성공");
		// 하나의 세션변수안에 여러개의 값을 저장하기 위해서 HashMap타입을 사용
		HashMap<String, Object> loginEmp = new HashMap<String, Object>();
		loginEmp.put("empId", rs.getString("empId"));
		loginEmp.put("empName", rs.getString("empName"));
		loginEmp.put("grade", rs.getInt("grade"));
		
		session.setAttribute("loginEmp", loginEmp); // session이 "loginEmp"
		
		// 디버깅
		HashMap<String, Object> hm = (HashMap<String, Object>)session.getAttribute("loginEmp");
		
		System.out.println((String)hm.get("empId"));
		System.out.println((String)hm.get("empName"));
		System.out.println((Integer)hm.get("grade")); //참조변수 확인할 것 int
		
		response.sendRedirect("/shop/emp/empList.jsp");
		
	} else {
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요.", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?=errMsg" +errMsg);	
		
	}
	
	
%>
