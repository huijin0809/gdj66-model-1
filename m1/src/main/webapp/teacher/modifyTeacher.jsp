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
	System.out.println(teacherNo + " <- addTeacher teacherNo");
	
	// 2. 출력부 (교사 상세보기 메서드 사용)
	TeacherDao dao = new TeacherDao();
	Teacher teacher = dao.selectTeacherOne(teacherNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify Teacher</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container mt-5 text-center">
		<h1>교사 정보 수정</h1>
		<!----- msg 출력 ----->
		<%
			if(request.getParameter("msg") != null) {
		%>
				<span class="text-danger"><%=request.getParameter("msg")%></span>
		<%
			}
		%>
		<!------------------ 수정 form ------------------>
		<form action="<%=request.getContextPath()%>/teacher/modifyTeacherAction.jsp" method="post">
			<!-- teacherNo는 수정 불가능하므로 hidden으로 넘겨준다 -->
			<input type="hidden" name="teacherNo" value="<%=teacher.getTeacherNo()%>">
			<table class="table container">
				<tr>
					<th class="table-warning">번호</th>
					<td>
						<%=teacher.getTeacherNo()%>
					</td>
				</tr>
				<tr>
					<th class="table-warning">아이디</th>
					<td>
						<!-- teacherId 수정 가능 -->
						<input type="text" name="teacherId" value="<%=teacher.getTeacherId()%>">
					</td>
				</tr>
				<tr>
					<th class="table-warning">이름</th>
					<td>
						<!-- teahcerName 수정 가능 -->
						<input type="text" name="teacherName" value="<%=teacher.getTeacherName()%>">
					</td>
				</tr>
				<tr>
					<th class="table-warning">연혁</th>
					<td>
						<!-- teahcerHistory 수정 가능 -->
						<textarea rows="3" cols="100" name="teacherHistory"><%=teacher.getTeacherHistory()%></textarea>
					</td>
				</tr>
				<tr>
					<th class="table-warning">생성일자</th>
					<td>
						<%=teacher.getCreatedate()%>
					</td>
				</tr>
				<tr>
					<th class="table-warning">수정일자</th>
					<td>
						<%=teacher.getUpdatedate()%>
					</td>
				</tr>
			</table>
			<a href="<%=request.getContextPath()%>/teacher/teacherList.jsp" class="btn btn-outline-warning">
				뒤로가기
			</a>
			<button type="submit" class="btn btn-warning">수정</button>
		</form>
	</div>
</body>
</html>