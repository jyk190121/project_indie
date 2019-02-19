<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert Title here</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="shortcut icon" href="/public/favicon.ico">
<link rel="stylesheet" href="/public/css/style.css">
<style>
.header {
	height: 300px;
}

.game-image-board {
	width: 100%;
	max-width: 340px;
	border: 2px solid #ccc;
	margin-bottom: 15px;
	border-radius: 10px;
}

.row {
	margin-top: 20px;
}

#game-image {
	width: 100%;
}

.disnone {
	display: none !important;
}

.footer {
	margin-top: 100px;
	height: 100px;
}

/* input file 디자인 변경 */
.filebox input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.filebox .file-label {
	display: inline-block;
	padding: .5em .75em;
	color: gray;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
} /* named upload */
.filebox .upload-name {
	display: inline-block;
	padding: .5em .75em; /* label의 패딩값과 일치 */
	font-size: inherit;
	font-family: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #f5f5f5;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
}
</style>
</head>
<body>
	<div class="header">
		<jsp:include page="/WEB-INF/views/navbar.jsp" />
		<div class="text-center"
			style="height: 200px; background-image: url('/public/image/background3.jpg');">
		</div>
	</div>
	<div class="content">
		<form:form
			action="/game/insert?${_csrf.parameterName}=${_csrf.token }"
			method="post" modelAttribute="game" enctype="multipart/form-data"
			class="form-horizontal filebox">
			<!-- <img> -->
			<div class="container-fluid">
				<div class="row">
					<div class="col-sm-3 col-sm-offset-2">
						<div class="game-image-board text-center">
							<p style="margin-top: 90px;">Insert Game Image</p>
						</div>
						<label for="image_file_input" class="file-label">이미지 선택</label> <input
							class="file-label" type="file" name="image_file"
							id="image_file_input" onchange="uploadImage(this);" />
					</div>
					<div class="col-sm-5">
						<div class="form-group">
							<label class="col-sm-3 control-label" for="name">게임명</label>
							<div class="col-sm-9">
								<form:input class="form-control" id="name" path="name"></form:input>
								<form:errors path="name"></form:errors>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="name">게임 설명</label>
							<div class="col-sm-9">
								<form:textarea path="info" placeholder="게임의 설명을 작성하세요"
									class="form-control"
									style="width: 100%; height: 150px; resize: none;"></form:textarea>
								<form:errors path="info"></form:errors>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-3 col-sm-offset-2">
						<form:radiobutton path="type" value="web"
							style="width: 30px ;height: 30px; vertical-align:middle;"
							checked="true" onclick="changeType(this);" id="radio-web" />
						<label for="radio-web"
							style="font-size: 30px; vertical-align: middle; margin-bottom: 0;">&nbsp;Web
							게임</label>
					</div>
					<div class="col-sm-3 ">
						<form:radiobutton path="type" value="exe"
							style="width: 30px ;height: 30px; vertical-align:middle;"
							onclick="changeType(this);" id="radio-web" />
						<label for="radio-web"
							style="font-size: 30px; vertical-align: middle; margin-bottom: 0;">&nbsp;exe
							게임</label>
					</div>
					<div class="col-sm-3">
						<form:radiobutton path="type" value="etc"
							style="width: 30px ;height: 30px; vertical-align:middle;"
							onclick="changeType(this);" id="radio-web" />
						<label for="radio-web"
							style="font-size: 30px; vertical-align: middle; margin-bottom: 0;">&nbsp;기타</label>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-8 col-sm-offset-2">
						<div id="src-board">
							<label for="gameFiles" class="control-label file-label">게임
								파일 전체폴더</label> <input name="gameFiles"
								onchange="javascript:uploadFiles(this);" id="gameFiles"
								type="file" multiple directory webkitdirectory />
							<div id="triggerFile-board">
								<label for="triggerFile" class="control-label file-label">시작
									html File</label> <input name="game_file"
									onchange="javascript:uploadFile(this);" id="triggerFile"
									type="file" webkit />
							</div>
							<form:textarea id="etcInfo" class='form-control disnone'
								path='etc_info' placeholder='게임 실행 방법을 적어주세요'></form:textarea>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-8 col-sm-offset-2">
						<button type="button" onclick="insert(this.form);"
							class="btn btn-block btn-primary">등록</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
	<div class="footer">
		<div class="text-center"
			style="height: 100px; background-image: url('/public/image/background3.jpg'); background-position: bottom;">
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="/public/js/fileUpload.js"></script>
	<script>
		$(document).ready(
				function() {
					var fileTarget = $('.filebox .upload-hidden');
					fileTarget.on('change', function() { // 값이 변경되면 
						if (window.FileReader) { // modern browser 
							var filename = $(this)[0].files[0].name;
						} else {
							// old IE 
							var filename = $(this).val().split('/').pop()
									.split('\\').pop();
							// 파일명만 추출 
						}
						// 추출한 파일명 삽입 
						$(this).siblings('.upload-name').val(filename);
					});
				});

		$etcInfo = $("#etcInfo");
		$htmlBoard = $("#triggerFile-board")
		function changeType(input) {
			switch (input.value) {
			case 'web':
				$htmlBoard.removeClass("disnone");
				$etcInfo.addClass("disnone");
				break;
			case 'exe':
				$htmlBoard.addClass("disnone");
				$etcInfo.addClass("disnone");
				break;
			case 'etc':
				$htmlBoard.addClass("disnone");
				$etcInfo.removeClass("disnone");
				break;
			}
		}

		function insert(f) {
			if (f.name.value == '') {
				alert('게임명을 작성하세요');
				f.name.focus();
				return;
			}
			if (f.info.value == '') {
				alert('게임 설명란을 작성하세요');
				f.info.focus();
				return;
			}
			if (f.image_file.value == '') {
				alert('게임 대표 이미지를 선택하세요');
				f.image_file.focus();
				return;
			}
			if (f.gameFiles.value == '') {
				alert('게임 폴더를 선택하세요');
				f.gameFiles.focus();
				return;
			}
			if (f.type.value == 'web') {
				if (f.game_file.value == '') {
					alert('html 파일을 선택하세요');
					f.game_file.focus();
					return;
				}
			} else {
				$(f.game_file).remove();
			}
			f.submit();
		}

		function uploadFile(input) {
			var ext = 'html';

			$("[name='srcPath']").remove();
			if ($("#gameFiles").val() == "") {
				alert('게임 파일 전체폴더를 먼저 업로드해주세요');
				initInput(input);
				return;
			}

			var filename = input.value
					.substring(input.value.lastIndexOf('\\') + 1);
			var isExisting = false;
			for (var i = 0; i < paths.length; i++) {
				var path = paths[i];
				if (paths[i].lastIndexOf('/') != -1) {
					path = paths[i].substring(paths[i].lastIndexOf('/') + 1);
				}
				if (path == filename) {
					console.log(paths[i]);
					$(input.form)
							.append(
									`<input type='hidden' name='srcPath' value='\${paths[i]}'>`);
					isExisting = true;
				}
			}
			if (!isExisting) {
				alert('게임 전체폴더에 포함된 시작 파일을 업로드해주세요');
				initInput(input);
				return;
			}

			if (ext == 'exe' || ext == 'html') {
				if (input.value.substring(input.value.indexOf('.') + 1)
						.toLowerCase() != ext) {
					alert('게임이 시작되는 \'' + ext + '\' 파일을 업로드해주세요');
					initInput(input);
					return;
				}
			}
		}

		function uploadFiles(input) {
			$("[name='paths']").remove();
			initInput(document.getElementById("triggerFile"));
			var files = $(input)[0].files;
			if (input.value == "") {
				return;
			}
			var index = files[0].webkitRelativePath.indexOf('/') + 1;
			for (var i = 0; i < files.length; i++) {
				var fileExt = files[i].name.substring(
						files[i].name.lastIndexOf('.') + 1).toUpperCase();
				if (fileExt == "ASP" || fileExt == "PHP" || fileExt == "JSP") {
					alert("ASP,PHP,JSP 파일은 업로드 하실 수 없습니다!");
					initInput(input);
					return;
				}
				paths.push(files[i].webkitRelativePath.substring(index));
				console.log(files[i].webkitRelativePath.substring(index));
			}
			console.log(files.length);
			$(input.form)
					.append(
							`<input type='hidden' name='paths' value='\${paths.toString()}'>`)
		}
	</script>
</body>
</html>