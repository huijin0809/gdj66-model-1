<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 한글 깨지지 않게 인코딩
	request.setCharacterEncoding("utf-8");

	// 1. 유효성 검사
	// subjectNo
	if(request.getParameter("subjectNo") == null
			|| request.getParameter("subjectNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");
		return;
	}
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	System.out.println(subjectNo + " <- modifySubjectAction subjectNo");
	
	// subjectName, subjectTime
	String msg = null;
	if(request.getParameter("subjectName") == null
			|| request.getParameter("subjectName").equals("")) {
		msg = URLEncoder.encode("과목 이름을 입력해주세요", "utf-8");
	} else if(request.getParameter("subjectTime") == null
			|| request.getParameter("subjectTime").equals("")) {
		msg = URLEncoder.encode("시간을 입력해주세요", "utf-8");			
	}
	if(msg != null) {
		response.sendRedirect(request.getContextPath() + "/subject/modifySubject.jsp?subjectNo=" + subjectNo + "&msg=" + msg);
		return;
	}
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	System.out.println(subjectName + " <- modifySubjectAction subjectName");
	System.out.println(subjectTime + " <- modifySubjectAction subjectTime");
	
	// 객체에 값 저장
	Subject subject = new Subject();
	subject.setSubjectNo(subjectNo);
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	
	// 2. update
	// 과목 수정 메서드 호출
	SubjectDao dao = new SubjectDao();
	int row = dao.updateSubject(subject);
	System.out.println(row + " <- modifySubjectAction row");
	
	// 3. 리다이렉션
	if(row == 1) { // update 성공시
		System.out.println("modifySubjectAction 성공");
		msg = URLEncoder.encode("과목이 정상적으로 수정되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath() + "/subject/subjectOne.jsp?subjectNo=" + subjectNo + "&msg=" + msg);
		return;
	} else { // update 실패시
		System.out.println("modifySubjectAction 실패");
		msg = URLEncoder.encode("과목이 수정되지 않았습니다 다시 시도해주세요", "utf-8");
		response.sendRedirect(request.getContextPath() + "/subject/modifySubject.jsp?subjectNo=" + subjectNo + "&msg=" + msg);
		return;
	}
%>