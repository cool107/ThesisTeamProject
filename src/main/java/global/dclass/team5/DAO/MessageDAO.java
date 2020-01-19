package global.dclass.team5.DAO;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.dclass.team5.VO.Message;

@Repository
public class MessageDAO {
	@Autowired
	SqlSession session;

	public ArrayList<Message> select_all_messages(String id) {
		ArrayList<Message> list = null;
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		try {
			list = mapper.select_all_messages(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int delete_messages(int msg_seq) {
		int num = 0;
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		try {
			num = mapper.delete_messages(msg_seq);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return num;
	}
	
	public Message select_one_messages(int msg_seq) {
		Message msg =null;
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		try {
			msg = mapper.select_one_messages(msg_seq);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return msg;
	}
	
	public int insert_messages(Message msg) {
		int num = 0;
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		try {
			num = mapper.insert_messages(msg);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return num;
	}

	public int updateConfirm(Message message) {
		int result = 0;
		
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		try {
			result = mapper.updateConfirm(message);
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return result;
	}

	public ArrayList<Message> select_five_messages(String id) {
		ArrayList<Message> list = null;
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		try {
			list = mapper.select_five_messages(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int updateMessageCheck(int msg_seq) {
		int result = 0;
		
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		try {
			result = mapper.updateMessageCheck(msg_seq);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return result;
	}

	public ArrayList<Message> fromAllMessage(String id) {
		ArrayList<Message> list = new ArrayList<Message>();
		
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		
		try {
			list = mapper.fromAllMessage(id);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return list;
	}

}
