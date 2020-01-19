package global.dclass.team5.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.dclass.team5.VO.Application;
import global.dclass.team5.VO.Member;
import global.dclass.team5.VO.Message;
import global.dclass.team5.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	MemberService service;
	
	//회원가입 폼 이동
	@RequestMapping(value="/joinMember", method=RequestMethod.GET)
	public String joinForm() {
		return "/member/joinForm";
	}
	
	//아이디 중복 체크
	@ResponseBody
	@RequestMapping(value="checkId", method=RequestMethod.GET)
	public Member checkId(String id) {
		
		Member result = service.selectMember(id);
		
		if (result != null) {
			return result;
		}
		
		return null;
	}
	
	//회원가입
	@RequestMapping(value="joinMember", method=RequestMethod.POST)
	public String joinMember(Member member) {
		
		int result  = service.insertMember(member);
		
		if (result != 1) {
			return "redirect:/joinForm";
		}
		
		return "redirect:/";
	}
	
	//로그인폼 이동
	@RequestMapping(value="loginMember", method=RequestMethod.GET)
	public String loginForm() {
		return "/member/loginForm";
	}
	
	//로그인
	@RequestMapping(value="loginMember", method=RequestMethod.POST)
	public String loginMember(String id, HttpSession session) {

		Member result = service.selectMember(id);

		session.setAttribute("loginId", result.getId());
		session.setAttribute("loginName", result.getName());
		session.setAttribute("loginDivision", result.getDivision());
		session.setAttribute("loginGroupBoardNum", result.getGroupBoardNum());
		
		return "home";
	}
	
	//로그아웃
	@RequestMapping(value="logoutMember", method=RequestMethod.GET)
	public String logoutMember(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	//회원정보 보기
	@RequestMapping(value="mypage", method=RequestMethod.GET)
	public String Memberpage(Model model,HttpSession session) {
	
	
			String id= (String) session.getAttribute("loginId");			
			Member result = service.selectMember(id);
			model.addAttribute("member", result);
		
			return "/member/mypage";
	
	}

	//회원정보 수정폼으로 가기
	@RequestMapping(value="updateMember", method=RequestMethod.GET)
	public String updateMember_GET(HttpSession session,Model model) {

		String id= (String) session.getAttribute("loginId");
		Member result = service.selectMember(id);
		model.addAttribute("member", result);

		
		return "/member/updateForm";
	}

	//회원정보 수정
	@RequestMapping(value="updateMember", method=RequestMethod.POST)
	public String updateMember(HttpSession session,Member member,Model model) {

		String id= (String) session.getAttribute("loginId");			
		Member member_select = service.selectMember(id);
		
		if( member.getPw() != "" && member.getPw() != null) {			
			member_select.setPw(member.getPw());
		}
				
		if(member.getDepartment() != "" && member.getDepartment() != null) {					
			member_select.setDepartment(member.getDepartment());
		}
	
		int result = service.updateMember(member_select);
		
		model.addAttribute("member",  member_select);
		
		if(result ==1) {		
			return "redirect:/";		
		}

		return "/member/mypage";
	}

	//독립게시판 신청하기 폼
	@RequestMapping(value="applicationForm", method=RequestMethod.GET)
	public String applicationForm() {
		return "/member/applicationForm";
	}
	
	//독립게시판 신청하기
	@RequestMapping(value="insertApplication", method=RequestMethod.POST)
	public String insertApplication(Application application, HttpSession session, Model model) {

		String id = (String) session.getAttribute("loginId");
		application.setId(id);
		
		if (application.getMember2().equals("")) {
			application.setMemberNum(2);
		} else if (application.getMember3().equals("")) {
			application.setMemberNum(3);
		} else if (application.getMember4().equals("")) {
			application.setMemberNum(4);
		} else {
			application.setMemberNum(5);
		}

		int result = service.insertApplication(application);
		
		if (result != 1) {
			return "redirect:/member/applicationForm";
		}
		
		sendConfirmMessage(id, session);

		model.addAttribute("msgCheck", 1);
		
		return "redirect:/";
	}

	//멤버에게 확인 메세지 보내기
	public void sendConfirmMessage(String id, HttpSession session) {

		String name = (String)session.getAttribute("loginName");

		Application application = service.selectApplication(id);

		Message message1 = new Message();

		message1.setApplicationSeq(application.getApplicationSeq());
		message1.setToId(application.getMember1());
		message1.setMessageContent(name+"様が チーム掲示板に 招待しました。ご同意の場合は受諾のボタンを押してください。");

		service.sendConfirmMessage(message1);

		if (application.getMemberNum() == 3) {
			Message message2 = new Message();

			message2.setApplicationSeq(application.getApplicationSeq());
			message2.setToId(application.getMember2());
			message2.setMessageContent(name+"様が チーム掲示板に 招待しました。ご同意の場合は受諾のボタンを押してください。");

			service.sendConfirmMessage(message2);
		} else if (application.getMemberNum() == 4)  {
			Message message2 = new Message();
			Message message3 = new Message();

			message2.setApplicationSeq(application.getApplicationSeq());
			message2.setToId(application.getMember2());
			message2.setMessageContent(name+"様が チーム掲示板に 招待しました。ご同意の場合は受諾のボタンを押してください。");
			message3.setApplicationSeq(application.getApplicationSeq());
			message3.setToId(application.getMember3());
			message3.setMessageContent(name+"様が チーム掲示板に 招待しました。ご同意の場合は受諾のボタンを押してください。");

			service.sendConfirmMessage(message2);
			service.sendConfirmMessage(message3);
		} else {
			Message message2 = new Message();
			Message message3 = new Message();
			Message message4 = new Message();

			message2.setApplicationSeq(application.getApplicationSeq());
			message2.setToId(application.getMember2());
			message2.setMessageContent(name+"様が チーム掲示板に 招待しました。ご同意の場合は受諾のボタンを押してください。");
			message3.setApplicationSeq(application.getApplicationSeq());
			message3.setToId(application.getMember3());
			message3.setMessageContent(name+"様が チーム掲示板に 招待しました。ご同意の場合は受諾のボタンを押してください。");
			message4.setApplicationSeq(application.getApplicationSeq());
			message4.setToId(application.getMember4());
			message4.setMessageContent(name+"様が チーム掲示板に 招待しました。ご同意の場合は受諾のボタンを押してください。");

			service.sendConfirmMessage(message2);
			service.sendConfirmMessage(message3);
			service.sendConfirmMessage(message4);
		}
	}

	//팀원들이 모두 독립게시판을 할당 안받은 사람인지 체크
	@ResponseBody
	@RequestMapping(value="checkGroupBoardNum", method=RequestMethod.POST)
	public int checkGroupBoardNum(Application application) {
		
		String member1 = application.getMember1();
		String member2 = application.getMember2();
		String member3 = application.getMember3();
		String member4 = application.getMember4();
		
		Member result1 = service.selectMember(member1);
		Member result2 = service.selectMember(member2);
		Member result3 = service.selectMember(member3);
		Member result4 = service.selectMember(member4);
		
		if (result1 == null & member1 != "") {
			System.out.println(1);
			return 2;
		} else if (result2 == null & member2 != "") {
			System.out.println(2);
			return 2;
		} else if (result3 == null & member3 != "") {
			System.out.println(3);
			return 2;
		} else if (result4 == null & member4 != "") {
			System.out.println(4);
			return 2;
		}
		
		int memberNum = 0;
		
		if (member2 == "") {
			memberNum = 2;
		} else if (member3 == "") {
			memberNum = 3;
		} else if (member4 == "") {
			memberNum = 4;
		} else {
			memberNum = 5;
		}
		
		System.out.println(memberNum);
	
		switch (memberNum) {
		case 2:
			if (result1.getGroupBoardNum() == 0) {
				return 0;
			} else {
				return 1;
			}
		case 3:
				if (result1.getGroupBoardNum() == 0 && result2.getGroupBoardNum() == 0) {
					return 0;
				} else {
					return 1;
				}
		case 4:
			if (result1.getGroupBoardNum() == 0 && result2.getGroupBoardNum() == 0 && result3.getGroupBoardNum() == 0) {
				return 0;
			} else {
				return 1;
			}
		case 5:
			if (result1.getGroupBoardNum() == 0 && result2.getGroupBoardNum() == 0 && result3.getGroupBoardNum() == 0 && result4.getGroupBoardNum() == 0) {
				return 0;
			} else {
				return 1;
			}
		default:
			return 1;
		}
	}
	
	//메세지 갯수 가져오기
	@ResponseBody
	@RequestMapping(value="selectMsgCount", method=RequestMethod.GET)
	public int selectMsgCount(String toId) {
		int result = 0;
		
		result = service.selectMsgCount(toId);
		
		return result;
	}
}
