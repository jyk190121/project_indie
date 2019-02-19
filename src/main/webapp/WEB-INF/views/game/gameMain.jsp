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

.gameList .row {
	margin-top: 20px;
}

.header {
	height: 320px;
}

.content {
	min-width: 1000px;
}

a {
	text-decoration: none !important;
	color: #222;
}

a:hover {
	color: #444;
}

.hotGame img {
	width: 100%;
	height: 200px; /* 차후 수정 */
}

.gameImage {
	width: 100%;
	height: 120px; /* 차후 수정 */
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
	background-color: #ffbe76;
	height: 300px;
}

.podium-frame>h3 {
	color: black;
	font-weight: 500;
	margin-bottom: 20px;
	font-weight: 700;
}

.podium>div {
	width: 100%;
	position: absolute;
	bottom: 0;
	text-align: center;
	position: absolute;
}

.gameList [class^=col-] {
	padding: 5px;
}

.notice-panel .panel-heading {
	background-color: #535c68 !important;
	color: white !important;
	height: 40px;
	font-size: 16px;
	padding: 7.5px 20px;
}

.notice-panel .panel-heading:hover {
	opacity: 0.8;
}
</style>
</head>
<body>
	<div class="header">
		<div style="height: 50px;">
			<jsp:include page="/WEB-INF/views/navbar.jsp" />
		</div>
		<div class="container">
			<div class="row">
				<div
					style="background-image: url('/public/image/background3.jpg'); width: 100%; height: 200px;">
					<h1 class="text-center"
						style="padding-top: 0; color: white; font-weight: 600; font-size: 200px;">Game
						Main</h1>
				</div>
			</div>
		</div>
	</div>
	<div class="content">
		<div class="container">
			<div class="row">
				<div class="notice-panel">
					<div class="panel panel-default"
						style="background-color: #636e72; color: white;">
						<a href="#notice-full" data-toggle="collapse">
							<div class="panel-heading">
								<h4 class="panel-title">
									<p style="display: inline-block; width: 98%;">[공지]
										&nbsp;&nbsp; Game 페이지 방문이 처음이신가요?</p>
									<span class="text-right" style="font-size: 20px">+</span>
								</h4>
							</div>
						</a>
						<div id="notice-full" class="panel-collapse collapse">
							<div class="panel-body"
								style="background: #f1f2f6; color: black; font-weight: 500; border: 1px solid #636e72; font-size: 16px;">
								<p style="margin-top: 10px;">1. 이달의 추천 : 매니저가 선정한 이달의 게임 3종을 플레이하고 최고기록을 세워보세요.</p>
								<p>2. 랭커 TOP3 : 이달의 게임 3종을 플레이한 점수를 합산해 순위를 산출합니다.</p>
								<p>3. 게임 업로드 : 새로운 게임을 업로드해보세요! 본인이 제작한 게임을 평가받을 수 있습니다.</p>
								<p>4. 신규 게임 : 게임들을 보다 체계적으로 분류했습니다. 검색 기능도 사용 가능합니다.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="div-title-underbar">
					<a href=""> <span class="div-title-underbar-bold"
						style="font-size: 36px; padding: 5px 20px;"> <b>이달의 추천</b></span>
					</a>
				</div>
				<c:forEach items="${hotGameList }" var="hotGame">
					<div
						class="col-xs-4 <c:if test="${fn:length(hotGameList) <= 2 }">col-offset-sm-2</c:if><c:if test="${fn:length(hotGameList) <= 1 }">col-offset-sm-2</c:if>">
						<div class="hotGame">
							<a href="/game/view?id=${hotGame.id }" style=""> <img
								class="gameImage" alt="game image"
								src="/upload/image/${hotGame.image }">
								<div class="text-center"
									style="border: 2px solid #487eb0; border-top: none; padding-bottom: 20px;">
									<h1 style="margin-top: 0; padding-top: 20px;">
										${hotGame.name }</h1>
									<p style="font-size: 16px;">${hotGame.info }</p>
								</div>
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="div-title-underbar">
						<a href=""> <span class="pull-right lightgray">+</span> <span
							class="div-title-underbar-bold"> <b>랭커 TOP3</b></span>
						</a>
					</div>
					<div class="col-xs-4 podium" style="padding: 5px;">
						<div style="bottom: 161px;" class="podium-content hover-lightgray">
							<a href="/profile?writer_id=${rankerList[1].user.writer_id }">
								<span class="col-xs-6"> <img
									src="/upload/image/${rankerList[1].user.image}" alt="" />
							</span> <span class="col-xs-6">
									<h3 style="margin-top: 10px;">${rankerList[1].user.nickname}</h3>
							</span>
							</a>
							<h3>${rankerList[1].score }<c:if
									test="${rankerList[1] != null }">점</c:if>
							</h3>
						</div>
						<div class="podium-frame"
							style="height: 140px; border-radius: 10px 0 0 0;">
							<h3>{ 2 }</h3>

						</div>
					</div>
					<div class="col-xs-4 podium" style="padding: 5px;">
						<div style="bottom: 220px;" class="podium-content hover-lightgray">
							<a href="/profile?writer_id=${rankerList[0].user.writer_id }">
								<span class="col-xs-6"> <img
									src="/upload/image/${rankerList[0].user.image}" alt="" />
							</span> <span class="col-xs-6">
									<h3 style="margin-top: 10px;">${rankerList[0].user.nickname}</h3>
							</span>
							</a>
							<h3>${rankerList[0].score }<c:if
									test="${rankerList[0] != null }">점</c:if>
							</h3>
						</div>
						<div class="podium-frame"
							style="height: 200px; border-radius: 10px 10px 0 0;">
							<h3>{ 1 }</h3>
							<img style="width: 60%;" src="/public/image/award.png" alt="" />
						</div>
					</div>
					<div class="col-xs-4 podium" style="padding: 5px;">
						<div style="bottom: 130px;" class="podium-content hover-lightgray">
							<a href="/profile?writer_id=${rankerList[2].user.writer_id }">
								<span class="col-xs-6"> <img
									src="/upload/image/${rankerList[2].user.image}" alt="" />
							</span> <span class="col-xs-6">
									<h3 style="margin-top: 10px;">${rankerList[2].user.nickname}</h3>
							</span>
							</a>
							<h3>${rankerList[2].score }<c:if
									test="${rankerList[2] != null }">점</c:if>
							</h3>
						</div>
						<div class="podium-frame"
							style="height: 110px; border-radius: 0 10px 0 0;">
							<h3>{ 3 }</h3>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="div-title-underbar">
						<a href="/game/insert"> <span class="pull-right lightgray">+</span>
							<span class="div-title-underbar-bold"> <b>게임 업로드</b></span>
						</a>
					</div>
					<a href="/game/insert">
						<div id="insertGameImage-cover"
							class="image-cover text-center over-hidden"
							style="height: 300px; margin: auto;">
							<div id="insertGameImage"
								style="background-image: url('/public/image/background2.jpg'); height: 300px; width: 463px;">
								<div
									style="position: relative; z-index: 10; padding: 80px 20px;">
									<h1 class="text-right" style="margin: 0; color: white;">Click
										to upload a</h1>
									<h1 class="text-right" style="margin: 0; color: white;">
										New game</h1>
									<h4 class="text-right"
										style="margin: 0; color: white; margin-top: 30px;">새로운
										게임을 소개해주세요</h4>
								</div>
							</div>
						</div>
					</a>
				</div>
			</div>
			<div class="row gameList">
				<div class="container-fluid">
					<div class="row">
						<p class="text-right" style="font-size: 20px; font-weight: 600;">
							<a href="/game/list" style="color: black;"></a>
						</p>
						<div class="div-title-underbar">
							<a href="/game/list"> <span class="pull-right"
								style="font-weight: 600;">더보기 +</span> <span
								class="div-title-underbar-bold"> <b>신규 게임</b></span>
							</a>
						</div>
					</div>
					<c:if test="${fn:length(gameList) < 7 }">
						<h2 class="text-center">검색 결과가 없습니다</h2>
					</c:if>
					<c:if test="${fn:length(gameList) >= 7 }">
						<c:forEach begin="0"
							end="${(fn:length(gameList)/6)-((fn:length(gameList)/6)%1)-1}"
							var="i">
							<div class="row">
								<div class="col-sm-2 hover-lightgray">
									<div class="">
										<a href="/game/view?id=${gameList[i*6].id }"> <img
											class="gameImage" alt="/준비중인 게임입니다"
											src="/upload/image/${gameList[i*6].image }">
											<div class="" style="padding: 10px;">
												<div class="text-left">
													<p class="over-hidden"
														style="overflow: hidden; margin: 0 0 5px 0; font-size: 20px; height: 25px;">${gameList[i*6].name }</p>
												</div>
												<div>
													<i class="far fa-thumbs-up"></i> <span>${gameList[i*6].likes-gameList[i*6].unlikes }</span>
													&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i*6].reply_count }</span>
													&nbsp;&nbsp; <i class="far fa-eye"></i> <span>${gameList[i*4].hit }</span>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="col-sm-2 hover-lightgray">
									<a href="/game/view?id=${gameList[i*6+1].id }"> <img
										class="gameImage" alt="/준비중인 게임입니다"
										src="/upload/image/${gameList[i*6+1].image }">
										<div class="" style="padding: 10px;">
											<div class="text-left">
												<p class="over-hidden"
													style="overflow: hidden; margin: 0 0 5px 0; font-size: 20px; height: 25px;">${gameList[i*6+1].name }</p>
											</div>
											<div>
												<i class="far fa-thumbs-up"></i> <span>${gameList[i*6+1].likes-gameList[i*6+1].unlikes }</span>
												&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i*6+1].reply_count }</span>
												&nbsp;&nbsp; <i class="far fa-eye"></i> <span>${gameList[i*4].hit }</span>
											</div>
										</div>
									</a>
								</div>
								<div class="col-sm-2 hover-lightgray">
									<a href="/game/view?id=${gameList[i*6+2].id }"> <img
										class="gameImage" alt="/준비중인 게임입니다"
										src="/upload/image/${gameList[i*6+2].image }">
										<div class="" style="padding: 10px;">
											<div class="text-left">
												<p class="over-hidden"
													style="overflow: hidden; margin: 0 0 5px 0; font-size: 20px; height: 25px;">${gameList[i*6+2].name }</p>
											</div>
											<div>
												<i class="far fa-thumbs-up"></i> <span>${gameList[i*6+2].likes-gameList[i*6+2].unlikes }</span>
												&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i*6+2].reply_count }</span>
												&nbsp;&nbsp; <i class="far fa-eye"></i> <span>${gameList[i*4].hit }</span>
											</div>
										</div>
									</a>
								</div>
								<div class="col-sm-2 hover-lightgray">
									<a href="/game/view?id=${gameList[i*6+3].id }"> <img
										class="gameImage" alt="/준비중인 게임입니다"
										src="/upload/image/${gameList[i*6+3].image }">
										<div class="" style="padding: 10px;">
											<div class="text-left">
												<p class="over-hidden"
													style="overflow: hidden; margin: 0 0 5px 0; font-size: 20px; height: 25px;">${gameList[i*6+3].name }</p>
											</div>
											<div>
												<i class="far fa-thumbs-up"></i> <span>${gameList[i*6+3].likes-gameList[i*6+3].unlikes }</span>
												&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i*6+3].reply_count }</span>
												&nbsp;&nbsp; <i class="far fa-eye"></i> <span>${gameList[i*4].hit }</span>
											</div>
										</div>
									</a>
								</div>
								<div class="col-sm-2 hover-lightgray">
									<a href="/game/view?id=${gameList[i*6+4].id }"> <img
										class="gameImage" alt="/준비중인 게임입니다"
										src="/upload/image/${gameList[i*6+4].image }">
										<div class="" style="padding: 10px;">
											<div class="text-left">
												<p class="over-hidden"
													style="overflow: hidden; margin: 0 0 5px 0; font-size: 20px; height: 25px;">${gameList[i*6+4].name }</p>
											</div>
											<div>
												<i class="far fa-thumbs-up"></i> <span>${gameList[i*6+4].likes-gameList[i*6+4].unlikes }</span>
												&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i*6+4].reply_count }</span>
												&nbsp;&nbsp; <i class="far fa-eye"></i> <span>${gameList[i*4].hit }</span>
											</div>
										</div>
									</a>
								</div>
								<div class="col-sm-2 hover-lightgray">
									<a href="/game/view?id=${gameList[i*6+5].id }"> <img
										class="gameImage" alt="/준비중인 게임입니다"
										src="/upload/image/${gameList[i*6+5].image }">
										<div class="" style="padding: 10px;">
											<div class="text-left">
												<p class="over-hidden"
													style="overflow: hidden; margin: 0 0 5px 0; font-size: 20px; height: 25px;">${gameList[i*6+5].name }</p>
											</div>
											<div>
												<i class="far fa-thumbs-up"></i> <span>${gameList[i*6+5].likes-gameList[i*6+5].unlikes }</span>
												&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i*6+5].reply_count }</span>
												&nbsp;&nbsp; <i class="far fa-eye"></i> <span>${gameList[i*4].hit }</span>
											</div>
										</div>
									</a>
								</div>

							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<div class="footer">
		<div>
			Icons made by <a href="https://www.flaticon.com/authors/eucalyp"
				title="Eucalyp">Eucalyp</a> from <a href="https://www.flaticon.com/"
				title="Flaticon">www.flaticon.com</a> is licensed by <a
				href="http://creativecommons.org/licenses/by/3.0/"
				title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		var $insertImage = $("#insertGameImage");
		var $insertImageCover = $("#insertGameImage-cover");

		$(document).ready(resizeImageBoard());

		function resizeImageBoard() {
			if ($insertImageCover.width() > $insertImage.width()) {
				$insertImageCover.width($insertImage.width() + "px");
			}
		}
	</script>
</body>
</html>