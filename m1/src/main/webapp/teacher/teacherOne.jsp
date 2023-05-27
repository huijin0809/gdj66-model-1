<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 1. 유효성 검사
	if(request.getParameter("teacherNo") == null
			|| request.getParameter("teacherNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/teacher/teacherList.jsp");
		return;
	}
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	System.out.println(teacherNo + " <- teacherOne teacherNo");
	
	// 2. 메서드 호출
	TeacherDao dao = new TeacherDao();
	// Teacher 타입 객체에 저장
	Teacher teacher = dao.selectTeacherOne(teacherNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Teacher One</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container mt-5 text-center">
		<h1>교사 정보 보기</h1>
		<!----- msg 출력 ----->
		<%
			if(request.getParameter("msg") != null) {
		%>
				<span class="text-danger"><%=request.getParameter("msg")%></span>
		<%
			}
		%>
		<!------------------ 데이터 출력부 ------------------>
		<table class="table container">
			<tr>
				<th class="table-warning">번호</th>
				<td><%=teacher.getTeacherNo()%></td>
			</tr>
			<tr>
				<th class="table-warning">아이디</th>
				<td><%=teacher.getTeacherId()%></td>
			</tr>
			<tr>
				<th class="table-warning">이름</th>
				<td><%=teacher.getTeacherName()%></td>
			</tr>
			<tr>
				<th class="table-warning">연혁</th>
				<td><%=teacher.getTeacherHistory()%></td>
			</tr>
			<tr>
				<th class="table-warning">생성일자</th>
				<td><%=teacher.getCreatedate()%></td>
			</tr>
			<tr>
				<th class="table-warning">수정일자</th>
				<td><%=teacher.getUpdatedate()%></td>
			</tr>
		</table>
		<!----------------- 버튼 출력 ----------------->
		<a href="<%=request.getContextPath()%>/teacher/teacherList.jsp" class="btn btn-outline-warning">
			뒤로가기
		</a>
		<a href="<%=request.getContextPath()%>/subject/modifyTeacher.jsp?teacherNo=<%=teacherNo%>" class="btn btn-warning">
			수정
		</a>
		<a href="<%=request.getContextPath()%>/subject/removeTeacher.jsp?teacherNo=<%=teacherNo%>" class="btn btn-warning">
			삭제
		</a>
	</div>
</body>
</html>