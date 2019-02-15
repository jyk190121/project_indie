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
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
	function signin() {
		var form = $("<form method='post' action='/user/signin'>");
		form.append($("<input type='hidden' name='id' value='${id}'>"));
		form.append($("<input type='hidden' name='password' value='${googleId}'>"));
		form.append($("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>"));
		$("body").append(form);
		form.submit();
	}
	signin();
	</script>
</body>
</html>