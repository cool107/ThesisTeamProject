package global.dclass.team5.VO;

public class GroupBoardComments {
	private int groupBoardNum;//개별 부여된 게시판
	private int groupBoardCommentSeq;//리플번호
	private int groupBoardSeq;//게시판번호
	private String gbcid;//아이디
	private String groupBoardComment;//리플내용
	private String groupBoardCommentDate;//리플단날짜

	public GroupBoardComments() {
		super();
		// TODO Auto-generated constructor stub
	}

	public GroupBoardComments(int groupBoardNum, int groupBoardCommentSeq, int groupBoardSeq, String gbcid,
			String groupBoardComment, String groupBoardCommentDate) {
		super();
		this.groupBoardNum = groupBoardNum;
		this.groupBoardCommentSeq = groupBoardCommentSeq;
		this.groupBoardSeq = groupBoardSeq;
		this.gbcid = gbcid;
		this.groupBoardComment = groupBoardComment;
		this.groupBoardCommentDate = groupBoardCommentDate;
	}

	public int getGroupBoardNum() {
		return groupBoardNum;
	}

	public void setGroupBoardNum(int groupBoardNum) {
		this.groupBoardNum = groupBoardNum;
	}

	public int getGroupBoardCommentSeq() {
		return groupBoardCommentSeq;
	}

	public void setGroupBoardCommentSeq(int groupBoardCommentSeq) {
		this.groupBoardCommentSeq = groupBoardCommentSeq;
	}

	public int getGroupBoardSeq() {
		return groupBoardSeq;
	}

	public void setGroupBoardSeq(int groupBoardSeq) {
		this.groupBoardSeq = groupBoardSeq;
	}

	public String getGbcid() {
		return gbcid;
	}

	public void setGbcid(String gbcid) {
		this.gbcid = gbcid;
	}

	public String getGroupBoardComment() {
		return groupBoardComment;
	}

	public void setGroupBoardComment(String groupBoardComment) {
		this.groupBoardComment = groupBoardComment;
	}

	public String getGroupBoardCommentDate() {
		return groupBoardCommentDate;
	}

	public void setGroupBoardCommentDate(String groupBoardCommentDate) {
		this.groupBoardCommentDate = groupBoardCommentDate;
	}

	@Override
	public String toString() {
		return "GroupBoardComments [groupBoardNum=" + groupBoardNum + ", groupBoardCommentSeq=" + groupBoardCommentSeq
				+ ", groupBoardSeq=" + groupBoardSeq + ", gbcid=" + gbcid + ", groupBoardComment=" + groupBoardComment
				+ ", groupBoardCommentDate=" + groupBoardCommentDate + "]";
	}

}
