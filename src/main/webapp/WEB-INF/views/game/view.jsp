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

#game-frame {
	margin-top: 100px;
	width: 100%;
	height: 600px;
	overflow: hidden;
}

#game-panel {
	text-align: center;
}
</style>
<body onload="draw();" onresize="draw();">
	<div class="header">
		game view
		<h1 class="text-center">${game.name }</h1>
	</div>
	<div class="content">

		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">s
					<div class="container-fluid">
						<div class="row" id="game-panel">
							<iframe scrolling="no" id="game-frame" 
								src="/upload/game/${game.id }_${game.name}/${game.src}">브라우저에
								따라 작동하지 않을 수 있습니다. Chrome 으로 접속하는걸 권장합니다.</iframe>
						</div>
						<div class="row">
							<div class="col-xs-1">
								<a href="javascript:evaluateGame('like');" class="likes-btn">
									좋아요
								</a>			
							</div>
							<div class="col-xs-10" id="likes-bar-container">
								<div>
									<canvas id="likes-bar" width="100%" height="30px"></canvas>
								</div>
								<div class="col-xs-4">${game.likes }</div>
								<div class="col-xs-4">이건 뭐 그냥</div>
								<div class="col-xs-4">${game.unlikes }</div>
							</div>
							<div class="col-xs-1">
								<a href="javascript:evaluateGame('unlike');" class="likes-btn">
									싫어요
								</a>	
							</div>
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
		
		$(document).ready(resizeLikesBar());

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
		
		function evaluateGame(eval){
			console.log('aa');
			$.ajax({
				url : '/game/evaluate/'+eval,
				type : 'post',
				success : function(data){
					if(data == 'success'){
						console.log(data);
					}
				},
				error : function(e){
					console.error(e);
				}
			});
		}
		
		function draw(){
			var canvas = $("#likes-bar")[0];
			if(canvas.getContext){
				var ctx = canvas.getContext("2d");
				ctx.fillStyle = '#74b9ff';
				if(evalCount == 0){
					roundRect(ctx,0,0,canvasWidth-1,30,15,true,false);
				}else{
					roundRect(ctx,0,0,canvasWidth*likeRatio,30,{tl:15,bl:15},true,false);
					ctx.fillStyle = '#fab1a0';
					roundRect(ctx,canvasWidth*likeRatio,0,canvasWidth*unlikeRatio,30,{tr:15,br:15},true,false);
				}
				//console.log(${game.likes}/(${game.likes+game.unlikes}));
			}
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
		
	</script>
</body>
</html>