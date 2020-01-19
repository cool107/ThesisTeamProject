package global.dclass.team5.DAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.dclass.team5.VO.GroupBoard;
import global.dclass.team5.VO.GroupBoardComments;
import global.dclass.team5.VO.GroupBoardInfo;
import global.dclass.team5.VO.ThesisTemp;
import global.dclass.team5.util.PageNavigator;

@Repository
public class GroupBoardDAO {

	@Autowired
	SqlSession session;

	public int insertGroupBoardInfo(GroupBoardInfo result) {
		int success = 0;
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);

		try {
			success = mapper.insertGroupBoardInfo(result);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}

		return success;
	}

	public GroupBoardInfo selectGroupBoardInfo(String groupBoardId) {
		GroupBoardInfo result = null;

		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);

		try {
			result = mapper.selectGroupBoardInfo(groupBoardId);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}

	public int insertBoard(GroupBoard board) {
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		int result = 0;
		try {
			result=mapper.insertBoard(board);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	public GroupBoard getBoard(GroupBoard board) {
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		GroupBoard rBoard = null;
		try {
			rBoard = mapper.getBoard(board);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return rBoard;
	}

	public int addHits(GroupBoard board) {
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		int result = 0;
		try {
			result = mapper.addHits(board);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
		

	}

	public ArrayList<GroupBoard> listBoard(PageNavigator navi, String groupBoardNum, String keyField, String keyWord) {
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		Map<String, String> map = new HashMap<String, String>();
		map.put("groupBoardNum", groupBoardNum);
		map.put("keyField", keyField);
		map.put("keyWord", keyWord);
		RowBounds rb = new RowBounds(navi.getStartBoardPage(), navi.getBoardPerPage());
		ArrayList<GroupBoard> gBoard = null;
		try {
			gBoard = mapper.listBoard(rb, map);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return gBoard;
	}

	public int deleteBoard(GroupBoard board) {
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		int result = 0;
		try {
			result = mapper.deleteBoard(board);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		System.out.println("삭제 메서드"+ result);
		return result;
	}

	public int updateBoard(GroupBoard board) {
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		int result = 0;
		try {
			result = mapper.updateBoard(board);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	public int insertReply(GroupBoardComments reply) {
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		int result = 0;
		try {
			result = mapper.insertReply(reply);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;

	}

	public ArrayList<GroupBoardComments> listReply(GroupBoardComments nReplylist) {
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		ArrayList<GroupBoardComments> gReply = null;
		try {
			gReply = mapper.listReply(nReplylist);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return gReply;
	}

	public GroupBoardComments selectReply(GroupBoardComments reply) {
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		GroupBoardComments sReply = null;
		try {
			sReply = mapper.selectReply(reply);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return sReply;

	}

	public int deleteReply(GroupBoardComments reply) {
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		int result = 0;
		try {
			result = mapper.deleteReply(reply);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;

	}

	public int updateReply(GroupBoardComments reply) {
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		int result = 0;
		try {
			result = mapper.updateReply(reply);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		System.out.println("DAO"+reply);
		System.out.println("수정DAO"+result);
		return result;
	}

	public int getTotal(String groupBoardNum, String keyField, String keyWord) {
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		Map<String, String> map = new HashMap<String, String>();
		map.put("keyField", keyField);
		map.put("keyWord", keyWord);
		map.put("groupBoardNum", groupBoardNum);
		System.out.println(groupBoardNum);
		System.out.println(keyField);
		System.out.println(keyWord);
		int result = 0;
		try {
			result = mapper.getTotal(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int insertThesisTemp(ThesisTemp temp) {
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		int result = 0;
		try {
			result = mapper.insertThesisTemp(temp);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public ThesisTemp selectThesisTemp(int groupBoardNum) {
		ThesisTemp temp = null;
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		try {
			temp = mapper.selectThesisTemp(groupBoardNum);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return temp;
	}

	public int groupFileDelete(GroupBoard board) {
		int result = 0;
		
		GroupBoardMapper mapper = session.getMapper(GroupBoardMapper.class);
		
		try {
			result = mapper.groupFileDelete(board);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return result;
	}
	
	



}
