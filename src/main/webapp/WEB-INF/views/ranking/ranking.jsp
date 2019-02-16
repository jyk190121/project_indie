<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
	<div class="header">
		<div class="jumbotron">
			<h1 class="text-center">
				<i class="glyphicon glyphicon-th-list"
				   style="font-size:85%"></i>
				 랭킹
			</h1>
		</div>
		<a class="btn btn-primary btn-block" href="/main">main</a>
		<div class="content">
			<div class="container">
				<div class="row">
					<table class="table table-hover">
						<thead>
							<tr>
								<td colspan="5" class="text-right">
								<form action="" method="get" class="form-inline">
									유저 검색 
									<input type="text" name="search" class="form-control"/>
									<button type="submit" class="btn btn-primary">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</form>
								</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th width="10%">순위</th>
								<th width="10%">닉네임</th>
								<th width="10%">레벨</th>
								<th width="10%">경험치</th>
							</tr>
						</tbody>
						<tfoot id="userList">
							<c:forEach var="user" items="${userList}">
								<tr onclick="javascript:userList('${user.writer_id}');"
									style="cursor:pointer;">
									<td>${user.rnum}</td>
									<td>${user.nickname }</td>
									<td>${user.lev}</td>
									<td>${user.exp }</td>
								</tr>
							</c:forEach>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</div>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script>
	function userList(id){
		location.href = "/profile?writer_id="+id
	}
	
	$(document).ready(function(){
		var page = 2; //처음 30개를 빼고 시작해야하므로
		var docH = $(document).height(); //document의 높이
		var scrollH = $(window).height()+$(window).scrollTop();
		  $(window).scroll(function(){
			  scrollH = $(window).height()+$(window).scrollTop();	
			  if(scrollH == docH){       //(문서의 높이 - 50)에서 실행됨
				  //alert('d');
			  	  //console.log(scrollH);
				  $.ajax({
					url:"/ranking",
					type: "post",
					data: {page:page},
					beforeSend : function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					success:function(data){
						console.log(page);
						$("#userList").append(data);
						docH = $(document).height();
						if(scrollH < document.body.scrollHeight){
							//결과값이 없을 때 page증가 멈춤
							page++;
						}
						
						}
					});
			  }
		});
	});
		
	
</script>
</body>
</html>