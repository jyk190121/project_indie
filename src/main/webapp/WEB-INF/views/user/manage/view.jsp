<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

#image {
	width: 100%;
	height: 100%;
}

#userInfo {
	text-align: left;
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
		<i class="" style="font-size: 85%"></i> ${param.nickname }님의 정보
	</h1>
	<a href="/main">main</a>
	<div class="content">
		<div class="panel panel-default">
			<div class="panel-heading text-center">
				<span class="glyphicon glyphicon-user"></span>
				<h4>회원정보 수정</h4>
			</div>
			<div class="panel-body" style="font-size: 18px;">
				<div class="col-sm-offset-1 col-sm-5 form-group" id="userInfo">
					<p>
						아이디 : <input id="id" type="text" value="${param.id }" />
						<button class="btn btn-primary" type="button"
							onclick="userUpdate(this.form, 'id');">수정</button>
					</p>
					<p>
						비밀번호 :<input id="password" type="text" value="${param.password }" />
						<button class="btn btn-primary" type="button"
							onclick="userUpdate('password');">수정</button>
					</p>
					<p>
						닉네임 : <input id="nickname" type="text" value="${param.nickname }" />
						<button class="btn btn-primary" type="button"
							onclick="userUpdate(this.input);">수정</button>
					</p>
					<p>
						이미지 : <input id="imageName" type="text" value="${param.image }"
							style="background-color: gray;" readonly />
					</p>
					<p>
						레벨 : <input id="level" type="text" value="${param.lev }" />
						<button class="btn btn-primary" type="button"
							onclick="userUpdate(this.input);">수정</button>
					</p>
					<p>
						경험치 : <input id="exp" type="text" value="${param.exp }" />
						<button class="btn btn-primary" type="button"
							onclick="userUpdate(this.input);">수정</button>
					</p>
				</div>

				<div class="col-sm-offset-1 col-sm-5">
					<div class="form-group">
						<label>프로필 이미지</label>
						<div class="image-board" style="margin-bottom: 10px;">
							<img id=image src="/upload/image/${param.image }"
								alt="${param.image }" />
						</div>
						<p>
							<label>${param.nickname}님의 소개</label>
						</p>
						<textarea style="resize: none; width: 300px;">${param.myinfo }</textarea>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="footer text-center">
		<pre class="text-center" style="font-size: 30px;">현재레벨 : ${param.lev}  경험치 : ${param.exp}</pre>
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
		function userUpdate(column) {
			var $column = $("#"+column);
			console.log($column.val());
			if (!confirm("수정하시겠습니까??")) {
				return;
			}
			$.ajax({
				url:"/user/manage/update",
				type: "get",
				data: {"column":column, "value":$column.val()},
				success(data) function {
					
				}
			});
			location.href = "/user/manage/update?id=" + id;
		}

		function userDelete(id) {
			var check = confirm("정말 탈퇴하시겠습니까??(매니저 권한으로 삭제합니다)");
			if (!check) {
				return;
			}
			//관리자는 탈퇴불가
			location.href = "/user/manage/delete?id=" + id;
		}
	</script>
</body>
</html>