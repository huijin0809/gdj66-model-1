package vo;

public class TeacherSubject {
	private int teacherSubjectNo;
	private int teacherNo;
	private int subjectNo;
	private String createdate;
	private String updatedate;
	
	public int getTeacherSubjectNo() {
		return teacherSubjectNo;
	}
	public void setTeacherSubjectNo(int teacherSubjectNo) {
		this.teacherSubjectNo = teacherSubjectNo;
	}
	public int getTeacherNo() {
		return teacherNo;
	}
	public void setTeacherNo(int teacherNo) {
		this.teacherNo = teacherNo;
	}
	public int getSubjectNo() {
		return subjectNo;
	}
	public void setSubjectNo(int subjectNo) {
		this.subjectNo = subjectNo;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
}
