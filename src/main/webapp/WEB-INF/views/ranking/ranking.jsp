<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="shortcut icon" href="/public/favicon.ico">
<link rel="stylesheet" href="/public/css/style.css">
<style>
.header {
	height: 400px;
}
</style>
</head>
<body>
	<div class="header">
		<div style="height: 50px;">
			<jsp:include page="/WEB-INF/views/navbar.jsp" />
		</div>
		<div class="text-center"
			style="height: 300px; background-image: url('/public/image/background6-1.png'); background-position: center;">
			<div class="text-center" style="padding-top: 110px;">
				<form action="" method="get" class="form-inline">
					<div class="input-group">
						<input placeholder="" type="text" name="search"
							class="form-control input"
							style="width: 300px; height: 50px; font-size: 24px;">
						<div class="input-group-btn">
							<button class="btn btn-primary"
								style="width: 50px; height: 50px;">
								<span class="glyphicon glyphicon-search"
									style="font-size: 20px;"></span>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="content">
		<div class="container">
			<div class="row">
				<table class="table table-hover text-center">
					<thead style="text-align: center !important;">
						<tr>
							<th width="10%">순위</th>
							<th width="10%">닉네임</th>
							<th width="10%">레벨</th>
							<th width="10%">경험치</th>
						</tr>
					</thead>
					<tbody id="userList">
						<c:forEach var="user" items="${userList}">
							<tr onclick="javascript:userList('${user.writer_id}');"
								style="cursor: pointer;">
								<td>${user.rnum}</td>
								<td>${user.nickname }</td>
								<td>${user.lev}</td>
								<td>${user.exp }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="footer"></div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		function userList(id) {
			location.href = "/profile?writer_id=" + id
		}

		$(document)
				.ready(
						function() {
							var page = 2; //처음 30개를 빼고 시작해야하므로
							var docH = $(document).height(); //document의 높이
							var scrollH = $(window).height()
									+ $(window).scrollTop();

							$(window)
									.scroll(
											function() {
												scrollH = $(window).height()
														+ $(window).scrollTop();
												if (scrollH == docH) { //(문서의 높이 - 50)에서 실행됨
													//alert('d');
													//console.log(scrollH);
													$
															.ajax({
																url : "/ranking",
																type : "post",
																data : {
																	page : page
																},
																beforeSend : function(
																		xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
																	xhr
																			.setRequestHeader(
																					"${_csrf.headerName}",
																					"${_csrf.token}");
																},
																success : function(
																		data) {
																	console
																			.log(page);
																	$(
																			"#userList")
																			.append(
																					data);
																	docH = $(
																			document)
																			.height();
																	if (scrollH < document.body.scrollHeight) {
																		//결과값이 없을 때 page증가 멈춤
																		page++;
																	}

																}
															});
												}
											});
						});
	</script>
</body>
</html>