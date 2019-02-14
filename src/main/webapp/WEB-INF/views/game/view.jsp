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
</head>
<style>
* {
	box-sizing: border-box;
}

body {
	font-size: 20px;
}

#game-frame {
	width: 100%;
	height: 600px;
	overflow: hidden;
}

#game-panel {
	text-align: center;
}

.disnone {
	display: none !important;
}

.row {
	margin-top: 50px;
}

.game-info {
	min-height: 150px;
	width: 70%;
	margin: 50px auto 0 auto;
	font-size: 20px;
	text-align: left;
}

.game-info pre {
	min-height: 150px;
	height: 150px;
	padding: 20px;
	font-size: 20px;
	white-space: pre-wrap;
	overflow: hidden;
}

@keyframes show {
  from {background-color: white;}
  to {background-color: lightgray;}
}

@keyframes hide {
  from {background-color: lightgray;}
  to {background-color: white;}
}

.game-info button {
	width:41px;
	background-color: white;
	border: none;
	border-radius: 20px;
}
.game-info button:focus {
	outline: none;
}

.game-info-title {
	margin: 20px auto 40px auto;
}

textarea:focus {
	outline: none;
}

.bar-horizontal {
	width: 80%;
	border: 2px gray solid;
	margin-top: 50px;
}

#downloadFile, #downloadFile-btn {
	display: inline-block;
	height: 50px;
	padding: 10px 12px;
	color: #555;
	border: 1px solid gray;
	border-left-width: 0;
	border-right-width: 0;
	border-radius: 4px;
}

#downloadFile {
	
}

#downloadFile-btn {
	margin-left: 10px; color : #337ab7;
	border: 1px solid #337ab7;
	text-decoration: none;
	color: #337ab7;
}

.far{
	font-size: 50px;
}
.profileImage {
	display: inline-block; 
	border-radius : 100%;
	width: 50px;
	height: 50px;
	background-position: center center;
	border-radius: 100%;
	background-size: contain;
}

</style>
<body onload="draw();" onresize="draw();">
	<div class="header">
		game view
		<h1 class="text-center">${game.name }</h1>
		<div class="text-center">
			<div class="profileImage" style="background-image: url('/upload/image/${game.user.image}');"></div>
			<div style="display: inline-block; transform:translate(0,-17px)">
				<a onclick="location.href='/profile?writer_id=${game.user.writer_id}'" style="cursor: pointer; text-decoration: none;">
					Lv.${game.user.lev } ${game.user.nickname}
				</a>
			</div>
		</div>
	</div>
	<div class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">
					<div class="container-fluid">
						<div class="row content-game" id="game-panel">
							<c:if test="${game.type == 'web' }">
								<iframe scrolling="no" id="game-frame"
									src="/upload/game/${game.id }/${game.src}">브라우저에 따라
									작동하지 않을 수 있습니다. Chrome 으로 접속하는걸 권장합니다.</iframe>
							</c:if>
							<c:if test="${game.type == 'exe' || game.type == 'etc'}">
								<img src="/upload/image/${game.image }" alt="${game.image }"
									style="min-width: 50%; max-width: 100%;" />
								<div style="margin-top: 20px;">
									<div id="downloadFile">${game.src }</div>
									<a href="/upload/game/${game.id }/${game.src}"
										id="downloadFile-btn" class="">download</a>
								</div>
							</c:if>
							<hr class="bar-horizontal" />
							<div class="game-info">
								<h1 class="game-info-title">
									게임 설명
									<button type="button" onclick="show(this, 'game-info-text')">+</button>
								</h1>
								<%-- <textarea onclick="" readonly="readonly" placeholder="그런것은 없다!!" 
											style="width: 100%; min-height: 200px; resize: none; border:1px lightgray solid; padding:10px 20px;">${game.info }
								</textarea> --%>
								<pre id="game-info-text" style="">${game.info }</pre>
							</div>
							<c:if test="${game.type == 'etc' }">
								<hr class="bar-horizontal" />
								<div class="game-info">
									<h1 class="game-info-title">
										게임 실행 방법
										<button type="button" onclick="show(this, 'game-ect_info-text')">+</button>
									</h1>
									<pre id="game-ect_info-text" style="">${game.etc_info }</pre>
								</div>
							</c:if>
						</div>
						<div class="row" style="">
							<div class="col-xs-1">
								<div class="disnone" id="like-activated">
									<a href="javascript:evaluateGame('like');" class="likes-btn"><i class="far fa-thumbs-up"></i></a>
								</div>
								<div id="like-deactivated"><i class="far fa-thumbs-up"></i></div>
							</div>
							<div class="col-xs-10" id="likes-bar-container">
								<div>
									<canvas id="likes-bar" width="100%" height="30px"></canvas>
								</div>
								<div class="col-xs-4">
									<span id="likeCount">${game.likes }</span>
								</div>
								<div class="col-xs-4 text-center">게임을 평가해주세요!</div>
								<div class="col-xs-4 text-right">
									<span id="unlikeCount">${game.unlikes }</span>
								</div>
							</div>
							<div class="col-xs-1">
								<div class="disnone" id="unlike-activated">
									<a href="javascript:evaluateGame('unlike');" class="likes-btn"><i class="far fa-thumbs-down"></i></a>
								</div>
								<div id="unlike-deactivated"><i class="far fa-thumbs-down"></i></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row content-reply">
				<div class="col-sm-8 col-sm-offset-2">
					<div class="container-fluid">
						<div class="reply-form">
							<h4>Leave a Comment</h4>
							<form action="/reply/insert" method="post">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token }" />
								<div class="form-group">
									<textarea name="content" rows="3" class="form-control" required></textarea>
								</div>
								<div class="form-group text-right">
									<button type="button" onclick="replySend(this.form)"
										class="btn btn-primary">등록</button>
								</div>
							</form>
						</div>
						<div class="reply-list">
							<p>
								<span class="badge"> ${fn:length(game.replyList) } </span>
								Comments
							</p>
							<c:forEach var="reply" items="${game.replyList }">
								<div class="reply" style="margin-left:${reply.depth*30}px">
									<div class="reply-header">
										<div class="profileImage" style="background-image: url('/upload/image/${reply.user.image}');"></div>
										<div style="display: inline-block; transform:translate(0,-17px)">
											<a onclick="location.href='/profile?writer_id=${reply.user.writer_id}'" style="cursor: pointer; text-decoration: none;">
												LV ${reply.user.lev } ${reply.user.nickname }
											</a>
											<c:if test="${empty reply.user.nickname}">
												삭제된 사용자입니다
											</c:if>
											<c:if test="${!empty reply.user.nickname}">
												<span class="glyphicon glyphicon-time"></span>
												${reply.write_date } &nbsp;&nbsp;
												<button class="btn btn-primary btn-xs" type="button"
													data-parent="#reply-list" data-toggle="collapse"
													data-target="#form_${reply.id }">댓글</button>
											</c:if>
										</div>
									</div>
									<div class="reply-body">
										<c:if test="${reply.depth != 0 }">
											<i class="fas fa-reply" style="transform: rotate(180deg)"></i>
										</c:if>
										${reply.content }
									</div>
									<div class="rereply-form collapse" id="form_${reply.id}">
										<form action="/reply/rereply" method="post">
											<input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token }" /> <input type="hidden" name="ref"
												value="${reply.id}" />
											<div class="form-group">
												<textarea name="content" rows="3" class="form-control"
													required></textarea>
											</div>
											<div class="form-group text-right">
												<button type="button" onclick="replySend(this.form)"
													class="btn btn-primary">등록</button>
											</div>
										</form>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		var canvasWidth; 
		var evalCount = ${game.likes + game.unlikes};
		var likeRatio = ${game.likes}/evalCount;
		var unlikeRatio = ${game.unlikes}/evalCount;
		var selectedEval = '${selectedEval}';
		
		$(document).ready(function(){resizeLikesBar();activateEval()});

		$(window).resize(function() {
			canvasWidth = $("#likes-bar-container").innerWidth()-30;
			$("#likes-bar").attr({
				"width" : canvasWidth
			});
			draw();
		});

		function resizeLikesBar() {
			canvasWidth = $("#likes-bar-container").innerWidth()-30;
			$("#likes-bar").attr({
				"width" : canvasWidth
			});
		}
		
		//좋아요 싫어요
		
		function activateEval(){
			if(selectedEval == 'like'){
				$("#like-activated").addClass("disnone");
				$("#like-deactivated").removeClass("disnone");
				$("#unlike-activated").removeClass("disnone");
				$("#unlike-deactivated").addClass("disnone");
			}else if(selectedEval == 'unlike'){
				$("#like-activated").removeClass("disnone");
				$("#like-deactivated").addClass("disnone");
				$("#unlike-activated").addClass("disnone");
				$("#unlike-deactivated").removeClass("disnone");
			}else{
				$("#like-activated").removeClass("disnone");
				$("#like-deactivated").addClass("disnone");
				$("#unlike-activated").removeClass("disnone");
				$("#unlike-deactivated").addClass("disnone");
			}
		}
		
		function evaluateGame(eval){
			$.ajax({
				url : '/game/evaluate?${_csrf.parameterName}=${_csrf.token}',
				type : 'post',
				data : {type : eval, game_id : ${game.id}},
				success : function(data){
					var list = data.split(',');
					list[1] *= 1;
					list[2] *= 1;
					$("#likeCount").text(list[1]);
					$("#unlikeCount").text(list[2]);
					evalCount = list[1]+list[2];
					likeRatio = list[1]/evalCount;
					unlikeRatio = list[2]/evalCount;
					draw();
					selectedEval = list[0];
					activateEval();
				},
				error : function(e){
					console.error(e);
				}
			});
		}
		
		//좋아요 싫어요 바
		
		function draw(){
			var canvas = $("#likes-bar")[0];
			if(canvas.getContext){
				var ctx = canvas.getContext("2d");
				ctx.clearRect(0, 0, canvas.width, canvas.height);
				ctx.fillStyle = '#74b9ff';
				if(evalCount == 0){
					roundRect(ctx,0,0,canvasWidth-1,30,15,true,false);
				}else if(likeRatio == 0 || unlikeRatio == 0){
					if(likeRatio == 0){ctx.fillStyle = '#fab1a0';}
					roundRect(ctx,0,0,canvasWidth-1,30,15,true,false);
				}else{
					roundRect(ctx,0,0,canvasWidth*likeRatio,30,{tl:15,bl:15},true,false);
					ctx.fillStyle = '#fab1a0';
					roundRect(ctx,canvasWidth*likeRatio,0,canvasWidth*unlikeRatio,30,{tr:15,br:15},true,false);
				}
				//console.log(${game.likes}/(${game.likes+game.unlikes}));
			}
		}
		
		//게임설명 토글 직접구현
		
		function hide(button, target) {
			$("#"+target).css('height','150px');
			$(button).css('animation-name','hide');
			$(button).css('animation-duration','0.5s');
			$(button).css('background-color','white');
			button.onclick = function() { show(button, target); };
		}
		
		function show(button, target) {
			$("#"+target).css('height','auto');
			$(button).css('animation-name','show');
			$(button).css('animation-duration','0.5s');
			$(button).css('background-color','lightgray');
			button.onclick = function() { hide(button, target); };
		}
		
		//canvas tool
		function roundRect(ctx, x, y, width, height, radius, fill, stroke) {
			  if (typeof stroke == 'undefined') {
			    stroke = true;
			  }
			  if (typeof radius === 'undefined') {
			    radius = 5;
			  }
			  if (typeof radius === 'number') {
			    radius = {tl: radius, tr: radius, br: radius, bl: radius};
			  } else {
			    var defaultRadius = {tl: 0, tr: 0, br: 0, bl: 0};
			    for (var side in defaultRadius) {
			      radius[side] = radius[side] || defaultRadius[side];
			    }
			  }
			  ctx.beginPath();
			  ctx.moveTo(x + radius.tl, y);
			  ctx.lineTo(x + width - radius.tr, y);
			  ctx.quadraticCurveTo(x + width, y, x + width, y + radius.tr);
			  ctx.lineTo(x + width, y + height - radius.br);
			  ctx.quadraticCurveTo(x + width, y + height, x + width - radius.br, y + height);
			  ctx.lineTo(x + radius.bl, y + height);
			  ctx.quadraticCurveTo(x, y + height, x, y + height - radius.bl);
			  ctx.lineTo(x, y + radius.tl);
			  ctx.quadraticCurveTo(x, y, x + radius.tl, y);
			  ctx.closePath();
			  if (fill) {
			    ctx.fill();
			  }
			  if (stroke) {
			    ctx.stroke();
			  }

			}
		
		//reply
		function replySend(f){
    		$(f).append(`<input type='hidden' name='type' value='game'/>`);
    		$(f).append(`<input type='hidden' name='idx' value='${game.id}'/>`);
			f.submit();
    	}
		
	</script>
</body>
</html>