package global.dclass.team5.VO;

public class EveryBoardComments {
	
	private int everyBoardCommentSeq;
	private int everyBoardSeq;
	private String id;
	private String everyBoardComment;
	private String everyBoardCommentDate;
	
	public EveryBoardComments() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	
	
	public String getEveryBoardCommentDate() {
		return everyBoardCommentDate;
	}




	public void setEveryBoardCommentDate(String everyBoardCommentDate) {
		this.everyBoardCommentDate = everyBoardCommentDate;
	}




	public int getEveryBoardCommentSeq() {
		return everyBoardCommentSeq;
	}

	public void setEveryBoardCommentSeq(int everyBoardCommentSeq) {
		this.everyBoardCommentSeq = everyBoardCommentSeq;
	}

	public int getEveryBoardSeq() {
		return everyBoardSeq;
	}

	public void setEveryBoardSeq(int everyBoardSeq) {
		this.everyBoardSeq = everyBoardSeq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getEveryBoardComment() {
		return everyBoardComment;
	}

	public void setEveryBoardComment(String everyBoardComment) {
		this.everyBoardComment = everyBoardComment;
	}




	public EveryBoardComments(int everyBoardCommentSeq, int everyBoardSeq, String id, String everyBoardComment,
			String everyBoardCommentDate) {
		super();
		this.everyBoardCommentSeq = everyBoardCommentSeq;
		this.everyBoardSeq = everyBoardSeq;
		this.id = id;
		this.everyBoardComment = everyBoardComment;
		this.everyBoardCommentDate = everyBoardCommentDate;
	}




	@Override
	public String toString() {
		return "EveryBoardComments [everyBoardCommentSeq=" + everyBoardCommentSeq + ", everyBoardSeq=" + everyBoardSeq
				+ ", id=" + id + ", everyBoardComment=" + everyBoardComment + ", everyBoardCommentDate="
				+ everyBoardCommentDate + "]";
	}
	
	
	


}
