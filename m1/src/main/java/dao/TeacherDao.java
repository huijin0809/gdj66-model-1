package dao;
import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.*;

public class TeacherDao {
	// 1) 교사 리스트 조회 (+ 담당하는 과목 한 행에 같이 출력) (+ 페이징)
	/*
		SELECT
			t.teacher_no teacherNo,
			t.teacher_id teacherId,
			t.teacher_name teacherName,
			NVL(GROUP_CONCAT(s.subject_name), ' ') subjectName
			// GROUP_CONCAT -> 담당하는 과목을 한 행에 같이 출력, 문자열을 집계하는 함수
			// NVL -> 담당과목이 NULL이면 공백으로 출력
		FROM teacher t
		LEFT JOIN teacher_subject ts
		// LEFT JOIN -> 담당과목이 없는 교사도 출력하기 위해 LEFT JOIN 사용
		ON t.teacher_no = ts.teacher_no
			LEFT JOIN subject s
			ON ts.subject_no = s.subject_no
		GROUP BY t.teacher_no, t.teacher_id, t.teacher_name
		LIMIT ?, ?
	*/
	public ArrayList<HashMap<String, Object>> selectTeacherListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT t.teacher_no teacherNo, t.teacher_id teacherId, t.teacher_name teacherName, NVL(GROUP_CONCAT(s.subject_name), ' ') subjectName FROM teacher t LEFT JOIN teacher_subject ts ON t.teacher_no = ts.teacher_no LEFT JOIN subject s ON ts.subject_no = s.subject_no GROUP BY t.teacher_no, t.teacher_id, t.teacher_name LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("teacherNo", rs.getInt("teacherNo"));
			m.put("teacherId", rs.getString("teacherId"));
			m.put("teacherName", rs.getString("teacherName"));
			m.put("subjectName", rs.getString("subjectName"));
			list.add(m);
		}
		
		return list;
	}
	
	// 2) 교사 상세보기(One)
	public Teacher selectTeacherOne(int teacherNo) throws Exception {
		Teacher teacher = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT teacher_no teacherNo, teacher_id teacherId, teacher_name teacherName, teacher_history teacherHistory, createdate, updatedate FROM teacher WHERE teacher_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, teacherNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			teacher = new Teacher();
			teacher.setTeacherNo(rs.getInt("teacherNo"));
			teacher.setTeacherId(rs.getString("teacherId"));
			teacher.setTeacherName(rs.getString("teacherName"));
			teacher.setTeacherHistory(rs.getString("teacherHistory"));
			teacher.setCreatedate(rs.getString("createdate"));
			teacher.setUpdatedate(rs.getString("updatedate"));
		}
		return teacher;
	}
	
	// 3) 교사 추가
	public int[] insertTeacher(Teacher teacher) throws Exception {
		int[] rowAndKey = new int[2];
		
		String teacherId = teacher.getTeacherId();
		String teahcerName = teacher.getTeacherName();
		String teahcerHistory = teacher.getTeacherHistory();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO teacher(teacher_id, teacher_name, teacher_history, createdate, updatedate) VALUES(?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
		// RETURN_GENERATED_KEYS -> 방금 insert한 키 값을 받아올 수 있다
		stmt.setString(1, teacherId);
		stmt.setString(2, teahcerName);
		stmt.setString(3, teahcerHistory);
		int row = stmt.executeUpdate();
		rowAndKey[0] = row; // 배열에 row값 넣기
		
		// 키 값(teacherNo) 받아오기
		// teacherSubject insert 할 때와 insert 성공시 교사 상세페이지로 리다이렉션할 때 사용
		ResultSet rs = stmt.getGeneratedKeys(); // getGeneratedKeys() 메서드로 키값 호출
		int teacherNo = 0;
		if(rs.next()) {
			teacherNo = rs.getInt(1);
		}
		rowAndKey[1] = teacherNo;
		
		return rowAndKey;
	}
	
	// 4) 교사 수정
	public int updateTeacher(Teacher teacher) throws Exception {
		int row = 0;
		
		int teacherNo = teacher.getTeacherNo();
		String teacherId = teacher.getTeacherId();
		String teahcerName = teacher.getTeacherName();
		String teahcerHistory = teacher.getTeacherHistory();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE teacher SET teacher_id = ?, teacher_name = ?, teacher_history = ?, updatedate = NOW() WHERE teacher_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, teacherId);
		stmt.setString(2, teahcerName);
		stmt.setString(3, teahcerHistory);
		stmt.setInt(4, teacherNo);
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 5) 교사 삭제
	public int deleteTeacher(int teacherNo) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM teacher WHERE teacher_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, teacherNo);
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 6) 전체 교사 수 (totalRow)
	public int selectTeacherCnt() throws Exception {
		int totalRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM teacher";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalRow = rs.getInt(1);
		}
		
		return totalRow;
	}
}
