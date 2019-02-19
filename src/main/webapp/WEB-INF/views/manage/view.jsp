<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="seq" uri="http://www.springframework.org/security/tags" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
.image-board {
	width: 212px;
	height: 212px;
	border: 1px solid gray;
}

.image {
	width: 100%;
	height: 100%;
}

#userInfo {
	text-align: center;
	border: 3px solid gray;
	height: 450px;
}

#userInfo input {
	text-align: center;
	background-color:black;
	color: white;
	border:none;
	border-right:0px;
	border-top:0px;
	boder-left:0px;
	boder-bottom:0px;
}

#imageName {
	text-align: center;
}
.background{
	background-color: black;
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
			<div class="row">
				<form:form action="/manage/user/update?${_csrf.parameterName}=${_csrf.token }"
						method="post" enctype="multipart/form-data" modelAttribute="user"
						class="form-horizontal">
					<div class="panel panel-default">
						<div class="panel-heading text-center" style="font-size: 30px;">
							${user.id }님의 정보
						</div>
						<div class="panel-body" style="font-size: 18px; background-color: pink;">
							<div class="col-sm-4 col-sm-offset-1">
								<div class="form-group">
									<div class="col-xs-7 text-center">
										<label class="control-label">프로필 이미지</label>
									</div>
									<input type="file" name="image_file" onchange="showImage(this)" required="required" accept="image"/>
									<div class="image-board" style="margin-bottom: 10px;">
										<img class="image" src="/upload/image/${user.image }" alt="${user.image }" />
									</div>
									<%-- <p>
										<label>${user.nickname}님의 소개</label>
									</p>
									<textarea name="myinfo" style="resize: none; width: 300px; height: 200px;">${user.myinfo }</textarea> --%>
									<span style="background-color: white; position: relative; z-index: 2;">
										<label style="background-color: pink;" class="control-label">&nbsp;&nbsp; 나의 소개 &nbsp;&nbsp;</label>
									</span>
									<div style="width: 90%; height: 210px; border: 1px solid gray; margin-top: 10px; position: absolute; transform: translate(-20px, -25px);">
									<textarea name="myinfo" style="resize: none; width: 100%; background-color: black; color: white; font-size: 16px; border: none; margin-top: 20px; height: 185px; padding: 10px; overflow: hidden;">${user.myinfo }</textarea>
									</div>
								</div>
							</div>
							<div class="col-sm-offset-1 col-sm-6 form-group" id="userInfo" style="margin-top: 63px;">
								<input name="id" type="hidden" value="${user.id }"/>
								<div class="form-group" style="margin-top: 100px;">
									<div class="col-sm-offset-1 col-sm-3">
										<label class="control-label">비밀번호</label>										
									</div>
									<div class="col-sm-5">
										<input name="password" type="password" value="${user.password }"/>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-offset-1 col-sm-3">
										<label class="control-label">닉네임 </label>	
									</div>
									<div class="col-sm-5">
										<input name="nickname" type="text" value="${user.nickname }" />
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-offset-1 col-sm-3">
										<label class="control-label">레벨  </label>										
									</div>
									<div class="col-sm-5">
										<input name="lev" type="text" value="${user.lev }" />
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-offset-1 col-sm-3">
										<label class="control-label">경험치 </label>										
									</div>
									<div class="col-sm-5">
										<input name="exp" type="text" value="${user.exp }" />
									</div>
								</div>
								<div class="form-group" style="margin-top: 60px;">
									<div class="col-sm-offset-1 col-sm-5">
										<button class="btn btn-primary btn-block"  onclick="userUpdate(this.form);">수정</button>
									</div>
									<div class="col-sm-5">
										<button class="btn btn-danger btn-block" type="button" onclick="userDelete('${user.id}');">회원탈퇴</button>
									</div>
								</div>
							</div>
							</div>
						</div>
				</form:form>
			</div>
		</div>
	</div>
	<div class="footer">
			
	</div>
</div>
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		$(document).ready(resizeImageBoard());

		function resizeImageBoard() {
			var width = $(".image-board").outerWidth();
		}
		function userUpdate(f) {
			f.submit();
		}

		function userDelete(id) {
			if (!confirm("정말 탈퇴하시겠습니까??(매니저 권한으로 삭제합니다)")) {
				return;
			}
			location.href = "/manage/user/delete?id=" + id;
		}
		
		function showImage(input) {
			//console.log(input.files[0]);
			var reader = new FileReader();
			reader.onload = function(e) {
				$(".image-board").empty();
				$(".image-board").append(
						"<img class='image' src='"+e.target.result+"'></img>");
				$(".image-board").css('border', 'none');
			}
			reader.readAsDataURL(input.files[0]);
		}
	</script>
</body>
</html>