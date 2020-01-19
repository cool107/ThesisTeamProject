package global.dclass.team5.VO;

public class Thesis {
	private int thesisSeq ;
	private String thesisTitle;
	private String thesisAuthor;
	private String thesisDate;
	private String thesisAbstract;
	private String thesisLink;
	private String thesisOrgname;
	private String thesisSavename;
	private String department;
	private String degree;
	
	public Thesis() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Thesis(int thesisSeq, String thesisTitle, String thesisAuthor, String thesisDate, String thesisAbstract,
			String thesisLink, String thesisOrgname, String thesisSavename, String department, String degree) {
		super();
		this.thesisSeq = thesisSeq;
		this.thesisTitle = thesisTitle;
		this.thesisAuthor = thesisAuthor;
		this.thesisDate = thesisDate;
		this.thesisAbstract = thesisAbstract;
		this.thesisLink = thesisLink;
		this.thesisOrgname = thesisOrgname;
		this.thesisSavename = thesisSavename;
		this.department = department;
		this.degree = degree;
	}

	public int getThesisSeq() {
		return thesisSeq;
	}

	public void setThesisSeq(int thesisSeq) {
		this.thesisSeq = thesisSeq;
	}

	public String getThesisTitle() {
		return thesisTitle;
	}

	public void setThesisTitle(String thesisTitle) {
		this.thesisTitle = thesisTitle;
	}

	public String getThesisAuthor() {
		return thesisAuthor;
	}

	public void setThesisAuthor(String thesisAuthor) {
		this.thesisAuthor = thesisAuthor;
	}

	public String getThesisDate() {
		return thesisDate;
	}

	public void setThesisDate(String thesisDate) {
		this.thesisDate = thesisDate;
	}

	public String getThesisAbstract() {
		return thesisAbstract;
	}

	public void setThesisAbstract(String thesisAbstract) {
		this.thesisAbstract = thesisAbstract;
	}

	public String getThesisLink() {
		return thesisLink;
	}

	public void setThesisLink(String thesisLink) {
		this.thesisLink = thesisLink;
	}

	public String getThesisOrgname() {
		return thesisOrgname;
	}

	public void setThesisOrgname(String thesisOrgname) {
		this.thesisOrgname = thesisOrgname;
	}

	public String getThesisSavename() {
		return thesisSavename;
	}

	public void setThesisSavename(String thesisSavename) {
		this.thesisSavename = thesisSavename;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getDegree() {
		return degree;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}

	@Override
	public String toString() {
		return "Thesis [thesisSeq=" + thesisSeq + ", thesisTitle=" + thesisTitle + ", thesisAuthor=" + thesisAuthor
				+ ", thesisDate=" + thesisDate + ", thesisAbstract=" + thesisAbstract + ", thesisLink=" + thesisLink
				+ ", thesisOrgname=" + thesisOrgname + ", thesisSavename=" + thesisSavename + ", department="
				+ department + ", degree=" + degree + "]";
	}
	
}
