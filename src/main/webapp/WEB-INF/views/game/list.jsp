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
		<div class="container-fluid">
			<c:if test="${fn:length(gameList) < 5 }">
				<h2 class="text-center">검색 결과가 없습니다</h2>
			</c:if>
			<c:if test="${fn:length(gameList) >= 5 }">
			<c:forEach begin="0" end="${(fn:length(gameList)/4)-((fn:length(gameList)/4)%1)-1 }" var="i">
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