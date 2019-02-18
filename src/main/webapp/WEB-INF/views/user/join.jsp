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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="shortcut icon" href="/public/favicon.ico">
<link rel="stylesheet" href="/public/css/style.css">
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
	<div class="header">
		<div style="height: 50px;">
			<jsp:include page="/WEB-INF/views/navbar.jsp" />
		</div>
	</div>
	<div class="content">
		<div class="container-fluid">
			<form:form action="/user/join?${_csrf.parameterName}=${_csrf.token }"
				method="post" enctype="multipart/form-data" modelAttribute="user"
				class="form-horizontal">
				<div class="row">
					<div class="col-sm-5 col-sm-offset-2">
						<div class="form-group">
							<label class="col-sm-3 control-label" for="id">ID</label>
							<div class="col-sm-9">
								<div class="input-group">
									<form:input path="id" class="form-control"
										onkeydown="javascript:idModified();"
										placeholder="영문 또는 숫자 4 ~ 20 글자" />
									<div class="input-group-btn">
										<button type="button" id="idCheck-btn" class="btn btn-danger"
											onclick="idDualCheck(this.form);">중복 확인</button>
									</div>
								</div>
								<p id="id-error" style="color: red" class="disnone">사용할 수 없는
									아이디입니다</p>
								<form:errors path="id"></form:errors>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="password">Password</label>
							<div class="col-sm-9">
								<form:password path="password" class="form-control"
									id="password" placeholder="숫자와 영문, 특수문자(!@#*_-) 4 ~ 20 글자"
									onkeyup="checkPassword();" />
								<form:errors path="password"></form:errors>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="pCheck">Password
								Check</label>
							<div class="col-sm-9">
								<input type="password" class="form-control" id="pCheck"
									placeholder="패스워드 확인" onkeyup="checkPassword();" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="nickname">Nickname</label>
							<div class="col-sm-9">
								<form:input path="nickname" class="form-control"
									onkeyup="dualCheckNickname(this);"
									placeholder="숫자와 영문, 한글, 특수문자(!@#*_-) 4 ~ 20 글자" />
								<p id="dualCheckResult" class="disnone" style="margin: 0;"></p>
								<form:errors path="nickname"></form:errors>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="email">email</label>
							<div class="col-sm-9">
								<div class="input-group">
									<form:input path="email" class="form-control"
										placeholder="한 이메일 당 하나의 계정만 생성 가능" />
									<span class="input-group-btn">
										<button id="sendCode-btn" type="button" class="btn btn-danger"
											onclick="sendCode(this.form);">인증번호 발송</button>
									</span>
								</div>
								<p id="email-error" style="margin: 0"></p>
							</div>
						</div>
						<div class="form-group disnone" id="emailCertify">
							<label class="col-sm-3 control-label" for="code">이메일 인증코드</label>
							<div class="col-sm-9">
								<div class="input-group">
									<input id="code" name="code" class="form-control"
										placeholder="해당 이메일로 발송된 코드를 입력하세요" /> <span
										class="input-group-btn">
										<button type="button" class="btn btn-danger"
											onclick="checkCode(this.form);">인증번호 확인</button>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="myinfo">한 줄 소개</label>
							<div class="col-sm-9">
								<form:textarea path="myinfo" class="form-control"
									placeholder="자신을 소개해보세요" style="resize: none;"></form:textarea>
								<form:errors path="myinfo"></form:errors>
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
			</form:form>
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
		var passwordCheck = false;
		var isCertified = false;
		var idCheck = false;
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

		function sendCode(f) {
			var email = f.email.value;
			$("#email").attr("readOnly", "<true></true>");
			$("#sendCode-btn").attr("disabled", "disabled").text("인증번호 발송중")
					.css("background-color", "gray");
			$
					.ajax({
						url : "/user/sendEmail",
						type : "post",
						beforeSend : function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
							xhr.setRequestHeader("${_csrf.headerName}",
									"${_csrf.token}");
						},
						data : {
							"email" : email
						},
						success : function(data) {
							if (data == "success") {
								$("#sendCode-btn").css("background-color",
										"green").text("인증번호 발송됨");
								$("#email-error").text("");
								$("#emailCertify").removeClass("disnone");
								$("#code").focus();
							} else {
								$("#email").removeAttr("readOnly");
								$("#sendCode-btn").removeAttr("disabled").text(
										"인증번호 발송").css("background-color",
										"#d9534f");
								$("#email").focus();
							}
							if (data == "unvalidEmail") {
								$("#email-error").text("올바른 이메일 형식을 입력해 주세요.")
										.css({
											color : "red"
										});
							}
							if (data == "duplicatedEmail") {
								$("#email-error").text("이미 가입된 이메일입니다.").css({
									color : "red"
								});
							}

							if (data == "error") {
								alert('죄송합니다.\n현재 서버 상태가 불안정하오니 관리자에게 문의하거나 차후 다시 시도하시기 바랍니다.')
							}
						},
						error : function(e) {
							console.error(e);
						}
					});
		}

		function checkCode(f) {
			$.ajax({
				url : "/user/checkEmailCode",
				type : "post",
				data : {
					"email" : f.email.value,
					"emailCode" : f.code.value
				},
				beforeSend : function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
					xhr.setRequestHeader("${_csrf.headerName}",
							"${_csrf.token}");
				},
				success : function(data) {
					console.log(data);
					if (data == "wrongEmail") {
						alert('수정된 이메일을 인증해주세요');
					} else if (data == "wrongEmailCode") {
						alert('잘못된 코드입니다');
						$("#code").text("").focus();
					} else if (data == "success") {
						$("#email-error").text("인증이 완료되었습니다").css({
							color : "green"
						});
						$("#emailCertify").addClass("disnone");
						isCertified = true;
					}
				},
				error : function(e) {
					console.error(e);
				}
			});
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

		function idDualCheck(f) {
			var id = f.id.value;
			console.log(id);
			$.ajax({
				url : "/user/dualcheck/id",
				type : "post",
				data : {
					id : id
				},
				beforeSend : function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
					xhr.setRequestHeader("${_csrf.headerName}",
							"${_csrf.token}");
				},
				success : function(data) {
					console.log(data);
					if (data == "duplicated") {
						$("#id-error").removeClass("disnone");
					} else {
						$("#idCheck-btn").text("사용 가능").css({
							"background-color" : "green",
							"border-color" : "green"
						}).attr("disabled", "disabled");
						$("#id").css("border-color", "green");
						$("#id-error").addClass("disnone");
						idCheck = true;
					}
				},
				error : function(e) {
					console.error(e);
				}
			});
		}

		function idModified() {
			$("#idCheck-btn").text("중복 확인").css("background-color", "#d9534f")
					.removeAttr("disabled");
			$("#id").css("border-color", "red");
			$("#idCheck-btn").css("border-color", "red");
		}

		function showImage(src) {
			//console.log(input.files[0]);
			$(".image-board").empty();
			$(".image-board").append(
					"<img id='image' src='"+src+"'></img>");
			$(".image-board").css('border', 'none');
		}

		function insert(f) {
			if (idCheck == false) {
				alert('아이디 중복 여부를 확인하세요');
				return;
			}
			if (passwordCheck == false) {
				alert("패스워드를 확인하세요");
				return;
			}
			if (isCertified == false) {
				alert('이메일 인증을 완료해주세요');
				return;
			}
			if (rToken == "") {
				alert("reCAPTCHA '로봇이 아닙니다'를 클릭하세요");
				return;
			}
			f.submit();
		}

		function checkPassword() {
			if ($("#password").val() == $("#pCheck").val()) {
				passwordCheck = true;
				$("#pCheck").css('border-color', 'green');
			} else {
				passwordCheck = false;
				$("#pCheck").css('border-color', 'red');
			}
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
	</script>
</body>
</html>