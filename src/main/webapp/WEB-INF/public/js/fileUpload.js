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

function uploadFiles(input) {
	var files = $(input)[0].files;
	var paths = [];
	for (var i = 0; i < files.length; i++) {
		var fileExt = files[i].name
				.substring(files[i].name.lastIndexOf('.') + 1).toUpperCase();
		if (fileExt == "ASP" || fileExt == "PHP"
				|| fileExt == "JSP") {
			alert("ASP,PHP,JSP 파일은 업로드 하실 수 없습니다!");

			if ((navigator.appName == 'Netscape' && navigator.userAgent
					.search('Trident') != -1)
					|| (agent.indexOf("msie") != -1)) {
				// ie 일때 input[type = file] init.
				$(input).replaceWith($(input).clone(true));
			} else { // other browser 일때 input[type = file] init.
				$(input).val("");
			}
			return;
		}
		paths.push(files[i].webkitRelativePath);
		files[i].name = 'aa';
	}
	$(input.form).append(
			`<input type='hidden' name='paths' value='\${paths.toString()}'>`)
}

function uploadImage(input){
	var ext = input.value.substring(input.value.lastIndexOf('.') + 1).toUpperCase();
	if(!(ext == 'PNG' || ext == 'JPG' || ext == 'JPEG' || ext == 'GIF' || ext == "BMP")){
		alert('이미지는 png, jpg, bmp, gif 형식의 파일만 업로드할 수 있습니다');
		if ((navigator.appName == 'Netscape' && navigator.userAgent
				.search('Trident') != -1)
				|| (agent.indexOf("msie") != -1)) {
			// ie 일때 input[type = file] init.
			$(input).replaceWith($(input).clone(true));
		} else { // other browser 일때 input[type = file] init.
			$(input).val("");
		}
		$(".game-image-board").text("Insert Game Image");
		return;
	}
	showImage(input);
}