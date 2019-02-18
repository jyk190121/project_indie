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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
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
	border: 1px solid gray;
	text-align: center;
	height: 350px;
	overflow: scroll;
}
</style>
</head>
<body>
	<div class="header">
		<div style="height: 50px;">
			<jsp:include page="/WEB-INF/views/navbar.jsp" />
		</div>
		<div class="jumbotron">
			<h1 class="text-center">
				<i class="" style="font-size: 85%"></i> ${user.nickname }님의 정보
			</h1>
		</div>
	</div>
	<div class="content">
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
					<div class="col-sm-offset-2 col-sm-2" style="font-size: 20px;">
						<div class="form-group">
							<div class="text-center" style="width: 300px;">
								<label class="control-label">프로필 이미지</label>
							</div>
							<div class="image-board">
								<img id="image" name="image" src="/upload/image/${user.image }"
									alt="${user.image }" />
							</div>
						</div>
					</div>
					<div class="col-sm-offset-1 col-sm-7" style="font-size: 20px; height: 300px; margin-top: 50px;">
						<form:input type="hidden" path="id" name="id" />
						<p><label class="control-label">아이디 : ${user.id }</label></p> 
						<label class="control-label">비밀번호</label>
						<form:password id="userpassword" name="password" path="password" />
						<button class="btn btn-primary" type="button"
							onclick="userUpdate(this.form);">수정</button>
						<button class="btn btn-danger" type="button"
							onclick="userDelete(this.form);">회원탈퇴</button>
						<p><label class="control-label">이메일 : ${user.email }</label></p>
						<p><label class="control-label">레벨 : ${user.lev }</label></p>
						<p><label class="control-label">경험치 : ${user.exp }</label></p>
					</div>
					
				</form:form>
			</div>
			
			<div class="myBoard col-sm-offset-2 col-sm-8">
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
					<c:if test="${myBoardList eq null}">
						<a href="/board/insert?type=normal" class="btn btn-primary">글쓰기</a>
					</c:if>
				</div>
				<div class="pagination">${myBoardPage }</div>
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