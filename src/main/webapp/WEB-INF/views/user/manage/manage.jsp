<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>manage</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style>
tfoot{
		text-align: center;	
	}
</style>
</head>
<body>
	<div class="header">
		<div class="jumbotron">
			<h1 class="text-center">
				<i class="glyphicon glyphicon glyphicon-pencil
				   style="font-size:85%"></i>
				  유저 관리 시스템
			</h1>
		</div>
	</div>
	<div class="content">
		<div class="container">
			<div class="row">
				<table class="table table-hover">
					<thead>
						<tr>
							<th width="10%">유저 아이디</th>
							<th width="10%">닉네임</th>
							<th width="10%">레벨</th>
							<th width="10%">경험치</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="user" items="${userList}">
						<tr onclick="javascript:userList('${user.id}','${user.password}','${user.nickname}','${user.image}','${user.myinfo}','${user.lev}','${user.exp}');"
							style="cursor:pointer;">
							<td>${user.id }</td>
							<td>${user.nickname }</td>
							<td>${user.lev}</td>
							<td>${user.exp }</td>
						</tr>
					</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="5" class="text-right">
							<form action="/manage" method="get">
								유저 검색 <input type="text" name="id" />
								<button type="submit" class="btn btn-primary">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</form>
							</td>
						</tr>
						<tr>
							<td colspan="5" style="border-top:none;">
								<ul class="pagination">
									${page }
								</ul>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
	<div class="footer">
		Game Made By <a href="">me</a>
	</div>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script>
	function userList(id,password,nickname,image,myinfo,lev,exp){
		location.href='/user/manage/view?id='+id+'&password='+password+'&nickname='+nickname+'&image='+image+'&myinfo='+myinfo+'&lev='+lev+'&exp='+exp;
	}
</script>
</body>
</html>