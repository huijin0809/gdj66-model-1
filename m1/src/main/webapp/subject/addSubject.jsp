<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Subject</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container mt-5 text-center">
		<h1>과목 추가하기</h1>
		<!----- msg 출력 ----->
		<%
			if(request.getParameter("msg") != null) {
		%>
				<span class="text-danger"><%=request.getParameter("msg")%></span>
		<%
			}
		%>
		<!------------------ 데이터 출력부 ------------------>
		<form action="<%=request.getContextPath()%>/subject/addSubjectAction.jsp" method="post">
			<table class="table">
				<tr>
					<th class="table-danger">과목 이름</th>
					<td><input type="text" name="subjectName"></td>
				</tr>
				<tr>
					<th class="table-danger">시간</th>
					<td><input type="number" name="subjectTime"></td>
				</tr>
			</table>
			<a href="<%=request.getContextPath()%>/subject/subjectList.jsp" class="btn btn-outline-secondary">
				뒤로가기
			</a>
			<button type="submit" class="btn btn-secondary">추가</button>
		</form>
	</div>
</body>
</html>