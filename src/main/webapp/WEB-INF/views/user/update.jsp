<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="stylesheet" href="/public/css/shop.css" />
</head>
<style>
	.content{
		font-size: 20px;
		background-color: white;
		text-align: center;
	}
</style>
<body>
<div class="header">
	<h1 class="text-center"> 회원정보 수정 </h1>
</div>
<div class="content">
	<div class="panel panel-default">
			<div class="panel-heading">
				<p>ID : ${user.id }</p>
			</div>
			<div class="container">
				<div class="row" style="margin-bottom: 10px;">
					<div class="col-sm-3">닉네임:</div>
					<div class="col-sm-9">
						<input id="userNickname" class="form-control" type="text" name="name" value="${user.nickname }" style="font-size: 20px; text-align: center;"/>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-3">변경하실 비밀번호 :</div>
					<div class="col-sm-9">
						<input id="userpassword" class="form-control" type="password" name="password"/>
					</div>
				</div>
			</div>
		</div>
</div>
<button type="button" class="btn btn-primary btn-block" onclick="userChange('${user.id}')">수정</button>
<div class="footer">
</div>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</body>
</html>