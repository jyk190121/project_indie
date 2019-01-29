<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage</title>
<style>
	.image-board{
		width: 300px;
		height: 200px;
		border: 1px solid gray;
	}
	#image{
		width: 100%;
		height: 100%;
	}
</style>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="header">
		<div class="jumbotron">
			<h1 class="text-center">
				<i class="" 
				   style="font-size:85%"></i>
				${user.nickname }님의 정보
			</h1>
		</div>
	</div>
	<a href="/main">main</a>
	<div class="content">
		<div class="panel panel-default">
			<div class="panel-heading text-center">
				<span class="glyphicon glyphicon-user"></span>
				<h4>회원정보 수정</h4>
			</div>
			<div class="panel-body">
				<div class="col-sm-offset-1 col-sm-5" style="font-size: 20px;">
					<p>ID : ${user.id }</p>
					비밀번호 <input id="userpassword" type="password" name="password"/>
							<button class="btn btn-primary" type="button"
										onclick="userUpdate('${user.id}');">수정</button>
							<button class="btn btn-danger" type="button"
										onclick="userDelete('${user.id}');">회원탈퇴</button>
				</div>
				<div class="col-sm-2">
					<div class="form-group">
						<label class="control-label">프로필 이미지</label>
						<div class="image-board">
							<img id=image src="/upload/image/${user.image }" alt="${user.image }" />
						</div>
					</div>
				</div>
			</div>
				<pre class="text-center" style="font-size: 30px;">현재레벨 : ${user.lev}  경험치 : ${user.exp}</pre>
		</div>
	</div>
	<div class="footer">
	</div>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script>
function userUpdate(id){
	var check = confirm("수정하시겠습니까??");
		if(!check){
		return;
		}
		var userPassword = $("#userpassword").val();
		/* if (${user.password} == userPassword){
			location.href="/user/update?id="+id
		}else{
				alert("비밀번호가 틀립니다");
		} */
   		$.ajax({
   			type: "get",
   			data: {id: id,password:userPassword},
   			url: "/user/checkPassword",
   			success: function(data){
   				if(data == "correct"){
   					location.href="/user/update?id="+id+"&password="+userPassword
   				}else{
   					alert("비밀번호가 틀립니다");
   				}
   				
   			}
   		});
	}
function userDelete(id){
	var check = confirm("정말 탈퇴하시겠습니까??(이 아이디와 관련된 정보는 모두 삭제됩니다)");
		if(!check){
		return;
		}
		var userPassword = $("#userpassword").val();
		$.ajax({
   			type: "get",
   			data: {id: id,password:userPassword},
   			url: "/user/checkPassword",
   			success: function(data){
   				if(data == "correct"){
   					location.href="/user/delete?id="+id;
   				}else{
   					alert("비밀번호가 틀립니다");
   				}
   			}
   		});
	}
	
$(document).ready(
		resizeImageBoard());	

	function resizeImageBoard(){
		var width = $(".image-board").outerWidth();
	}
	
	
</script>
</body>
</html>