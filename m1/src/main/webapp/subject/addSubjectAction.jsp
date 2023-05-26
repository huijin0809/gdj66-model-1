<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*"%>
<%
	// 한글 깨지지 않게 인코딩
	request.setCharacterEncoding("utf-8");

	// 1. 유효성 검사
	String msg = null;
	if(request.getParameter("subjectName") == null
			|| request.getParameter("subjectName").equals("")) {
		msg = URLEncoder.encode("과목 이름을 입력해주세요", "utf-8");
	} else if (request.getParameter("subjectTime") == null
			|| request.getParameter("subjectTime").equals("")) {
		msg = URLEncoder.encode("시간을 입력해주세요", "utf-8");
	}
	if(msg != null) {
		response.sendRedirect(request.getContextPath() + "/subject/addSubject.jsp?msg=" + msg);
		return;
	}
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	System.out.println(subjectName + " <- addSubjectAction subjectName");
	System.out.println(subjectTime + " <- addSubjectAction subjectTime");
	
	// 객체에 값 저장
	Subject subject = new Subject();
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	
	// 2. insert
	SubjectDao dao = new SubjectDao(); // 과목 메서드 호출
	int[] rowAndKey = dao.insertSubject(subject);
	// row값과 subjectNo값 불러오기
	int row = rowAndKey[0];
	int subjectNo = rowAndKey[1]; // insert 성공시 생성된 과목의 상세페이지로 리다이렉션할 때 사용
	
	// 3. 리다이렉션
	if(row == 1) { // insert 성공시
		System.out.println("addSubjectAction 성공");
		msg = URLEncoder.encode("과목이 추가되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath() + "/subject/subjectOne.jsp?subjectNo=" + subjectNo + "&msg=" + msg);
		return;
	} else { // insert 실패시
		System.out.println("addSubjectAction 실패");
		msg = URLEncoder.encode("과목이 추가되지 않았습니다 다시 시도해주세요", "utf-8");
		response.sendRedirect(request.getContextPath() + "/subject/addSubject.jsp?msg=" + msg);
		return;
	}
%>