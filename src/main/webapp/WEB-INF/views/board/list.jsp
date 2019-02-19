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
<title>notice board</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="shortcut icon" href="/public/favicon.ico">
<link rel="stylesheet" href="/public/css/style.css">
<style>
.row {
	margin-top: 50px;
}

.header {
	height: 320px;
}

.table-board {
	background-color: white;
}

.table-board>thead>tr>th, .table-board>tbody>tr>td {
	text-align: center;
	padding: 20px 0;
}

tfoot {
	text-align: center;
}

.emptyUser {
	margin: 0;
	color: silver;
	background-color: black;
}

.board-title-notice {
	display: inline-block;
	width: 80%;
	transform: translate(-5%, 0);
	font-weight: bold;
}

.over-hidden {
	height: 20px;
	overflow: hidden;
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
					style="background-image: url('/public/image/background4-dark.jpg'); width: 100%; height: 200px;">
					<h1 class="text-center"
						style="padding-top: 0; color: white; font-weight: 600; font-size: 200px;">Board
						Main</h1>
				</div>
			</div>
		</div>
	</div>
	<div class="content">
		<div class="container">
			<div class="row">
				<h2 class="text-center">게시물을 작성할 수 있습니다</h2>
			</div>
			<div class="row">
				<div class="text-right" style="margin-bottom: 10px;">
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<a href="/board/insert?type=notice" class="btn btn-danger">공지사항
							작성</a>
					</sec:authorize>
					<a href="/board/insert?type=normal" class="btn btn-primary" style="width: 200px;">게시물 작성하기</a>
				</div>
				<table class="table table-hover table-board">
					<thead>
						<tr>
							<th width="30%">제목</th>
							<th width="30%">작성자</th>
							<th width="20%">작성일</th>
							<th width="10%">댓글수</th>
							<th width="10%">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="board" items="${boardList}">
							<tr onclick="location.href='/board/view?id=${board.id}'"
								style="cursor: pointer;">
								<td><c:if test="${board.type == 'notice' }">
										<div class="text-center"
											style="display: inline-block; width: 10%;">
											<span class="badge" style="background-color: red;">공지</span>
										</div>
										<div class="board-title-notice over-hidden">${board.title }</div>
									</c:if> <c:if test="${board.type == 'normal' }">
										<div class="over-hidden">${board.title }</div>
									</c:if></td>
								<td>
									<div class="over-hidden">
										${board.user.nickname }
										<c:if test="${board.user.nickname eq null}">
											<p class="emptyUser">탈퇴한 유저의 게시물입니다.</p>
										</c:if>
									</div>
								</td>
								<td>
									<div class="over-hidden">${board.write_date }</div>
								</td>
								<td>${board.reply_count }</td>
								<td>${board.hit }</td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="5" style="border-top: none;">
								<ul class="pagination">${page }
								</ul>
							</td>
						</tr>
					</tfoot>
				</table>

			</div>
		</div>
	</div>
	<div class="footer">
		Game Made By <a href="">me</a>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>



