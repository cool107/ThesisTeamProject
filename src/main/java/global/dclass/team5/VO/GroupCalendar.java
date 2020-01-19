package global.dclass.team5.VO;

public class GroupCalendar extends Calendar{

	private int group_calendar_num;
	private int groupBoardNum;
	
	public int getGroup_calendar_num() {
		return group_calendar_num;
	}
	public void setGroup_calendar_num(int group_calendar_num) {
		this.group_calendar_num = group_calendar_num;
	}
	public int getGroupBoardNum() {
		return groupBoardNum;
	}
	public void setGroupBoardNum(int groupBoardNum) {
		this.groupBoardNum = groupBoardNum;
	}
	public GroupCalendar(int group_calendar_num, int groupBoardNum) {
		super();
		this.group_calendar_num = group_calendar_num;
		this.groupBoardNum = groupBoardNum;
	}
	public GroupCalendar() {
		super();
	}

	@Override
	public String toString() {
		return "GroupCalendar [group_calendar_num=" + group_calendar_num + ", groupBoardNum=" + groupBoardNum + super.toString() 
	+"]";
	}

}
