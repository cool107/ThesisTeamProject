package global.dclass.team5.DAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.dclass.team5.VO.EveryBoard;
import global.dclass.team5.VO.EveryBoardComments;
import global.dclass.team5.util.PageNavigator;

@Repository
public class EveryBoardDAO {

	@Autowired
	SqlSession session;

	public ArrayList<EveryBoard> selectAllEveryBoard(PageNavigator pn, String keyField, String keyWord) {
		ArrayList<EveryBoard> result = new ArrayList<EveryBoard>();
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("keyField", keyField);
		map.put("keyWord", keyWord);
		
		RowBounds rb = new RowBounds(pn.getStartBoardPage(), pn.getBoardPerPage());
		
		EveryBoardMapper mapper = session.getMapper(EveryBoardMapper.class);
		
		try {
			result = mapper.selectAllEveryBoard(rb, map);
		} catch (Exception e) {
			e.printStackTrace();
			return result;
		}
		
		return result;
	}

	public EveryBoard getBoard(int everyBoardSeq) {
		EveryBoard result = null;
		
		EveryBoardMapper mapper = session.getMapper(EveryBoardMapper.class);
		
		try {
			result = mapper.getBoard(everyBoardSeq);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return result;
	}

	public void updateHitcount(int everyBoardSeq) {
		
		EveryBoardMapper mapper = session.getMapper(EveryBoardMapper.class);
		
		try {
			mapper.updateHitcount(everyBoardSeq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public int insertEveryBoard(EveryBoard result) {
		int success = 0;
		
		EveryBoardMapper mapper = session.getMapper(EveryBoardMapper.class);
		
		try {
			success = mapper.insertEveryBoard(result);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return success;
	}

	public EveryBoard selectEveryBoard(int everyBoardSeq) {
		EveryBoard result = null;
		
		EveryBoardMapper mapper = session.getMapper(EveryBoardMapper.class);
				
		try {
			result = mapper.selectEveryBoard(everyBoardSeq);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return result;
	}

	public int updateEveryBoard(EveryBoard result) {
		int success = 0;
		
		EveryBoardMapper mapper = session.getMapper(EveryBoardMapper.class);
		
		try {
			success = mapper.updateEveryBoard(result);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return success;
	}

	public int deleteEveryBoard(int everyBoardSeq) {
		int result = 0;
		
		EveryBoardMapper mapper = session.getMapper(EveryBoardMapper.class);
		
		try {
			result = mapper.deleteEveryBoard(everyBoardSeq);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return result;
	}

	public int totalCount(String keyField, String keyWord) {
		int result = 0;
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("keyField", keyField);
		map.put("keyWord", keyWord);
		
		EveryBoardMapper mapper = session.getMapper(EveryBoardMapper.class);
		
		try {
			result = mapper.totalCount(map);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return result;
	}

	public ArrayList<EveryBoardComments> selectAllComment(int everyBoardSeq) {
		ArrayList<EveryBoardComments> result = null;
		
		EveryBoardMapper mapper = session.getMapper(EveryBoardMapper.class);
		
		try {
			result = mapper.selectAllComment(everyBoardSeq);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return result;
	}
	
	
	public int insert_comments(EveryBoardComments everyBoardComments) {
		
		EveryBoardMapper mapper = session.getMapper(EveryBoardMapper.class);
		
		int result = mapper.insert_comments(everyBoardComments);
				
		return result;
	}
	
	public int delete_comments(EveryBoardComments everyBoardComments) {
		int result = 0;
		EveryBoardMapper mapper = session.getMapper(EveryBoardMapper.class);
		
		try {
			result = mapper.delete_comments(everyBoardComments);			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return result;
	}
	
	public int update_comments(EveryBoardComments everyBoardComments) {
		
		EveryBoardMapper mapper = session.getMapper(EveryBoardMapper.class);
		
		int result = mapper.update_comments(everyBoardComments);
		
		return result;
		
	}

	public int fileDelete(int everyBoardSeq) {
		int result = 0;
		
		EveryBoardMapper mapper = session.getMapper(EveryBoardMapper.class);
		
		try {
			result = mapper.fileDelete(everyBoardSeq);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		return result;
	}

}
