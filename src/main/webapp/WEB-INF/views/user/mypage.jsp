<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="shortcut icon" href="/public/favicon.ico">
<link rel="stylesheet" href="/public/css/style.css">
<title>MyPage</title>
<style>
.image-board {
	width: 300px;
	height: 300px;
	border: 1px solid gray;
}

#image {
	width: 100%;
	height: 100%;
}

.myBoard {
	margin-top: 10px;
	font-size: 15px;
	height: 400px;
	overflow: hidden;
	text-align: center;
}

textarea {
	outline: none;
}

.header{
	height: 350px;
<<<<<<< HEAD
=======
}

.footer{
	height: 100px;
>>>>>>> 980bf46e3ca3ed144ba97c6c44eb93817cc216b5
}
</style>
</head>
<body>
	<div class="header">
		<div style="height: 50px;">
			<jsp:include page="/WEB-INF/views/navbar.jsp" />
		</div>
		<div class="container">
			<div class="row" style="margin-top: 30px;">
				<div
					style="background-image: url('/public/image/background5-1.jpg'); width: 100%; height: 200px;">
					<h1 class="text-center"
						style="padding-top: 0; color: white; font-weight: 600; font-size: 100px; padding-top: 40px;">Mypage</h1>
				</div>
			</div>
		</div>
	</div>
	<div class="content">
		<div class="container">
			<div class="row">
				<form:form id="sendForm"
					action="/user/mypage?${_csrf.parameterName}=${_csrf.token }"
					method="post" enctype="multipart/form-data" modelAttribute="user"
					class="form-horizontal">
					<div class="col-sm-4 text-center" style="font-size: 20px;">
						<div class="div-title-underbar text-left">
							<a href=""> <span class="div-title-underbar-bold"> <b>프로필 이미지</b></span></a>
						</div>
						<div class="form-group" style="">
							<div class="image-board" style="margin: auto;">
								<img id="image" name="image" src="/upload/image/${user.image }"
									alt="${user.image }" />
							</div>
						</div>
					</div>
					<div class="col-sm-8"
						style="font-size: 20px; height: 300px;">
						<div class="div-title-underbar text-left">
							<a href=""> <span class="div-title-underbar-bold"> <b>내 정보</b></span></a>
						</div>
						<div class="row" style=" margin-top: 25px;">
							<div class="col-xs-6" style="padding-left: 30px;">
								<div class="form-group">
									<div class="col-xs-3">
										<label class="control-label">아이디</label>
									</div>
									<div class="col-xs-9">
										<label class="control-label">${user.id }</label>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-3">
										<label class="control-label">닉네임</label>
									</div>
									<div class="col-xs-9 text-left" style="height:35px;">
										<label style="height:35px;" class="over-hidden control-label">${user.nickname }</label>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-3">
										<label class="control-label">이메일</label>
									</div>

									<div class="col-xs-9" style="height: 35px;">
										<label style="height: 35px;"class="over-hidden control-label">${user.email }</label>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-3">
										<label class="control-label">레벨</label>
									</div>
									<div class="col-xs-9">
										<label class="control-label">Lv. ${user.lev }</label>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-3">
										<label class="control-label">경험치</label>
									</div>
									<div class="col-xs-9">
										<label class="control-label">${user.exp} exp</label>
									</div>
								</div>
							</div>
							<div class="col-xs-6">
								<span
									style="background-color: white; position: relative; z-index: 2;">
									<label for="" class="control-label">&nbsp;&nbsp; 한줄 소개
										&nbsp;&nbsp;</label>
								</span>
								<div
									style="width: 90%; height: 210px; border: 1px solid gray; margin-top: 10px; position: absolute; transform: translate(-20px, -25px);">
									<textarea
										style="resize: none; width: 100%; font-size: 16px; background-color: white; border: none; margin-top: 20px; height: 185px; padding: 10px; overflow: hidden;">${user.myinfo }</textarea>
								</div>
							</div>
						</div>
						<form:input type="hidden" path="id" name="id" />
						<div class="row">
							<div class="form-group" style="margin-bottom: 5px;">
								<form:hidden id="userpassword" name="password" path="password"
									style="width:205px;" />
							</div>
							<div class="form-group" style="margin-top: 15px;">
								<div class="" style="font-size: 0; padding-left: 35px;">
									<button class="btn btn-primary" type="button"
										style="width: 46%; height: 30px; padding: 0px; margin-right: 1%;"
										onclick="userUpdate(this.form);">수정</button>
									<button class="btn btn-danger" type="button"
										style="width: 46%; height: 30px; padding: 0px;"
										onclick="userDelete(this.form);">회원탈퇴</button>
								</div>
							</div>
						</div>
					</div>
				</form:form>
			</div>
			<div class="row" style="margin-top: 30px;">
				<div class="myBoard">
					<div>
						<div class="div-title-underbar text-left">
							<a href=""> <span class="div-title-underbar-bold"> <b>나의 게시물</b></span></a>
						</div>
						<table class="table table-hover table-board">
							<thead>
								<tr>
									<th class="text-center">제목</th>
									<th class="text-center">조회수</th>
									<th class="text-center">댓글수</th>
									<th class="text-center">작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="board" items="${myBoardList}">
									<tr onclick="location.href='/board/view?id=${board.id}'"
										style="cursor: pointer;">
										<td>${board.title }</td>
										<td>${board.hit }</td>
										<td>${board.reply_count }</td>
										<td>${board.write_date }</td>
									</tr>
								</c:forEach>
							</tbody>
							<tfoot>
							</tfoot>
						</table>
						<c:if test="${myBoardList eq null}">
							<a href="/board/insert?type=normal" class="btn btn-primary">글쓰기</a>
						</c:if>
					</div>
					<div class="pagination">${myBoardPage }</div>
				</div>
			</div>
		</div>
	</div>
	<div class="footer"></div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		function userUpdate(f) {
			if (!confirm("수정하시겠습니까??")) {
				return;
			}
			var password;
			if (!(password = prompt("비밀번호를 입력하세요"))) {
				return;
			}
			f.password.value = password;
			f.submit();
		}

		function userDelete(f) {
			var check = confirm("정말 탈퇴하시겠습니까??(이 아이디와 관련된 정보는 모두 삭제됩니다)");
			if (!check) {
				return;
			}
			var password;
			if (!(password = prompt("비밀번호를 입력하세요"))) {
				return;
			}
			f.password.value = password;
			$("#sendForm").attr("action",
					"/user/delete?${_csrf.parameterName}=${_csrf.token }");
			f.submit();
		}

		$(document).ready(resizeImageBoard());

		function resizeImageBoard() {
			var width = $(".image-board").outerWidth();
		}
	</script>
</body>
</html>