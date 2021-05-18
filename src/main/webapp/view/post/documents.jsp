<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="dto.Member" %>
<html>
<head>
<title>문서공유 게시판</title>
<link rel="stylesheet" href="/resource/css/post.css">
</head>

<body>
	<c:set var="loginFlag" value="${sessionScope.login}" />
	<c:set var="loginFail" value="${requestScope.loginFail}" />
	<c:set var="registerErrorCode" value="${requestScope.registerErrorCode}" />
	<c:set var="postList" value="${requestScope.postList}"/>

	<c:choose>
		<c:when test="${registerErrorCode eq -1}">
			out.println("<script>alert('회원가입에 실패하였습니다.'); history.go(-1);</script>");
		</c:when>
		<c:when test="${registerErrorCode eq -10}">
			out.println("<script>alert('이미 존재하는 아이디입니다.'); history.go(-1);</script>
		</c:when>
		<c:when test="${loginFail eq true}">
			out.println("<script>alert('로그인에 실패하였습니다.'); window.location='/index.jsp';</script>");
		</c:when>
	</c:choose>

	<div class="all">
		<header>
			<jsp:include page="/fragments/header.jsp" />
		</header>
		<div class="search">
			<jsp:include page="/form/search.jsp" />
		</div>
		<div class="menu">
			<c:choose>
				<c:when test="${loginFlag eq null}">
					<jsp:include page="/form/login.jsp" />
				</c:when>
				<c:when test="${loginFlag eq 'success'}">
					<jsp:include page="/fragments/userProfile.jsp" />
				</c:when>
			</c:choose>
			<br>
			<jsp:include page="/fragments/menu.jsp" />
		</div>

		<div>
			<div class="main" >
				<div class="postName">Documents</div>
				<br>
				<div class="postDetail">단국대학교 컴퓨터공학과 학생들이 파일들을 공유하기 위한 게시판입니다.</div>
				<table class="type07">
					<thead>
					<tr>
						<th id="title">제목</th>
						<th class="writer">작성자</th>
						<th class="date">작성날짜</th>
					</tr>
					</thead>
					<c:forEach var="post" items="${postList}">
						<c:set var="nickName" value="${Member.getNickName(post.memberID)}"/>
						<tr>
							<td id="titleTd" onclick="location.href='/Post/PostDetail?id=${post.id}';" style="cursor:pointer;">${post.title}</td>
							<td class="writer">${nickName}</td>
							<td class="date">${post.creationDate}</td>
						</tr>
					</c:forEach>
				</table>
				<div class="pageButton">
					<div class="" role="toolbar" aria-label="Toolbar with button groups">
						<div class="" role="group" aria-label="First group">
							<button type="button" class="previous" onclick="location='/Classification/Notice?page=${param.page-1}'">이전</button>
							<c:forEach var="i" begin="${requestScope.blockNum}" end="${requestScope.blockNum+9}">
								<button type="button" class="number" onclick="location='/Classification/Notice?page=${i}'">${i}</button>
							</c:forEach>
							<button type="button" class="next" onclick="location='/Classification/Notice?page=${param.page+1}'">다음</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="text-center">
	<jsp:include page="/fragments/footer.jsp" />
	</div> 
</body>
</html>
