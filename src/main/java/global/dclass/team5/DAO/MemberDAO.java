package global.dclass.team5.DAO;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.dclass.team5.VO.Application;
import global.dclass.team5.VO.Member;
import global.dclass.team5.VO.Message;

@Repository
public class MemberDAO {
	
	@Autowired
	SqlSession session;

	public Member selectMember(String id) {
		Member result = null;
		
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		
		try {			
			result = mapper.selectMember(id);

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return result;
	}

	public int insertMember(Member member) {
		int result = 0;
		
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		
		try {
			result = mapper.insertMember(member);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return result;
	}

	public int insertApplication(Application application) {
		int result = 0;
		
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		
		try {
			result = mapper.insertApplication(application);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return result;
	}

	public Application selectApplication(String id) {
		Application result = null;
		
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		
		try {
			result = mapper.selectApplication(id);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return result;
	}

	public void sendConfirmMessage(Message message) {
		
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		System.out.println(message);
		try {
		mapper.sendConfirmMessage(message);
		} catch (Exception e) {
			e.printStackTrace();
		}		

	}
	
	public int updateMember(Member member) {
		
		int result = 0;
		
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		
		try{
			
		result = mapper.updateMember(member);
		
		}catch(Exception e) {
		
			e.printStackTrace();
			
		}
		
		return result;
	}

	public void updateGroupBoardNum(Application application) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		
		try {
			mapper.updateGroupBoardNum(application);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public int selectMsgCount(String toId) {
		int result = 0;
		
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		
		try {
			result = mapper.selectMsgCount(toId);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return result;
	}

	public ArrayList<Member> selectTeamMember(int num) {
		ArrayList<Member> teamMember = null;
		
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		
		try {
			teamMember = mapper.selectTeamMember(num);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return teamMember;
	}

}
