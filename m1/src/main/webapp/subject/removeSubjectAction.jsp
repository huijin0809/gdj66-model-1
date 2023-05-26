<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="java.net.*" %>
<%
	// 1. 유효성 검사
	if(request.getParameter("subjectNo") == null
			|| request.getParameter("subjectNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");
		return;
	}
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	System.out.println(subjectNo + " <- removeSubjectAction subjectNo");
	
	// 2. delete
	// 과목 삭제 메서드 호출
	SubjectDao dao = new SubjectDao();
	int row = dao.deleteSubject(subjectNo);
	System.out.println(row + " <- removeSubjectAction row");
	
	// 3. 리다이렉션
	String msg = null;
	if(row == 1) { // delete 성공시
		System.out.println("removeSubjectAction 성공");
		msg = URLEncoder.encode("과목이 삭제되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp?msg=" + msg);
		return;
	} else {
		System.out.println("removeSubjectAction 실패");
		msg = URLEncoder.encode("과목이 삭제되지 않았습니다 다시 시도해주세요","utf-8");
		response.sendRedirect(request.getContextPath() + "/subject/subjectOne.jsp?subjectNo=" + subjectNo + "&msg=" + msg);
		return;
	}
%>