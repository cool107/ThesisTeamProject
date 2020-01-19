package global.dclass.team5.VO;

public class ThesisTemp {
	private int seq_thesistemp;
	private String thesisTitle;
	private String thesisAbstract;
	private String editor;
	private int groupBoardNum;
	private String thesistempdate;
	private String thesisorgname;
	private String thesissavename;
	private int submit;
	private String teamName;
	private String department;
	private String degree;
	private int thesisComplete;
	
	
	public ThesisTemp() {
		
	}

	public int getThesisComplete() {
		return thesisComplete;
	}

	public void setThesisComplete(int thesisComplete) {
		this.thesisComplete = thesisComplete;
	}

	public String getTeamName() {
		return teamName;
	}

	public String getDegree() {
		return degree;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public void setTeamName(String teamMember) {
		this.teamName = teamMember;
	}

	public ThesisTemp(int seq_thesistemp, String thesisTitle, String thesisAbstract, String editor, int groupBoardNum,
			String thesistempdate, String thesisorgname, String thesissavename, int submit,
			String teamName, String department, String degree, int thesisComplete) {
		super();
		this.seq_thesistemp = seq_thesistemp;
		this.thesisTitle = thesisTitle;
		this.thesisAbstract = thesisAbstract;
		this.editor = editor;
		this.groupBoardNum = groupBoardNum;
		this.thesistempdate = thesistempdate;
		this.thesisorgname = thesisorgname;
		this.thesissavename = thesissavename;
		this.submit = submit;
		this.teamName = teamName;
		this.department = department;
		this.degree = degree;
		this.thesisComplete = thesisComplete;
	}


	public int getSeq_thesistemp() {
		return seq_thesistemp;
	}

	public void setSeq_thesistemp(int seq_thesistemp) {
		this.seq_thesistemp = seq_thesistemp;
	}

	public String getThesisTitle() {
		return thesisTitle;
	}

	public void setThesisTitle(String thesisTitle) {
		this.thesisTitle = thesisTitle;
	}

	public String getThesisAbstract() {
		return thesisAbstract;
	}

	public void setThesisAbstract(String thesisAbstract) {
		this.thesisAbstract = thesisAbstract;
	}

	public String getEditor() {
		return editor;
	}

	public void setEditor(String editor) {
		this.editor = editor;
	}

	public int getGroupBoardNum() {
		return groupBoardNum;
	}

	public void setGroupBoardNum(int groupBoardNum) {
		this.groupBoardNum = groupBoardNum;
	}

	public String getThesistempdate() {
		return thesistempdate;
	}

	public void setThesistempdate(String thesistempdate) {
		this.thesistempdate = thesistempdate;
	}

	public String getThesisorgname() {
		return thesisorgname;
	}

	public void setThesisorgname(String thesisorgname) {
		this.thesisorgname = thesisorgname;
	}

	public String getThesissavename() {
		return thesissavename;
	}

	public void setThesissavename(String thesissavename) {
		this.thesissavename = thesissavename;
	}

	public int getSubmit() {
		return submit;
	}

	public void setSubmit(int submit) {
		this.submit = submit;
	}

	@Override
	public String toString() {
		return "ThesisTemp [seq_thesistemp=" + seq_thesistemp + ", thesisTitle=" + thesisTitle + ", thesisAbstract="
				+ thesisAbstract + ", editor=" + editor + ", groupBoardNum=" + groupBoardNum + ", thesistempdate="
				+ thesistempdate + ", thesisorgname=" + thesisorgname + ", thesissavename=" + thesissavename
				+ ", submit=" + submit + ", teamName=" + teamName + ", department=" + department + ", degree=" + degree
				+ ", thesisComplete=" + thesisComplete + "]";
	}

}
