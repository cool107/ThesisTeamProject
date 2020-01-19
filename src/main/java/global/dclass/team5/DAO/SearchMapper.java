package global.dclass.team5.DAO;

import java.util.ArrayList;
import java.util.Map;

import global.dclass.team5.VO.Thesis;

public interface SearchMapper {

	//논문 검색
	public ArrayList<Thesis> searchUniversityThesis(Map<String, Object> keyword);

	//논문 하나 가져오기
	public Thesis selectThesis(int thesisSeq);
}
