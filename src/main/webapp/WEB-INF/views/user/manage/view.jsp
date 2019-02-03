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
	height: 100px;
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
		<i class="" style="font-size: 85%"></i> ${param.nickname }님의 정보
	</h1>
	<a href="/main">main</a>
	<div class="content">
		<form:form action="/user/manage/update?${_csrf.parameterName}=${_csrf.token }"
				method="post" enctype="multipart/form-data" modelAttribute="user"
				class="form-horizontal" id="form">
			<div class="panel panel-default">
				<div class="panel-heading text-center">
				</div>
				<div class="panel-body" style="font-size: 18px;">
					<div class="col-sm-offset-1 col-sm-5 form-group" id="userInfo">
						<p>
							아이디 : <input name="id" type="text" value="${param.id }" 
								style="background-color:gray;" readonly/>
						</p>
						<p>
							비밀번호 : <input name="password" type="password" value="${param.password }"/>
						</p>
						<p>
							닉네임 : <input name="nickname" type="text" value="${param.nickname }" />
						</p>
						<p>
							레벨 : <input name="lev" type="text" value="${param.lev }" />
						</p>
						<p>
							경험치 : <input name="exp" type="text" value="${param.exp }" />
						</p>
					</div>
	
					<div class="col-sm-offset-1 col-sm-5">
						<div class="form-group">
							<label>프로필 이미지</label>
							<input type="file" name="image_file" onchange="showImage(this)" required="required" accept="image"/>
							<div class="image-board" style="margin-bottom: 10px;">
								<img class="image" src="/upload/image/${param.image }" alt="${param.image }" />
							</div>
							<p>
								<label>${param.nickname}님의 소개</label>
							</p>
							<textarea name="myinfo" style="resize: none; width: 300px;">${param.myinfo }</textarea>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</div>
	<div class="footer text-center">
		<pre class="text-center" style="font-size: 30px;">현재레벨 : ${param.lev}  경험치 : ${param.exp}</pre>
			<button class="btn btn-primary" 
				onclick="userUpdate();">수정</button>
			<button class="btn btn-danger" type="button"
				onclick="userDelete('${param.id}');">회원탈퇴</button>
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