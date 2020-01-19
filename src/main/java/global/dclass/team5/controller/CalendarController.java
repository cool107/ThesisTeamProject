package global.dclass.team5.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.dclass.team5.DAO.CalendarMapper;
import global.dclass.team5.VO.Calendar;
import global.dclass.team5.VO.GroupCalendar;
import global.dclass.team5.VO.Member;
import global.dclass.team5.service.CalendarService;
import global.dclass.team5.service.MemberService;

@Controller
public class CalendarController {

	@Autowired
	CalendarService service;
	
	@Autowired
	MemberService member_service;
	
	//�쟾泥댁텧�젰
/*	goEveryBoard_calendar.jsp
	*/
	
	//그룹보드 스케쥴  <!-- 전체출력 -->
	@ResponseBody
	@RequestMapping(value="all_Group_Calendar",method=RequestMethod.POST)
	public ArrayList<GroupCalendar> select_Calendar( HttpSession session, Model model) {
		
		int groupBoardNum = (Integer) session.getAttribute("groupBoardNum");
		
		ArrayList<GroupCalendar> select = service.all_Group_Calendar(groupBoardNum);
	
			return select;
			
	}
	
//	Selected_group_Calendar
//	 선택된  메소드의 달의 스케쥴만 출력
	@RequestMapping(value="Selected_group_Calendar",method=RequestMethod.POST)
	public @ResponseBody ArrayList<GroupCalendar> testCalendar(String start_day,HttpSession session, Model model) {
		GroupCalendar calendar = new GroupCalendar();
		
		int groupBoardNum = (Integer) session.getAttribute("groupBoardNum");
		
		calendar.setGroupBoardNum(groupBoardNum);
		calendar.setStart_day(start_day);
	
		ArrayList<GroupCalendar> select = service.selected_Group_Calendar(calendar);

		return select;
		
	}
		
	
	//업데이트 용 1개 셀렉트 
	@ResponseBody
	@RequestMapping(value="select_Group_calendar_update" , method=RequestMethod.POST)
	public GroupCalendar select_group_calendar_update(GroupCalendar groupCalendar,HttpSession session) {
		GroupCalendar result = new GroupCalendar();
		
		int groupBoardNum= (Integer) session.getAttribute("groupBoardNum");
				
		groupCalendar.setGroupBoardNum(groupBoardNum);
		
		try {
			result = service.select_Group_calendar_update(groupCalendar);

			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return result; 
		 
	}	
	
	// calendar insert
	@ResponseBody
	@RequestMapping(value="insert_Group_calendar",method=RequestMethod.POST)
	public int insert_calendar(GroupCalendar calendar,HttpSession session) {
		
		calendar.setGroupBoardNum((Integer)session.getAttribute("groupBoardNum"));
		String id = (String)session.getAttribute("loginId");	
		
		calendar.setId(id);
		Member memberInfo = member_service.selectMember(id);		
		calendar.setDepartment(memberInfo.getDepartment());
				
		
		int insert =  service.insert_Group_calendar(calendar);
		
		return insert;
	}
	
	// calendar delete
	@ResponseBody
	@RequestMapping(value="delete_Group_calendar",method=RequestMethod.POST)
	public boolean delete_calendar(GroupCalendar calendar,HttpSession session) {
		
		boolean result=false;
		String id = (String)session.getAttribute("loginId");	
		calendar.setId(id);
		calendar.setGroupBoardNum((Integer)session.getAttribute("groupBoardNum"));
		
		try {
			result = service.delete_Group_calendar(calendar);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
		
	}

	@ResponseBody
	@RequestMapping(value="update_Group_Calendar",method=RequestMethod.POST)
	public int update_Group_Calendar(GroupCalendar groupCalendar,HttpSession session) {
			
		int result = 0;
		
		groupCalendar.setGroupBoardNum((Integer)session.getAttribute("groupBoardNum"));
		
		try {
			
			result = service.update_Group_calendar(groupCalendar);

		}catch(Exception e) {
			
			e.printStackTrace();
		}
	
		return result;
	}
	
	
//	전체게시판 시작
//	goEveryBoard_calendar

	@RequestMapping(value="all_Every_Calendar",method=RequestMethod.GET)
	public String allCalendar( HttpSession session, Model model) {
		
	
		return "/everyboard/goEveryBoard_calendar";
	}
	
	
	@ResponseBody
	@RequestMapping(value="all_Every_Calendar",method=RequestMethod.POST)
	public ArrayList<Calendar> alldCalendar( HttpSession session, Model model) {
		
		ArrayList<Calendar> result = null;
		
		try {
			result = service.all_Every_Calendar();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="selected_Every_Calendar",method=RequestMethod.POST)
	public ArrayList<Calendar> selected_Every_Calendar(String start_day,HttpSession session, Model model){
		
		Calendar calendar = new Calendar();
		ArrayList<Calendar> select = null;
		
		calendar.setStart_day(start_day);
	
		try {
			 select = service.selected_Every_Calendar(calendar);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return select;
		
	}
	
	@ResponseBody
	@RequestMapping(value="select_Every_calendar_update" , method=RequestMethod.POST)
	public Calendar select_Every_calendar_update(int calendar_num) {
		
		Calendar result = null;
		
		
		try {
			result = service.select_Every_calendar_update(calendar_num);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return result; 
		 
	}
	
	@ResponseBody
	@RequestMapping(value="insert_Every_Calendar",method=RequestMethod.POST)
	public int insert_Every_Calendar(Calendar calendar,HttpSession session) {
		
		String id = (String)session.getAttribute("loginId");	
		
		calendar.setId(id);
		Member memberInfo = member_service.selectMember(id);		
		calendar.setDepartment(memberInfo.getDepartment());
				

		
		int result = 0;
		
		try {
			result = service.insert_Every_Calendar(calendar);
		}catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	@ResponseBody
	@RequestMapping(value="delete_Every_calendar",method=RequestMethod.POST)
	public int delete_Every_calendar(int calendar_num,HttpSession session) {
		
		int result = 0;

		try {
			result = service.delete_Every_calendar(calendar_num);			
		}catch(Exception e) {			
			e.printStackTrace();
		}		
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value="update_Every_Calendar",method=RequestMethod.POST)
	public int update_Every_calendar(Calendar Calendar) {
		
		
		int result = 0;		
		try {
			result = service.update_Every_calendar(Calendar);
		}catch(Exception e) {			
			e.printStackTrace();
		}	
		return result;
	}
}
