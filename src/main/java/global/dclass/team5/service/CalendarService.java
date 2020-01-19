package global.dclass.team5.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import global.dclass.team5.DAO.CalendarDAO;
import global.dclass.team5.VO.Calendar;
import global.dclass.team5.VO.GroupCalendar;

@Service
public class CalendarService {

	
	@Autowired
	CalendarDAO dao;


	public ArrayList<GroupCalendar> all_Group_Calendar (int groupBoardNum){
		
		return dao.all_Group_Calendar(groupBoardNum);

	}
	
	public ArrayList<GroupCalendar> selected_Group_Calendar(GroupCalendar calendar){
		
		ArrayList<GroupCalendar> result = dao.selected_Group_Calendar(calendar);

		return result;
		
		
	}
	
	
	public GroupCalendar select_Group_calendar_update(GroupCalendar groupCalendar) {
		
		return dao.select_Group_calendar_update(groupCalendar);
		
	}
	
	public Calendar select_Every_calendar_update(int calendar_num) {
		
		return dao.select_Every_calendar_update(calendar_num);
	}

	
	public int insert_Group_calendar(GroupCalendar calendar) {
		
		return dao.insert_Group_calendar(calendar);
	}


	public boolean delete_Group_calendar(GroupCalendar calendar) {
		
		return dao.delete_Group_calendar(calendar);
	}
	
	public int update_Group_calendar(GroupCalendar groupCalendar) {
		
		return dao.update_Group_calendar(groupCalendar);
	}
	
	//전체 게시판 시작
	
	public ArrayList<Calendar> all_Every_Calendar(){
		
		return dao.all_Every_Calendar();
	
	}
	
	public ArrayList<Calendar> selected_Every_Calendar(Calendar calendar){
		
		return dao.selected_Every_Calendar(calendar);
		
	}

	public int insert_Every_Calendar(Calendar calendar) {
		
		return dao.insert_Every_Calendar(calendar);
	}
	
	public int delete_Every_calendar(int calendar_num) {
		
		return dao.delete_Every_calendar(calendar_num);
	}
	
	public int update_Every_calendar(Calendar Calendar) {
		return dao.update_Every_calendar(Calendar);		
	}

}
