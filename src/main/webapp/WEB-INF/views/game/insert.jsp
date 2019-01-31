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
<style>
.game-image-board {
	border: 1px solid gray;
	width: 100%;
	height: 200px;
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
</style>
</head>
<body>
	<div class="content">
		<form:form
			action="/game/insert?${_csrf.parameterName}=${_csrf.token }"
			method="post" modelAttribute="game" enctype="multipart/form-data"
			class="form-horizontal">
			<!-- <img> -->
			<div class="container-fluid">
				<div class="row">
					<div class="col-sm-3 col-sm-offset-2">
						<div class="game-image-board">
							<p>Insert Game Image</p>
						</div>
						<input type="file" name="image_file" onchange="uploadImage(this);" />
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
						<form:radiobutton path="type" value="web" label="웹 게임"
							checked="true" onclick="changeType(this);" />
					</div>
					<div class="col-sm-3">
						<form:radiobutton path="type" value="exe" label="exe 게임"
							onclick="changeType(this);" />
					</div>
					<div class="col-sm-3">
						<form:radiobutton path="type" value="etc" label="기타"
							onclick="changeType(this);" />
					</div>
				</div>
				<div class="row">
					<div class="col-sm-8 col-sm-offset-2">
						<div id="src-board">
							<label for="gameFiles" class="control-label">게임 파일 전체폴더</label>
							<input name="gameFiles" onchange="javascript:uploadFiles(this);"
								id="gameFiles" type="file" multiple directory webkitdirectory />
							<label for="htmlFile" class="control-label">시작 html File</label>
							<input name="htmlFile" onchange="javascript:uploadHtmlFile(this);"
								id="gameFiles" type="file"/>
							<input id="gameFile" type='file' name="game_file" class="disnone">
							<form:textarea id="etcInfo" class='form-control disnone'
								path='etc_info' placeholder='게임 실행 방법을 적어주세요'></form:textarea>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-8 col-sm-offset-2">
						<button type="button" onclick="insert(this.form);"
							class="btn btn-block">등록</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="/public/js/fileUpload.js"></script>
	<script>
		function changeType(input) {
			$webSrc = $("#webSrc");
			$gameFile = $("#gameFile");
			$etcInfo = $("#etcInfo");
			switch (input.value) {
			case 'web':
				$webSrc.removeClass("disnone");
				$gameFile.addClass("disnone");
				$etcInfo.addClass("disnone");
				break;
			case 'exe':
				$webSrc.addClass("disnone");
				$gameFile.removeClass("disnone");
				$etcInfo.addClass("disnone");
				break;
			case 'etc':
				$webSrc.addClass("disnone");
				$gameFile.removeClass("disnone");
				$etcInfo.removeClass("disnone");
				break;
			}
		}

		function insert(f) {
			console.log('insert function');
			f.submit();
		}
		
		function uploadHtmlFile(input){
			if(input.value.substring(input.value.indexOf('.')+1).toUpperCase() != 'HTML'){
				alert('게임이 시작되는 html 파일을 업로드해주세요');
				if ((navigator.appName == 'Netscape' && navigator.userAgent
						.search('Trident') != -1)
						|| (agent.indexOf("msie") != -1)) {
					// ie 일때 input[type = file] init.
					$(input).replaceWith($(input).clone(true));
				} else { // other browser 일때 input[type = file] init.
					$(input).val("");
				}
			}
		}
	</script>
</body>
</html>