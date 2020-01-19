package global.dclass.team5.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import global.dclass.team5.DAO.EveryBoardDAO;
import global.dclass.team5.VO.EveryBoard;
import global.dclass.team5.VO.EveryBoardComments;
import global.dclass.team5.util.PageNavigator;

@Service
public class EveryBoardService {

	@Autowired
	EveryBoardDAO dao;

	public ArrayList<EveryBoard> selectAllEveryBoard(PageNavigator pn, String keyField, String keyWord) {
		return dao.selectAllEveryBoard(pn, keyField, keyWord);
	}

	public EveryBoard getBoard(int everyBoardSeq) {
		return dao.getBoard(everyBoardSeq);
	}

	public void updateHitcount(int everyBoardSeq) {
		dao.updateHitcount(everyBoardSeq);
	}

	public int insertEveryBoard(EveryBoard result) {
		return dao.insertEveryBoard(result);
	}

	public EveryBoard selectEveryBoard(int everyBoardSeq) {
		return dao.selectEveryBoard(everyBoardSeq);
	}

	public int updateEveryBoard(EveryBoard result) {
		return dao.updateEveryBoard(result);
	}

	public int deleteEveryBoard(int everyBoardSeq) {
		return dao.deleteEveryBoard(everyBoardSeq);
	}

	public int totalCount(String keyField, String keyWord) {
		return dao.totalCount(keyField, keyWord);
	}

	public ArrayList<EveryBoardComments> selectAllComment(int everyBoardSeq) {
		return dao.selectAllComment(everyBoardSeq);
	}
	
	public int insert_comments(EveryBoardComments everyBoardComments) {
		return dao.insert_comments(everyBoardComments);
	}

	public int delete_comments(EveryBoardComments everyBoardComments) {
		return dao.delete_comments(everyBoardComments);
	}
	
	public int update_comments(EveryBoardComments everyBoardComments) {
		return dao.update_comments(everyBoardComments);
	}

	public int fileDelete(int everyBoardSeq) {
		return dao.fileDelete(everyBoardSeq);
	}
	
}
