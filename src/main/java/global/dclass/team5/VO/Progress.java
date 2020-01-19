package global.dclass.team5.VO;

public class Progress {
	
       private int progressNum;
	   private int groupBoardNum;
	   private String id;
	   private int progress_per;
	   private String pro_date;
	   private String name;
	   private String department;
	   
	   
	public Progress(int progressNum, int groupBoardNum, String id, int progress_per, String pro_date, String name,
			String department) {
		super();
		this.progressNum = progressNum;
		this.groupBoardNum = groupBoardNum;
		this.id = id;
		this.progress_per = progress_per;
		this.pro_date = pro_date;
		this.name = name;
		this.department = department;
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
	public int getProgressNum() {
		return progressNum;
	}
	public void setProgressNum(int progressNum) {
		this.progressNum = progressNum;
	}
	public int getGroupBoardNum() {
		return groupBoardNum;
	}
	public void setGroupBoardNum(int groupBoardNum) {
		this.groupBoardNum = groupBoardNum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getProgress_per() {
		return progress_per;
	}
	public void setProgress_per(int progress_per) {
		this.progress_per = progress_per;
	}
	public String getPro_date() {
		return pro_date;
	}
	public void setPro_date(String pro_date) {
		this.pro_date = pro_date;
	}
	
	
	public Progress() {
		super();
	}
	
	@Override
	public String toString() {
		return "Progress [progressNum=" + progressNum + ", groupBoardNum=" + groupBoardNum + ", id=" + id
				+ ", progress_per=" + progress_per + ", pro_date=" + pro_date + "]";
	}

	    
}
