package global.dclass.team5.VO;

public class GroupBoard {
	private int groupBoardNum;// 독립게시판 부여번호
	private int groupBoardSeq;// 게시판 시퀀스 번호
	private String groupBoardId;// 아이디
	private String groupBoardTitle;// 제목
	private String groupBoardContent;// 내용
	private String groupBoardDate;// 날짜
	private int groupBoardHitcount;// 조회수
	private int recount;// 댓글개수
	private String orgname;// 원본파일
	private String savename;// 저장파일

	public GroupBoard() {
		super();
		// TODO Auto-generated constructor stub
	}

	public GroupBoard(int groupBoardNum, int groupBoardSeq, String groupBoardId, String groupBoardTitle,
			String groupBoardContent, String groupBoardDate, int groupBoardHitcount, int recount, String orgname,
			String savename) {
		super();
		this.groupBoardNum = groupBoardNum;
		this.groupBoardSeq = groupBoardSeq;
		this.groupBoardId = groupBoardId;
		this.groupBoardTitle = groupBoardTitle;
		this.groupBoardContent = groupBoardContent;
		this.groupBoardDate = groupBoardDate;
		this.groupBoardHitcount = groupBoardHitcount;
		this.recount = recount;
		this.orgname = orgname;
		this.savename = savename;
	}

	public int getGroupBoardNum() {
		return groupBoardNum;
	}

	public void setGroupBoardNum(int groupBoardNum) {
		this.groupBoardNum = groupBoardNum;
	}

	public int getGroupBoardSeq() {
		return groupBoardSeq;
	}

	public void setGroupBoardSeq(int groupBoardSeq) {
		this.groupBoardSeq = groupBoardSeq;
	}

	public String getGroupBoardId() {
		return groupBoardId;
	}

	public void setGroupBoardId(String groupBoardId) {
		this.groupBoardId = groupBoardId;
	}

	public String getGroupBoardTitle() {
		return groupBoardTitle;
	}

	public void setGroupBoardTitle(String groupBoardTitle) {
		this.groupBoardTitle = groupBoardTitle;
	}

	public String getGroupBoardContent() {
		return groupBoardContent;
	}

	public void setGroupBoardContent(String groupBoardContent) {
		this.groupBoardContent = groupBoardContent;
	}

	public String getGroupBoardDate() {
		return groupBoardDate;
	}

	public void setGroupBoardDate(String groupBoardDate) {
		this.groupBoardDate = groupBoardDate;
	}

	public int getGroupBoardHitcount() {
		return groupBoardHitcount;
	}

	public void setGroupBoardHitcount(int groupBoardHitcount) {
		this.groupBoardHitcount = groupBoardHitcount;
	}

	public int getRecount() {
		return recount;
	}

	public void setRecount(int recount) {
		this.recount = recount;
	}

	public String getOrgname() {
		return orgname;
	}

	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	public String getSavename() {
		return savename;
	}

	public void setSavename(String savename) {
		this.savename = savename;
	}

	@Override
	public String toString() {
		return "GroupBoard [groupBoardNum=" + groupBoardNum + ", groupBoardSeq=" + groupBoardSeq + ", groupBoardId="
				+ groupBoardId + ", groupBoardTitle=" + groupBoardTitle + ", groupBoardContent=" + groupBoardContent
				+ ", groupBoardDate=" + groupBoardDate + ", groupBoardHitcount=" + groupBoardHitcount + ", recount="
				+ recount + ", orgname=" + orgname + ", savename=" + savename + "]";
	}

}
