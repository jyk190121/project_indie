<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="seq"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id"
	content="643415307527-il731pmi36f68sn61e2ljieudcm3d107.apps.googleusercontent.com">

<title>main</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
</head>
<style>
.header {
	font-size: 20px;
	font-weight: 150;
	max-height: 280px;
}

#image {
	width: 100px;
	heigth: 100px;
	border: 1px solid gray;
}

.image {
	width: 200px;
	height: 200px;
	border: 1px solid gray;
}

.content-table {
	width: 60%;
	margin: auto;
}

.btn-primary{
	background-color: #4285F4;
}
</style>
<body>
	<div class="jumbotron text-center header">
		<h1>Game Site</h1>
		<c:if test="${user != null }">
			<div>
				<!-- <a class="btn btn-danger" href="/user/levUp">LevelUp</a> -->
				<p><img id="image" src="/upload/image/${user.image }" alt="${user.image }" />
				<a href="/profile?writer_id=${user.writer_id }" style="text-decoration: none;">${user.nickname }</a>으로 로그인
				<button onclick="javascript:signout();">로그아웃</button></p>
			</div>
		</c:if>
		<c:if test="${user == null }">
			<button onclick="showLoginModal();">로그인</button>
			<span class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"
				style="display: inline;"></span>
			<a href="/user/join" class="btn btn-warning">회원가입</a>
			<p>랭킹 이외의 모든 컨텐츠는 로그인 후에 이용이 가능합니다</p>
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
			<td><a href="/game/main"><img class="image"
					src="/upload/image/game.jpg" alt="게임"></img></a></td>
			<td><a href="/board/list"><img class="image"
					src="/upload/image/board.jpeg" alt="게시판"></img></a></td>
			<td><a href="/ranking"><img class="image"
					src="/upload/image/ranking.jpg" alt="랭킹"></img></a></td>
			<td><a href="/user/mypage"><img class="image"
					src="/upload/image/mypage.png" alt="마이페이지"></img></a></td>
			<seq:authorize access="hasRole('ROLE_ADMIN')">
				<td><a href="/manage"><img class="image"
						src="/upload/image/manage.jpg" alt="관리자"></img></a></td>
			</seq:authorize>
		</tr>
	</table>
	<div class="modal fade" id="googleJoinModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #4285F4;">
					<button type="button" class="close" data-dismiss="modal" style="color: white; opacity: 1;">&times;</button>
					<h4 style="color: white;">Join us</h4>
				</div>
				<div class="modal-body" style="padding: 30px; ">
					<h2 >가입된 계정이 없습니다!</h2>
					<h3 >구글계정으로 쉽고 빠르게 가입해보세요</h3>
					<div style="margin-top: 40px;">
						<button onclick="javascript:googleJoin();" class="btn btn-block btn-default" style="border-color: #4285F4;">
						<img style="width:25px;" src="https://img.icons8.com/color/48/000000/google-logo.png">
						<span style="font-size: 20px; color: #4285F4; font-weight: 600; vertical-align: middle;">구글계정으로 회원가입하기</span></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<a href="https://icons8.com/icon/17949/google">Google icon by Icons8</a>
	</footer>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="https://apis.google.com/js/platform.js" async defer></script>
	<jsp:include page="/WEB-INF/views/user/signin.jsp"></jsp:include>
	<script>
		var gCount = 0;
		
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

		$(document).ready(resizeImageBoard());

		function resizeImageBoard() {
			var width = $(".image-board").outerWidth();
		}

		
		//구글 로그인
		function onSignIn(googleUser) {
			// Useful data for your client-side scripts:
			if(gCount++ == 0){
				return;
			}
			var profile = googleUser.getBasicProfile();
			var form = $("<form method='post' action='/user/google/login'>");
			form.append($("<input type='hidden' name='email' value="+profile.getEmail()+">"));
			form.append($("<input type='hidden' name='googleId' value="+profile.getId()+">"));
			form.append($("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>"));
			$("body").append(form);
			form.submit();
			
			console.log("ID: " + profile.getId()); // Don't send this directly to your server!
			console.log('Full Name: ' + profile.getName());
			console.log('Given Name: ' + profile.getGivenName());
			console.log('Family Name: ' + profile.getFamilyName());
			console.log("Image URL: " + profile.getImageUrl());
			console.log("Email: " + profile.getEmail());

			// The ID token you need to pass to your backend:
			var id_token = googleUser.getAuthResponse().id_token;
			console.log("ID Token: " + id_token);
		}
		
		<c:if test="${param.googleFail != null}">
			$("#googleJoinModal").modal("show");
		</c:if>
		
		//구글계정으로 회원가입
		function googleJoin(){
			if(${googleInfo == null}) {
				alert('다시 시도해주세요');
				location.href='/';
				return;
			}
			var form = $("<form method='post' action='/user/google/join'>");
			form.append($("<input type='hidden' name='email' value='${googleInfo.email}'>"));
			form.append($("<input type='hidden' name='googleId' value='${googleInfo.googleId}'>"));
			form.append($("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>"));
			$("body").append(form);
			form.submit();
		}
	</script>
</body>
</html>