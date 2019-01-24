<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" 
 	  content="width=device-width, initial-scale=1">
<title>notice board</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<style>
	.table-board{
		background-color:white;
	}
	
	.table-board>thead>tr>th, .table-board>tbody>tr>td{
		text-align: center;
		padding: 20px 0;
	}
	
	tfoot{
		text-align: center;	
	}
</style>
</head>
<body>
	<div class="header">
		<jsp:include page="/WEB-INF/views/board/boardTopPage.jsp"/>
	</div>
	<div class="content">
		<div class="container">
			<div class="row" style="padding-bottom:50px">
				<h2 class="text-center">자유롭게 의견을 나눠보아요!</h2>
			</div>
			<div class="row">
				<table class="table table-hover table-board">
					<thead>
						<tr>
							<th width="30%">제목</th>
							<th width="20%">작성자</th>
							<th width="20%">작성일</th>
							<th width="10%">댓글수</th>
							<th width="10%">조회수</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="board" items="${boardList}">
						<tr onclick="location.href='/board/view?id=${board.id}'"
							style="cursor:pointer;">
							<td>
							<c:if test="${board.type == 'notice' }">
								<div class="text-center" style="display:inline-block; width: 10%;">
									<span class="badge" style="background-color:red;">공지</span>
								</div>
								<div style="display:inline-block; width: 80%; transform:translate(-5%,0); font-weight: bold;">
									${board.title }
								</div>
							</c:if>
							<c:if test="${board.type == 'normal' }">
								${board.title }
							</c:if>
							</td>
							<td>${board.user.nickname }</td>
							<td>${board.write_date }</td>
							<td>${board.reply_count }</td>
							<td>${board.hit }</td>
						</tr>
					</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="5" class="text-right">
								<sec:authorize access="hasRole('ROLE_ADMIN')">
								<a href="/board/insert?type=notice"
								   class="btn btn-danger">공지사항 작성</a>
								</sec:authorize>
								<a href="/board/insert?type=normal"
								   class="btn btn-primary">글쓰기</a>
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
</body>
</html>



