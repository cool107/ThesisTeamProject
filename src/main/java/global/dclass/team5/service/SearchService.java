package global.dclass.team5.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import global.dclass.team5.DAO.SearchDAO;
import global.dclass.team5.VO.Thesis;

@Service
public class SearchService {

	@Autowired
	SearchDAO dao;

	public ArrayList<Thesis> searchUniversityThesis(Map<String, Object> keyword) {
		return dao.searchUniversityThesis(keyword);
	}

	public Thesis selectThesis(int thesisSeq) {
		return dao.selectThesis(thesisSeq);
	}
}
