package global.dclass.team5.DAO;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.dclass.team5.VO.Application;
import global.dclass.team5.VO.Thesis;
import global.dclass.team5.VO.ThesisForm;
import global.dclass.team5.VO.ThesisTemp;

@Repository
public class AdminDAO {

	@Autowired
	SqlSession session;

	public ArrayList<Application> searchApplication() {
		ArrayList<Application> result = null;
		
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		
		try {
			result = mapper.searchApplication();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return result;
	}

	public int insertGroupBoard() {
		int result = 0;
		
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		
		try {
			result = mapper.insertGroupBoard();
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return result;
	}

	public Application selectApplication(int applicationSeq) {
		Application result = null;
		
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		
		try {
			result = mapper.selectApplication(applicationSeq);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return result;
	}

	public int updateMemberCheck(int applicationSeq) {
		int result = 0;
		
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		
		try {
			result = mapper.updateMemberCheck(applicationSeq);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return result;
	}

	public int updateAdminCheck(int applicationSeq) {
		int result = 0;
		
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		
		try {
			result = mapper.updateAdminCheck(applicationSeq);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return result;
	}

	public ThesisForm selectThesisForm(String department) {
		ThesisForm result = null;
		
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		
		try {
			result = mapper.selectThesisForm(department);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		
		return result;
	}

	public int updateThesisForm(ThesisForm form) {
		int result = 0;
		
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		
		try {
			result = mapper.updateThesisForm(form);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return result;
	}
	
	public int finalFileUpload(ThesisTemp temp) {
		int result = 0;
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		try {
			result = mapper.finalFileUpload(temp);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public ArrayList<ThesisTemp> selectThesisTemp() {
		ArrayList<ThesisTemp> result = null;
		
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		
		try {
			result = mapper.selectThesisTemp();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return result;
	}

	public ThesisTemp oneThesisTemp(int seq_thesistemp) {
		ThesisTemp result = null;
		
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		
		try {
			result = mapper.oneThesisTemp(seq_thesistemp);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return result;
	}

	public int insertThesisSubmit(ThesisTemp result) {
		int success = 0;
		
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		
		try {
			success = mapper.insertThesisSubmit(result);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return success;
	}

	public void updateThesisSubmit(int seq_thesistemp) {

		AdminMapper mapper = session.getMapper(AdminMapper.class);
		
		try {
			mapper.updateThesisSubmit(seq_thesistemp);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
