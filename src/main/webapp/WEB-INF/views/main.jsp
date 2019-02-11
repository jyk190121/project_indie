<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="seq" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>main</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
</head>
<style>
	.header{
		font-size: 20px;
  		font-weight: 150;
  		max-height: 280px;
	}
	#image{
		width: 100px;
		heigth: 100px;
		border: 1px solid gray;
	}
	.image{
		width: 200px;
		height: 200px;
		border: 1px solid gray;
	}
	.content-table{
		width: 60%;
		margin: auto;
	}
</style>
<body>
	<div class="jumbotron text-center header">
		<h1>Game Site</h1>
		<c:if test="${user != null }">
			<div>
				<p><img id="image" src="/upload/image/${user.image }" alt="${user.image }" />
				${user.nickname }으로 로그인
				<button onclick="javascript:signout();">로그아웃</button></p>
			</div>
		</c:if>
		<c:if test="${user == null }">
			<p><button onclick="showLoginModal();">로그인</button>
			<a href="/user/join" class="btn btn-warning">회원가입</a></p>
			<p>모든 컨텐츠는 로그인 후에 이용이 가능합니다</p>
		</c:if>
	</div>
		<table class="content-table">
			<tr>
				<th class="text-center">게임</th>
				<th class="text-center">게시판</th>
				<th class="text-center">랭킹</th>
				<th class="text-center">마이페이지</th>
				<seq:authorize access="hasRole('ROLE_ADMIN')">
					<th class="text-center">관리자</th>
				</seq:authorize>
			</tr>
			<tr class="content">
				<td>
					<a href="/game/main"><image class="image" src="/upload/image/게임.jpg" alt="게임"></image></a>
				</td>
				<td>
					<a href="/board/list"><image class="image" src="/upload/image/게시판.jpeg" alt="게시판"></image></a>
				</td>
				<td>
					<a href="/user/ranking"><image class="image" src="/upload/image/랭킹.jpg" alt="랭킹"></image></a>
				</td>
				<td>
					<a href="/user/mypage"><image class="image" src="/upload/image/보노.png" alt="마이페이지"></image></a>
				</td>
				<seq:authorize access="hasRole('ROLE_ADMIN')">
					<td>
						<a href="/manage"><image class="image" src="/upload/image/관리자.jpg" alt="관리자"></image></a>
					</td>
				</seq:authorize>
			</tr>
		</table>
	
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
		
		$(document).ready(
				resizeImageBoard());	

			function resizeImageBoard(){
				var width = $(".image-board").outerWidth();
		}
	</script>
</body>
</html>