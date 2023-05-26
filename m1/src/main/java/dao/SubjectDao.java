package dao;
import java.sql.*;
import java.util.*;
import vo.*;
import util.DBUtil;

public class SubjectDao {
	// 1) 과목 목록(list) 조회 // + 페이징
	public ArrayList<Subject> selectSubjectListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Subject> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT subject_no subjectNo, subject_name subjectName, subject_time subjectTime FROM subject ORDER BY subject_no DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Subject s = new Subject();
			s.setSubjectNo(rs.getInt("subjectNo"));
			s.setSubjectName(rs.getString("subjectName"));
			s.setSubjectTime(rs.getInt("subjectTime"));
			list.add(s);
		}
		
		return list;
	}
	
	// 2) 과목 상세보기(One)
	public Subject selectSubjectOne(int subjectNo) throws Exception {
		Subject subject = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT subject_no subjectNo, subject_name subjectName, subject_time subjectTime, createdate, updatedate FROM subject WHERE subject_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, subjectNo);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			subject = new Subject();
			subject.setSubjectNo(rs.getInt("subjectNo"));
			subject.setSubjectName(rs.getString("subjectName"));
			subject.setSubjectTime(rs.getInt("subjectTime"));
			subject.setCreatedate(rs.getString("createdate"));
			subject.setUpdatedate(rs.getString("updatedate"));
		}
		return subject;
	}
	
	// 3) 과목 추가
	public int[] insertSubject(Subject subject) throws Exception {
		int[] rowAndKey = new int[2];
		
		String subjectName = subject.getSubjectName();
		int subjectTime = subject.getSubjectTime();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO subject(subject_name, subject_time, createdate, updatedate) VALUES(?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
		// RETURN_GENERATED_KEYS -> 방금 insert한 키 값을 받아올 수 있다
		stmt.setString(1, subjectName);
		stmt.setInt(2, subjectTime);
		int row = stmt.executeUpdate();
		rowAndKey[0] = row; // 배열에 row값 넣기
		
		// 키 값(subjectNo) 받아오기 // insert 성공시 생성된 과목의 상세페이지로 리다이렉션할 때 사용
		ResultSet rs = stmt.getGeneratedKeys(); // getGeneratedKeys() 메서드로 키값 호출
		int subjectNo = 0;
		if(rs.next()) {
			subjectNo = rs.getInt(1);
		}
		rowAndKey[1] = subjectNo; // 배열에 subjectNo값 넣기
		
		return rowAndKey;
	}
	
	// 4) 과목 수정
	public int updateSubject(Subject subject) throws Exception {
		int row = 0;
		
		int subjectNo = subject.getSubjectNo();
		String subjectName = subject.getSubjectName();
		int subjectTime = subject.getSubjectTime();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE subject SET subject_name = ?, subject_time = ?, updatedate = NOW() WHERE subject_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, subjectNo);
		stmt.setString(2, subjectName);
		stmt.setInt(3, subjectTime);
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 5) 과목 삭제
	public int deleteSubject(int subjectNo) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM subject WHERE subject_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, subjectNo);
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 6) 전체 과목 수(totalRow)
	public int selectSubjectCnt() throws Exception {
		int totalRow = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM subject";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalRow = rs.getInt(1);
		}
		
		return totalRow;
	}
}
