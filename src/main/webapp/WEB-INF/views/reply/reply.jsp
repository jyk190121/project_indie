<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="reply" style="margin-left:${reply.depth*30}px">
	<div class="reply-header">
		<span class="glyphicon glyphicon-user"></span> ${reply.writer }
		<c:if test="${empty reply.writer }">
							삭제된 사용자입니다
						</c:if>
		&nbsp;&nbsp;
		<c:if test="${!empty reply.writer }">
			<span class="glyphicon glyphicon-time"></span>
							${reply.write_date } &nbsp;&nbsp;
							<button class="btn btn-primary btn-xs" type="button"
				data-parent="#reply-list" data-toggle="collapse"
				data-target="#form_${reply.id }">댓글</button>
		</c:if>
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
				<textarea name="content" rows="3" class="form-control" required></textarea>
			</div>
			<div class="form-group text-right">
				<button type="button" onclick="replySend(this.form)"
					class="btn btn-primary">등록</button>
			</div>
		</form>
	</div>
</div>