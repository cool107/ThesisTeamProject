package global.dclass.team5.VO;

public class Member {
	private String id;
	private String pw;
	private String name;
	private String department;
	private int groupBoardNum; 
	private String division;
	private String indate;
	
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getPw() {
		return pw;
	}


	public void setPw(String pw) {
		this.pw = pw;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getDepartment() {
		return department;
	}


	public void setDepartment(String department) {
		this.department = department;
	}


	public String getDivision() {
		return division;
	}


	public void setDivision(String division) {
		this.division = division;
	}


	public String getIndate() {
		return indate;
	}


	public void setIndate(String indate) {
		this.indate = indate;
	}

	public int getGroupBoardNum() {
		return groupBoardNum;
	}


	public void setGroupBoardNum(int groupBoardNum) {
		this.groupBoardNum = groupBoardNum;
	}


	@Override
	public String toString() {

		return "Member [id=" + id + ", pw=" + pw + ", name=" + name + ", department=" + department + ", groupBoardNum="
				+ groupBoardNum + ", division=" + division + ", indate=" + indate + "]";
	}

}
