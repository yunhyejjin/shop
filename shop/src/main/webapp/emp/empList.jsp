<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	// 인증분기 : 세션변수 이름 - loginEmp
	String loginEmp = (String)(session.getAttribute("loginEmp"));
	System.out.println("loginEmp(session) : " + loginEmp);
	
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
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	
	<h1>사원목록</h1>
	
	<table border= "1">
		
		<tr>
			<th>emp_id</th>
			<th>emp_name</th>
			<th>emp_job</th>
			<th>hire_date</th>
			<th>active</th>
		</tr>
		
		<% 
			while(rs.next()) {
		%>		
			
			<tr>
				<td><%=rs.getString("empId")%></td>
				<td><%=rs.getString("empName")%></td>
				<td><%=rs.getString("empJob")%></td>
				<td><%=rs.getString("hireDate")%></td>
				<td><%=rs.getString("active")%></td>
			</tr>
		
		<%
			}
		%>
	
	</table>
	

</body>
</html>