package global.dclass.team5.DAO;

import java.util.ArrayList;

import global.dclass.team5.VO.Message;

public interface MessageMapper {
	
	//select to messages
	public ArrayList<Message> select_all_messages(String id);

	//select one message
	public Message select_one_messages(int msg_seq);
	
	//delete messages
	public int delete_messages(int msg_seq);
	
	//send message
	public int insert_messages(Message msg);
	
	//update confirm
	public int updateConfirm(Message message);

	//select five message
	public ArrayList<Message> select_five_messages(String id);
	
	//update message check
	public int updateMessageCheck(int msg_seq);

	//select from messages
	public ArrayList<Message> fromAllMessage(String id);
}
