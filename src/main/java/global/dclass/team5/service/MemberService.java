package global.dclass.team5.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import global.dclass.team5.DAO.MemberDAO;
import global.dclass.team5.VO.Application;
import global.dclass.team5.VO.Member;
import global.dclass.team5.VO.Message;

@Service
public class MemberService {

	@Autowired
	MemberDAO dao;
	
	public Member selectMember(String id) {
		return dao.selectMember(id);
	}

	public int insertMember(Member member) {
		return dao.insertMember(member);
	}

	public int updateMember(Member member_select) {
		return dao.updateMember(member_select);
	}

	public void sendConfirmMessage(Message message) {
		dao.sendConfirmMessage(message);
	}

	public Application selectApplication(String id) {
		return dao.selectApplication(id);
	}

	public int insertApplication(Application application) {
		return dao.insertApplication(application);
	}

	public void updateGroupBoardNum(Application application) {
		dao.updateGroupBoardNum(application);
		
	}

	public int selectMsgCount(String toId) {
		return dao.selectMsgCount(toId);
	}

	public ArrayList<Member> selectTeamMember(int num) {
		return dao.selectTeamMember(num);
	}
	
}
