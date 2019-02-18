<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>notice board</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="shortcut icon" href="/public/favicon.ico">
<link rel="stylesheet" href="/public/css/style.css">
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css"
	rel="stylesheet">
<style>
.reply {
	padding: 10px;
	border: 1px solid white;
	border-radius: 3px;
}

.reply+.reply {
	margin-top: 10px;
}

.reply-header {
	color: #286090;
}

.reply-body {
	padding: 10px;
}

textarea {
	resize: none;
}

.profileImage {
	display: inline-block; 
	border-radius : 100%;
	width: 50px;
	height: 50px;
	background-position: center center;
	border-radius: 100%;
	background-size: contain;
}
</style>
</head>
<body>
	<div class="header">
		<jsp:include page="/WEB-INF/views/board/boardTopPage.jsp" />
	</div>
	<div class="content">
		<div class="container-fluid" style="width: 80%">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4>${board.title }</h4>
					<hr style="margin: 5px 0;" />
					<div class="text-right">
						<div class="profileImage"
								style="background-image: url('/upload/image/${board.user.image}');">
						</div>
						<div style="display: inline-block; transform:translate(0,-17px)">
							<a href="/profile?writer_id=${board.user.writer_id}">LV ${board.user.lev } ${board.user.nickname }</a>
							<span class="glyphicon glyphicon-time"></span> ${board.write_date }
							<span class="badge">${board.hit }</span>
						</div>
					</div>
				</div>
				<div class="panel-body">${board.content }</div>
				<div class="border-footer text-right" style="padding: 20px">
					<sec:authentication var="user" property="principal" />
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<a href="/board/update?id=${board.id }" class="btn btn-warning">수정</a>
						<a href="/board/delete?id=${board.id }" class="btn btn-danger">삭제</a>
					</sec:authorize>

					<sec:authorize access="!hasRole('ROLE_ADMIN')">
						<c:if test="${user.id eq board.writer }">
							<a href="/board/update?id=${board.id }" class="btn btn-warning">수정</a>
							<a href="/board/delete?id=${board.id }" class="btn btn-danger">삭제</a>
						</c:if>
					</sec:authorize>
					<a href="/board/list" class="btn btn-primary">목록</a>
				</div>
			</div>
			<div class="reply-form">
				<h4>Leave a Comment</h4>
				<form action="/reply/insert" method="post">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token }" />
					<div class="form-group">
						<textarea name="content" rows="3" class="form-control" required></textarea>
					</div>
					<div class="form-group text-right">
						<button type="button" onclick="replySend(this.form)"
							class="btn btn-primary">등록</button>
					</div>
				</form>
			</div>
			<div class="reply-list">
				<p>
					<span class="badge"> ${fn:length(board.replyList) } </span>
					Comments
				</p>
				<c:forEach var="reply" items="${board.replyList }">
					<div class="reply" style="margin-left:${reply.depth*30}px">
						<div class="reply-header">
							<div class="profileImage"
								style="background-image: url('/upload/image/${reply.user.image}');">
							</div>
							<div style="display: inline-block; transform:translate(0,-17px)">
								<a onclick="location.href='/profile?writer_id=${reply.user.writer_id}'" style="cursor: pointer;">
									LV ${reply.user.lev } ${reply.user.nickname }
								</a>
								<c:if test="${empty reply.user.nickname  }">
								삭제된 사용자입니다
								</c:if>
								&nbsp;&nbsp;
								<c:if test="${!empty reply.user.nickname  }">
									<span class="glyphicon glyphicon-time"></span>
								${reply.write_date } &nbsp;&nbsp;
								<button class="btn btn-primary btn-xs" type="button"
										data-parent="#reply-list" data-toggle="collapse"
										data-target="#form_${reply.id }">댓글</button>
								</c:if>
							</div>
						</div>
						<div class="reply-body">
							<c:if test="${reply.depth != 0 }">
								<i class="fas fa-reply" style="transform: rotate(180deg)"></i>
							</c:if>
							${reply.content }
						</div>
						<div class="rereply-form collapse" id="form_${reply.id}">
							<form action="/reply/rereply" method="post">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token }" /> <input type="hidden" name="ref"
									value="${reply.id}" />
								<div class="form-group">
									<textarea name="content" rows="3" class="form-control" required></textarea>
								</div>
								<div class="form-group text-right">
									<button type="button" onclick="replySend(this.form)"
										class="btn btn-primary">등록</button>
								</div>
							</form>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="footer">
		Game Made By <a href="">me</a>
	</div>
	<jsp:include page="/WEB-INF/views/user/signin.jsp"></jsp:include>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/lang/summernote-ko-KR.min.js"></script>
	<script>
		function replySend(f) {
			if ($(f.content).val() == "") {
				alert("내용을 입력해주세요");
				return;
			} else {
				$(f).append(`<input type='hidden' name='type' value='board'/>`);
				$(f)
						.append(
								`<input type='hidden' name='idx' value='${board.id}'/>`);
				f.submit();
			}
		}

		function checkForm(f) {
			if (f.title.value == "") {
				alert("제목을 입력해 주세요");
				f.title.focus();
				return;
			}

			if (f.content.value == "") {
				alert("내용을 입력해 주세요");
				//f.content.focus();
				$(".note-editable").focus();
				return;
			}

			f.submit();
		}

		$("#content").summernote({
			height : 400,
			//focus: true,
			disableResizeEditor : true,
			lang : 'ko-KR',
			callbacks : {
				onImageUpload : sendFile,
				onMediaDelete : deleteFile
			}
		});
		function deleteFile(target) {
			var src = target[0].src.substring(21);
			console.log("src", src);
			$.ajax({
				url : "/filedelete",
				type : "post",
				data : {
					src : src
				},
				success : function(data) {
					console.log(data);
				}
			});
		}

		function sendFile(files, editor, welEditable) {
			//console.log(files[0]);
			var data = new FormData();
			data.append('upload', files[0]);

			$.ajax({
				url : "/fileupload",
				contentType : false,
				processData : false,
				data : data,
				type : "post",
				success : function(data) {
					//console.log(data);
					$("#content").summernote('editor.insertImage', data.url);
				},
				error : function(error) {
					console.error(error);
				}
			});
		}
		
	</script>
</body>
</html>
