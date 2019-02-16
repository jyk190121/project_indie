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
<title>MyPage</title>
<style>
.image-board {
	width: 80%;
	height: 200px;
	border: 1px solid gray;
}

#image {
	width: 100%;
	height: 100%;
}

.myBoard {
	margin-top: 10px;
	font-size: 15px;
	border: 1px solid gray;
	text-align: center;
	height: 338px;
	overflow: auto;
}
</style>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="header">
		<div class="jumbotron">
			<h1 class="text-center">
				<i class="" style="font-size: 85%"></i> ${user.nickname }님의 정보
			</h1>
		</div>
	</div>
	<div class="content">
		<a class="btn btn-primary btn-block" href="/main">main</a>
		<div class="panel panel-default">
			<div class="panel-heading text-center">
				<span class="glyphicon glyphicon-user"></span>
				<h4>회원정보 수정</h4>
			</div>
			<div class="panel-body">
				<form:form id="sendForm"
					action="/user/mypage?${_csrf.parameterName}=${_csrf.token }"
					method="post" enctype="multipart/form-data" modelAttribute="user"
					class="form-horizontal">
					<div class="col-sm-offset-1 col-sm-5" style="font-size: 20px;">
						<div class="form-group">
							<label class="control-label">프로필 이미지</label>
							<div class="image-board">
								<img id="image" name="image" src="/upload/image/${user.image }"
									alt="${user.image }" />
							</div>
						</div>
						<form:input type="hidden" path="id" name="id" />
						<p>ID : ${user.id }</p>
						비밀번호
						<form:password id="userpassword" name="password" path="password" />
						<button class="btn btn-primary" type="button"
							onclick="userUpdate(this.form);">수정</button>
						<button class="btn btn-danger" type="button"
							onclick="userDelete(this.form);">회원탈퇴</button>
					</div>
					<div class="col-sm-5 myBoard">
						<div>
							<p style="font-size: 20px;">나의 게시판</p>
							<table class="table table-hover table-board">
								<thead>
									<tr>
										<th class="text-center" width="50%">제목</th>
										<th class="text-center" width="50%">작성일</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="board" items="${myBoardList}">
										<tr onclick="location.href='/board/view?id=${board.id}'"
											style="cursor: pointer;">
											<td>${board.title }</td>
											<td>${board.write_date }</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>

								</tfoot>
							</table>
						</div>
						<div class="pagination">${myBoardPage }</div>
					</div>
				</form:form>
			</div>
			<pre class="text-center" style="font-size: 30px;">현재레벨 : ${user.lev}  경험치 : ${requestScope.user.exp}</pre>
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
			f.submit();
		}

		function userDelete(f) {
			var check = confirm("정말 탈퇴하시겠습니까??(이 아이디와 관련된 정보는 모두 삭제됩니다)");
			if (!check) {
				return;
			}
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