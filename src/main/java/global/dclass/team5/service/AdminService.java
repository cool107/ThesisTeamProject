package global.dclass.team5.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import global.dclass.team5.DAO.AdminDAO;
import global.dclass.team5.VO.Application;
import global.dclass.team5.VO.Thesis;
import global.dclass.team5.VO.ThesisForm;
import global.dclass.team5.VO.ThesisTemp;

@Service
public class AdminService {
	
	@Autowired
	AdminDAO dao;

	public ArrayList<Application> searchApplication() {
		return dao.searchApplication();
	}

	public Application selectApplication(int applicationSeq) {
		return dao.selectApplication(applicationSeq);
	}


	public int updateMemberCheck(int applicationSeq) {
		return dao.updateMemberCheck(applicationSeq);
	}

	public int updateAdminCheck(int applicationSeq) {
		return dao.updateAdminCheck(applicationSeq);
	}

	public ThesisForm selectThesisForm(String department) {
		return dao.selectThesisForm(department);
	}

	public int updateThesisForm(ThesisForm form) {
		return dao.updateThesisForm(form);
	}
	
	public int finalFileUpload(ThesisTemp temp) {
		return dao.finalFileUpload(temp);
}

	public ArrayList<ThesisTemp> selectThesisTemp() {
		return dao.selectThesisTemp();
	}

	public ThesisTemp oneThesisTemp(int seq_thesistemp) {
		return dao.oneThesisTemp(seq_thesistemp);
	}

	public int insertThesisSubmit(ThesisTemp result) {
		return dao.insertThesisSubmit(result);
	}

	public void updateThesisSubmit(int seq_thesistemp) {
		dao.updateThesisSubmit(seq_thesistemp);
		
	}

}
