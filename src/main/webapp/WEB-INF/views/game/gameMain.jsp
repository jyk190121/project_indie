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
<style>

* {
	box-sizing: border-box;
}

.content {
	min-width: 1000px;
}

.hotGame {
	
}

.gameImage {
	width: 100%;
}
</style>
</head>
<body>
	<div class="header">
		<div class="jumbotron">
			<h1 class="text-center">GAME</h1>
		</div>
	</div>
	<div class="content">
		<div class="container-fluid">
			<div class="row">
				<c:forEach items="${hotGameList }" var="hotGame">
					<div
						class="col-sm-4 <c:if test="${fn:length(hotGameList) <= 2 }">col-offset-sm-2</c:if><c:if test="${fn:length(hotGameList) <= 1 }">col-offset-sm-2</c:if>">
						<div class="hotGame">
							<a href="/game/view?id=${hotGame.id }">
								<img class="gameImage" alt="game image"
									src="/upload/image/${hotGame.image }">
							</a>
							<div class="text-center">${hotGame.name }</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<c:if test="${fn:length(rankerList) == 0 }">
						랭커가 없네요..?
					</c:if>
					<c:if test="${fn:length(rankerList) != 0 }">
					<c:forEach begin="0" end="${fn:length(rankerList)-1 }" var="i">
						${i+1 }등
						${rankerList[i].user.nickname }
						${rankerList[i].score }
					</c:forEach>
					</c:if>
				</div>
				<div class="col-sm-6">
					<a href="/game/insert">+ 게임 등록</a>
				</div>
			</div>
			<div class="row">
				<div class="container-fluid">
					<div class="row">
						<p class="text-right"><a href="/game/list">더보기 +</a></p>
					</div>
					<c:if test="${fn:length(gameList) < 6 }">
					<h2 class="text-center">검색 결과가 없습니다</h2>
					</c:if>
					<c:if test="${fn:length(gameList) >= 6 }">
					<c:forEach begin="0" end="${(fn:length(gameList)/5)-((fn:length(gameList)/5)%1)-1 }" var="i">
					<div class="row">
						<div class="col-sm-2 col-sm-offset-1">
							<a href="/game/view?id=${gameList[i*5].id }">
								<img class="gameImage" alt="/준비중인 게임입니다"
									 src="/upload/image/${gameList[i*5].image }">
							</a>	
								<div class="text-center">${gameList[i*5].name }</div>
						</div>
						<div class="col-sm-2">
							<a href="/game/view?id=${gameList[i*5+1].id }">
								<img class="gameImage" alt="/준비중인 게임입니다"
								 src="/upload/image/${gameList[i*5+1].image }">
							</a>
							<div class="text-center">${gameList[i*5+1].name }</div>
						</div>
						<div class="col-sm-2">
							<a href="/game/view?id=${gameList[i*5+2].id }">
								<img class="gameImage" alt="/준비중인 게임입니다"
									 src="/upload/image/${gameList[i*5+2].image }">
							</a>	
							<div class="text-center">${gameList[i*5+2].name }</div>
						</div>
						<div class="col-sm-2">
							<a href="/game/view?id=${gameList[i*5+3].id }">
								<img class="gameImage" alt="/준비중인 게임입니다"
									 src="/upload/image/${gameList[i*5+3].image }">
							</a>
							<div class="text-center">${gameList[i*5+3].name }</div>
						</div>
						<div class="col-sm-2">
							<a href="/game/view?id=${gameList[i*5+4].id }">
								<img class="gameImage" alt="/준비중인 게임입니다"
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
</body>
</html>