<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	// 1. 유효성 검사
	if(request.getParameter("teacherNo") == null
			|| request.getParameter("teacherNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/teacher/teacherList.jsp");
		return;
	}
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	System.out.println(teacherNo + " <- removeTeacherAction teacherNo");
	
	// 2. delete // 메서드 호출
	TeacherDao dao = new TeacherDao();
	int row = dao.deleteTeacher(teacherNo);
	System.out.println(row + " <- removeTeacherAction row");
	
	// 3. 리다이렉션
	String msg = null;
	if(row == 1) { // delete 성공
		System.out.println("removeTeacherAction 성공");
		msg = URLEncoder.encode("교사가 삭제되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath() + "/teacher/teacherList.jsp?msg=" + msg);
		return;
	} else { // delete 실패
		System.out.println("removeTeacherAction 실패");
		msg = URLEncoder.encode("교사가 삭제되지 않았습니다 다시 시도해주세요", "utf-8");
		response.sendRedirect(request.getContextPath() + "/teacher/teacherOne.jsp?teacherNo=" + teacherNo + "&msg=" + msg);
		return;
	}
%>