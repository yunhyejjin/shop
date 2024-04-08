<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
	//인증분기 : 세션변수 이음 - loginCustomer
	String loginCustomer =(String)(session.getAttribute("loginCustomer"));
	//로그인을 한 적이 없으면 null(초기화값)로그아웃상태, null이 안나오면 로그인 상태
	System.out.println("loginCustomer(session) : " + loginCustomer);
	
	// loginForm페이지는 로그아웃상태에서만 출력되는 페이지(회원이 아닐경우에도) / goodsList.jsp는 로그인상태만 가능
	if(session.getAttribute("loginCustomet") != null) {
		response.sendRedirect("/shop/customer/goodsList.jsp");
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
	
	<form method="/shop/customer/loginAction">
		<div>
			mail :
			<input type="text" name="mail">
		</div>
		
		<div>
			pw :
			<input type="password" name="pw">
		</div>
		
		<button type="submit">로그인</button>
		<button type="submit">회원가입</button>
	</form>

</body>
</html>