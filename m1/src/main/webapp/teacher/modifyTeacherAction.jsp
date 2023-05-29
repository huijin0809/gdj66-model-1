<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// 한글 깨지지 않게 인코딩
	request.setCharacterEncoding("utf-8");

	// 1. 유효성 검사
	// teahcerNo
	if(request.getParameter("teacherNo") == null
			|| request.getParameter("teacherNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/teacher/teacherList.jsp");
		return;
	}
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	System.out.println(teacherNo + " <- modifyTeahcerAction teacherNo");
	
	// teahcerId, teahcerName, teacherHistory
	String msg = null;
	if(request.getParameter("teacherId") == null
			|| request.getParameter("teacherId").equals("")) {
		msg = URLEncoder.encode("아이디를 입력해주세요", "utf-8");
	} else if(request.getParameter("teacherName") == null
			|| request.getParameter("teacherName").equals("")) {
		msg = URLEncoder.encode("이름을 입력해주세요", "utf-8");
	} else if(request.getParameter("teacherHistory") == null
			|| request.getParameter("teacherHistory").equals("")) {
		msg = URLEncoder.encode("연혁을 입력해주세요", "utf-8");
	}
	if(msg != null) {
		response.sendRedirect(request.getContextPath() + "/teacher/modifyTeacher.jsp?teacherNo=" + teacherNo + "&msg=" + msg);
		return;
	}
	String teacherId = request.getParameter("teacherId");
	String teacherName = request.getParameter("teacherName");
	String teacherHistory = request.getParameter("teacherHistory");
	System.out.println(teacherId + " <- modifyTeacherAction teacherId");
	System.out.println(teacherName + " <- modifyTeacherAction teacherName");
	System.out.println(teacherHistory + " <- modifyTeacherAction teacherHistory");
	
	// 객체에 값 저장
	Teacher teacher = new Teacher();
	teacher.setTeacherNo(teacherNo);
	teacher.setTeacherId(teacherId);
	teacher.setTeacherName(teacherName);
	teacher.setTeacherHistory(teacherHistory);
	
	// 2. update // 메서드 호출
	TeacherDao dao = new TeacherDao();
	int row = dao.updateTeacher(teacher);
	System.out.println(row + " <- modifyTeacherAction row");
	
	// 3. 리다이렉션
	if(row == 1) { // update 성공
		System.out.println("modifyTeacherAction 성공");
		msg = URLEncoder.encode("교사 정보가 수정되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath() + "/teacher/teacherOne.jsp?teacherNo=" + teacherNo + "&msg=" + msg);
		return;
	} else { // update 실패
		System.out.println("modifyTeacherAction 실패");
		msg = URLEncoder.encode("교사 정보가 수정되지 않았습니다 다시 시도해주세요", "utf-8");
		response.sendRedirect(request.getContextPath() + "/teacher/modifyTeacher.jsp?teacherNo=" + teacherNo + "&msg=" + msg);
		return;
	}
%>