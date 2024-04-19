<%@page import="java.util.concurrent.CopyOnWriteArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>

<!--controller Layer -->
<%
	// 인증분기 : 세션변수 이름 - loginEmp	
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLogForm.jsp");
		return;
	}
%>

<%
	/*
		select emp_id empId, emp_name empName, emp_job empJob,  hire_date hireDate, active
		from emp
		order by active asc, hire_date desc
	*/
	/*
	String empId = request.getParameter("empId"); 
	String empName = request.getParameter("empName"); 
	String empJob = request.getParameter("empJob");
	String hireDate = request.getParameter("hireDate");
	String active = request.getParameter("active");
	
	System.out.println("empId :" + empId);
	System.out.println("empName :" + empName);
	System.out.println("empJob :" + empJob);
	System.out.println("hireDate :" + hireDate);
	System.out.println("active :" + active);
	
	String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by active asc, hire_date desc";
	
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	conn = DriverManager.getConnection( // DB접속
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql); // 객체 생성
	rs = stmt.executeQuery(); // 쿼리문
	
	System.out.println("rs :" + rs);
	*/
%>

<%
	// request 분석
	int currentPage = 1; // 현재페이지

	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10; // 한페이지당 보여지는 행수(10개)
	int startRow = (currentPage - 1) * rowPerPage; // 페이지당 시작하는 행번호


//!--Model Layer -->

	// 특수한 형태의 데이터(RDBMS:maeisdb)
	// -> API사용 (JDBC API)하여 자료구조(ResultSet) 취득
	// -> 일반화된 자료구조(ArryList<HashMap>)로 변경 -> 모델 취득
	

	
	//JDBC API 종속된 자료구조 모델 ResultSet -> 기본 API 자료구조(ArryList)로 변결
	ArrayList<HashMap<String, Object>> empList = EmpListDAO.EmpList(startRow, rowPerPage);
	
	// ResultSet -> ArrayList<HashMap<String, Object>> 

	
	// JDBC API 사용이 끝났다면 DB자원들을을 반납
	
%>

<!--view Layer : 모델(ArrayList<HashMap<String, Object>>) 출력 -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<!-- empMenu.jsp include : 주체(서버) vs redirect(주체:클라이언트) -->
	<!-- 주체가 서버이기에 include할때는 절대주소가 /shop/...시작하지 않는다!!! -->
	<jsp:include page="/inc/empMenu.jsp"></jsp:include>
	
	<div><a href="/shop/emp/empLogout.jsp">로그아웃</a></div>
	
	<h1>사원목록</h1>
	
		<table border= "1">
			<tr>
				<th>emp_id</th>
				<th>grade</th>
				<th>emp_name</th>
				<th>emp_job</th>
				<th>hire_date</th>
				<th>active</th>
			</tr>
				
				<%
					for(HashMap<String, Object> m : empList) {
				%>
					<tr>
						<td><%=(String)(m.get("empId"))%></td>
						<td><%=(Integer)(m.get("grade"))%></td>
						<td><%=(String)(m.get("empName"))%></td>
						<td><%=(String)(m.get("empJob"))%></td>
						<td><%=(String)(m.get("hireDate"))%></td>
						<td>
							<% // "grade" 0 보다 큰사람만 "active"를 전환할 수 있다
								HashMap<String, Object> resultMap = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
								if((Integer)(resultMap.get("grade"))> 0) { 
							%> 
								<a href='/shop/emp/modifyEmpActive.jsp?empId=<%=(String)(m.get("empId"))%>&active=<%=(String)(m.get("active"))%>'>
									<%=(String)(m.get("active"))%>
								</a>
							<%
								}
							%>
						</td>
					</tr>
				<% 
					}
				%>
		</table>
	

</body>
</html>