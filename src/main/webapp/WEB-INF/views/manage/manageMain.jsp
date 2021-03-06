<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>manage</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="shortcut icon" href="/public/favicon.ico">
<link rel="stylesheet" href="/public/css/style.css">
<style>
tfoot {
	text-align: center;
}

.line {
	margin-bottom: 0;
}
.background{
	background-color: black;
	font-size: 20px;
	min-height: 800px;
}
</style>
</head>
<body>
<div class="background">
	<div class="header">
		<div style="height: 50px;">
			<jsp:include page="/WEB-INF/views/navbar.jsp" />
		</div>
		<div class="container">
			<div class="row" style="margin-top: 30px;">
				<div
					style="background-image: url('/public/image/background5-1.jpg'); width: 100%; height: 200px;">
					<h1 class="text-center"
						style="padding-top: 0; color: white; font-weight: 600; font-size: 100px; padding-top: 40px;">
						<i class="glyphicon glyphicon glyphicon-pencil
				   style="font-size:85%"></i>유저 관리 시스템</h1>
				</div>
			</div>
		</div>
	</div>
	<div class="content">
		<div class="container">
			<div class="row" style="margin-top: 20px;">
				<div class="text-right">
					<form action="" method="get" class="form-inline">
						<div class="form-group">
							<select name="type" class="form-control">
								<option value="id">아이디</option>
								<option value="nickname">닉네임</option>
							</select>
						</div>
						<div class="form-group">
							<input type="text" name="search" value="${search }" class="form-control" />
						</div>
						<button type="submit" class="btn btn-primary">
							<span class="glyphicon glyphicon-search"></span>
						</button>
					</form>
				</div>
			</div>
			<div class="row">
				<table class="table table-hover">
					<thead>
						<tr style="color: skyblue;">
							<th width="30%" style="text-align: center;">유저 아이디</th>
							<th width="30%" style="text-align: center;">닉네임</th>
							<th width="20%" style="text-align: center;">레벨</th>
							<th width="20%" style="text-align: center;">경험치</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="user" items="${userList}">
							<tr onclick="javascript:userList('${user.id}');"
								style="cursor: pointer; color: orange;">
								<td style="text-align: center;">${user.id }</td>
								<td style="text-align: center;">${user.nickname }</td>
								<td style="text-align: center;">${user.lev}</td>
								<td style="text-align: center;">${user.exp }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
	<div class="footer" style="background-color: black">
		Game Made By <a href="">me</a>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		function userList(id) {
			location.href = '/manage/user?id=' + id
		}
	</script>
</body>
</html>