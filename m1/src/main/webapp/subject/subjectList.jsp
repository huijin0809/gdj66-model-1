<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%
	// 1. 유효성 검사
	int currentPage = 1; // 현재 페이지
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10; // 데이터를 몇개씩 출력할지 지정
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	System.out.println(currentPage + " <- subjectList currentPage");
	System.out.println(rowPerPage + " <- subjectList rowPerPage");
	
	// 2. 출력부
	// 2-1. 데이터 출력부
	int beginRow = (currentPage - 1) * rowPerPage; // 시작 글번호
	// 과목 목록(list) 조회 메서드 호출
	SubjectDao dao = new SubjectDao();
	ArrayList<Subject> list = dao.selectSubjectListByPage(beginRow, rowPerPage);
	
	// 2-2. 페이지 출력부
	int pagePerPage = 5; // 몇 페이지씩 출력할지 지정
	int beginPage = (((currentPage - 1) / pagePerPage) * pagePerPage) + 1; // 시작 페이지 번호
	int endPage = beginPage + (pagePerPage - 1); // 끝 페이지 번호
	
	int totalRow = dao.selectSubjectCnt(); // 전체 데이터 갯수 조회 메서드 호출
	int lastPage = totalRow / rowPerPage; // 마지막 페이지 번호
	if(totalRow % rowPerPage != 0) { // 나누어떨어지지 않으면
		lastPage = lastPage + 1; // 꽉 채워지지 않은 페이지 1개 추가 발생
	}
	if(endPage > lastPage) { // endPage는 lastPage보다 클 수 없다
		endPage = lastPage;
	}
	System.out.println(beginPage + " <- subjectList beginPage");
	System.out.println(endPage + " <- subjectList endPage");
	System.out.println(totalRow + " <- subjectList totalRow");
	System.out.println(lastPage + " <- subjectList lastPage");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Subject List</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container mt-5 text-center">
		<h1>과목 목록</h1>
		<!--------------- 글쓰기 버튼 출력 --------------->
		<div style="float:left;">
			<a href="<%=request.getContextPath()%>/subject/addSubject.jsp" class="btn btn-outline-secondary">
				과목 추가
			</a>
		</div>
		<!------------ rowPerPage 선택 form ------------>
		<div style="float:right;">
			<form action="<%=request.getContextPath()%>/subject/subjectList.jsp" method="post">
				<select name="rowPerPage" onchange="this.form.submit()"> <!-- 옵션 선택시 바로 submit -->
					<%
						for (int i = 5; i <= 50; i = i + 5) {
					%>
							<option value="<%=i%>" <%if (rowPerPage == i) {%> selected <%}%>>
								<%=i%>개씩
							</option>
					<%
						}
					%>
				</select>
			</form>
		</div>
		<!------------------ 데이터 출력부 ------------------>
		<table class="table container">
			<thead class="table-danger">
				<tr>
					<td>번호</td>
					<td>이름</td>
					<td>시간</td>
				</tr>
			</thead>
			<tbody>
				<%
					for(Subject s : list) {
				%>
						<tr>
							<td>
								<%=s.getSubjectNo()%>
							</td>
							<td>
								<a href="<%=request.getContextPath()%>/subject/subjectOne.jsp?subjectNo=<%=s.getSubjectNo()%>">
									<%=s.getSubjectName()%>							
								</a>
							</td>
							<td>
								<%=s.getSubjectTime()%>
							</td>
						</tr>
				<%					
					}
				%>
			</tbody>
		</table>
		<!------------------ 페이지 출력부 ------------------>
		<nav>
			<ul class="pagination justify-content-center">
				<%
					if(beginPage != 1) {
				%>
						<li class="page-item">
							<a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=beginPage - 1%>&rowPerPage=<%=rowPerPage%>" class="page-link">
								&laquo;
							</a>
						</li>
				<%
					} else { // 1페이지에서는 버튼 비활성화   
				%>
						<li class="page-item disabled">
					      <span class="page-link">&laquo;</span>
					    </li>
				<%
					}
					for(int i = beginPage; i <= endPage; i++) {
						if(i != currentPage) {
				%>
							<li class="page-item">
								<a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=i%>&rowPerPage=<%=rowPerPage%>" class="page-link">
									<%=i%>
								</a>
							</li>
				<%
						} else { // 현재 페이지에서는 버튼 비활성화
				%>
							<li class="page-item disabled">
								<span class="page-link"><%=i%></span>
							</li>
				<%
						}
					}
					if(endPage != lastPage) {
				%>
						<li class="page-item">
							<a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=endPage + 1%>&rowPerPage=<%=rowPerPage%>" class="page-link">
								&raquo;
							</a>
						</li>
				<%
					} else { // 마지막 페이지에서는 버튼 비활성화
				%>
						<li class="page-item disabled">
					      <span class="page-link">&raquo;</span>
					    </li>
				<%
					}
				%>
			</ul>
		</nav>
	</div>
</body>
</html>