package global.dclass.team5.VO;

public class GroupBoardInfo {
	private int groupBoardNum;
	private String groupBoardId;
	private String groupBoardPw;
	
	public GroupBoardInfo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public GroupBoardInfo(int groupBoardNum, String groupBoardId, String groupBoardPw) {
		super();
		this.groupBoardNum = groupBoardNum;
		this.groupBoardId = groupBoardId;
		this.groupBoardPw = groupBoardPw;
	}

	public int getGroupBoardNum() {
		return groupBoardNum;
	}

	public void setGroupBoardNum(int groupBoardNum) {
		this.groupBoardNum = groupBoardNum;
	}

	public String getGroupBoardId() {
		return groupBoardId;
	}

	public void setGroupBoardId(String groupBoardId) {
		this.groupBoardId = groupBoardId;
	}

	public String getGroupBoardPw() {
		return groupBoardPw;
	}

	public void setGroupBoardPw(String groupBoardPw) {
		this.groupBoardPw = groupBoardPw;
	}

	@Override
	public String toString() {
		return "GroupBoardInfo [groupBoardNum=" + groupBoardNum + ", groupBoardId=" + groupBoardId + ", groupBoardPw="
				+ groupBoardPw + "]";
	}
	
}
