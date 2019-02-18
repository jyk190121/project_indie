<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="shortcut icon" href="/public/favicon.ico">
<link rel="stylesheet" href="/public/css/style.css">
<style>
.gameImage {
	width: 100%;
	height: 10vw;
}

.profile-image-board {
	width: 100%;
}

#image {
	width: 100%;
	height: 100%;
}

#nickname {
	font-size: 40px;
	margin-top: 30px;
}

#lev {
	font-size: 40px;
}

#myinfo {
	width: 100%;
	height: 350px;
	font-size: 25px;
	color: white;
}

.background {
	position: relative;
}

.background:after {
	content: "";
	display: block;
	position: absolute;
	top: 0;
	left: 0;
	background-image: url("/upload/image/sea.png");
	background-repeat: no-repeat;
	background-size: cover;
	width: 100%;
	height: 100%;
	opacity: 0.7;
	z-index: -1;
}

.image-cover::before {
	background: linear-gradient(to top, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.5));
}
/* navbar */
.navbar {
	position: fixed;
	z-index: 10;
	width: 100%;
	top: 0;
	background: none;
	border: none;
	height: 30px;
	border-radius: 0;
	animation-duration: 1s;
}

.navbar a {
	color: white !important;
	text-shadow: -2px 0 #222, 0 2px #222, 2px 0 #222, 0 -2px #222;
}

.nav a {
	font-size: 16px;
}

.profile {
	border: 2px solid white;
	box-shadow: -2px 0 #222, 0 2px #222, 2px 0 #222, 0 -2px #222;;
	background: none;
	font-size: 30px;
	color: white;
	text-shadow: -2px 0 #222, 0 2px #222, 2px 0 #222, 0 -2px #222;
}

.title {
	background: none;
}

.title h1 {
	color: white;
	text-shadow: -4px 0 #222, 0 4px #222, 4px 0 #222, 0 -4px #222;
	font-size: 100px;
	font-weight: 900;
}

.header {
	height: 300px;
}

.footer {
	height: 200px;
}
</style>
</head>
<body>
<body>
	<div class="image-cover">
		<div class="background">
			<div class="header">
				<div style="height: 50px;">
					<div class="navbar navbar-default">
						<div class="container-fluid">
							<div class="navbar-header">
								<a class="navbar-brand" href="/"><i class="fas fa-home"></i>
									Indiemoa</a>
							</div>
							<ul class="nav navbar-nav">
								<sec:authorize access="isAuthenticated()">
									<li><a href="/game/main">Game</a></li>
									<li><a href="/board/list">Board</a></li>
									<li><a href="/ranking">Ranking</a></li>
									<li><a href="/user/mypage">Mypage</a></li>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_ADMIN')">
									<li><a href="/manage">Manage</a></li>
								</sec:authorize>
							</ul>
							<ul class="nav navbar-nav navbar-right">
								<sec:authorize access="isAuthenticated()">
									<li class="text-right"><a href="javascript:signout();"><i
											class="fas fa-sign-out-alt"></i> Signout &nbsp;&nbsp;</a></li>
								</sec:authorize>
							</ul>
						</div>
					</div>
				</div>
				<div class="container">
					<div class="row">
						<div class="title">
							<div style="height: 200px; margin-top: 50px;">
								<h1 class="text-center">
									<i class="glyphicon glyphicon-sunglasses
							   style="font-size:85%"></i>
									프로필
								</h1>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="content">
				<div class="container">
					<div class="row">
						<pre class="text-center profile">${user.nickname}님의 프로필 
현재레벨 : Lv. ${user.lev}  경험치 : ${requestScope.user.exp} exp</pre>
					</div>
					<div class="row" style="margin-top: 50px;">
						<div class="form-group col-xs-4 col-sm-5">
							<div id="image-board" class="profile" style="padding: 10px;">
								<div class="profile-image-board">
									<img id="image" name="image" src="/upload/image/${user.image }"
										alt="${user.image }" />
								</div>
							</div>
						</div>
						<div class="form-group col-xs-6 col-sm-7">
							<div id="myinfo-board" class="profile" style="padding: 20px;">
								<div id="myinfo" class="form-group "
									style="height: 100%; overflow: auto;">
									<div class="text-center"
										style="font-size: 30px; margin-bottom: 10px;">나의 소개</div>
									<textarea id="myinfo-textarea" class="text-left"
										style="color: white; text-shadow: -2px 0 #222, 0 2px #222, 2px 0 #222, 0 -2px #222; background: none; border: none; width: 100%; height: 85%; resize: none; overflow: auto;"
										readonly="readonly">${user.myinfo }
									</textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="row" style="margin-top: 50px;">
						<div class="container-fluid">
							<c:if test="${fn:length(gameList) >= 5}">
							<c:forEach begin="0"
								end="${(fn:length(gameList)/4)-((fn:length(gameList)/4)%1)-1 }"
								var="i">
								<div class="row" style="margin-bottom: 30px;">
									<div class="col-sm-3 col-xs-3">
										<div class="profile" style="padding: 10px;">
											<div class="profile">
												<a href="/game/view?id=${gameList[i*4].id }"> <img
													class="gameImage" alt=""
													src="/upload/image/${gameList[i*4].image }">
												</a>
											</div>
											<div class="text-center" style="margin-top: 20px;">
												<p class="over-hidden"
													style="overflow: hidden; margin: 0 0 5px 0; font-size: 16px; height: 25px;">${gameList[i*4].name }</p>
											</div>
											<div class="text-center" style="font-size: 16px;">
												<i class="far fa-thumbs-up"></i> <span>${gameList[i*4].likes-gameList[i*4].unlikes }</span>
												&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i*4].reply_count }</span>
												&nbsp;&nbsp; <i class="far fa-eye"></i> <span>${gameList[i*4].hit }</span>
											</div>
										</div>
									</div>
									<div class="col-sm-3 col-xs-3">
										<div class="profile" style="padding: 10px;">
											<div class="profile">
												<a href="/game/view?id=${gameList[i*4+1].id }"> <img
													class="gameImage" alt=""
													src="/upload/image/${gameList[i*4+1].image }">
												</a>
											</div>
											<div class="text-center" style="margin-top: 20px;">
												<p class="over-hidden"
													style="overflow: hidden; margin: 0 0 5px 0; font-size: 16px; height: 25px;">${gameList[i*4+1].name }</p>
											</div>
											<div class="text-center" style="font-size: 16px;">
												<i class="far fa-thumbs-up"></i> <span>${gameList[i*4+1].likes-gameList[i*4+1].unlikes }</span>
												&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i*4+1].reply_count }</span>
												&nbsp;&nbsp; <i class="far fa-eye"></i> <span>${gameList[i*4+1].hit }</span>
											</div>
										</div>
									</div>
									<div class="col-sm-3 col-xs-3">
										<div class="profile" style="padding: 10px;">
											<div class="profile">
												<a href="/game/view?id=${gameList[i*4+2].id }"> <img
													class="gameImage" alt=""
													src="/upload/image/${gameList[i*4+2].image }">
												</a>
											</div>
											<div class="text-center" style="margin-top: 20px;">
												<p class="over-hidden"
													style="overflow: hidden; margin: 0 0 5px 0; font-size: 16px; height: 25px;">${gameList[i*4+2].name }</p>
											</div>
											<div class="text-center" style="font-size: 16px;">
												<i class="far fa-thumbs-up"></i> <span>${gameList[i*4+2].likes-gameList[i*4+2].unlikes }</span>
												&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i*4+2].reply_count }</span>
												&nbsp;&nbsp; <i class="far fa-eye"></i> <span>${gameList[i*4+2].hit }</span>
											</div>
										</div>
									</div>
									<div class="col-sm-3 col-xs-3">
										<div class="profile" style="padding: 10px;">
											<div class="profile">
												<a href="/game/view?id=${gameList[i*4+3].id }"> <img
													class="gameImage" alt=""
													src="/upload/image/${gameList[i*4+3].image }">
												</a>
											</div>
											<div class="text-center" style="margin-top: 20px;">
												<p class="over-hidden"
													style="overflow: hidden; margin: 0 0 5px 0; font-size: 16px; height: 25px;">${gameList[i*4+3].name }</p>
											</div>
											<div class="text-center" style="font-size: 16px;">
												<i class="far fa-thumbs-up"></i> <span>${gameList[i*4+3].likes-gameList[i*4+3].unlikes }</span>
												&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i*4+3].reply_count }</span>
												&nbsp;&nbsp; <i class="far fa-eye"></i> <span>${gameList[i*4+3].hit }</span>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
							</c:if>
						</div>
					</div>
				</div>
			</div>

			<div class="footer"></div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		$(document).ready(resizeImageBoard());
		$(window).resize(function() {
			resizeImageBoard();
		});

		function resizeImageBoard() {
			$("#myinfo-board").outerHeight($("#image-board").outerHeight());
			$("#myinfo-textarea").outerHeight(
					$("#image-board").outerHeight() * 0.75);
		}
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