function showImage(input) {
	console.log(input.files[0]);
	var reader = new FileReader();
	reader.onload = function(e) {
		$(".game-image-board").empty();
		$(".game-image-board").append(
				"<img id='game-image' src='" + e.target.result + "'></img>");
	}
	reader.readAsDataURL(input.files[0]);
}

function deleteFile(target) {
	var src = target[0].src.substring(21);
	console.log("src", src);
	$.ajax({
		url : "/filedelete",
		type : "post",
		data : {
			src : src
		},
		success : function(data) {
			console.log(data);
		}
	});
}

var agent = navigator.userAgent.toLowerCase();
var paths = [];

function uploadImage(input){
	var ext = input.value.substring(input.value.lastIndexOf('.') + 1).toUpperCase();
	if(!(ext == 'PNG' || ext == 'JPG' || ext == 'JPEG' || ext == 'GIF' || ext == "BMP")){
		alert('이미지는 png, jpg, bmp, gif 형식의 파일만 업로드할 수 있습니다');
		initInput(input);
		$(".game-image-board").text("Insert Game Image");
		return;
	}
	showImage(input);
}

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