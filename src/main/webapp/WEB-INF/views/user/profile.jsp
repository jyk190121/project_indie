<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="shortcut icon" href="/public/favicon.ico">
<link rel="stylesheet" href="/public/css/style.css">
<style>
.gameImage {
	width: 100%;
	height: 200px;
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
	color: Indigo;
}
.background{
  	position: relative;
}
.background:after {
    content : "";
    display: block;
    position: absolute;
    top: 0;
    left: 0;
    background-image: url("/upload/image/sea.png");
    background-repeat: no-repeat;
   	background-size: cover;
    width: 100%;
    height: 100%;
    opacity : 0.7;
    z-index: -1;
}
.profile{
	background: none;
}
</style>
</head>
<body>
<body>
<div class="background">
	<div class="header">
		<div style="height: 50px;">
			<jsp:include page="/WEB-INF/views/navbar.jsp" />
		</div>
		<div class="jumbotron profile">
			<h1 class="text-center">
				<i class="glyphicon glyphicon-sunglasses
				   style="font-size:85%"></i>
				프로필
			</h1>
		</div>
	</div>

	<div class="content">
		<div class="container">
			<div class="row">
				<div class="form-group col-xs-4 col-sm-5">
					<div class="profile-image-board">
						<img id="image" name="image" src="/upload/image/${user.image }"
							alt="${user.image }" />
					</div>
				</div>
				<div class="form-group col-xs-6 col-sm-7">
					<div id="myinfo" class="form-group">
						<p class="text-center"><strong style="font-size: 30px;">나의 소개</strong></p>
						${user.myinfo }
					</div>
				</div>
			</div>
			<div class="row">
				<div class="container-fluid">
					<c:forEach begin="0"
						end="${(fn:length(gameList)/4)-((fn:length(gameList)/4)%1) }"
						var="i">
						<div class="row">
							<div class="col-sm-3 col-xs-3">
								<a href="/game/view?id=${gameList[i*4].id }"> <img
									class="gameImage" alt=""
									src="/upload/image/${gameList[i*4].image }">
								</a>
								<div class="text-center">${gameList[i*4].name }</div>
							</div>
							<div class="col-sm-3 col-xs-3">
								<a href="/game/view?id=${gameList[i*4+1].id }"> <img
									class="gameImage" alt=""
									src="/upload/image/${gameList[i*4+1].image }">
								</a>
								<div class="text-center">${gameList[i*4+1].name }</div>
							</div>
							<div class="col-sm-3 col-xs-3">
								<a href="/game/view?id=${gameList[i*4+2].id }"> <img
									class="gameImage" alt=""
									src="/upload/image/${gameList[i*4+2].image }">
								</a>
								<div class="text-center">${gameList[i*4+2].name }</div>
							</div>
							<div class="col-sm-3 col-xs-3">
								<a href="/game/view?id=${gameList[i*4+3].id }"> <img
									class="gameImage" alt=""
									src="/upload/image/${gameList[i*4+3].image }">
								</a>
								<div class="text-center">${gameList[i*4+3].name }</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<div class="footer">
		<pre class="text-center profile" style="font-size: 30px;">${user.nickname}님의 프로필 
현재레벨 : ${user.lev}  경험치 : ${requestScope.user.exp}</pre>
	</div>
</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		$(document).ready(resizeImageBoard());

		function resizeImageBoard() {
			var width = $(".image-board").outerWidth();
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