<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 한글 깨지지 않게 인코딩
	request.setCharacterEncoding("utf-8");

	// 1. 유효성 검사
	String msg = null;
	if(request.getParameter("teacherId") == null
			|| request.getParameter("teacherId").equals("")) {
		msg = URLEncoder.encode("교사 아이디를 입력해주세요", "utf-8");
	} else if(request.getParameter("teacherName") == null
			|| request.getParameter("teacherName").equals("")) {
		msg = URLEncoder.encode("이름을 입력해주세요", "utf-8");
	} else if(request.getParameter("teacherHistory") == null
			|| request.getParameter("teacherHistory").equals("")) {
		msg = URLEncoder.encode("연혁을 입력해주세요", "utf-8");
	} else if(request.getParameter("subjectNo") == null
			|| request.getParameter("subjectNo").equals("")) {
		msg = URLEncoder.encode("담당과목을 선택해주세요", "utf-8");
	}
	if(msg != null) {
		response.sendRedirect(request.getContextPath() + "/teacher/addTeacher.jsp?msg=" + msg);
		return;
	}
	String teacherId = request.getParameter("teacherId");
	String teacherName = request.getParameter("teacherName");
	String teacherHistory = request.getParameter("teacherHistory");
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	System.out.println(teacherId + " <- addTeacherAction teacherId");
	System.out.println(teacherName + " <- addTeacherAction teacherName");
	System.out.println(teacherHistory + " <- addTeacherAction teacherHistory");
	System.out.println(subjectNo + " <- addTeacherAction subjectNo");
	
	// Teacher 객체에 값 저장
	Teacher teacher = new Teacher();
	teacher.setTeacherId(teacherId);
	teacher.setTeacherName(teacherName);
	teacher.setTeacherHistory(teacherHistory);

	// 2. insert
	// 2-1) teacher
	TeacherDao dao = new TeacherDao();
	int[] rowAndKey = dao.insertTeacher(teacher);
	// row와 teacherNo값 불러오기
	int row = rowAndKey[0];
	int teacherNo = rowAndKey[1]; // teacherSubject insert 할 때와 insert 성공시 교사 상세페이지로 리다이렉션할 때 사용
	
	// 2-2) teacher_subject
	TeacherSubjectDao dao2 = new TeacherSubjectDao();
	int row2 = dao2.insertTeacherSubject(teacherNo, subjectNo);
	
	// 3. 리다이렉션
	if(row == 1 && row2 == 1) { // insert 성공시
		System.out.println("addTeacherAction 성공");
		msg = URLEncoder.encode("교사가 추가되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath() + "/teacher/teacherOne.jsp?teacherNo=" + teacherNo + "&msg=" + msg);
		return;
	} else { // insert 실패시
		System.out.println("addTeacherAction 실패");
		msg = URLEncoder.encode("교사가 추가되지 않았습니다 다시 시도해주세요", "utf-8");
		response.sendRedirect(request.getContextPath() + "/teacher/addTeacher.jsp?msg=" + msg);
		return;
	}
%>