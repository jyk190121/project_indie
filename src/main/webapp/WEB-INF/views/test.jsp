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
<body>
	<form action="/test/game/upload?${_csrf.parameterName }=${_csrf.token}" enctype="multipart/form-data" method="post">
		<input type="hidden" name="id" value="62"/>
		<input name="files" onchange="javascript:uploadFiles(this.form);" id="files" type="file" multiple
			directory webkitdirectory />
		<button>등록</button>
	</form>
	<form action="/test/upload/image?${_csrf.parameterName }=${_csrf.token}" enctype="multipart/form-data" method="post">
		<input type="file" name="image"/>
		<button>이미지 등록</button>
	</form>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		var agent = navigator.userAgent.toLowerCase();

		function upload(f) {
			var files = $('#files')[0].files;
			var paths = [];
			for (var i = 0; i < files.length; i++) {
				console.log(files[i]);
				var fileExt = files[i].name.substring(files[i].name
						.lastIndexOf('.') + 1);
				if (fileExt.toUpperCase() == "ASP"
						|| fileExt.toUpperCase() == "PHP"
						|| fileExt.toUpperCase() == "JSP") {
					alert("ASP,PHP,JSP 파일은 업로드 하실 수 없습니다!");

					if ((navigator.appName == 'Netscape' && navigator.userAgent
							.search('Trident') != -1)
							|| (agent.indexOf("msie") != -1)) {
						// ie 일때 input[type = file] init.
						$("#files").replaceWith($("#filename").clone(true));
					} else { // other browser 일때 input[type = file] init.
						$("#files").val("");
					}
					return;
				}
				console.log(files[i].webkitRelativePath);
				paths.push(files[i].webkitRelativePath);
				files[i].name = 'aa';
				console.log(files[i].name);
			}
			$(f).append(`<input type='hidden' name='paths' value='\${paths.toString()}'>`)		
		}
	</script>
</body>
</html>