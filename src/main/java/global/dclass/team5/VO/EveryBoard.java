package global.dclass.team5.VO;

public class EveryBoard {
	private int everyBoardSeq;
	private String id;
	private String everyBoardTitle;
	private String everyBoardContent;
	private String everyBoardDate;
	private int everyBoardHitcount;
	private String everyBoardOrgname;
	private String everyBoardSavename;
	private int recount;
	
	public EveryBoard() {
		super();
		// TODO Auto-generated constructor stub
	}

	public EveryBoard(int everyBoardSeq, String id, String everyBoardTitle, String everyBoardContent,
			String everyBoardDate, int everyBoardHitcount, String everyBoardOrgname, String everyBoardSavename,
			int recount) {
		super();
		this.everyBoardSeq = everyBoardSeq;
		this.id = id;
		this.everyBoardTitle = everyBoardTitle;
		this.everyBoardContent = everyBoardContent;
		this.everyBoardDate = everyBoardDate;
		this.everyBoardHitcount = everyBoardHitcount;
		this.everyBoardOrgname = everyBoardOrgname;
		this.everyBoardSavename = everyBoardSavename;
		this.recount = recount;
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

	public String getEveryBoardTitle() {
		return everyBoardTitle;
	}

	public void setEveryBoardTitle(String everyBoardTitle) {
		this.everyBoardTitle = everyBoardTitle;
	}

	public String getEveryBoardContent() {
		return everyBoardContent;
	}

	public void setEveryBoardContent(String everyBoardContent) {
		this.everyBoardContent = everyBoardContent;
	}

	public String getEveryBoardDate() {
		return everyBoardDate;
	}

	public void setEveryBoardDate(String everyBoardDate) {
		this.everyBoardDate = everyBoardDate;
	}

	public int getEveryBoardHitcount() {
		return everyBoardHitcount;
	}

	public void setEveryBoardHitcount(int everyBoardHitcount) {
		this.everyBoardHitcount = everyBoardHitcount;
	}

	public String getEveryBoardOrgname() {
		return everyBoardOrgname;
	}

	public void setEveryBoardOrgname(String everyBoardOrgname) {
		this.everyBoardOrgname = everyBoardOrgname;
	}

	public String getEveryBoardSavename() {
		return everyBoardSavename;
	}

	public void setEveryBoardSavename(String everyBoardSavename) {
		this.everyBoardSavename = everyBoardSavename;
	}

	public int getRecount() {
		return recount;
	}

	public void setRecount(int recount) {
		this.recount = recount;
	}

	@Override
	public String toString() {
		return "EveryBoard [everyBoardSeq=" + everyBoardSeq + ", id=" + id + ", everyBoardTitle=" + everyBoardTitle
				+ ", everyBoardContent=" + everyBoardContent + ", everyBoardDate=" + everyBoardDate
				+ ", everyBoardHitcount=" + everyBoardHitcount + ", everyBoardOrgname=" + everyBoardOrgname
				+ ", everyBoardSavename=" + everyBoardSavename + ", recount=" + recount + "]";
	}
	
}
