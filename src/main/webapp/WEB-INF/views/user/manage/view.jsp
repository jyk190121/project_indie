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
<style>
.image-board {
	width: 300px;
	height: 200px;
	border: 1px solid gray;
}

.image {
	width: 100%;
	height: 100%;
}

#userInfo {
	text-align: center;
}

#userInfo input {
	text-align: center;
}

#imageName {
	text-align: center;
}
</style>
</head>
<body>
	<div class="header">
		<div class="jumbotron">
			<h1 class="text-center">
				<i class="glyphicon glyphicon glyphicon-pencil
				   style="font-size:85%"></i>
				유저 관리 시스템
			</h1>
		</div>
	</div>
	<h1 class="text-center">
	<span class="glyphicon glyphicon-user"></span>
		<i class="" style="font-size: 85%"></i> ${user.nickname }님의 정보
	</h1>
	<div class="content">
	<a class="btn btn-primary btn-block" href="/manage">유저리스트</a>
		<form:form action="/user/manage/update?${_csrf.parameterName}=${_csrf.token }"
				method="post" enctype="multipart/form-data" modelAttribute="user"
				class="form-horizontal" id="form">
			<div class="panel panel-default">
				<div class="panel-heading text-center">
				</div>
				<div class="panel-body" style="font-size: 18px;">
					<div class="col-sm-offset-1 col-sm-5 form-group" id="userInfo">
						<p>
							아이디 : <input name="id" type="text" value="${user.id }" 
								style="background-color:gray;" readonly/>
						</p>
						<p>
							비밀번호 : <input name="password" type="password" value="${user.password }"/>
						</p>
						<p>
							닉네임 : <input name="nickname" type="text" value="${user.nickname }" />
						</p>
						<p>
							레벨 : <input name="lev" type="text" value="${user.lev }" />
						</p>
						<p>
							경험치 : <input name="exp" type="text" value="${user.exp }" />
						</p>
					</div>
	
					<div class="col-sm-offset-1 col-sm-5">
						<div class="form-group">
							<label>프로필 이미지</label>
							<input type="file" name="image_file" onchange="showImage(this)" required="required" accept="image"/>
							<div class="image-board" style="margin-bottom: 10px;">
								<img class="image" src="/upload/image/${user.image }" alt="${user.image }" />
							</div>
							<p>
								<label>${user.nickname}님의 소개</label>
							</p>
							<textarea name="myinfo" style="resize: none; width: 300px;">${user.myinfo }</textarea>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</div>
	<div class="footer text-center">
		<pre class="text-center" style="font-size: 30px;">현재레벨 : ${user.lev}  경험치 : ${user.exp}</pre>
			<button class="btn btn-primary" 
				onclick="userUpdate();">수정</button>
			<button class="btn btn-danger" type="button"
				onclick="userDelete('${user.id}');">회원탈퇴</button>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		$(document).ready(resizeImageBoard());

		function resizeImageBoard() {
			var width = $(".image-board").outerWidth();
		}
		function userUpdate() {
			$("#form").submit();
		}

		function userDelete(id) {
			if (!confirm("정말 탈퇴하시겠습니까??(매니저 권한으로 삭제합니다)")) {
				return;
			}
			location.href = "/user/manage/delete?id=" + id;
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