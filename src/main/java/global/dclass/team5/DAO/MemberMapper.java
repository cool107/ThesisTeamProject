package global.dclass.team5.DAO;

import java.util.ArrayList;

import global.dclass.team5.VO.Application;
import global.dclass.team5.VO.Member;
import global.dclass.team5.VO.Message;

public interface MemberMapper {

	//select One Member
	public Member selectMember(String id);

	//insert Member
	public int insertMember(Member member);

	//update Member
	public int updateMember(Member member);

	//insert Application
	public int insertApplication(Application application);
	
	//select One Application
	public Application selectApplication(String id);

	//insert Message to Team Member 
	public void sendConfirmMessage(Message message);
	
	//update Member's GroupBoardNum
	public void updateGroupBoardNum(Application application);

	//select Message Count
	public int selectMsgCount(String toId);

	//select Team Member
	public ArrayList<Member> selectTeamMember(int num);


}
