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
<link rel="stylesheet" href="/public/css/croppie.css" />
</head>
<body>
	<div style="height: 500px;"></div>
	<div id="upload-demo"></div>
	<input type="file" id="upload" value="Choose a file" accept="image/*">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="/public/js/croppie.js"></script>
	<script>
		function set() {
			var $uploadCrop;

			function readFile(input) {
	 			if (input.files && input.files[0]) {
		            var reader = new FileReader();
		            
		            reader.onload = function (e) {
						$('.upload-demo').addClass('ready');
		            	$uploadCrop.croppie('bind', {
		            		url: e.target.result
		            	}).then(function(){
		            		console.log('jQuery bind complete');
		            	});
		            	
		            }
		            
		            reader.readAsDataURL(input.files[0]);
		        }
		        else {
			        swal("Sorry - you're browser doesn't support the FileReader API");
			    }
			}

			$uploadCrop = $('#upload-demo').croppie({
				viewport: {
					width: 100,
					height: 100,
					type: 'circle'
				},
				enableExif: true
			});

			$('#upload').on('change', function () { readFile(this); });
			$('.upload-result').on('click', function (ev) {
				$uploadCrop.croppie('result', {
					type: 'canvas',
					size: 'viewport'
				}).then(function (resp) {
					popupResult({
						src: resp
					});
				});
			});
		}
		set();
	</script>
</body>
</html>