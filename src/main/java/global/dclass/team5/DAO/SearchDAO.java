package global.dclass.team5.DAO;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.dclass.team5.VO.Thesis;

@Repository
public class SearchDAO {

	@Autowired
	SqlSession session;

	public ArrayList<Thesis> searchUniversityThesis(Map<String, Object> keyword) {
		ArrayList<Thesis> result = new ArrayList<Thesis>();
		
		SearchMapper mapper = session.getMapper(SearchMapper.class);
		
		try {
			result = mapper.searchUniversityThesis(keyword);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return result;
	}

	public Thesis selectThesis(int thesisSeq) {
		Thesis result = null;
		
		SearchMapper mapper = session.getMapper(SearchMapper.class);
		
		try {
			result = mapper.selectThesis(thesisSeq);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return result;
	}
}
