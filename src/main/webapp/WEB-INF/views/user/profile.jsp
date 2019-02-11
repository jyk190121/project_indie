<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style>
	.image-board{
		width: 300px;
		height: 200px;
		border: 1px solid gray;
	}
	#image{
		width: 100%;
		height: 100%;
	}
	#lev{
		font-size: 60px;
		margin-top: 30px;
	}
	#myinfo{
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
				  ${user.nickname }
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
			<div class="form-group col-sm-5">
				<label class="control-label">프로필 이미지</label>
				<div class="image-board">
					<img id="image" name="image" src="/upload/image/${user.image }" alt="${user.image }" />
				</div>
			</div>
			<div id="lev" class="form-group col-sm-5">
				<p>유저 레벨 :	${user.lev }</p>
			</div>
			<div id="myinfo" class="form-group col-sm-3">
				<p class="text-center">나의 소개</p>
				${user.myinfo }
			</div>
		</div>
	</div>
	
	<div class="footer">
		<a href="/user/mypage" class="btn btn-primary btn-block">나의 정보수정하기</a>
	</div>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script>
$(document).ready(
		resizeImageBoard());	

	function resizeImageBoard(){
		var width = $(".image-board").outerWidth();
	}
</script>
</body>
</html>