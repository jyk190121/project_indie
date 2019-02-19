<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="seq"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id"
	content="643415307527-il731pmi36f68sn61e2ljieudcm3d107.apps.googleusercontent.com">
<title>main</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="shortcut icon" href="/public/favicon.ico">
<link rel="stylesheet" href="/public/css/style.css">
</head>

<style>
.header {
	height: 260px;
}

.header h1 {
	position: relative;
	text-shadow: -2px 0 #222, 0 2px #222, 2px 0 #222, 0 -2px #222;
	color: white;
	font-size: 300px;
	margin: 0;
	transform: translate(0, -265px);
}

.footer {
	margin-top: 100px;
	height: 100px;
}

@
keyframes showbar {
	from {opacity: 0;
}

to {
	opacity: 1;
}

}
@
keyframes hidebar {
	from {opacity: 1;
}

to {
	opacity: 0;
}

}
.navbar {
	opacity: 0;
}

#image {
	width: 100%;
}

.image {
	width: 200px;
	height: 200px;
	border: 1px solid #be2edd;
}

.content-table {
	width: 60%;
	margin: auto;
}

.btn-primary {
	background-color: #4285F4;
}

.gameImage {
	width: 100%;
	height: 25vw;
}

.game-recent img {
	width: 100%;
	height: 7vw;
}

.game-recent [class^=col-] {
	padding: 10px 5px;
}

.signin {
	border: 1px solid #be2edd;
	padding: 10px;
}

.ranking-list>div {
	padding: 2px 20px;
}

.ranking-list>div>div {
	padding: 0;
	cursor: pointer;
	color: black;
	height: 20px;
	overflow: hidden;
}

.ranking-rank {
	width: 20px;
	height: 20px;
	line-height: 20px;
	background-color: #e056fd;
	color: white;
	text-align: center;
	border-radius: 2px;
	font-size: 12px;
}

.board .row {
	height: 30px;
}

.board .row [class^=col-] {
	padding: 0;
}

.signin [class^=col-] {
	padding: 0;
}

.cropping {
	max-height: 800px;
	overflow: hidden;
}

.cropping img {
	max-height: initial;
	margin-top: -15%;
}
</style>
<body>
	<div class="text-center header">
		<jsp:include page="/WEB-INF/views/navbar.jsp" />
		<img src="/public/image/background1-img.jpg" alt="" />
		<div style="padding-top: 0;">
			<h1 style="">Indiemoa</h1>
		</div>
		<%-- <c:if test="${user != null }">
			<div>
				<!-- <a class="btn btn-danger" href="/user/levUp">LevelUp</a> -->
				<p>
					<img id="image" src="/upload/image/${user.image }"
						alt="${user.image }" /> <a
						href="/profile?writer_id=${user.writer_id }"
						style="text-decoration: none;">${user.nickname }</a>으로 로그인
					<button onclick="javascript:signout();">로그아웃</button>
				</p>
			</div>
		</c:if>
		<c:if test="${user == null }">
			<button onclick="showLoginModal();">로그인</button>
			<a href="/user/join" class="btn btn-warning">회원가입</a>
			<p>랭킹 이외의 모든 컨텐츠는 로그인 후에 이용이 가능합니다</p>
		</c:if> --%>
	</div>
	<div
		style="height: 50px; z-index: 0; background-color: white; position: relative;"></div>
	<%-- <table class="content-table" style="margin-bottom: 50px;">
		<tr>
			<th class="text-center">게임</th>
			<th class="text-center">게시판</th>
			<th class="text-center">랭킹</th>
			<th class="text-center">마이페이지</th>
			<seq:authorize access="hasRole('ROLE_ADMIN')">
				<th class="text-center">관리자</th>
			</seq:authorize>
		</tr>
		<tr class="content">
			<td><a href="/game/main"><img class="image"
					src="/public/image/game.jpg" alt="게임"></img></a></td>
			<td><a href="/board/list"><img class="image"
					src="/public/image/board.jpeg" alt="게시판"></img></a></td>
			<td><a href="/ranking"><img class="image"
					src="/public/image/ranking.jpg" alt="랭킹"></img></a></td>
			<td><a href="/user/mypage"><img class="image"
					src="/public/image/mypage.png" alt="마이페이지"></img></a></td>
			<seq:authorize access="hasRole('ROLE_ADMIN')">
				<td><a href="/manage"><img class="image"
						src="/public/image/manage.jpg" alt="관리자"></img></a></td>
			</seq:authorize>
		</tr>
	</table> --%>
	<div class="content">
		<div class="container">
			<div class="row">
				<div class="col-md-9">
					<div class="game" style="margin-bottom: 30px;">
						<div class="div-title-underbar">
							<a href="/game/main"> <span class="pull-right lightgray">+</span>
								<span class="div-title-underbar-bold"> <b>게임</b>
							</span>
							</a>
						</div>
						<div style="margin-top: 40px;">
							<div class="carousel slide" data-ride="carousel"
								id="gameCarousel" style="width: 90%; margin: auto;">
								<ol class="carousel-indicators">
									<li data-target="#mycarousel" data-slide-to="0" class="active"></li>
									<li data-target="#mycarousel" data-slide-to="1"></li>
									<li data-target="#mycarousel" data-slide-to="2"></li>
								</ol>
								<div class="carousel-inner">
									<div class="item active">
										<a href="/game/view?id=${hotGameList[0].id }">
											<div class="image-cover">
												<img class="gameImage"
													src="/upload/image/${hotGameList[0].image }"
													alt="gameImage1" />
											</div>
											<div class="carousel-caption">
												<h1>${hotGameList[0].name }</h1>
												<p style="font-size: 20px;">${hotGameList[0].info }</p>
											</div>
										</a>
									</div>
									<div class="item">
										<a href="/game/view?id=${hotGameList[1].id }">
											<div class="image-cover">
												<img class="gameImage"
													src="/upload/image/${hotGameList[1].image }"
													alt="gameImage2" />
											</div>
											<div class="carousel-caption">
												<h1>${hotGameList[1].name }</h1>
												<p style="font-size: 20px;">${hotGameList[1].info }</p>
											</div>
										</a>
									</div>
									<div class="item">
										<a href="/game/view?id=${hotGameList[2].id }">
											<div class="image-cover">
												<img class="gameImage"
													src="/upload/image/${hotGameList[2].image }"
													alt="gameImage3" />
											</div>
											<div class="carousel-caption">
												<h1>${hotGameList[2].name }</h1>
												<p style="font-size: 20px;">${hotGameList[2].info }</p>
											</div>
										</a>
									</div>
								</div>
								<a href="#gameCarousel" data-slide="prev"
									class="left carousel-control"> <span
									class="glyphicon glyphicon-chevron-left"></span>
								</a> <a href="#gameCarousel" data-slide="next"
									class="right carousel-control"> <span
									class="glyphicon glyphicon-chevron-right"></span>
								</a>
							</div>
						</div>
						<div class="game-recent" style="width: 90%; margin: auto;">
							<div class="row" style="margin-top: 20px;">
								<c:forEach begin="0" end="${fn:length(gameList)/2-1}" var="i">
									<div class="col-xs-3" style="padding: 10px;">
										<div class="hover-gray"
											style="background-color: #eee; padding: 10px;">
											<a href="/game/view?id=${gameList[i].id }"
												style="text-decoration: none; color: black;"> <img
												src="/upload/image/${gameList[i].image }" alt="game" />
												<div style="border: none; border-top: none; padding: 10px;">
													<div class="text-left">
														<p class="over-hidden"
															style="overflow: hidden; margin: 0 0 5px 0; font-size: 20px; height: 25px;">${gameList[i].name }</p>
													</div>
													<div>
														<i class="far fa-thumbs-up"></i> <span>${gameList[i].likes-gameList[i].unlikes }</span>
														&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i].reply_count }</span>
														&nbsp;&nbsp; <i class="far fa-eye"></i> <span>${gameList[i].hit }</span>
													</div>
												</div>
											</a>
										</div>
									</div>
								</c:forEach>
							</div>
							<div class="row" style="margin-top: 10px;">
								<c:forEach begin="${fn:length(gameList)/2}"
									end="${fn:length(gameList)-1}" var="i">
									<div class="col-xs-3" style="padding: 10px;">
										<div class="hover-gray"
											style="background-color: #eee; padding: 10px;">
											<a href="/game/view?id=${gameList[i].id }"
												style="text-decoration: none; color: black;"> <img
												src="/upload/image/${gameList[i].image }" alt="game" />
												<div style="border: none; border-top: none; padding: 10px;">
													<div class="text-left">
														<p class="over-hidden"
															style="overflow: hidden; margin: 0 0 5px 0; font-size: 20px; height: 25px;">${gameList[i].name }</p>
													</div>
													<div>
														<i class="far fa-thumbs-up"></i> <span>${gameList[i].likes-gameList[i].unlikes }</span>
														&nbsp;&nbsp; <i class="far fa-comment-dots"></i> <span>${gameList[i].reply_count }</span>
														&nbsp;&nbsp; <i class="far fa-eye"></i> <span>${gameList[i].hit }</span>
													</div>
												</div>
											</a>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="board">
						<div class="col-xs-6">
							<div class="div-title-underbar">
								<a href="/board/list"> <span class="pull-right lightgray">+</span>
									<span class="div-title-underbar-bold" style="font-size: 20px;"><b>공지사항</b>
								</span>
								</a>
							</div>
							<div style="padding: 0 5px;">
								<div class="container-fluid">
									<c:forEach var="board" items="${noticeBoardList}">
										<div class="row hover-lightgray"
											onclick="location.href='/board/view?id=${board.id}'"
											style="cursor: pointer; padding: 5px 0;">
											<div class="col-xs-2 text-center">
												<div class="text-center" style="display: inline-block;">
													<span class="badge" style="background-color: #be2edd;">공지</span>
												</div>
											</div>
											<div class="col-xs-7">
												<div class="over-hidden" style="display: inline-block;">${board.title }</div>
											</div>
											<div class="col-xs-1">
												<div class="over-hidden text-right" style="color: #be2edd;">
													<c:if test="${board.reply_count != 0 }">
													+${board.reply_count }
												</c:if>
												</div>
											</div>
											<div class="col-xs-2">
												<div class="text-center" style="overflow: hidden;">${fn:substring(board.write_date,5,11) }</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
						<div class="col-xs-6">
							<div class="div-title-underbar">
								<a href="/board/list"> <span class="pull-right lightgray">+</span>
									<span class="div-title-underbar-bold" style="font-size: 20px;"><b>게시판</b>
								</span>
								</a>
							</div>
							<div style="padding: 0 5px;">
								<div class="container-fluid">
									<c:forEach var="board" items="${normalBoardList}">
										<div class="row hover-lightgray"
											onclick="location.href='/board/view?id=${board.id}'"
											style="cursor: pointer; padding: 5px 0;">
											<div class="col-xs-1 text-right">
												<span class="text-center"
													style="display: inline-block; width: 20px; background-color: #be2edd; color: white; margin-right: 0 !important;">N</span>
											</div>
											<div class="col-xs-8">
												<div class="over-hidden"
													style="display: inline-block; padding-left: 10px;">${board.title }</div>
											</div>
											<div class="col-xs-1">
												<div class="over-hidden text-right" style="color: #be2edd;">
													<c:if test="${board.reply_count != 0 }">
													+${board.reply_count }
												</c:if>
												</div>
											</div>
											<div class="col-xs-2">
												<div class="text-center" style="overflow: hidden;">${fn:substring(board.write_date,5,11) }</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div
						style="background-color: #be2edd; color: white; height: 45px; font-size: 20px; padding: 10px; font-weight: 600;">마이페이지</div>
					<div class="signin" style="margin-bottom: 50px">
						<seq:authorize access="!isAuthenticated()">
							<form action="/user/signin" method="post">
								<input type="hidden" name="${_csrf.parameterName }"
									value="${_csrf.token }" />
								<div class="form-group" style="margin-top: 10px;">
									<input type="text" class="form-control" placeholder="Enter ID"
										id="id" name="id" value="" />
								</div>
								<div class="form-group">
									<input type="password" class="form-control"
										placeholder="Enter Password" name="password" value="" />
								</div>
								<div style="margin-bottom: 10px;">
									<button id="signin-btn" class="btn btn-primary btn-block"
										type="button" onclick="signin(this.form);">Sign in</button>
								</div>
								<div style="margin-bottom: 10px;">
									<span class="g-signin2" data-onsuccess="onSignIn"
										data-theme="dark" id="google-btn" style="border-radius: 5px;"
										style="display: inline;"></span>
								</div>
								<div class="text-right">
									<span onclick="location.href='/user/join'"
										style="cursor: pointer;">회원가입</span> <span
										style="color: gray;">|</span> <span
										onclick="location.href='/'" style="cursor: pointer;">정보
										찾기</span>
								</div>
							</form>
						</seq:authorize>
						<seq:authorize access="isAuthenticated()">
							<div class="container-fluid"
								style="margin-bottom: 20px; margin-top: 10px;">
								<div class="row">
									<div class="col-xs-4">
										<img id="image" src="/upload/image/${user.image }"
											alt="${user.image }" />
									</div>
									<div class="col-xs-7 col-xs-offset-1">
										<div>안녕하세요!</div>
										<div style="font-size: 16px; font-weight: 600;">${user.nickname }님
										</div>
										<div style="margin-top: 10px;">
											<a href="/user/mypage?writer_id=${user.writer_id }"
												style="text-decoration: none; font-size: 16px; font-weight: 600;"><i
												class="fas fa-user-edit"></i> 마이페이지</a>
										</div>
									</div>
								</div>
							</div>
							<button class="btn btn-primary btn-block" type="button"
								onclick="javascript:signout();">로그아웃</button>
						</seq:authorize>
					</div>
					<div class="ranking" style="margin-bottom: 30px;">
						<div class="div-title-underbar">
							<a href="/ranking"> <span class="pull-right lightgray">+</span>
								<span class="div-title-underbar-bold" style="font-size: 16px;">
									유저랭킹 <b>TOP30</b>
							</span>
							</a>
						</div>
						<div class="ranking-list" style="list-style-type: none;">
							<c:forEach var="user" items="${userList}">
								<div class="row hover-lightgray"
									onclick="javascript:userList('${user.writer_id}')">
									<div class="col-xs-2">
										<div class="ranking-rank">${user.rnum}</div>
									</div>
									<div class="col-xs-7">${user.nickname }</div>
									<div class="col-xs-2 col-xs-offset-1">Lv.${user.lev}</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="googleJoinModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #4285F4;">
					<button type="button" class="close" data-dismiss="modal"
						style="color: white; opacity: 1;">&times;</button>
					<h4 style="color: white;">Join us</h4>
				</div>
				<div class="modal-body" style="padding: 30px;">
					<h2>가입된 계정이 없습니다!</h2>
					<h3>구글계정으로 쉽고 빠르게 가입해보세요</h3>
					<div style="margin-top: 40px;">
						<button onclick="javascript:googleJoin();"
							class="btn btn-block btn-default" style="border-color: #4285F4;">
							<img style="width: 25px;"
								src="https://img.icons8.com/color/48/000000/google-logo.png">
							<span
								style="font-size: 20px; color: #4285F4; font-weight: 600; vertical-align: middle;">구글계정으로
								회원가입하기</span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="footer">
		<div class="text-center"
			style="height: 150px; background-image: url('/public/image/background1-1.jpg'); background-position: bottom;">
			<a href="https://icons8.com/icon/17949/google">Google icon by
				Icons8</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="https://apis.google.com/js/platform.js" async defer></script>
	<script>
		//fail, signout 등 파라미터 한번만 표출
		history.replaceState({}, null, location.pathname);
		
		var gCount = 0;
		$signinBtn = $("#signin-btn");
		
		$navbar = $(".navbar");
		//스크롤
		$( window ).scroll(function() {
			var scrollTop = $(window).scrollTop();
			if(scrollTop == 0){
				$navbar.css({'animation-name': "hidebar", opacity:'0'});
			}else{
				$navbar.css({'animation-name': "showbar", opacity:'1'});
			}
		});
		
		function signout() {
			var form = document.createElement("form");
			form.method = "post";
			form.action = "/user/signout";
			var input = document.createElement("input");
			input.type = "hidden";
			input.name = "${_csrf.parameterName}";
			input.value = "${_csrf.token}";
			form.appendChild(input);
			document.body.appendChild(form);
			form.submit();
		}

		$(document).ready(function(){
			$("#google-btn").width($signinBtn.outerWidth()+"px");
		});

		$(window).resize(function() {
			$(".abcRioButton").width($signinBtn.outerWidth()+"px");
		});
		
		<c:if test="${param.googleFail != null}">
		$("#googleJoinModal").modal("show");
		</c:if>
		<c:if test="${param.signin != null }">
			alert('로그인 후 이용가능합니다');
			$("#id").focus();
		</c:if>
		<c:if test="${param.signout != null }">
			alert('로그아웃되었습니다');
		</c:if>
		<c:if test="${param.fail != null }">
			alert('아이디 또는 비밀번호가 불일치합니다');
			$("#id").focus();
		</c:if>

		//game carousel
		$("#gameCarousel").carousel({
			interval:5000, //default: 5000, false: slide 안함
			puase: "hover",
			wrap: true //default: true, false: 반복 x
		});
		
		//구글 로그인
		function onSignIn(googleUser) {
			if(gCount++ == 0){
				return;
			}
			var profile = googleUser.getBasicProfile();
			var form = $("<form method='post' action='/user/google/login'>");
			form.append($("<input type='hidden' name='email' value="+profile.getEmail()+">"));
			form.append($("<input type='hidden' name='googleId' value="+profile.getId()+">"));
			form.append($("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>"));
			$("body").append(form);
			form.submit();
			
			/* console.log("ID: " + profile.getId()); // Don't send this directly to your server!
			console.log('Full Name: ' + profile.getName());
			console.log('Given Name: ' + profile.getGivenName());
			console.log('Family Name: ' + profile.getFamilyName());
			console.log("Image URL: " + profile.getImageUrl());
			console.log("Email: " + profile.getEmail()); */

			// The ID token you need to pass to your backend:
			/* var id_token = googleUser.getAuthResponse().id_token;
			console.log("ID Token: " + id_token); */
		}
		
		//구글계정으로 회원가입
		function googleJoin(){
			if(${googleInfo == null}) {
				alert('다시 시도해주세요');
				location.href='/';
				return;
			}
			var form = $("<form method='post' action='/user/google/join'>");
			form.append($("<input type='hidden' name='email' value='${googleInfo.email}'>"));
			form.append($("<input type='hidden' name='googleId' value='${googleInfo.googleId}'>"));
			form.append($("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>"));
			$("body").append(form);
			form.submit();
		}
		
		//signin
		function showLoginModal(){
			$("#loginModal").modal("show");
		}
		function signin(f){
			if(f.id.value == ""){
				alert("아이디를 입력해 주세요");
				f.id.focus();
				return;
			}
			
			if(f.password.value == ""){
				alert("비밀번호를 입력해 주세요");
				f.password.focus();
				return;
			}
			
			f.submit();
			
		}
		
		//ranking
		function userList(id){
			location.href = "/profile?writer_id="+id;
		}
		
	</script>
</body>
</html>