<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
* {
	box-sizing: border-box;
}

.image-board {
	width: 100%;
	max-width: 340px;
	border: 2px solid #ccc;
	margin-bottom: 15px;
	border-radius: 10px;
}

#image {
	width: 100%;
}

.disnone {
	display: none !important;
}

.form-group {
	margin-bottom: 20px;
}

.header {
	height: 100px;
}
</style>
</head>
<body>
	<div class="header"></div>
	<div class="content">
		<div class="container-fluid">
			<form action="/user/google/regist?${_csrf.parameterName}=${_csrf.token }"
				method="post" enctype="multipart/form-data"
				class="form-horizontal">
				<div class="row">
					<div class="col-sm-5 col-sm-offset-2">
						<div class="form-group">
							<label class="col-sm-3 control-label" for="nickname">Nickname</label>
							<div class="col-sm-9">
								<input name="nickname" class="form-control"
									onkeyup="dualCheckNickname(this);"
									placeholder="숫자와 영문, 한글, 특수문자(!@#*_-) 4 ~ 20 글자" />
								<p id="dualCheckResult" class="disnone" style="margin: 0;"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="myinfo">한 줄 소개</label>
							<div class="col-sm-9">
								<textarea name="myinfo" class="form-control"
									placeholder="자신을 소개해보세요" style="resize: none;"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">reCAPTCHA</label>
							<div class="col-sm-9">
								<div id="html_element"></div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3"></label>
							<div class="col-sm-9">
								<button type="button" class="btn btn-block btn-primary"
									onclick="insert(this.form)">가입</button>
							</div>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="form-group">
							<div class="image-board">
								<div class="text-center">
									<div id="image-board-text">
										<label class="control-label">프로필 이미지</label>
										<p style="margin : 10px 0 0 0;">가로세로 비율이 1대1인 이미지만 </p>
										<p>사용할 수 있습니다</p>
									</div>
								</div>
							</div>
							<input type="file" name="image_file" onchange="uploadImage(this)" />
						</div>
						<div>
							<a href="/user/cropimage" target="_blank">이미지 조정하러가기</a>
						</div>
					</div>
				</div>
				<input type="hidden" name="email" value="${email }"/>
				<input type="hidden" name="googleId" value="${googleId }"/>
			</form>
		</div>
	</div>
	<div class="footer"></div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script
		src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
		async defer>
		
	</script>
	<script>
		var rToken = "";
		var $imageBoard = $(".image-board");
		var $imageText = $("#image-board-text");
		
		/* reCAPCHA */
		var verifyCallback = function(response) {
			rToken = response;
		};
		var onloadCallback = function() {
			grecaptcha.render('html_element', {
				'sitekey' : '6LcXgo0UAAAAAIEiA6J-jefjIOq_bNtqN6L1F-Lj',
				'callback' : verifyCallback,
				'size' : 'normal'
			});
		};

		$(document).ready(resizeImageBoard());

		$(window).resize(function() {
			var width = $imageBoard.outerWidth();
			$imageBoard.css({
				'height' : width + "px",
				//"line-height" : width + "px"
			});
			$imageText.css("margin-top",(width-$imageText.height())/2+"px");
		});

		function resizeImageBoard() {
			var width = $imageBoard.outerWidth();
			$imageBoard.css({
				'height' : width + "px",
				//"line-height" : width + "px"
			});
			$imageText.css("margin-top",(width-$imageText.height())/2+"px");
		}

		function showImage(src) {
			//console.log(input.files[0]);
			$(".image-board").empty();
			$(".image-board").append(
					"<img id='image' src='"+src+"'></img>");
			$(".image-board").css('border', 'none');
		}

		function insert(f) {
			if (rToken == "") {
				alert("reCAPTCHA '로봇이 아닙니다'를 클릭하세요");
				return;
			}
			f.submit();
		}

		var agent = navigator.userAgent.toLowerCase();
		
		function initInput(input){
			if ((navigator.appName == 'Netscape' && navigator.userAgent
					.search('Trident') != -1)
					|| (agent.indexOf("msie") != -1)) {
				// ie 일때 input[type = file] init.
				$(input).replaceWith($(input).clone(true));
			} else { // other browser 일때 input[type = file] init.
				$(input).val("");
			}
		}
		
		function uploadImage(input){
			var ext = input.value.substring(input.value.lastIndexOf('.') + 1).toUpperCase();
			if(!(ext == 'PNG' || ext == 'JPG' || ext == 'JPEG' || ext == 'GIF' || ext == "BMP")){
				initInput(input);
				$imageBoard.css("border-color","red");
				alert('이미지는 png, jpg, bmp, gif 형식의 파일만 업로드할 수 있습니다');
				return;
			}
			var reader = new FileReader();
			reader.onload = function(e) {
				var newimage = new Image();
				newimage.src = e.target.result; 
				newimage.onload = function()
				{
				    if(this.naturalWidth < 50 || this.naturalHeight < 50){
				    	initInput(input);
				    	$imageBoard.css("border-color","red");
				    	alert('프로필 이미지는 가로세로 최소 50px 이상이어야 합니다.');
				    	return;
				    }
				    if(this.naturalWidth != this.naturalHeight){
				    	initInput(input);
				    	$imageBoard.css("border-color","red");
				    	alert('가로세로 비율이 1 대 1인 이미지만 사용할 수 있습니다.')
				    	return;
				    }
					showImage(e.target.result);
				}
			}
			reader.readAsDataURL(input.files[0]);
		}
		
		function dualCheckNickname(input) {
			if (input.value.length >= 4) {
				$
						.ajax({
							url : "/user/dualcheck/nickname?${_csrf.parameterName}=${_csrf.token}",
							type : "post",
							data : {
								"input" : input.value
							},
							success : function(data) {
								$("#dualCheckResult").removeClass('disnone');
								$("#dualCheckResult").text(
										data + '명이 현재 이 이름을 사용 중입니다');
							},
							error : function(e) {
								console.error(e);
							}
						});
			}
		}
	</script>
</body>
</html>