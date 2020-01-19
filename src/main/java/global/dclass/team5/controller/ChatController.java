package global.dclass.team5.controller;

import java.time.LocalDateTime;

import javax.servlet.http.HttpSession;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.dclass.team5.VO.ChatMessage;
import global.dclass.team5.VO.Member;

@Controller
public class ChatController {
	
	@MessageMapping("/chatForm")
	@SendTo("/subscribe/chatForm")
	public ChatMessage sendChatMessage(ChatMessage chatMessage, SimpMessageHeaderAccessor headerAccessor) {
		Member member = (Member)headerAccessor.getSessionAttributes().get("member");
	
//		session.setAttribute("flag", 1);
		chatMessage.setId(member.getId());
		chatMessage.setUserName(member.getName());
		chatMessage.setChatDate(LocalDateTime.now());
//		System.out.println("1번쨰"+chatMessage);
		return chatMessage;
	}
	
	@MessageMapping("/chat/{roomNum}")
	@SendTo("/subscribe/chat/{roomNum}")
	public ChatMessage sendChatMessage(@DestinationVariable("roomNum") int roomNum, ChatMessage chatMessage, SimpMessageHeaderAccessor headerAccessor) {
		Member member = (Member) headerAccessor.getSessionAttributes().get("member");
		
//		session.setAttribute("flag", 0);
		chatMessage.setId(member.getId());
		chatMessage.setUserName(member.getName());
		chatMessage.setChatDate(LocalDateTime.now());
//		System.out.println("2번쨰"+chatMessage);
		return chatMessage;
	}
	
	@RequestMapping(value="/chatForm", method=RequestMethod.GET)
	public String goChatForm() {
		return "/member/chatForm";
	}
}
