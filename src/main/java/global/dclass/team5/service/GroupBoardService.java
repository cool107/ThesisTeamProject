package global.dclass.team5.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import global.dclass.team5.DAO.GroupBoardDAO;
import global.dclass.team5.DAO.GroupBoardMapper;
import global.dclass.team5.VO.GroupBoard;
import global.dclass.team5.VO.GroupBoardComments;
import global.dclass.team5.VO.GroupBoardInfo;
import global.dclass.team5.VO.ThesisTemp;
import global.dclass.team5.util.PageNavigator;

@Service
public class GroupBoardService {

	@Autowired
	GroupBoardDAO dao;

	public int insertGroupBoardInfo(GroupBoardInfo result) {
		      return dao.insertGroupBoardInfo(result);
		   }

	public GroupBoardInfo selectGroupBoardInfo(String groupBoardId) {
		      return dao.selectGroupBoardInfo(groupBoardId);
		   }
	
	public int insertBoard(GroupBoard board) {
		 return dao.insertBoard(board);
		
	}

	public GroupBoard getBoard(GroupBoard board) {
		return dao.getBoard(board);
	}

	public int addHits(GroupBoard board) {
			return dao.addHits(board);
	}

	public ArrayList<GroupBoard> listBoard(PageNavigator navi, String groupBoardNum, String keyField, String keyWord) {
			return dao.listBoard(navi, groupBoardNum,keyField, keyWord);
	}

	public int deleteBoard(GroupBoard board) {
			return dao.deleteBoard(board);
	}

	public int updateBoard(GroupBoard board) {
			return dao.updateBoard(board);
	}

	public int insertReply(GroupBoardComments reply) {
			return dao.insertReply(reply);
	}

	public ArrayList<GroupBoardComments> listReply(GroupBoardComments nReplylist) {
			return dao.listReply(nReplylist);
	}

	public GroupBoardComments selectReply(GroupBoardComments reply) {
			return dao.selectReply(reply);
	}

	public int deleteReply(GroupBoardComments reply) {
			return dao.deleteReply(reply);
	}

	public int updateReply(GroupBoardComments reply) {
			return dao.updateReply(reply);
	}

	public int getTotal(String groupBoardNum, String keyField, String keyWord) {
			return dao.getTotal(groupBoardNum, keyField, keyWord);
	}

	public int groupFileDelete(GroupBoard board) {
		return dao.groupFileDelete(board);
	}
	
	public int insertThesisTemp(ThesisTemp temp) {
			return 	dao.insertThesisTemp(temp);
	}
	
	public ThesisTemp selectThesisTemp(int groupBoardNum) {
			return dao.selectThesisTemp(groupBoardNum);
	}
	
	
}
