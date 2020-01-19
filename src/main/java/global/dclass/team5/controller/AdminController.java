package global.dclass.team5.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.dclass.team5.VO.Application;
import global.dclass.team5.VO.Message;
import global.dclass.team5.VO.ThesisForm;
import global.dclass.team5.VO.ThesisTemp;
import global.dclass.team5.service.AdminService;
import global.dclass.team5.service.FileService;
import global.dclass.team5.service.MessageService;

@Controller
public class AdminController {
	
	private static final String uploadPath = "D:/Users/dud54/Desktop/DATA/K-move/36기 D반 5조 프로젝트/Project/ThesisManagementSystem/src/main/webapp/resources/finalFile/";
	
	@Autowired
	AdminService service;
	@Autowired
	MessageService mservice;
	
	
	//application form으로 가기
	@RequestMapping(value="insertApplicationForm", method=RequestMethod.GET)
	public String insertApplicationForm() {
		return "/admin/insertApplicationForm";
	}
	
	//application 전체 보여주기
	@ResponseBody
	@RequestMapping(value="searchApplication", method=RequestMethod.GET)
	public ArrayList<Application> searchApplication() {
		ArrayList<Application> result = new ArrayList<Application>();
		
		result = service.searchApplication();
		
		return result;
	}
	
	//update adminCheck
	@ResponseBody
	@RequestMapping(value="updateAdminCheck", method=RequestMethod.POST)
	public int updateAdminCheck(int applicationSeq) {
		int result = 0;
		
		Application application = service.selectApplication(applicationSeq);
		
		if (application == null) {
			return 0;
		}
		
		result = service.updateAdminCheck(applicationSeq);
		
		if (result != 1) {
			return 0;
		}
		
		return result;
	}
	
	//member가 수락하면 membercheck 증가하기
	@ResponseBody
	@RequestMapping(value="updateMemberCheck", method=RequestMethod.POST)
	public int updateMemberCheck(int applicationSeq, int msg_seq) {
		int result1 = 0;
		int result2 = 0;
		
		Message message = mservice.select_one_messages(msg_seq);
		
		result1 = service.updateMemberCheck(applicationSeq);
		
		if (result1 == 0) {
			return 0;
		} else {
			result2 = mservice.updateConfirm(message);
			
			if (result2 == 0) {
				return 0;
			}
		}
		
		return result2;
	}
	
	//논문 등록 페이지 이동
	@RequestMapping(value="insertThesis", method=RequestMethod.GET)
	public String goInsertThesisForm() {
		return "/admin/insertThesis";
	}
	
	//논문 양식 수정 페이지 이동
	@RequestMapping(value="updateThesis", method=RequestMethod.GET)
	public String goUpdateThesisForm() {
		return "/admin/updateThesis";
	}
	
	//논문양식 가져오기
	@ResponseBody
	@RequestMapping(value="selectThesisForm", method=RequestMethod.POST)
	public ThesisForm selectThesisForm(String department) {
		
		ThesisForm result = service.selectThesisForm(department);
		
		return result;
	}
	
	//논문양식 수정하기
	@ResponseBody
	@RequestMapping(value="updateThesisForm", method=RequestMethod.POST)
	public int updateThesisForm(ThesisForm form) {
		
		int result = service.updateThesisForm(form);
		
		return result;
	}
	
	//최종 논문 저장하기
	
	@RequestMapping(value = "finalSubmit", method = RequestMethod.POST)
	public String finalSubmit(int seq_thesistemp, HttpSession session, MultipartFile upload, Model model) {
		ThesisTemp temp = new ThesisTemp();
		int num = (Integer) session.getAttribute("groupBoardNum");
		temp.setSeq_thesistemp(seq_thesistemp);
		temp.setGroupBoardNum(num);
		System.out.println(temp);
		System.out.println("시퀀스 : "+temp.getSeq_thesistemp());
		
		ThesisTemp oldBoard = new ThesisTemp();
	      if (!upload.isEmpty()) {
	         String savedfile = oldBoard.getThesissavename();
	         if (savedfile != null) {
	            FileService.deleteFile(uploadPath + "/" + savedfile);
	         }
	         savedfile = FileService.saveFile(upload, uploadPath);
	         temp.setThesisorgname(upload.getOriginalFilename());
	         temp.setThesissavename(savedfile);
	      }
		service.finalFileUpload(temp);
		return "redirect:goGroupBoard";
		
	}
	
	@ResponseBody
	@RequestMapping(value="selectThesisTemp", method=RequestMethod.POST)
	public ArrayList<ThesisTemp> selectThesisTemp(){ 
		ArrayList<ThesisTemp> result = new ArrayList<ThesisTemp>();
	
		result = service.selectThesisTemp();
		
		return result;
	}
	
	@RequestMapping(value="thesisDetail", method=RequestMethod.GET)
	public String thesisDetail(int seq_thesistemp, Model model) {
		
		ThesisTemp result = service.oneThesisTemp(seq_thesistemp);
		
		model.addAttribute("ThesisTemp", result);
		
		return "/admin/thesisDetail";
	}
	
	@RequestMapping(value="insertThesisSubmit", method=RequestMethod.GET)
	public String insertThesisSubmit(int seq_thesistemp, Model model) {
		ThesisTemp result = service.oneThesisTemp(seq_thesistemp);
		
		int success = service.insertThesisSubmit(result);

		if (success != 1) {
			return "/admin/thesisDetail?seq_thesistemp="+seq_thesistemp;
		}
		
		service.updateThesisSubmit(seq_thesistemp);
		
		return "/admin/insertThesis";
	}
}
