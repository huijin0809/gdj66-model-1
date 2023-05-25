<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// 1. 유효성 검사
	if(request.getParameter("subjectNo") == null) {
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp");
		return;
	}
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	System.out.println(subjectNo + " <- subjectOne subjectNo");
	
	// 2. 출력부
	// 과목 상세보기 메서드 호출
	SubjectDao dao = new SubjectDao();
	// Subject 타입 객체에 저장
	Subject subject = dao.selectSubjectOne(subjectNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>subjectOne</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container mt-5 text-center">
		<h1>과목 상세보기</h1>
		<!------------------ 데이터 출력부 ------------------>
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
					<%=subject.getSubjectName()%>
				</td>
			</tr>
			<tr>
				<th class="table-danger">시간</th>
				<td>
					<%=subject.getSubjectTime()%>
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
		<!----------------- 버튼 출력 ----------------->
		<a href="<%=request.getContextPath()%>/subject/subjectList.jsp" class="btn btn-secondary">
			뒤로가기
		</a>
		<a href="<%=request.getContextPath()%>/subject/modifySubject.jsp" class="btn btn-secondary">
			수정
		</a>
		<a href="<%=request.getContextPath()%>/subject/removeSubject.jsp" class="btn btn-secondary">
			삭제
		</a>
	</div>
</body>
</html>