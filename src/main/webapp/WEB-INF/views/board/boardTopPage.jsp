<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>notice board</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
	<div class="header">
		<div class="jumbotron">
			<h1 class="text-center">
				<i class="glyphicon glyphicon-tree-deciduous 
				   style="font-size:85%"></i>
				자유 게시판
			</h1>
		</div>
	</div>
	<div class="navbar navbar-inverse">
		<div class="container-fluid">
			<ul class="nav navbar-nav">
				<li><a href="/main">main</a></li>
				<sec:authorize access="!isAuthenticated()">
				<li><a href="javascript:showLoginModal();">signin</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
				<li><a href="/board/list">board</a></li>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li><a href="/manage">manage</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
				<li><a href="javascript:signout();">signout</a></li>
				</sec:authorize>
			</ul>
		</div>
	</div>
	
<jsp:include page="/WEB-INF/views/user/signin.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
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