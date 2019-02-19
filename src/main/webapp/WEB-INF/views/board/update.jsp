<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>notice board</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="shortcut icon" href="/public/favicon.ico">
<link rel="stylesheet" href="/public/css/style.css">
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css"
	rel="stylesheet">
<style>
.footer {
	margin-top: 100px;
}

.header {
	height: 300px;
}

/* 안내창 */
.notice-panel .panel-heading {
	background-color: #535c68 !important;
	color: white !important;
	height: 40px;
	font-size: 16px;
	padding: 7.5px 20px;
}

.notice-panel .panel-heading:hover {
	opacity: 0.8;
}
</style>
</head>
<body>
	<div class="header">
		<div style="height: 50px;">
			<jsp:include page="/WEB-INF/views/navbar.jsp" />
		</div>
		<div class="text-center"
			style="height: 200px; background-image: url('/public/image/background4-1.jpg'); background-position: center;">
		</div>
	</div>
	<div class="content">
		<div class="container-fluid" style="width: 80%">
			<div class="row" style="margin-bottom: 50px;">
				<div class="notice-panel">
					<div class="panel panel-default"
						style="background-color: #636e72; color: white;">
						<a href="#notice-full" data-toggle="collapse">
							<div class="panel-heading">
								<h4 class="panel-title">
									<p style="display: inline-block; width: 98%;">[공지]
										&nbsp;&nbsp; 게시물을 작성하기 전에</p>
									<span class="text-right" style="font-size: 20px">+</span>
								</h4>
							</div>
						</a>
						<div id="notice-full" class="panel-collapse collapse">
							<div class="panel-body"
								style="background: #f1f2f6; color: black; font-weight: 500; border: 1px solid #636e72; font-size: 16px;">
								<p style="margin-top: 10px;">1. 게시물의 제목은 30자 이내로 작성 가능합니다.</p>
								<p>2. 사이트 기준에 위배되는 광고성 게시물 등은 경고 없이 삭제됩니다.</p>
								<p>3. 계정을 탈퇴해도 게시물은 삭제되지 않습니다.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h4>게시물 수정</h4>
					</div>
					<div class="panel-body">
						<form:form action="/board/update" method="post"
							modelAttribute="board">
							<form:hidden path="id" />
							<div class="form-group">
								<form:input class="form-control" path="title"
									placeholder="제목을 입력해 주세요" />
								<form:errors path="title" />
							</div>
							<div class="form-group">
								<form:textarea class="form-control" id="content" path="content"
									placeholder="내용을 입력해 주세요"></form:textarea>
								<form:errors path="content" />
							</div>
							<div class="form-group text-right">
								<button class="btn btn-primary" type="button"
									onclick="checkForm(this.form);">수정</button>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="footer">
		<div class="text-center"
			style="height: 150px; background-image: url('/public/image/background4-1.jpg'); background-position: bottom;">
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/lang/summernote-ko-KR.min.js"></script>
	<script>
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



