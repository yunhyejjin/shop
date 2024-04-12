<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String checkMail = request.getParameter("checkMail");
	System.out.println("check-Mail : " + checkMail);	
	
	if(checkMail == null) {
		checkMail = ""; // "" 공란으로 표시 ->보기싫어서? 
	}
	
	String ck = request.getParameter("ck");
	System.out.println("ck: " + ck);
	
	if(ck == null) {
		ck = ""; // "" 공란으로 표시 ->보기싫어서? 
	}
	
	String msg = ""; 
	
	if(ck.equals("O")){
		msg = "사용가능한 'mail' 입니다.";
	
	} else if(ck.equals("X")) {
		msg = "이미 사용중인 'mail' 입니다.";	
	
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	
	<h1>회원가입</h1>
	<!-- mail 중복확인 -->
	<form method="post" action="/shop/customer/checkAction.jsp">
		<div>
			mail확인 :
			<input type="text" name="checkMail" value="<%=checkMail%>">
			<button type="submit">중복확인</button>
			<span>&nbsp;<%=msg%></span>		
		</div>
	</form>
	
	<form method="post" action="/shop/customer/addCustomerAction.jsp">
		
		<div>
			mail : 
			<%
				if(ck.equals("O")) { //checkMail equals.O면 출력 
			%>				
					<input value="<%=checkMail%>" type="text" name="mail" readonly="readonly">
			<%		
				} else {
			%>				
					<input value="" type="text" name="mail" readonly="readonly">
			<%		
				}
			%>
		</div>
		
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
			<button type="submit">가입하기</button>
		</div>
		
	</form>

</body>
</html>