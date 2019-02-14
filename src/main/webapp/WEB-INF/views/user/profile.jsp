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
	border: 1px solid gray;
	width: 100%;
	height: 200px;
}
</style>
</head>
<body>
<body>
	<div class="header">
		<div class="jumbotron">
			<h1 class="text-center">
				<i class="glyphicon glyphicon-sunglasses
				   style="font-size:85%"></i>
				프로필
			</h1>
		</div>
		<div class="navbar navbar-inverse">
			<div class="container-fluid">
				<ul class="nav navbar-nav">
					<li><a href="/main">main</a></li>
					<li><a href="/board/list">board</a></li>
					<li><a href="javascript:signout();">signout</a></li>
				</ul>
			</div>
		</div>
	</div>

	<div class="content">
		<div class="container">
			<div class="row">
				<div class="form-group col-sm-5">
					<label class="control-label">프로필 이미지</label>
					<div class="profile-image-board">
						<img id="image" name="image" src="/upload/image/${user.image }"
							alt="${user.image }" />
					</div>
				</div>
				<div class="form-group col-sm-7">
					<div id="nickname">
						<p>${user.nickname }</p>
					</div>
					<div>
						<p id="lev">유저 레벨 : ${user.lev }</p>
					</div>
					<div id="myinfo" class="form-group">
						<p class="text-center">나의 소개</p>
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
							<div class="col-sm-3">
								<a href="/game/view?id=${gameList[i*4].id }"> <img
									class="gameImage" alt=""
									src="/upload/image/${gameList[i*4].image }">
								</a>
								<div class="text-center">${gameList[i*4].name }</div>
							</div>
							<div class="col-sm-3">
								<a href="/game/view?id=${gameList[i*4+1].id }"> <img
									class="gameImage" alt=""
									src="/upload/image/${gameList[i*4+1].image }">
								</a>
								<div class="text-center">${gameList[i*4+1].name }</div>
							</div>
							<div class="col-sm-3">
								<a href="/game/view?id=${gameList[i*4+2].id }"> <img
									class="gameImage" alt=""
									src="/upload/image/${gameList[i*4+2].image }">
								</a>
								<div class="text-center">${gameList[i*4+2].name }</div>
							</div>
							<div class="col-sm-3">
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
		<a href="/user/mypage" class="btn btn-primary btn-block">나의 정보수정하기</a>
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