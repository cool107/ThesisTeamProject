package global.dclass.team5.DAO;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.dclass.team5.VO.Calendar;
import global.dclass.team5.VO.GroupCalendar;

@Repository
public class CalendarDAO {

	
	@Autowired 
	SqlSession sql;
	
//해당  그룹보드 스케쥴 전체출력
	public ArrayList<GroupCalendar> all_Group_Calendar (int groupBoardNum){
		ArrayList<GroupCalendar> result = new ArrayList<GroupCalendar>();
		CalendarMapper mapper = sql.getMapper(CalendarMapper.class);
		
		try {
			result = mapper.all_Group_Calendar(groupBoardNum);			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	

	//그룹보드 해당 스케쥴 메소드에 따른 출력
	public ArrayList<GroupCalendar> selected_Group_Calendar (GroupCalendar calendar){
		
		CalendarMapper mapper = sql.getMapper(CalendarMapper.class);
		
		ArrayList<GroupCalendar> result = mapper.selected_Group_Calendar(calendar);

		return result;
		
	}


	public GroupCalendar select_Group_calendar_update(GroupCalendar groupCalendar) {
		
		CalendarMapper mapper = sql.getMapper(CalendarMapper.class);
		
		return mapper.select_Group_calendar_update(groupCalendar);
		
	}
	//인서트 그룹보드 스케쥴
	public int insert_Group_calendar(GroupCalendar calendar) {
		int insert = 0;

		CalendarMapper mapper = sql.getMapper(CalendarMapper.class);
		try {
			insert = mapper.insert_Group_calendar(calendar);			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return insert;
	}

	
	//삭제 그룹보드 스케쥴
	public boolean delete_Group_calendar(GroupCalendar calendar) {
		
		CalendarMapper mapper= sql.getMapper(CalendarMapper.class);
		
		boolean result = mapper.delete_Group_calendar(calendar);

			return result;
		
	}
	
	//수정 그룹캘린더
	public int update_Group_calendar(GroupCalendar groupCalendar) {
		
		CalendarMapper mapper= sql.getMapper(CalendarMapper.class);
		
		return mapper.update_Group_calendar(groupCalendar);
		
	}
	
	

//	전체 캘린더 시작 
	
	
	public ArrayList<Calendar> all_Every_Calendar(){
		
		CalendarMapper mapper= sql.getMapper(CalendarMapper.class);
		
		
		return mapper.all_Every_Calendar();
		
	}

	public ArrayList<Calendar> selected_Every_Calendar(Calendar calendar){
	
		CalendarMapper mapper= sql.getMapper(CalendarMapper.class);
		
		return mapper.selected_Every_Calendar(calendar);
	}
	
	
	
	public int insert_Every_Calendar(Calendar calendar) {
		CalendarMapper mapper= sql.getMapper(CalendarMapper.class);
		
		return mapper.insert_Every_Calendar(calendar);
	}
	
	public int delete_Every_calendar(int calendar_num) {
		
		CalendarMapper mapper= sql.getMapper(CalendarMapper.class);
		
		return mapper.delete_Every_calendar(calendar_num);
	}
	
	
	public int update_Every_calendar(Calendar Calendar) {
		CalendarMapper mapper= sql.getMapper(CalendarMapper.class);
		
		return mapper.update_Every_calendar(Calendar);
	}
	
	public Calendar select_Every_calendar_update(int calendar_num) {
		CalendarMapper mapper = sql.getMapper(CalendarMapper.class);
		
		return mapper.select_Every_calendar_update(calendar_num);
		
	}

	
}
