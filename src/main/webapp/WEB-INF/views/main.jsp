<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" 
 	  content="width=device-width, initial-scale=1">
<title>Insert Title here</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
</head>
<style>
	a{
		font-size : xx-large;
	}
</style>
<body>
	<div class="jumbotron">
		<h1>MAIN</h1>
	</div>
	
	<c:if test="${user != null }">
	<p>${user.nickname }으로 로그인</p>
	</c:if>
	
	<a href="/game/main">game</a>
	<a href="/board/list">board</a>
	<a href="/rank/main">rank</a>
	<a href="/profile?id=${user.id }">profile</a>
	<a href="/user/mypage">mypage</a>
	<a href="/manage">manage</a>
	
	<button onclick="showLoginModal();">로그인</button>
	<button onclick="javascript:signout();">로그아웃</button>
	<a href="/user/join">회원가입</a>
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<jsp:include page="/WEB-INF/views/user/signin.jsp"></jsp:include>
	<script>
		function signout(){
			var form = document.createElement("form");
			form.method="post";
			form.action="/user/signout";
			var input = document.createElement("input");
			input.type="hidden";
			input.name="${_csrf.parameterName}";
			input.value="${_csrf.token}";
			form.appendChild(input);
			document.body.appendChild(form);
			form.submit();
		}
	</script>
</body>
</html>