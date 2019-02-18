<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert Title here</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="shortcut icon" href="/public/favicon.ico">
<link rel="stylesheet" href="/public/css/style.css">
<style>
* {
	box-sizing: border-box;
}

.row {
	margin-top: 50px;
}

.content {
	min-width: 1000px;
}

a {
	text-decoration: none !important;
}

.hotGame {
	
}

.gameImage {
	width: 100%;
	height: 20vw;
}

.podium {
	height: 300px;
}

.podium-content h3 {
	font-size: 20px !important;
	font-weight: 700;
	margin: 0 0 10px 0;
}

.podium-content img {
	width: 90%;
	border-radius: 5px;
	height: 90%;
}

.podium-content span {
	padding: 0;
}

.podium-frame {
	background-color: #be2edd;
	height: 300px;
}

.podium-frame>h3 {
	color: white;
	font-weight: 500;
}

.podium>div {
	width: 100%;
	position: absolute;
	bottom: 0;
	text-align: center;
	position: absolute;
}
</style>
</head>
<body>
	<div class="header">
		<div style="height: 50px;">
			<jsp:include page="/WEB-INF/views/navbar.jsp" />
		</div>
	</div>
	<div class="content">
		<div class="container">
			<div class="row">
				<h3 style="padding-left: 20px;">이달의 추천</h3>
				<c:forEach items="${hotGameList }" var="hotGame">
					<div
						class="col-xs-4 <c:if test="${fn:length(hotGameList) <= 2 }">col-offset-sm-2</c:if><c:if test="${fn:length(hotGameList) <= 1 }">col-offset-sm-2</c:if>">
						<div class="hotGame">
							<a href="/game/view?id=${hotGame.id }"> <img
								class="gameImage" alt="game image"
								src="/upload/image/${hotGame.image }">
							</a>
							<div class="text-center"
								style="border: 1px solid #be2edd; border-top: none;">
								<h1 style="margin-top: 0; padding-top: 20px;">
									${hotGame.name }</h1>
								<p style="font-size: 16px;">${hotGame.info }</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="col-xs-4 podium" style="padding: 5px;">
						<div style="bottom: 161px;" class="podium-content">
							<a href="/profile?writer_id=${rankerList[1].user.writer_id }">
								<span class="col-xs-6"> <img
									src="/upload/image/${rankerList[1].user.image}" alt="" />
							</span> <span class="col-xs-6">
									<h3>${rankerList[1].user.nickname}</h3>
							</span>
							</a>
							<h3>${rankerList[1].score }<c:if
									test="${rankerList[1] != null }">점</c:if>
							</h3>
						</div>
						<div class="podium-frame"
							style="height: 140px; border-radius: 10px 0 0 0;">
							<h3>2</h3>
						</div>
					</div>
					<div class="col-xs-4 podium" style="padding: 5px;">
						<div style="bottom: 220px;" class="podium-content">
							<a href="/profile?writer_id=${rankerList[0].user.writer_id }">
								<span class="col-xs-6"> <img
									src="/upload/image/${rankerList[0].user.image}" alt="" />
							</span> <span class="col-xs-6">
									<h3>${rankerList[0].user.nickname}</h3>
							</span>
							</a>
							<h3>${rankerList[0].score }<c:if
									test="${rankerList[0] != null }">점</c:if>
							</h3>
						</div>
						<div class="podium-frame"
							style="height: 200px; border-radius: 10px 10px 0 0;">
							<h3>1</h3>
						</div>
					</div>
					<div class="col-xs-4 podium" style="padding: 5px;">
						<div style="bottom: 130px;" class="podium-content">
							<a href="/profile?writer_id=${rankerList[2].user.writer_id }">
								<span class="col-xs-6"> <img
									src="/upload/image/${rankerList[2].user.image}" alt="" />
							</span> <span class="col-xs-6">
									<h3>${rankerList[2].user.nickname}</h3>
							</span>
							</a>
							<h3>${rankerList[2].score }<c:if
									test="${rankerList[2] != null }">점</c:if>
							</h3>
						</div>
						<div class="podium-frame"
							style="height: 110px; border-radius: 0 10px 0 0;">
							<h3>3</h3>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<a href="/game/insert">
						<div id="insertGameImage-cover"
							class="image-cover text-center over-hidden"
							style="height: 300px; margin: auto;">
							<div id="insertGameImage"
								style="background-image: url('/public/image/background2.jpg'); height: 300px; width: 463px;">
								<div
									style="position: relative; z-index: 10; padding: 50px 10px;">
									<h1 class="text-right" style="margin: 0; color: white;">Click
										to upload a</h1>
									<h1 class="text-right" style="margin: 0; color: white;">
										New game</h1>
									<h4 class="text-right" style="margin: 0; color: white; margin-top: 30px;">새로운 게임을 소개해주세요</h4>
								</div>
							</div>
						</div>
					</a>
				</div>
			</div>
			<div class="row">
				<div class="container-fluid">
					<div class="row">
						<p class="text-right">
							<a href="/game/list">더보기 +</a>
						</p>
					</div>
					<c:if test="${fn:length(gameList) < 6 }">
						<h2 class="text-center">검색 결과가 없습니다</h2>
					</c:if>
					<c:if test="${fn:length(gameList) >= 6 }">
						<c:forEach begin="0"
							end="${(fn:length(gameList)/5)-((fn:length(gameList)/5)%1)-1 }"
							var="i">
							<div class="row">
								<div class="col-sm-2 col-sm-offset-1">
									<a href="/game/view?id=${gameList[i*5].id }"> <img
										class="gameImage" alt="/준비중인 게임입니다"
										src="/upload/image/${gameList[i*5].image }">
									</a>
									<div class="text-center">${gameList[i*5].name }</div>
								</div>
								<div class="col-sm-2">
									<a href="/game/view?id=${gameList[i*5+1].id }"> <img
										class="gameImage" alt="/준비중인 게임입니다"
										src="/upload/image/${gameList[i*5+1].image }">
									</a>
									<div class="text-center">${gameList[i*5+1].name }</div>
								</div>
								<div class="col-sm-2">
									<a href="/game/view?id=${gameList[i*5+2].id }"> <img
										class="gameImage" alt="/준비중인 게임입니다"
										src="/upload/image/${gameList[i*5+2].image }">
									</a>
									<div class="text-center">${gameList[i*5+2].name }</div>
								</div>
								<div class="col-sm-2">
									<a href="/game/view?id=${gameList[i*5+3].id }"> <img
										class="gameImage" alt="/준비중인 게임입니다"
										src="/upload/image/${gameList[i*5+3].image }">
									</a>
									<div class="text-center">${gameList[i*5+3].name }</div>
								</div>
								<div class="col-sm-2">
									<a href="/game/view?id=${gameList[i*5+4].id }"> <img
										class="gameImage" alt="/준비중인 게임입니다"
										src="/upload/image/${gameList[i*5+4].image }">
									</a>
									<div class="text-center">${gameList[i*5+4].name }</div>
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<div class="footer"></div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		var $insertImage = $("#insertGameImage");
		var $insertImageCover = $("#insertGameImage-cover");

		$(document).ready(resizeImageBoard());

		function resizeImageBoard() {
			if ($insertImageCover.width() > $insertImage.width()) {
				$insertImageCover.width($insertImage.width()+"px");
			}
		}
	</script>
</body>
</html>