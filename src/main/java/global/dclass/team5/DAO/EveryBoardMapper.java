package global.dclass.team5.DAO;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.dclass.team5.VO.EveryBoard;
import global.dclass.team5.VO.EveryBoardComments;

public interface EveryBoardMapper {

	//select All EveryBoard
	public ArrayList<EveryBoard> selectAllEveryBoard(RowBounds rb, Map<String, String> map);

	//select one EveryBoard
	public EveryBoard getBoard(int everyBoardSeq);

	//update Hitcount
	public void updateHitcount(int everyBoardSeq);

	//insert EveryBoard
	public int insertEveryBoard(EveryBoard result);

	//select one EveryBoard
	public EveryBoard selectEveryBoard(int everyBoardSeq);

	//update EveryBoard
	public int updateEveryBoard(EveryBoard result);

	//delete EveryBoard
	public int deleteEveryBoard(int everyBoardSeq);

	//select EveryBoard Count
	public int totalCount(Map<String, String> map);

	//select All EveryBoardComments
	public ArrayList<EveryBoardComments> selectAllComment(int everyBoardSeq);
	
	//insert_ comments
	public int insert_comments(EveryBoardComments everyBoardComments);
	
	//delete_comments
	public int delete_comments(EveryBoardComments everyBoardComments);
	
	//update_ comments
	public int update_comments(EveryBoardComments everyBoardComments);

	//delete board file
	public int fileDelete(int everyBoardSeq);

	
}

