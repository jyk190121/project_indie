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
.row{
	margin-top: 30px;
}

.content {
	min-width: 1000px;
}

.hotGame {
	
}

.gameImage {
	width: 100%;
	height: 10vw;
}
</style>
</head>
<body>
	<div class="header">
		<div style="height: 50px;">
			<jsp:include page="/WEB-INF/views/navbar.jsp" />
		</div>
		<form action="/game/list" method="get">
			<input type="text" name="search" />
			<button>
				<i class="fas fa-search"></i>
			</button>
		</form>
	</div>
	<div class="content">
		<p class="text-right">
			<a href="javascript:go('date')">최신순</a> <a
				href="javascript:go('hit')">조회순</a> <a href="javascript:go('like')">추천순</a>
		</p>
		<div class="container">
			<c:if test="${fn:length(gameList) < 5 }">
				<h2 class="text-center">검색 결과가 없습니다</h2>
			</c:if>
			<c:if test="${fn:length(gameList) >= 5 }">
				<c:forEach begin="0"
					end="${(fn:length(gameList)/4)-((fn:length(gameList)/4)%1)-1 }"
					var="i">
					<div class="row">
						<div class="col-sm-3">
							<a href="/game/view?id=${gameList[i*4].id }"> <img
								class="gameImage" alt="" style="border: 1px solid gray;"
								src="/upload/image/${gameList[i*4].image }">
							</a>
							<div>
								<div class="" style="padding: 10px; border: 1px solid #be2edd; border-top: none;">
									<div class="text-left">
										<p class="over-hidden"
											style="overflow: hidden; margin: 0 0 5px 0; font-size: 20px; font-weight: 700; height: 25px;">[${gameList[i*4].type}]
											${gameList[i*4].name }</p>
										<p class="over-hidden"
											style="overflow: hidden; margin: 0 0 5px 0; font-size: 16px; height: 40px;">${gameList[i*4].info }</p>
									</div>
									<div style="font-size: 20px">
										<i class="far fa-thumbs-up"></i> <span>${gameList[i*4].likes-gameList[i*4].unlikes }</span>
										&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i*4].reply_count }</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-3">
							<a href="/game/view?id=${gameList[i*4+1].id }"> <img
								class="gameImage" alt="" style="border: 1px solid gray;"
								src="/upload/image/${gameList[i*4+1].image }">
							</a>
							<div>
								<div class=""  style="padding: 10px; border: 1px solid #be2edd; border-top: none;">
									<div class="text-left">
										<p class="over-hidden"
											style="overflow: hidden; margin: 0 0 5px 0; font-size: 20px; font-weight: 700; height: 25px;">[${gameList[i*4+1].type}]
											${gameList[i*4+1].name }</p>
										<p class="over-hidden"
											style="overflow: hidden; margin: 0 0 5px 0; font-size: 16px; height: 40px;">${gameList[i*4+1].info }</p>
									</div>
									<div style="font-size: 20px">
										<i class="far fa-thumbs-up"></i> <span>${gameList[i*4+1].likes-gameList[i*4+1].unlikes }</span>
										&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i*4+1].reply_count }</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-3">
							<a href="/game/view?id=${gameList[i*4+2].id }"> <img
								class="gameImage" alt="" style="border: 1px solid gray;"
								src="/upload/image/${gameList[i*4+2].image }">
							</a>
							<div>
								<div class="" style="padding: 10px; border: 1px solid #be2edd; border-top: none;">
									<div class="text-left">
										<p class="over-hidden"
											style="overflow: hidden; margin: 0 0 5px 0; font-size: 20px; font-weight: 700; height: 25px;">[${gameList[i*4+2].type}]
											${gameList[i*4+2].name }</p>
										<p class="over-hidden"
											style="overflow: hidden; margin: 0 0 5px 0; font-size: 16px; height: 40px;">${gameList[i*4+2].info }</p>
									</div>
									<div style="font-size: 20px">
										<i class="far fa-thumbs-up"></i> <span>${gameList[i*4+2].likes-gameList[i*4+2].unlikes }</span>
										&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i*4+2].reply_count }</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-3">
							<a href="/game/view?id=${gameList[i*4+3].id }"> <img
								class="gameImage" alt="" style="border: 1px solid gray;"
								src="/upload/image/${gameList[i*4+3].image }">
							</a>
							<div>
								<div class="" style="padding: 10px; border: 1px solid #be2edd; border-top: none;">
									<div class="text-left">
										<p class="over-hidden"
											style="overflow: hidden; margin: 0 0 5px 0; font-size: 20px; font-weight: 700; height: 25px;">[${gameList[i*4+3].type}]
											${gameList[i*4+3].name }</p>
										<p class="over-hidden"
											style="overflow: hidden; margin: 0 0 5px 0; font-size: 16px; height: 40px;">${gameList[i*4+3].info }</p>
									</div>
									<div style="font-size: 20px">
										<i class="far fa-thumbs-up"></i> <span>${gameList[i*4+3].likes-gameList[i*4+3].unlikes }</span>
										&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i*4+3].reply_count }</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
		</div>
	</div>
	<div class="footer"></div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		function go(type){
			var url;
			if(${param.search != null}){
				url = "/game/list?search=${search}&type="+type;
			}else{
				url = "/game/list?type="+type;
			}
			location.href=url;
		}
	</script>
</body>
</html>