package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.DBUtil;

public class TeacherSubjectDao {
	// 교사 추가시, 과목 선택하면 같이 insert (복수 선택은 아직 구현x)
	public int insertTeacherSubject(int teacherNo, int subjectNo) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO teacher_subject(teacher_no,subject_no,createdate,updatedate) VALUES(?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, teacherNo);
		stmt.setInt(2, subjectNo);
		row = stmt.executeUpdate();
		
		return row;
	}
}
