package global.dclass.team5.DAO;

import java.util.ArrayList;

import global.dclass.team5.VO.Calendar;
import global.dclass.team5.VO.GroupCalendar;

public interface CalendarMapper {
	
	//그룹보드 해당 그룹 전체 스케쥴 출력 
	public ArrayList<GroupCalendar> all_Group_Calendar (int groupBoardNum);
	
	// <  >그룹보드 해당 그룹 선택 메소드 스케쥴 출력 
	public ArrayList<GroupCalendar> selected_Group_Calendar (GroupCalendar groupCalendar);
	
	// 넘버로 해당 캘린더 1개만 가져와서 수정 할때 출력
	public GroupCalendar select_Group_calendar_update(GroupCalendar groupCalendar);
	
	public int insert_Group_calendar(GroupCalendar groupCalendar);
	
	public boolean delete_Group_calendar(GroupCalendar groupCalendar);
	
	public int update_Group_calendar(GroupCalendar groupCalendar);
	
	
	//EveryBoard 매니져 전체 스케쥴 출력 
	public ArrayList<Calendar> all_Every_Calendar();	
	
	public ArrayList<Calendar> selected_Every_Calendar(Calendar calendar); 

	public int insert_Every_Calendar(Calendar calendar);
	
	public int delete_Every_calendar(int calendar_num);
	
	public int update_Every_calendar(Calendar Calendar);
	
	//1개만 찾음	
	public Calendar select_Every_calendar_update(int calendar_num);
	
	
}
