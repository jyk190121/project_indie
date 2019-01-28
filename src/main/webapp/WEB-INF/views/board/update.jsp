<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" 
 	  content="width=device-width, initial-scale=1">
<title>notice board</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
<style>
	
</style>
</head>
<body>
	<div class="header">
		<jsp:include page="/WEB-INF/views/board/boardTopPage.jsp"/>
	</div>
	<div class="content">
		<div class="container-fluid" style="width:80%">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h4>글수정</h4>
				</div>
				<div class="panel-body">
					<form:form action="/board/update" method="post" 
							   modelAttribute="board">
						<form:hidden path="id" />
						<div class="form-group">
							<form:input
								   class="form-control"
								   path="title"
								   placeholder="제목을 입력해 주세요"/>
							<form:errors path="title"/>
						</div>
						<div class="form-group">
							<form:textarea 
									  class="form-control" id="content"
									  path="content"
									  placeholder="내용을 입력해 주세요"></form:textarea>
							<form:errors path="content"/>
						</div>
						<div class="form-group text-right">
							<button class="btn btn-primary"
									type="button" 
									onclick="checkForm(this.form);">수정</button>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	<div class="footer">
		Game Made By <a href="">me</a>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/lang/summernote-ko-KR.min.js"></script>
    <script>
    	function checkForm(f){
    		if(f.title.value == ""){
    			alert("제목을 입력해 주세요");
    			f.title.focus();
    			return;
    		}
    		
    		if(f.content.value == ""){
    			alert("내용을 입력해 주세요");
    			//f.content.focus();
    			$(".note-editable").focus();
    			return;
    		}
    		alert("${msg}");
    		f.submit();
    	}
    
    	$("#content").summernote({
    		height:400,
    		//focus: true,
    		disableResizeEditor:true,
    		lang: 'ko-KR',
    		callbacks:{
    			onImageUpload:sendFile,
    			onMediaDelete:deleteFile
    		}
    	});
    	function deleteFile(target){
    		var src = target[0].src.substring(21);
    		console.log("src",src);
    		$.ajax({
    			url:"/filedelete",
    			type:"post",
    			data:{src:src},
    			success:function(data){
    				console.log(data);
    			}
    		});
    	}
    	
    	function sendFile(files, editor, welEditable){
    		//console.log(files[0]);
    		var data = new FormData();
    		data.append('upload', files[0]);
    		
    		$.ajax({
    			url:"/fileupload",
    			contentType:false,
    			processData:false,
    			data:data,
    			type:"post",
    			success:function(data){
    				//console.log(data);
    				$("#content").summernote(
    						'editor.insertImage', data.url);
    			},error:function(error){
    				console.error(error);
    			}
    		});
    	}
    	
    </script>
</body>
</html>



