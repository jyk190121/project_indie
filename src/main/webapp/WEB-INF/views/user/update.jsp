<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<style>
	.image-board{
		width: 300px;
		height: 200px;
		border: 1px solid gray;
	}
	.image{
		width: 100%;
		height: 100%;
	}
	.content{
		font-size: 20px;
		background-color: white;
		text-align: center;
	}
	
	#myinfo{
		resize: none;
		height: 100px;
	}
</style>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="header">
	<h1 class="text-center"> 회원정보 수정 </h1>
</div>
<div class="content">
	<div class="panel panel-default">
			<div class="panel-heading">
				<p>ID : ${user.id }</p>
			</div>
			<div class="container">
					<form:form
						action="/user/update?${_csrf.parameterName}=${_csrf.token }"
						method="post" enctype="multipart/form-data" modelAttribute="user"
						class="form-horizontal" id="form">
					<form:input type="hidden" path="id" name="id" />
					<div class="form-group" style="margin-bottom: 10px;">
						<div class="col-sm-3">닉네임 :</div>
						<div class="col-sm-9">
							<form:input id="nickname" class="form-control text-center"  path="nickname"
								 name="nickname" style="font-size: 20px;"/>
							<form:errors path="nickname"/>
						</div>
					</div>
					<div class="form-group" style="margin-bottom: 10px;">
						<div class="col-sm-3">변경하실 비밀번호 :</div>
						<div class="col-sm-9">
							<form:password id="passwordChange" path="password" class="form-control text-center" 
								name="password"/>
							<form:errors path="password"/>
						</div>
					</div>
					<div class="form-group" style="margin-bottom: 10px;">
						<div class="col-sm-3">변경하실 비밀번호 확인 :</div>
						<div class="col-sm-9">
							<input type="password" id="passwordChangeCheck" class="form-control text-center"/>
						</div>
					</div>
					<div class="form-group" style="margin-bottom: 10px;">
						<div class="col-sm-3"><label>프로필 이미지</label></div>
						<div class="col-sm-9">
							<input type="file" name="image_file" onchange="showImage(this)" accept="image"/>
							<div class="image-board" style="margin-bottom: 10px;">
								<img name="image" class="image" src="/upload/image/${user.image }" alt="${user.image }" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-3">나의 소개</div>
						<div class="col-sm-9">
							<form:textarea name="myinfo" path="myinfo" class="form-control" type="text" value="${user.myinfo }"/>
							<form:errors path="myinfo"/>
						</div>
					</div>
				</form:form>
			</div>
		</div>
</div>
<div class="footer">
	<div class="col-sm-offset-3 col-sm-4">
		<button class="btn btn-warning btn-block" onclick="userUpdate();">수정</button>
	</div>
	<div class="col-sm-4">
		<a href="/user/mypage" class="btn btn-danger btn-block">취소</a>
	</div>
</div>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script>
function userUpdate(){
	var userPassword = $("#passwordChange");
	var userPasswordCheck = $("#passwordChangeCheck");
	var userNickname = $("#nickname");
	
	if(userNickname.val() == ""){
		alert("닉네임을 입력해주세요");
		userNickname.focus();
		return;
	}else if(userPassword.val() != userPasswordCheck.val()){
		alert("변경하실 비밀번호를 일치하도록 입력해주세요");
		userPasswordCheck.focus();
		return;
	}else if(userPassword.val() == ""){
		alert("변경하실 비밀번호를 입력해주세요");
		userPassword.focus();
		return;
	}
	
/* 	$.ajax({
		type:"get",
		data:{id: id,password: userPassword.val(), nickname: userNickname.val(),
			image: userImage.val(),myinfo: userMyinfo.val() },
		url:"/user/userChange",
		success: function(data){
			alert("수정되었습니다.");
			location.href="/user/mypage"
		},error: function error(error){
			console.log(error);
		}
	}); */
	$("#form").submit();
}

$(document).ready(
		resizeImageBoard());	

	function resizeImageBoard(){
		var width = $(".image-board").outerWidth();
	}

function showImage(input) {
	var reader = new FileReader();
	reader.onload = function(e) {
		$(".image-board").empty();
		$(".image-board").append(
				"<img class='image' src='"+e.target.result+"'></img>");
		$(".image-board").css('border','none');
	}
	reader.readAsDataURL(input.files[0]);
}
</script>
</body>
</html>