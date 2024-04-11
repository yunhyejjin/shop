<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	
	<h1>회원가입</h1>
	
	<form method="post" action="/shop/customer/checkAction.jsp">
		<div>
			mail :
			<input type="text"	name="mail">
			<button type="submit">중복확인</button>	
		</div>
	</form>
	
	<form method="post" action="/shop/customer/addCustomerAction.jsp">
		
		<div>
			pw : 
			<input type="password" name="pw">
		</div>
		
		<div>
			name :
			<input type="text"	name="name">
		</div>
		
		<div>
			birth :
			<input type="date"	name="birth">
		</div>
		
		<div>
			gender :
			<input type="radio" name="gender" value="남">남자
			<input type="radio" name="gender" value="여">여자
		</div>
		
		<div>
			<button type="submit">회원가입</button>
		</div>
		
	</form>

</body>
</html>