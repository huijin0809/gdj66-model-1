<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// 1. 유효성 검사
	if(request.getParameter("subjectNo") == null
			|| request.getParameter("subjectNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");
		return;
	}
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	System.out.println(subjectNo + " <- modifySubject subjectNo");
	
	// 2. 출력부 (과목 상세보기 메서드 사용)
	SubjectDao dao = new SubjectDao();
	Subject subject = dao.selectSubjectOne(subjectNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify Subject</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container mt-5 text-center">
		<h1>과목 상세보기</h1>
		<!----- msg 출력 ----->
		<%
			if(request.getParameter("msg") != null) {
		%>
				<span class="text-danger"><%=request.getParameter("msg")%></span>
		<%
			}
		%>
		<!------------------ 수정 form ------------------>
		<form action="<%=request.getContextPath()%>/subject/modifySubjectAction.jsp" method="post">
			<!-- subjectNo는 수정 불가능하므로 hidden으로 넘겨준다 -->
			<input type="hidden" name="subjectNo" value="<%=subject.getSubjectNo()%>">
			<table class="table container">
				<tr>
					<th class="table-danger">번호</th>
					<td>
						<%=subject.getSubjectNo()%>
					</td>
				</tr>
				<tr>
					<th class="table-danger">이름</th>
					<td>
						<!-- subjectName 수정 가능 -->
						<input type="text" name="subjectName" value="<%=subject.getSubjectName()%>">
					</td>
				</tr>
				<tr>
					<th class="table-danger">시간</th>
					<td>
						<!-- subjectTime 수정 가능 -->
						<input type="number" name="subjectTime" value="<%=subject.getSubjectTime()%>">
					</td>
				</tr>
				<tr>
					<th class="table-danger">생성일자</th>
					<td>
						<%=subject.getCreatedate()%>
					</td>
				</tr>
				<tr>
					<th class="table-danger">수정일자</th>
					<td>
						<%=subject.getUpdatedate()%>
					</td>
				</tr>
			</table>
			<a href="<%=request.getContextPath()%>/subject/subjectList.jsp" class="btn btn-outline-secondary">
				뒤로가기
			</a>
			<button type="submit" class="btn btn-secondary">수정</button>
		</form>
	</div>
</body>
</html>