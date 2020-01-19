package global.dclass.team5.VO;

public class Calendar {

	private int calendar_num;
	private String id;
	private String department;
	private String schdule_title;
 	private String start_day;
	private String last_day;
	private String place;
	private String discription;
	
	
	public int getCalendar_num() {
		return calendar_num;
	}

	public void setCalendar_num(int calendar_num) {
		this.calendar_num = calendar_num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getSchdule_title() {
		return schdule_title;
	}

	public void setSchdule_title(String schdule_title) {
		this.schdule_title = schdule_title;
	}

	public String getStart_day() {
		return start_day;
	}

	public void setStart_day(String start_day) {
		this.start_day = start_day;
	}

	public String getLast_day() {
		return last_day;
	}

	public void setLast_day(String last_day) {
		this.last_day = last_day;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getDiscription() {
		return discription;
	}

	public void setDiscription(String discription) {
		this.discription = discription;
	}

	@Override
	public String toString() {
		return "Calendar [calendar_num=" + calendar_num + ", id=" + id + ", department=" + department
				+ ", schdule_title=" + schdule_title + ", start_day=" + start_day + ", last_day=" + last_day
				+ ", place=" + place + ", discription=" + discription + "]";
	}

	public Calendar() {
		super();
	}

	public Calendar(int calendar_num, String id, String department, String schdule_title, String start_day,
			String last_day, String place, String discription) {
		super();
		this.calendar_num = calendar_num;
		this.id = id;
		this.department = department;
		this.schdule_title = schdule_title;
		this.start_day = start_day;
		this.last_day = last_day;
		this.place = place;
		this.discription = discription;
	}
		

}
