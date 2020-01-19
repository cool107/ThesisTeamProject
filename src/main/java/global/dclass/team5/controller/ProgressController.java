package global.dclass.team5.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.dclass.team5.VO.Member;
import global.dclass.team5.VO.Progress;
import global.dclass.team5.service.MemberService;
import global.dclass.team5.service.ProgressService;

@Controller
public class ProgressController {

	@Autowired
		ProgressService Pservice;

		
	//id,학과 셀렉트
	@ResponseBody
	@RequestMapping(value="list_progress" ,method=RequestMethod.POST)
	public ArrayList<Progress> select_group_progress(HttpSession session) {
		
		int groupBoardNum2 = (Integer) session.getAttribute("groupBoardNum");		
		ArrayList<Progress> result = null;	
		
		try {
			result = Pservice.select_group_progress(groupBoardNum2);			
		}catch(Exception e) {
			
			e.printStackTrace();
		}
		
		return result;
			
	}
	
	//모든 전체평균
	@ResponseBody
	@RequestMapping(value="select_all_avg_day",method=RequestMethod.POST)
	public Progress select_all_day_avg_progress(HttpSession session){
		
		Progress result = null;
		Progress progress = new Progress();
		
		try {
			progress.setId((String) session.getAttribute("loginId"));
			progress.setGroupBoardNum((Integer)session.getAttribute("groupBoardNum"));

			result= Pservice.select_all_day_avg_progress(progress);

		}catch(Exception e) {
			
			e.printStackTrace();
		}
		return result;
		
	}
	
	//7일동안 인서트한 팀원들 각각의 평균
	@ResponseBody
	@RequestMapping(value="select_7_day_avg_progress" , method=RequestMethod.POST)
	public ArrayList<Progress> select_7_day_avg_progress(HttpSession session){
		
		ArrayList<Progress> result = null;		
		int groupBoardNum= (Integer)session.getAttribute("groupBoardNum");
		
		try {					
			result=Pservice.select_7_day_avg_progress(groupBoardNum);
		}catch(Exception e) {			
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	//7일동안 인서트한 팀원들의 7일간 전체평균
	@ResponseBody
	@RequestMapping(value="all_select_7_day_avg_progress" , method=RequestMethod.POST)
	public int all_select_7_day_avg_progress(HttpSession session){
		
		int result  = 0;
		int groupBoardNum= (Integer)session.getAttribute("groupBoardNum");
		try {
			result = Pservice.all_select_7_day_avg_progress(groupBoardNum);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	//전체 팀원  로그 출력(인서트한 기록)
	@ResponseBody
	@RequestMapping(value="progress_log" ,method=RequestMethod.POST)
	public ArrayList<Progress> progress_log(HttpSession session) {
		 ArrayList<Progress> result  = null;
		int groupBoardNum = (Integer)session.getAttribute("groupBoardNum");

		try {
			result = Pservice.progress_log(groupBoardNum);

		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="insert_progress",method=RequestMethod.GET)
	public int insert_progress(Progress progress,HttpSession session) {
		
		int result = 0; 
		
		try {			
			progress.setId((String) session.getAttribute("loginId"));
			progress.setGroupBoardNum((Integer)session.getAttribute("groupBoardNum"));
			result = Pservice.insert_progress(progress);
						
		}catch(Exception e) {			
			e.printStackTrace();			
		}		
		return result;
	}

	@ResponseBody
	@RequestMapping(value="delete_progress",method=RequestMethod.POST)
	public int delete_progress(int progressNum) {
		
		int result = 0; 	
		
		try {			
			result = Pservice.delete_progress(progressNum);			
			System.out.println(result);
			
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return result;
	}
	
}
