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
	*{
		box-sizing: border-box;
	}
	.image-board{
		margin-top : 10px;
		width: 100%;
		height: 100%;
		border: 1px solid gray;
	}	
	#image{
		width: 100%;
	}
	.disnone{
		display: none !important;
	}
</style>
</head>
<body>
	<div class="header"></div>
	<div class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-3 col-sm-offset-2">
					<div class="form-group">
						<label class="control-label">프로필 이미지</label> <input type="file"
							name="image_file" onchange="showImage(this)" />
						<div class="image-board"></div>
					</div>
				</div>
				<div class="col-sm-5">
					<form:form
						action="/user/join?${_csrf.parameterName}=${_csrf.token }"
						method="post" enctype="multipart/form-data" modelAttribute="user"
						class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-3 control-label" for="id">ID</label>
							<div class="col-sm-9">
								<form:input path="id" class="form-control"
									placeholder="영문 또는 숫자 4 ~ 20 글자" />
								<form:errors path="id"></form:errors>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="password">Password</label>
							<div class="col-sm-9">
								<form:password path="password" class="form-control" id="password"
									placeholder="숫자와 영문, 특수문자(!@#*_-) 4 ~ 20 글자"  onkeyup="checkPassword();"/>
								<form:errors path="password"></form:errors>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="pCheck">Password Check</label>
							<div class="col-sm-9">
								<input type="password" class="form-control" id="pCheck"
									placeholder="패스워드 확인" onkeyup="checkPassword();"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="nickname">Nickname</label>
							<div class="col-sm-9">
								<form:input path="nickname" class="form-control"
									onkeyup="dualCheck(this);"
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
										<button type="button" class="btn btn-danger" onclick="sendCode();" >인증번호 발송</button>
									</span>
								</div>
								<form:errors path="email"></form:errors>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="code">이메일 인증코드</label>
							<div class="col-sm-9">
								<input id="code" name="code" class="form-control"
									placeholder="해당 이메일로 발송된 코드를 입력하세요" />
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

						<button type="button" class="btn btn-block" onclick="insert(this.form)">가입</button>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	<div class="footer"></div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		var passwordCheck = false;
	
		$(document).ready(
			resizeImageBoard());	
	
		$(window).resize(
			function (){
				var width = $(".image-board").outerWidth();
				$(".image-board").css('height', width+"px");
			}
		);
	
		function resizeImageBoard(){
			var width = $(".image-board").outerWidth();
			$(".image-board").css('height', width+"px");
		}
		
		function dualCheck(input) {
			if(input.value.length >= 4){
				console.log(input.value);
				$.ajax({
					url: "/user/dualCheck?${_csrf.parameterName}=${_csrf.token}",
					type: "post",
					data: {"input" : input.value},
					success: function(data){
						$("#dualCheckResult").removeClass('disnone');
						$("#dualCheckResult").text(data+'명이 현재 이 이름을 사용 중입니다');
					},
					error : function(e){
						console.error(e);
					}
				});
			}
		}

		function showImage(input) {
			console.log(input.files[0]);
			var reader = new FileReader();
			reader.onload = function(e) {
				$(".image-board").empty();
				$(".image-board").append(
						"<img id='image' src='"+e.target.result+"'></img>");
				$(".image-board").css('border','none');
			}
			reader.readAsDataURL(input.files[0]);
		}
		
		function insert(f){
			if(passwordCheck == false){
				alert("패스워드를 확인하세요");
				return;
			}
			f.submit();
		}
		
		function checkPassword(){
			if($("#password").val() == $("#pCheck").val()){
				passwordCheck = true;
				$("#pCheck").css('border-color', 'green');
			}else{
				passwordCheck = false;
				$("#pCheck").css('border-color', 'red');
			}
		}
	</script>
</body>
</html>