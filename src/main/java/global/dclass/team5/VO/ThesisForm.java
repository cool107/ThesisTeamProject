package global.dclass.team5.VO;

public class ThesisForm {
	private String department;
	private String thesisForm;
	
	public ThesisForm() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ThesisForm(String department, String thesisForm) {
		super();
		this.department = department;
		this.thesisForm = thesisForm;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getThesisForm() {
		return thesisForm;
	}

	public void setThesisForm(String thesisForm) {
		this.thesisForm = thesisForm;
	}

	@Override
	public String toString() {
		return "ThesisForm [department=" + department + ", thesisForm=" + thesisForm + "]";
	}
	
}
