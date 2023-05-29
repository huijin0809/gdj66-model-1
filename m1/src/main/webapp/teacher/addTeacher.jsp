<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 과목 이름, 번호 조회 메서드 호출
	SubjectDao dao = new SubjectDao();
	ArrayList<Subject> list = dao.subjectNameNumberList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Teacher</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container mt-5">
		<h1>교사 추가하기</h1>
		<!----- msg 출력 ----->
		<%
			if(request.getParameter("msg") != null) {
		%>
				<span class="text-danger"><%=request.getParameter("msg")%></span>
		<%
			}
		%>
		<!------------------ 데이터 출력부 ------------------>
		<form action="<%=request.getContextPath()%>/teacher/addTeacherAction.jsp" method="post">
			<table class="table">
				<tr>
					<th class="table-warning">교사 아이디</th>
					<td><input type="text" name="teacherId"></td>
				</tr>
				<tr>
					<th class="table-warning">이름</th>
					<td><input type="text" name="teacherName"></td>
				</tr>
				<tr>
					<th class="table-warning">연혁</th>
					<td>
						<textarea rows="3" cols="100" name="teacherHistory"></textarea>
					</td>
				</tr>
				<tr>
					<th class="table-warning">담당과목</th>
					<td>
						<!-- 담당과목 선택 박스 -->
						<select name="subjectNo">
							<%
								for(Subject s : list) {
							%>	
									<!-- value는 subjectNo, 출력은 subjectName -->
									<option value="<%=s.getSubjectNo()%>"><%=s.getSubjectName()%></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
			</table>
			<a href="<%=request.getContextPath()%>/teacher/teacherList.jsp" class="btn btn-outline-warning">
				뒤로가기
			</a>
			<button type="submit" class="btn btn-warning">추가</button>
		</form>
	</div>
</body>
</html>