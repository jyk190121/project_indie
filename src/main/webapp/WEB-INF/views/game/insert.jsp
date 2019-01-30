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
		<form:form action="/game/insert?${_csrf.parameterName}=${_csrf.token }" method="post" modelAttribute="game"
			enctype="multipart/form-data" class="form-horizontal">
			<!-- <img> -->
			<div class="container-fluid">
				<div class="row">
					<div class="col-sm-3 col-sm-offset-2">
						<div class="game-image-board">
							<p>Insert Game Image</p>
						</div>
						<input type="file" name="image_file" onchange="showImage(this);" />
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
							<input type="file" webkitdirectory mozdirectory msdirectory odirectory directory multiple/>
							<form:textarea id="webSrc" class="form-control" path='src'
								placeholder='Enter script code here' style='resize:none;'></form:textarea>
							<input id="gameFile" type='file' name="game_file" class="disnone">
							<form:textarea id="etcInfo" class='form-control disnone'
								path='etc_info' placeholder='게임 실행 방법을 적어주세요'></form:textarea>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-8 col-sm-offset-2">
						<button type="button" onclick="insert(this.form);" class="btn btn-block">등록</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
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

		function showImage(input) {
			console.log(input.files[0]);
			var reader = new FileReader();
			reader.onload = function(e) {
				$(".game-image-board").empty();
				$(".game-image-board")
						.append(
								"<img id='game-image' src='"+e.target.result+"'></img>");
			}
			reader.readAsDataURL(input.files[0]);
		}

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
		
		var agent = navigator.userAgent.toLowerCase();

		function upload(id) {
			var files = $('#'+id)[0].files;
			var paths = [];
			for (var i = 0; i < files.length; i++) {
				console.log(files[i]);
				var fileExt = files[i].name.substring(files[i].name
						.lastIndexOf('.') + 1);
				if (fileExt.toUpperCase() == "ASP"
						|| fileExt.toUpperCase() == "PHP"
						|| fileExt.toUpperCase() == "JSP") {
					alert("ASP,PHP,JSP 파일은 업로드 하실 수 없습니다!");

					if ((navigator.appName == 'Netscape' && navigator.userAgent
							.search('Trident') != -1)
							|| (agent.indexOf("msie") != -1)) {
						// ie 일때 input[type = file] init.
						$("#files").replaceWith($("#filename").clone(true));
					} else { // other browser 일때 input[type = file] init.
						$("#files").val("");
					}
					return;
				}
				console.log(files[i].webkitRelativePath);
				paths.push(files[i].webkitRelativePath);
				files[i].name = 'aa';
				console.log(files[i].name);
			}
			$(f).append(`<input type='hidden' name='paths' value='\${paths.toString()}'>`)		
		}
	</script>
</body>
</html>