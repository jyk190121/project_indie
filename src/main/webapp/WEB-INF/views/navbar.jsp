<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<style>
.navbar {
	position: fixed;
	z-index: 10;
	width: 100%;
	top: 0;
	background-color: #be2edd;
	border-color: #be2edd;
	height: 30px;
	border-radius: 0;
	animation-duration: 1s;
}

.navbar a{
	color: white !important;
}

.nav a {
	font-size: 16px;
}
</style>
</head>
<body>
<div class="navbar navbar-default">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="/"><i class="fas fa-home"></i>
				Indiemoa</a>
		</div>
		<ul class="nav navbar-nav">
			<sec:authorize access="isAuthenticated()">
				<li><a href="/game/main">game</a></li>
				<li><a href="/board/list">board</a></li>
				<li><a href="/user/mypage">mypage</a></li>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li><a href="/manage">manage</a></li>
			</sec:authorize>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<sec:authorize access="isAuthenticated()">
				<li class="text-right"><a href="javascript:signout();"><i class="fas fa-sign-out-alt"></i> signout &nbsp;&nbsp;</a></li>
			</sec:authorize>
		</ul>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script>
	function signout() {
		var form = document.createElement("form");
		form.method = "post";
		form.action = "/user/signout";
		var input = document.createElement("input");
		input.type = "hidden";
		input.name = "${_csrf.parameterName}";
		input.value = "${_csrf.token}";
		form.appendChild(input);
		document.body.appendChild(form);
		form.submit();
	}
</script>
</body>
</html>