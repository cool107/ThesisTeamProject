package global.dclass.team5.VO;

public class Application {
	private int applicationSeq;
	private String id;
	private String member1;
	private String member2;
	private String member3;
	private String member4;
	private int memberNum;
	private int memberCheck;
	private int adminCheck;
	private String applicationDate;
	
	public Application() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Application(int applicationSeq, String id, String member1, String member2, String member3, String member4,
			int memberNum, int memberCheck, int adminCheck, String applicationDate) {
		super();
		this.applicationSeq = applicationSeq;
		this.id = id;
		this.member1 = member1;
		this.member2 = member2;
		this.member3 = member3;
		this.member4 = member4;
		this.memberNum = memberNum;
		this.memberCheck = memberCheck;
		this.adminCheck = adminCheck;
		this.applicationDate = applicationDate;
	}

	public int getApplicationSeq() {
		return applicationSeq;
	}

	public void setApplicationSeq(int applicationSeq) {
		this.applicationSeq = applicationSeq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMember1() {
		return member1;
	}

	public void setMember1(String member1) {
		this.member1 = member1;
	}

	public String getMember2() {
		return member2;
	}

	public void setMember2(String member2) {
		this.member2 = member2;
	}

	public String getMember3() {
		return member3;
	}

	public void setMember3(String member3) {
		this.member3 = member3;
	}

	public String getMember4() {
		return member4;
	}

	public void setMember4(String member4) {
		this.member4 = member4;
	}

	public int getMemberNum() {
		return memberNum;
	}

	public void setMemberNum(int memberNum) {
		this.memberNum = memberNum;
	}

	public int getMemberCheck() {
		return memberCheck;
	}

	public void setMemberCheck(int memberCheck) {
		this.memberCheck = memberCheck;
	}

	public int getAdminCheck() {
		return adminCheck;
	}

	public void setAdminCheck(int adminCheck) {
		this.adminCheck = adminCheck;
	}

	public String getApplicationDate() {
		return applicationDate;
	}

	public void setApplicationDate(String applicationDate) {
		this.applicationDate = applicationDate;
	}

	@Override
	public String toString() {
		return "Application [applicationSeq=" + applicationSeq + ", id=" + id + ", member1=" + member1 + ", member2="
				+ member2 + ", member3=" + member3 + ", member4=" + member4 + ", memberNum=" + memberNum
				+ ", memberCheck=" + memberCheck + ", adminCheck=" + adminCheck + ", applicationDate=" + applicationDate
				+ "]";
	}
	
}
