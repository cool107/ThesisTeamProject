package global.dclass.team5.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import global.dclass.team5.DAO.MessageDAO;
import global.dclass.team5.VO.Message;

@Service
public class MessageService {
	@Autowired
	MessageDAO dao;
	
	//5개 리스트만 출력
	public ArrayList<Message> select_five_messages(String id) {
		ArrayList<Message> list = dao.select_five_messages(id);
		return list;
	}
	
	//모든 메시지 출력
	public ArrayList<Message> select_all_messages(String id) {

		 ArrayList<Message>	list = dao.select_all_messages(id);
		return list;
	}
	
	//메시지 삭제
	public int delete_messages(int msg_seq) {
		int num = dao.delete_messages(msg_seq);
		return num;
	}

	//메시지 1개 출력
	public Message select_one_messages(int msg_seq) {
		return dao.select_one_messages(msg_seq);
	}

	public int updateConfirm(Message message) {
		return dao.updateConfirm(message);
	}

	public int updateMessageCheck(int msg_seq) {
		return dao.updateMessageCheck(msg_seq);
	}
	
	//메시지 전송
	public int insert_messages(Message msg) {
		int num = 0;
		num = dao.insert_messages(msg);
		return num;
	}

	public ArrayList<Message> fromAllMessages(String id) {
		return dao.fromAllMessage(id);
	}

}
