package global.dclass.team5.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.dclass.team5.VO.Member;
import global.dclass.team5.VO.Message;
import global.dclass.team5.service.MemberService;
import global.dclass.team5.service.MessageService;

@Controller
	public class MessageController {
	
		@Autowired
		MessageService service;
		@Autowired
		MemberService mservice;
		
		// 최신 5개 메시지 불러오기
		@RequestMapping(value = "selectFiveMessages",method = RequestMethod.GET)
		@ResponseBody
		public ArrayList<Message> select_five_messages(HttpSession session) {
			String id = (String) session.getAttribute("loginId");
			ArrayList<Message> newList = service.select_five_messages(id);
			return newList;
		}
		
		//전체 메시지 보는 창으로
		@RequestMapping(value = "viewAllMessages", method = RequestMethod.GET)
		public String select_all_messages_form() {
			
			return "/messages/allMessages";
		}

		//메인창에 있는 쪽지를 클릭하면 개별 메시지 창으로 넘어가는 메서드
		@RequestMapping(value = "entergetMsg", method = RequestMethod.GET)
		public String entergetMsg(int msg_seq, Model model) {
			//Message msg = service.select_one_messages(msg_seq);
			model.addAttribute("oneMsg", msg_seq);
			return "/messages/oneMsg";
		}
		
		//받은 메세지 출력
		@RequestMapping(value = "toAllMessages", method = RequestMethod.GET)
		@ResponseBody
		public ArrayList<Message> select_all_messages(HttpSession session){
			String id = (String) session.getAttribute("loginId");	
			 ArrayList<Message>	list = service.select_all_messages(id);
			return list;
		}
		
		//보낸메세지 출력
		@ResponseBody
		@RequestMapping(value="fromAllMessages", method=RequestMethod.GET)
		public ArrayList<Message> fromAllMessages(HttpSession session){
			String id = (String) session.getAttribute("loginId");
			ArrayList<Message> list = service.fromAllMessages(id);
			return list;
		}
		
		//메시지 삭제
		@RequestMapping(value = "deleteMsg", method = RequestMethod.GET)
		@ResponseBody
		public int delete_messages(String msg_seq) {
			int num = 0;
			int result = 0;
			System.out.println("결과값"+msg_seq);
			if(msg_seq.isEmpty()) {
				System.out.println("빈값이야~");
			}
			String[] temp = msg_seq.split(",");
			for (String string : temp) {
				 num = Integer.parseInt(string);
				 result = service.delete_messages(num);
			}
			System.out.println("int로 바꾼 값"+num);
			return result;
		}
		
		//메시지 한개만 보기
		@RequestMapping(value = "getMsg", method = RequestMethod.GET)
		@ResponseBody
		public Message select_one_messages(int msg_seq) {
			Message msg = service.select_one_messages(msg_seq);
			return msg;
		}
		
		//메시지 전송
		@RequestMapping(value = "insertMsg", method = RequestMethod.POST)
		@ResponseBody
		public int insert_messages(Message msg, HttpSession session, Model model) {
			int num = 0;
			String id = (String) session.getAttribute("loginId");
			msg.setFromId(id);//보내는사람 : 로그인한 사람 아이디
			Member member = mservice.selectMember(msg.getToId());//받는사람 아이디가 데이터베이스에 있는지 확인
			if(member != null) {
				num = service.insert_messages(msg);	
			}
				return num;
		}
		
		//새 팝업창으로
		@RequestMapping(value = "popup", method = RequestMethod.GET)
			public String popup() {
				return "messages/popup";
		}
			
		//메세지확인 업데이트
		@ResponseBody
		@RequestMapping(value="updateMessageCheck", method=RequestMethod.GET)
		public int updateMessageCheck(int msg_seq) {
			int result = 0;
			
			result = service.updateMessageCheck(msg_seq);
			
			if (result != 1) {
				return 0;
			}
			
			return result;
		}
	
	}
