<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	// 인증분기 : 세션변수 이름 - loginEmp
	String loginEmp = (String)(session.getAttribute("loginEmp"));
	//사용되는 Session API
	// session.getAttribute(String) :  변수이름으로 변수값을 반환하는 메서드
	// session.getAttribute() 는 찾는 변수가 없으면 null값을 반환한다.
	// 로그인을 한 적이 없으면 null(초기화값)로그아웃상태, null이 안나오면 로그인 상태
	System.out.println("loginEmp(session) : " + loginEmp);
	
	// emploginForm페이지는 로그아웃상태에서만 출력되는 페이지 / empList.jsp는 로그인상태만 가능
	if(session.getAttribute("loginEmp") != null) { 
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	
	<div>
		<h1>LOGIN</h1>
	</div>
	
	<form method="post" action="/shop/emp/empLoginAction.jsp">
		<div>
			ID :
			<input type="text" name="empid">
		</div>
		
		<div>
			PW :
			<input type="password" name="emppw">
		</div>
		<hr>
		<div>
			<button type="submit">로그인</button>
		</div>
	</form>
</body>
</html>